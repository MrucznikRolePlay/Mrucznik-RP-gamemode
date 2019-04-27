/*
    ANTI CHEAT SYSTEM 0.3z
    By Kubi                 2014
*/
//=================================[Config]=================================//

#define USE_MA               0 //Using MapAndreas? 0-1.
#define SAMP_NET_HOST        40 //Additionaly net bandwith - don't change if not needed.

//=================================[Include]=================================//

#include <a_samp>
#include <foreach>
#if USE_MA == 1
#include <mapandreas>
#endif

//=================================[Define]=================================//

#define SAMP_NET_CHNGCLR    1000
#define SAMP_NET_DDOS       2565

#define PLAYER_FALL         1
#define PLAYER_LAND         2

#define DEF_ACDIST          70.0
#define DEF_AC_PACKETPERCENT    6.0

//=================================[Variable]=================================//

new bool:AC_AntiAB=true,
    bool:AC_AntiFLY=true,
    bool:AC_AntiVEH=true,
    bool:AC_AntiSPAWNER=true,
    bool:AC_ServerLag=false,
    bool:AC_AntiSpawner4=true,
    bool:AC_AntiSpawner2=true;

new AC_NETWORKQueue=0;
new AC_count, AC_AFKCount[MAX_PLAYERS],bool:AC_pause[MAX_PLAYERS]={false, ...}, bool:AC_resume[MAX_PLAYERS]={false,...}, AC_inactivetime[MAX_PLAYERS]={0, ...};
new AC_Car[MAX_PLAYERS], Float:AC_PlayerHP[MAX_PLAYERS], Float:AC_PlayerArmour[MAX_PLAYERS], AC_StateCounter[MAX_PLAYERS], AC_CarSeat[MAX_PLAYERS] = {-1, ...};

new AC_createCar[MAX_PLAYERS];
new PlayerIP[MAX_PLAYERS][16];

//AC_bandwidth
new AC_MsgSent[MAX_PLAYERS], Float:AC_Packets;

//AIRBREAK
new Float:AC_dist, Float:AC_Pos[MAX_PLAYERS][3], AC_Immunity[MAX_PLAYERS], AC_vid, Float:SpeedAC_dist[MAX_PLAYERS], AC_CarImmunity[MAX_VEHICLES];

//Fake Kill
new AC_countDeaths[MAX_PLAYERS], AC_StartDeathTick[MAX_PLAYERS];

//Fly hack
new Float:AC_Positions[3];
#if USE_MA == 1
new Float:AC_MapZ, bool:AC_JumpState[MAX_PLAYERS], Float:AC_JumpZ[MAX_PLAYERS], AC_JumpEnd[MAX_PLAYERS];
#endif

//Vehicle teleport into
new AC_pstate;

//=================================[Forward]=================================//

forward AC_CheckCheats();
forward AC_KickPlayer(playerid);
forward OnPlayerFly(playerid);
forward OnPlayerAirbreak(playerid);
forward OnPlayerVehicleAirBreak(playerid, vehicleid);
forward OnPlayerVehicleTeleport(playerid, vehicleid);
forward OnPlayerVehicleSpeedhack(playerid, vehicleid);
forward OnPlayerFakeKill(playerid);
forward OnPlayerCarFly(playerid, vehicleid);
forward OnPlayerAbuseVehicle(playerid, vehicleid);
forward OnPlayerMultihack(playerid, level);
forward OnPlayerUseHack(playerid, text[]);

forward CheckServerTick();

forward Sobeit_Check(playerid);
forward Sobeit_Check_1(playerid);
forward Sobeit_Check_2(playerid);

//=================================[HOOK]=================================//

static bool:MRPAC_g_CTS = false;
static bool:MRPAC_g_OPC = false;
static bool:MRPAC_g_OPS = false;
static bool:MRPAC_g_OPD = false;
static bool:MRPAC_g_OPU = false;
//static bool:MRPAC_g_OPSC = false;
static bool:MRPAC_g_OEEMS = false;
static bool:MRPAC_g_OUVU = false;
static bool:MRPAC_g_OVR = false;
static bool:MRPAC_g_OPCM = false;
static bool:MRPAC_g_OPEV = false;
static bool:MRPAC_g_OPWS = false;
static bool:MRPAC_n_CVC = false;
static bool:MRPAC_n_SPH = false;
static bool:MRPAC_n_SPA = false;

public OnGameModeInit()
{
	if (!MRPAC_g_CTS)
	{
		MRPAC_g_CTS = true;
		MRPAC_g_OPC = (funcidx("MRPAC_OnPlayerConnect") != -1);

        MRPAC_g_OPS = (funcidx("MRPAC_OnPlayerSpawn") != -1);
        MRPAC_g_OPD = (funcidx("MRPAC_OnPlayerDeath") != -1);
        MRPAC_g_OPU = (funcidx("MRPAC_OnPlayerUpdate") != -1);
        //MRPAC_g_OPSC = (funcidx("MRPAC_OnPlayerStateChange") != -1);
        MRPAC_g_OEEMS = (funcidx("MRPAC_OnEnterExitModShop") != -1);
        MRPAC_g_OPD = (funcidx("MRPAC_OnPlayerDeath") != -1);
        MRPAC_g_OUVU = (funcidx("MRPAC_OnUnoccupiedVehicleUpdate") != -1);
        MRPAC_g_OVR = (funcidx("MRPAC_OnVehicleRespray") != -1);
        MRPAC_n_CVC = (funcidx("MRP_ChangeVehicleColor") != -1);
        MRPAC_g_OPCM = (funcidx("MRPAC_OnPlayerClickMap") != -1);
        MRPAC_g_OPEV = (funcidx("MRPAC_OnPlayerEnterVehicle") != -1);
        MRPAC_g_OPWS = (funcidx("MRPAC_OnPlayerWeaponShot") != -1);
        MRPAC_n_SPH = (funcidx("MRP_SetPlayerHealth") != -1);
        MRPAC_n_SPA = (funcidx("MRP_SetPlayerArmour") != -1);

        #if USE_MA == 1
        MapAndreas_Init(MAP_ANDREAS_MODE_MINIMAL);
        #endif
        SetTimer("AC_CheckCheats", 1000, 1);
        SetTimer("CheckServerTick", 450, 1);
    	print("\n--------------------------------------");
    	print(" ANTI CHEAT BY KUBI (POLAND)");
        print(" Contain: \n+ AirBreak + teleport (OnFoot + InCar)\n+ FlyHack (OnFoot)\n+ FakeKill\n+ Car Float\n+ Color changer\n+ Car warp\n+ DoS\n+ Speedhack");
    	print("--------------------------------------\n");
	}
	if (funcidx("MRPAC_OnGameModeInit") != -1)
	{
		return CallLocalFunction("MRPAC_OnGameModeInit", "");
	}
	return 1;
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit MRPAC_OnGameModeInit

forward MRPAC_OnGameModeInit();

//          OnPlayerConnect
public OnPlayerConnect(playerid)
{
    GetPlayerIp(playerid, PlayerIP[playerid], 16);
    SetAC_Immunity(playerid, 1);
    AC_inactivetime[playerid] = 0;

    //FakeKill
    AC_countDeaths[ playerid ] = 0, AC_StartDeathTick[ playerid ] = 0;

    //AC_bandwidth
    AC_MsgSent[playerid]=0;
    AC_CarSeat[playerid] = -1;

    //END
	if (MRPAC_g_OPC)
	{
		return CallLocalFunction("MRPAC_OnPlayerConnect", "d", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect MRPAC_OnPlayerConnect

forward MRPAC_OnPlayerConnect(playerid);

//          OnPlayerSpawn
public OnPlayerSpawn(playerid)
{
    if(GetPVarInt(playerid, "sobeitcheck") == 0)
    {
        SetTimerEx("Sobeit_Check",500,false,"i",playerid);
    }

    SetAC_Immunity(playerid, 1);
    if (MRPAC_g_OPS)
	{
		return CallLocalFunction("MRPAC_OnPlayerSpawn", "d", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn MRPAC_OnPlayerSpawn

forward MRPAC_OnPlayerSpawn(playerid);

//          OnPlayerDeath
public OnPlayerDeath(playerid, killerid, reason)
{
    //FakeKill
    if(!IsPlayerNPC(playerid))
    {
        //Fixed YLESS
        if(gettime() - AC_StartDeathTick[playerid] < 3)
        {
            AC_countDeaths[playerid] ++;
            if(AC_countDeaths[playerid] >= 5)
            {
                OnPlayerFakeKill(playerid);
                return 0;
            }
        }
        else
            AC_countDeaths[playerid] = 1;
        AC_StartDeathTick[playerid] = gettime();
    }
    //END FakeKill
    if (MRPAC_g_OPD)
	{
		return CallLocalFunction("MRPAC_OnPlayerDeath", "ddd", playerid, killerid, reason);
	}
	return 1;
}

#if defined _ALS_OnPlayerDeath
	#undef OnPlayerDeath
#else
	#define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath MRPAC_OnPlayerDeath

forward MRPAC_OnPlayerDeath(playerid, killerid, reason);

//          OnPlayerUpdate

new AC_OPUCar, Float:AC_OPUPos[3];

new acstr[128];

new Float:czitX;
new Float:czitY;
new Float:czitZ;

#define         MAX_VEHICLE_ID_CHANGES          3

static LastVehicleID[MAX_PLAYERS];
static VehicleIDChanges[MAX_PLAYERS];
static VehicleIDChangeTime[MAX_PLAYERS];

public OnPlayerUpdate(playerid)
{
    AC_pause[playerid] = true;
    if((AC_OPUCar = GetPlayerVehicleID(playerid)) != 0)
    {
        if(AC_Car[playerid] != AC_OPUCar)
        {

            if(!CheckAC_CarImmunity(AC_OPUCar) && AC_AntiSPAWNER)
            {
                //printf("%d now %d", AC_Car[playerid], AC_OPUCar);
                //OnPlayerUseHack(playerid,"Vehicle Spawner");
                return 0;
            }
        }
    }

    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
    {
        GetPlayerVelocity(playerid, AC_OPUPos[0], AC_OPUPos[1], AC_OPUPos[2]);
        if(VectorSize(AC_OPUPos[0], AC_OPUPos[1], AC_OPUPos[1]) > 2.0)
        {
            if(GetPlayerSurfingObjectID(playerid) == INVALID_OBJECT_ID && GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID)
            {
                OnPlayerUseHack(playerid,"Onfoot speedhack");
                return 0;
            }
        }
    }
    if (MRPAC_g_OPU)
	{
		return CallLocalFunction("MRPAC_OnPlayerUpdate", "d", playerid);
	}
	return 1;
}

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate MRPAC_OnPlayerUpdate

forward MRPAC_OnPlayerUpdate(playerid);
/*
//          OnPlayerStateChange
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER && oldstate == PLAYER_STATE_PASSENGER)
    {
        new seatid = GetPlayerVehicleSeat(playerid);
        if(AC_CarSeat[playerid] != seatid && AC_AntiSpawner2)
        {
            OnPlayerUseHack(playerid,"Remote Car #2");
            return 0;
        }
    }
    if(newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_DRIVER)
    {
        //VHEICLE SPAWNER PROTECTION
        SetPVarInt(playerid, "AC-removed", 0);
        AC_Car[playerid] = GetPlayerVehicleID(playerid);

        if(AC_CarSeat[playerid] == -1) AC_CarSeat[playerid] = GetPlayerVehicleSeat(playerid);
    }
    if(newstate == PLAYER_STATE_DRIVER)
    {

        if(GetPVarInt(playerid, "sobeitcheck") == 1) //Sprawdzajac sobeita nie wyswietlamy komunikatow
        {
            //Znowu kamerka
            SetPlayerCameraPos(playerid, -1657.4678,1211.2292,13.6781);
            SetPlayerCameraLookAt(playerid,-1657.5237,1207.6644,13.6719);

            SetPVarInt(playerid, "sobeitcheck", 2); //Wszystko sprawdzone
            return 1;
        }

        //FAST SPAWNER ANTI CHEAT
        if(GetTickDiff(GetTickCount(), AC_StateCounter[playerid]) < 221)
        {
            if(!IsABoat(AC_Car[playerid]) && AC_AntiSpawner2)
            {
                printf("AC: Player %d kick for SPAWNER #2", playerid);
                Kick(playerid);
            }
            return 0;
        }
    }
    if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
    {
        SetPVarInt(playerid, "AC-removed", 0);
        SetPVarInt(playerid, "AC-removedcheck", 0);
        AC_CarSeat[playerid] = -1;

        GetPlayerPos(playerid, AC_Pos[playerid][0],AC_Pos[playerid][1],AC_Pos[playerid][2]);
    }
    if(newstate == PLAYER_STATE_SPAWNED || oldstate == PLAYER_STATE_SPAWNED)
    {
        SetAC_Immunity(playerid, 1);
    }

    AC_StateCounter[playerid] = GetTickCount();
    if (MRPAC_g_OPSC)
	{
		return CallLocalFunction("MRPAC_OnPlayerStateChange", "ddd", playerid, newstate, oldstate);
	}
	return 1;
}

#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange MRPAC_OnPlayerStateChange

forward MRPAC_OnPlayerStateChange(playerid, newstate, oldstate);
*/
//          OnEnterExitModShop
public OnEnterExitModShop(playerid, enterexit, interiorid)
{
    if(gettime() - GetPVarInt(playerid, "ac_entermodstick") < 2)
    {
        if(GetPVarInt(playerid, "ac_entermods") > 2)
        {
            OnPlayerUseHack(playerid,"Unknown #1");
            return 0;
        }
        SetPVarInt(playerid, "ac_entermods", GetPVarInt(playerid, "ac_entermods") + 1);
    }
    else
        SetPVarInt(playerid, "ac_entermods", 0);
    SetPVarInt(playerid, "ac_entermodstick", gettime());


    SetAC_Immunity(playerid, 1);
    if (MRPAC_g_OEEMS)
	{
		return CallLocalFunction("MRPAC_OnEnterExitModShop", "ddd", playerid, enterexit, interiorid);
	}
	return 1;
}

#if defined _ALS_OnEnterExitModShop
	#undef OnEnterExitModShop
#else
	#define _ALS_OnEnterExitModShop
#endif
#define OnEnterExitModShop MRPAC_OnEnterExitModShop

forward MRPAC_OnEnterExitModShop(playerid, enterexit, interiorid);

//          OnPlayerWeaponShot
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(hittype < 0 || hittype > 4) return 0;
    if(playerid != INVALID_PLAYER_ID)
    {
        if(!(-3000.0 < fX < 3000.0 || -3000.0 < fY < 3000.0 || -3000.0 < fZ < 3000.0)) return 0;
        if(16 <= weaponid <= 18 || 22 <= weaponid <= 39)
        {
            if(weaponid == 38 && IsPlayerInAnyVehicle(playerid))
            {
                SetPlayerArmedWeapon(playerid,0);
                return 0;
            }
        }
        else return 0;
    }
    else return 0;
    if (MRPAC_g_OPWS)
	{
		return CallLocalFunction("MRPAC_OnPlayerWeaponShot", "ddddfff", playerid, weaponid, hittype, hitid, fX, fY, fZ);
	}
	return 1;
}

#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot MRPAC_OnPlayerWeaponShot

forward MRPAC_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);

//          OnVehicleRespray
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
    if(!CheckAC_CarImmunity(vehicleid))
    {
        SetPVarInt(playerid, "AC-warn", GetPVarInt(playerid, "AC-warn") +1 );
        return 0;
    }
    if (MRPAC_g_OVR)
	{
		return CallLocalFunction("MRPAC_OnVehicleRespray", "dddd", playerid, vehicleid, color1, color2);
	}
    return 1;
}

#if defined _ALS_OnVehicleRespray
	#undef OnVehicleRespray
#else
	#define _ALS_OnVehicleRespray
#endif
#define OnVehicleRespray MRPAC_OnVehicleRespray

forward MRPAC_OnVehicleRespray(playerid, vehicleid, color1, color2);

//          OnPlayerClickMap
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    SetPVarFloat(playerid, "AC-mapX", fX);
    SetPVarFloat(playerid, "AC-mapY", fY);
    SetPVarInt(playerid, "AC-checkmap", 1);

    GetPlayerPos(playerid, AC_Pos[playerid][0], AC_Pos[playerid][1], AC_Pos[playerid][2]);
    SetPVarFloat(playerid, "AC-mapoldX", AC_Pos[playerid][0]);
    SetPVarFloat(playerid, "AC-mapoldY", AC_Pos[playerid][1]);
    if (MRPAC_g_OPCM)
	{
		return CallLocalFunction("MRPAC_OnPlayerClickMap", "dfff", playerid, fX, fY, fZ);
	}
    return 1;
}

#if defined _ALS_OnPlayerClickMap
	#undef OnPlayerClickMap
#else
	#define _ALS_OnPlayerClickMap
#endif
#define OnPlayerClickMap MRPAC_OnPlayerClickMap

forward MRPAC_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);

//          OnPlayerEnterVehicle
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    AC_Car[playerid] = vehicleid;
    new Float:x, Float:y, Float:z, Float:dist;
    GetVehiclePos(vehicleid, x ,y ,z);
    if((dist = GetPlayerDistanceFromPoint(playerid, x, y, z)) > 20.0 && AC_AntiSpawner4)
    {
        if(NetStats_PacketLossPercent(playerid) > 1.0 && dist < 25.0)
        {
            printf("AC: Spawner #4: Packet loss for %d, %.2f", playerid, dist);
        }
        else
        {
            SetVehiclePos(vehicleid, x, y, z);
            OnPlayerUseHack(playerid,"Vehicle Spawner #4");
            return 0;
        }
    }
    SetPVarInt(playerid, "AC_et", GetTickCount());
    if (MRPAC_g_OPEV)
	{
		return CallLocalFunction("MRPAC_OnPlayerEnterVehicle", "ddd", playerid, vehicleid, ispassenger);
	}
    return 1;
}

#if defined _ALS_OnPlayerEnterVehicle
	#undef OnPlayerEnterVehicle
#else
	#define _ALS_OnPlayerEnterVehicle
#endif
#define OnPlayerEnterVehicle MRPAC_OnPlayerEnterVehicle

forward MRPAC_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);

//      OnUnoccupiedVehicleUpdate
public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
    new Float:vx, Float:vy, Float:vz, Float:x, Float:y, Float:z;
    GetVehiclePos(vehicleid, x ,y ,z);
    GetVehicleVelocity(vehicleid, vx, vy, vz);

    if(z < -50.0 && new_z > z) //void map
    {
        return 1;
    }
    new Float:dist = VectorSize(new_x-x,new_y-y,new_z-z);
    if(dist > 15.0)
    {
        if(dist > VectorSize(vel_x-vx, vel_y-vy, vel_z-vz)*166.6666)
        {
            if(AC_AntiSPAWNER)
            {
                printf("CAR TELEPORT Dist: %.1f [%.1f, %.1f, %.1f] [%.1f, %.1f, %.1f], report by %d", dist, x, y, z, new_x, new_y, new_z, playerid);
            }
            SetVehiclePos(vehicleid, x, y, z);
            SetVehicleVelocity(vehicleid, vx, vy, vz);
            return 0;
        }
    }
    if (MRPAC_g_OUVU)
	{
		return CallLocalFunction("MRPAC_OnUnoccupiedVehicleUpdate", "dddffffff", vehicleid, playerid, passenger_seat, new_x, new_y, new_z, vel_x, vel_y, vel_z);
	}
	return 1;
}

#if defined _ALS_OnUnoccupiedVehicleUpdate
	#undef OnUnoccupiedVehicleUpdate
#else
	#define _ALS_OnUnoccupiedVehicleUpdate
#endif
#define OnUnoccupiedVehicleUpdate MRPAC_OnUnoccupiedVehicleUpdate

forward MRPAC_OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z);

//=================================[Native HOOK]=================================//

//Native hook
stock MRPAC_ChangeVehicleColor(vehicleid, color1, color2)
{
    new value;
    SetAC_CarImmunity(vehicleid, 1);
    value = ChangeVehicleColor(vehicleid, color1, color2);
    if (MRPAC_n_CVC)
	{
		return CallLocalFunction("MRP_ChangeVehicleColor", "ddd", vehicleid, color1, color2);
	}
	return value;
}
#if defined _ALS_ChangeVehicleColor
	#undef ChangeVehicleColor
#else
	#define _ALS_ChangeVehicleColor
#endif
#define ChangeVehicleColor MRPAC_ChangeVehicleColor

//SetPlayerHealth
stock MRPAC_SetPlayerHealth(playerid, Float:hp)
{
    new value;
    AC_PlayerHP[playerid] = hp;
    value = SetPlayerHealth(playerid, hp);
    if (MRPAC_n_SPH)
	{
		return CallLocalFunction("MRPAC_SetPlayerHealth", "df", playerid, hp);
	}
	return value;
}
#if defined _ALS_SetPlayerHealth
	#undef SetPlayerHealth
#else
	#define _ALS_SetPlayerHealth
#endif
#define SetPlayerHealth MRPAC_SetPlayerHealth

//SetPlayerArmour
stock MRPAC_SetPlayerArmour(playerid, Float:armor)
{
    new value;
    AC_PlayerArmour[playerid] = armor;
    value = SetPlayerArmour(playerid, armor);
    if (MRPAC_n_SPA)
	{
		return CallLocalFunction("MRPAC_SetPlayerArmour", "df", playerid, armor);
	}
	return value;
}
#if defined _ALS_SetPlayerArmour
	#undef SetPlayerArmour
#else
	#define _ALS_SetPlayerArmour
#endif
#define SetPlayerArmour MRPAC_SetPlayerArmour

//=================================[Callback]=================================//

stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return VectorSize(x1-x2, y1-y2, z1-z2);
}

stock AC_ConvertTime(sec, &h, &m, &s)
{
    h = (sec % 86400) / 3600;
    m = (sec % 3600) / 60;
    s = (sec % 60);
}

public AC_CheckCheats()
{
    new AC_str[64]="\0", actime[3], Float:fVal;
    foreach(Player, i)
    {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        if(GetPVarInt(i, "AC-warn") > 4)
        {
            SetTimerEx("AC_KickPlayer", 200, 0, "i", i);
            continue;
        }
        // !----            Anty Cheat          ----! //
        AC_pstate = GetPlayerState(i);
        GetPlayerPos( i, AC_Positions[ 0 ], AC_Positions[ 1 ], AC_Positions[ 2 ] );
        AC_vid = GetPlayerVehicleID(i);

        if(GetPVarInt(i, "AC-izolacja") != 0)
        {
            SetPVarInt(i, "AC-izolacja", GetPVarInt(i, "AC-izolacja")-1);
            if(GetPVarInt(i, "AC-izolacja") == 0)
            {
                SetPlayerVirtualWorld(i, 0);
            }
        }

        //=================================[Car check]=================================//
        AC_count = NetStats_MessagesReceived(i);
        AC_Packets = NetStats_PacketLossPercent(i);
        if(AC_MsgSent[i] == 0)
        {
            AC_MsgSent[i] = AC_count;
        }
        else
        {
            if(AC_count - AC_MsgSent[i] > SAMP_NET_DDOS)
            {
                if(!AC_ServerLag && AC_NETWORKQueue < 10) OnPlayerMultihack(i,AC_count - AC_MsgSent[i]);
            }
            else if(AC_count - AC_MsgSent[i] > SAMP_NET_CHNGCLR)
            {
                if(!AC_ServerLag && AC_NETWORKQueue < 10) OnPlayerMultihack(i,AC_count - AC_MsgSent[i]);
            }
        }
        AC_MsgSent[i] = AC_count;

        if(AC_pause[i])
        {
            ///=================================[Armour/HP]=================================//
            GetPlayerArmour(i, fVal);
            if(fVal > AC_PlayerArmour[i])
            {
                SetPlayerArmour(i, AC_PlayerArmour[i]);
                SetPVarInt(i, "AC-warn", GetPVarInt(i, "AC-warn") +1 );
            }
            else AC_PlayerArmour[i] = fVal;

            GetPlayerHealth(i, fVal);
            if(fVal > AC_PlayerHP[i])
            {
                SetPlayerHealth(i, AC_PlayerHP[i]);
            }
            else AC_PlayerHP[i] = fVal;
            ///=================================[Air Break]=================================//

            AC_dist = GetDistanceBetweenPoints(AC_Pos[i][0], AC_Pos[i][1], AC_Pos[i][2], AC_Positions[0],AC_Positions[1],AC_Positions[2]);

            if(AC_AntiAB) CheckAB(i);

            //=================================[Fly hack]=================================//

            if(AC_AntiFLY) CheckFly(i);

            //=================================[Vehicle abuse]=================================//
            if(AC_AntiVEH)
            {
                if(GetPVarInt(i, "AC-removed") == 1)
                {
                    if(AC_pstate == PLAYER_STATE_DRIVER || AC_pstate == PLAYER_STATE_PASSENGER)
                    {
                        if(AC_vid != 0)
                        {
                            if(!(CheckAC_Immunity(i) || CheckAC_CarImmunity(AC_vid)))
                            {
                                if(AC_vid == AC_Car[i] )
                                {
                                    if(GetPVarInt(i, "AC-removedcheck") == 1)
                                    {
                                        SetPVarInt(i, "AC-removedcheck", 0);
                                        SetPVarInt(i, "AC-removed", 0);
                                        if(AC_Packets < DEF_AC_PACKETPERCENT) CallRemoteFunction("OnPlayerAbuseVehicle","dd",i,AC_vid);
                                    }
                                    else
                                    {
                                        SetPVarInt(i, "AC-removedcheck", 1);
                                        SetPlayerPos(i,  AC_Positions[0],AC_Positions[1],AC_Positions[2]+0.1);
                                    }
                                }
                                else
                                {
                                    SetPVarInt(i, "AC-removedcheck", 0);
                                    SetPVarInt(i, "AC-removed", 0);
                                }
                            }
                        }
                    }
                }
            }
        }

        //=================================[AFK check]=================================//
        if(AC_pstate != PLAYER_STATE_NONE && AC_pstate != PLAYER_STATE_WASTED && AC_pstate != PLAYER_STATE_SPECTATING && AC_pstate != PLAYER_STATE_SPAWNED)
        {
            if(AC_pause[i])
            {
                if(AC_resume[i])
                {
                    AC_resume[i] = false;
                    AC_inactivetime[i] = 0;
                    if(AC_vid != 0) SetAC_CarImmunity(AC_vid, 1);
                    SetAC_Immunity(i, 1);
                    SetPlayerChatBubble(i, " ", 0xD48C26FF, 7.0, 100);
                }
                AC_pause[i]=false;
                AC_AFKCount[i] = 0;
            }
            else
            {
                if(AC_AFKCount[i] == 1)
                {
                    if(AC_inactivetime[i] == 0)
                        AC_inactivetime[i] = gettime();
                }
                else
                    AC_AFKCount[i] = 1;

                if(gettime()-AC_inactivetime[i] > 0 && AC_inactivetime[i] != 0)
                {
                    if(!AC_resume[i]) AC_resume[i] = true;
                    AC_ConvertTime(gettime()-AC_inactivetime[i], actime[0], actime[1], actime[2]);
                    format(AC_str, 64, "AFK [%ih %im %is]", actime[0], actime[1], actime[2]);
                    SetPlayerChatBubble(i, AC_str, 0xD48C26FF, 7.0, 1100);
                }
            }
        }

        AC_Pos[i][0] = AC_Positions[0], AC_Pos[i][1] = AC_Positions[1], AC_Pos[i][2] = AC_Positions[2];
    }
    return 1;
}

stock CheckFly(playerid)
{
    if(CheckAC_Immunity(playerid)) return;
    if(AC_vid != 0)
    {
        #if USE_MA == 1
        MapAndreas_FindZ_For2DCoord(AC_Positions[0], AC_Positions[1], AC_MapZ);
        if(!AC_JumpState[playerid])
        {
            if(AC_Positions[2] - AC_MapZ > 3.0)
            {
                AC_JumpState[playerid] = true;
                AC_JumpZ[playerid] = AC_Positions[2];
            }
        }
        else
        {
            if(AC_JumpZ[playerid] - AC_Positions[2] > 0.0) //Spada
            {
                if(AC_Positions[2] - AC_MapZ < 3.0)
                {
                    AC_JumpState[playerid]=false;
                }
            }
            else  //Wznosi sie
            {
                if(AC_JumpEnd[playerid] > 2)
                {
                    OnPlayerCarFly(playerid,AC_vid);
                    AC_JumpEnd[playerid]=0;
                    AC_JumpState[playerid]=false;
                }
                else AC_JumpEnd[playerid]++;
            }
        }
        #endif
    }
    else
    {
        if((AC_IsPlayerUsingFlyAnim ( playerid ) || AC_IsPlayerUsingParachuteAnim(playerid)) && !AC_IsPlayerInWater( playerid ) && (AC_Positions[ 2 ] >= 15.0))
        {
            if(AC_IsPlayerUsingParachuteAnim(playerid))
                if(GetPlayerWeapon(playerid) == 46) return;
            OnPlayerFly(playerid);
        }
    }
}

stock CheckAB(playerid)
{
    if(CheckAC_Immunity(playerid)) return;
    if(AC_resume[playerid]) return;
    if(AC_NETWORKQueue > 3) return;
    if(IsPlayerInRangeOfPoint(playerid, 100.0, 1958.0, 1343.0, 1100.0) || VectorSize(AC_Pos[playerid][0]-1958.0, AC_Pos[playerid][1]-1343.0, AC_Pos[playerid][2]-1100.0) < 100.0 || AC_Pos[playerid][2] == -5.0) return;
    if(IsPlayerInRangeOfPoint(playerid, 10.0, 0.0, 0.0, 0.0) || VectorSize(AC_Pos[playerid][0], AC_Pos[playerid][1], AC_Pos[playerid][2]) < 10.0) return;

    if(GetPVarInt(playerid, "AC-checkmap") == 1)
    {
        DeletePVar(playerid, "AC-checkmap");
        if(AC_pstate == PLAYER_STATE_ONFOOT)
        {
            if(VectorSize(GetPVarFloat(playerid, "AC-mapoldX")-AC_Positions[0],GetPVarFloat(playerid, "AC-mapoldY")-AC_Positions[1], 0.0) > DEF_ACDIST)
            {
                if(VectorSize(AC_Positions[0]-GetPVarFloat(playerid, "AC-mapX"), AC_Positions[1]-GetPVarFloat(playerid, "AC-mapY"), 0.0) < 3.0)
                {
                    if(AC_Packets < DEF_AC_PACKETPERCENT) OnPlayerUseHack(playerid,"Map Hack");
                    return;
                }
            }
        }
    }
    if(!IsPlayerInAnyVehicle(playerid)) //OnFoot
    {
        //printf("Check AB state %d dist %.1f for z %.1f last z %.1f fall state %d - thru map (%d)? IMMU %d VEH %d OBJ %d", AC_pstate, AC_dist, AC_Positions[2],AC_Pos[playerid][2], AC_IsPlayerFalling(playerid), GetPVarInt(playerid, "ThruMap"), CheckAC_Immunity(playerid), GetPlayerSurfingVehicleID(playerid), GetPlayerSurfingObjectID(playerid));
        if(GetPlayerSurfingVehicleID(playerid) == INVALID_VEHICLE_ID && GetPlayerSurfingObjectID(playerid) == INVALID_OBJECT_ID)
        {
            if(AC_pstate != 7 && AC_pstate != 9 && AC_pstate != 0)
            {
                if((AC_Positions[2] < AC_Pos[playerid][2]) && (AC_Positions[0] == AC_Pos[playerid][0])) SetPVarInt(playerid, "ThruMap", 1);
                else
                {
                    if(AC_IsPlayerFalling(playerid)) return;
                    if(AC_dist > DEF_ACDIST)
                    {
                        if(GetPlayerWeapon(playerid) == 46 && AC_IsPlayerUsingParachuteAnim(playerid)) return;
                        if(GetPVarInt(playerid, "ThruMap") == 1)
                        {
                            SetPVarInt(playerid, "ThruMap", 0);
                            SetAC_Immunity(playerid, 1);
                            return;
                        }
                        if(AC_Positions[2] > 990.0 || AC_Pos[playerid][2] > 990.0) return;
                        if(AC_Packets < DEF_AC_PACKETPERCENT) OnPlayerAirbreak(playerid);
                    }
                }
            }
        }
    }
    else //InCar
    {
        if(CheckAC_CarImmunity(AC_vid)) return;
        new Float:cspeed = AC_GetCarSpeed(AC_vid);
        if(GetPlayerVehicleSeat(playerid) != 0) return;

        if((AC_Positions[2] < AC_Pos[playerid][2]) && (AC_Positions[0] == AC_Pos[playerid][0])) SetPVarInt(playerid, "ThruMap", 1);

        if(cspeed < 1) //AirBreak
        {
            if(AC_dist > DEF_ACDIST)
            {
                if(AC_Packets < DEF_AC_PACKETPERCENT) OnPlayerVehicleAirBreak(playerid, AC_vid);
            }
        }
        else //Teleport
        {
            SpeedAC_dist[playerid]+=cspeed;
            if(AC_dist > SpeedAC_dist[playerid]+(AC_Packets*10) && AC_dist > DEF_ACDIST)
            {
                if(GetPVarInt(playerid, "ThruMap") == 1)
                {
                    SetPVarInt(playerid, "ThruMap", 0);
                    SetAC_Immunity(playerid, 1);
                    SetAC_CarImmunity(AC_vid, 1);
                    return;
                }
                SpeedAC_dist[playerid]=0.0;
                if(AC_Packets < DEF_AC_PACKETPERCENT) OnPlayerVehicleTeleport(playerid, AC_vid);
            }
            else
            {
                SpeedAC_dist[playerid]=SpeedAC_dist[playerid]/2;
                if(!AC_IsAPlane(AC_vid))
                {
                    if(cspeed > 220 && !AC_CheckCarFall(AC_vid))
                    {
                        if(AC_Packets < DEF_AC_PACKETPERCENT) OnPlayerVehicleSpeedhack(playerid, AC_vid);
                    }
                }
            }
        }
    }
}

stock AC_IsAPlane(carid)
{
	new model = GetVehicleModel(carid);
	switch(model)
	{
		case 460,464,476,511,513,519,520,539,593,417,425,447,465: return 1;
		case 469,487,488,497,501,548,563,592,577,553: return 1;
		default: return 0;
	}
	return 1;
}

stock SetAC_Immunity(playerid, time)
{
    AC_Immunity[playerid] = gettime() + time;
}

stock SetAC_CarImmunity(vehicleid, time)
{
    AC_CarImmunity[vehicleid] = gettime() + time;
}

stock CheckAC_CarImmunity(vehicleid)
{
    return AC_CarImmunity[vehicleid] >= gettime();
}

stock CheckAC_Immunity(playerid)
{
    return AC_Immunity[playerid] >= gettime();
}

stock AC_GetPlayerSpeed(playerid)
{
    new Float:pAC_Pos[3],Float:VS ;
    GetPlayerVelocity(playerid, pAC_Pos[0], pAC_Pos[1], pAC_Pos[2]);
    VS = VectorSize(pAC_Pos[0], pAC_Pos[1], pAC_Pos[2])*136.6666;
    return floatround(VS,floatround_round);
}



stock AC_CheckCarFall(vehicleid)
{
    new Float:pAC_Pos[3];
    GetVehicleVelocity(vehicleid, pAC_Pos[0], pAC_Pos[1], pAC_Pos[2]);
    if(pAC_Pos[2] < -0.25) return true;
    return false;
}

stock AC_IsPlayerFalling(playerid)
{
    switch( GetPlayerAnimationIndex( playerid ) )
    {
        case 1130..1132, 1128, 1000, 1001, 958, 959, 961: return PLAYER_FALL;
        case 1208, 1156, 1129, 1133, 1198, 1195, 1066, 1067: return PLAYER_LAND;
    }
    return 0;
}

stock AC_IsPlayerUsingParachuteAnim(playerid)
{
    switch(GetPlayerAnimationIndex(playerid))
    {
        case 0x3cb, 0x3c5, 0x3d0, 0x3d2, 0x3c3, 0x3cd, 0x3bf: return true;
        default: return false;
    }
    return false;
}

static stock AC_IsPlayerUsingFlyAnim( playerid )
{
    switch( GetPlayerAnimationIndex( playerid ) )
    {
        case 1538, 1542, 1544, 1250, 1539, 1543: return true;
    }
    return false;
}

public CheckServerTick()
{
    AC_ServerLag = false;
    new network_str[401], unusedstr[16],
        data[11];
	GetNetworkStats(network_str, sizeof(network_str));

    new pos=0, x=0;
    while(x != 6)
    {
        pos = strfind(network_str, ": ", false, pos);
        strmid(unusedstr, network_str, pos+2, pos+7);
        data[x] = strval(unusedstr);
        pos++;
        x++;
    }

    new str[32], bool:thissame=false;
    if(data[0] < 20)
    {
        format(str, 32, "Low %d", data[0]);
        ACLog("logi/server.tick", str);
        thissame=true;
    }
    AC_NETWORKQueue = data[5];
    if(data[5] > 2)
    {
        format(str, 32, "WARN %d", data[5]);
        ACLog("logi/server.tick", str);
        if(thissame)
        {
            AC_ServerLag = true;
            ACLog("logi/server.tick", "Server lag");
        }
    }
}

stock ACLog(plik[], text[])
{
	new File:file = fopen(plik, io_append);
    new message[512], data[2][3];
    if(file)
    {
    	gettime(data[0][0], data[0][1], data[0][2]);
    	getdate(data[1][0], data[1][1], data[1][2]);

    	format(message, sizeof(message), "[%02d/%02d/%02d - %02d:%02d:%02d] %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], text);
        fwrite(file, message);
        fclose(file);
    }
    else if(!fexist(plik))
    {
        file = fopen(plik, io_write);
        if(file)
        {
        	gettime(data[0][0], data[0][1], data[0][2]);
        	getdate(data[1][0], data[1][1], data[1][2]);

        	format(message, sizeof(message), "[%02d/%02d/%02d - %02d:%02d:%02d] %s\r\n", data[1][0], data[1][1], data[1][2], data[0][0], data[0][1], data[0][2], text);
            fwrite(file, message);
            fclose(file);
        }
    }
    else printf("File handle error! File %s cannot be opened to write [%s]", plik, text);
	return 1;
}

public AC_KickPlayer(playerid) Kick(playerid);

/*
    Function AC_IsPlayerInWater is created by Southclaw, thanks to him for sharing this useful function & array of SA water-area.
    This function were taken from his (Scavenge and Survive) script, its free to use and its available on Github!
    0.3z edit by Kubi, fixed static loop arg.
*/

static stock Float:AC_distance(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2) return VectorSize(x1-x2, y1-y2, z1-z2);
static stock Float:AC_distance2D(Float:x1, Float:y1, Float:x2, Float:y2) return VectorSize(x1-x2, y1-y2, 0.0);

static Float:AC_water_places[20][4] =
{
    {25.0,              2313.0,                -1417.0,        23.0},
    {15.0,              1280.0,                -773.0,         1083.0},
    {25.0,              2583.0,                2385.0,         15.0},
    {20.0,              225.0,                 -1187.0,        74.0},
    {50.0,              1973.0,                -1198.0,        17.0},
    {180.0,             1937.0,                1589.0,         9.0},
    {55.0,              2142.0,                1285.0,         8.0},
    {45.0,              2150.0,                1132.0,         8.0},
    {55.0,              2089.0,                1915.0,         10.0},
    {32.0,              2531.0,                1567.0,         9.0},
    {21.0,              2582.0,                2385.0,         17.0},
    {33.0,              1768.0,                2853.0,         10.0},
    {47.0,              -2721.0,               -466.0,         3.0},
    {210.0,             -671.0,                -1898.0,        6.0},
    {45.0,              1240.0,                -2381.0,        9.0},
    {50.0,              1969.0,                -1200.0,        18.0},
    {10.0,              513.0,                 -1105.0,        79.0},
    {20.0,              193.0,                 -1230.0,        77.0},
    {30.0,              1094.0,                -672.0,         113.0},
    {15.0,              1278.0,                -805.0,         87.0}
};

static stock AC_IsPlayerInWater(playerid)
{
    static Float:AC_PosX, Float:AC_PosY, Float:AC_PosZ, i;
    i = -1;
    GetPlayerPos(playerid, AC_PosX, AC_PosY, AC_PosZ);

    if(AC_PosZ < 44.0)
    {
        if(AC_distance(AC_PosX, AC_PosY, AC_PosZ, -965.0, 2438.0, 42.0) <= 700.0) return true;
    }
    while(++i < sizeof(AC_water_places))
    {
        if(AC_distance2D(AC_PosX, AC_PosY, AC_water_places[i][1], AC_water_places[i][2]) <= AC_water_places[i][0])
        {
            if(AC_PosZ < AC_water_places[i][3]) return true;
        }
        if(AC_PosZ < 1.9)
        {
            if(AC_distance(AC_PosX, AC_PosY, AC_PosZ, 618.4129, 863.3164, 1.0839) < 200.0)
            return false;
                else
            return true;
        }
    }
    return false;
}

public Sobeit_Check(playerid)
{
    new Float:pPos[3];
    GetPlayerPos(playerid,pPos[0],pPos[1],pPos[2]);
    new weapon, ammo;
    GetPlayerWeaponData(playerid, 1, weapon, ammo);
    SetPVarInt(playerid, "ac_gun", weapon);
    ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, 1, 1);

    SetPVarInt(playerid, "ac_checkenter", 1);
    AC_createCar[playerid] = CreateVehicle(457, pPos[0],pPos[1],pPos[2],0.0, 0,0, -1);
    PutPlayerInVehicleEx(playerid, AC_createCar[playerid], 0);
    LinkVehicleToInterior(AC_createCar[playerid], 1);

	return SetTimerEx("Sobeit_Check_1",1000,false,"i",playerid);
}

public Sobeit_Check_1(playerid)
{
    RemovePlayerFromVehicleEx(playerid);
    DestroyVehicle(AC_createCar[playerid]);

	return SetTimerEx("Sobeit_Check_2",500,false,"i",playerid);
}

public Sobeit_Check_2(playerid)
{
    new weapon, weapon1, ammo, ammo1;

    GetPlayerWeaponData(playerid, 1, weapon, ammo);
    GetPlayerWeaponData(playerid, 0, weapon1, ammo1);

	if(weapon1 == 0 || weapon == 2 || ((GetPVarInt(playerid, "ac_gun") != weapon || GetPVarInt(playerid, "ac_gun") == weapon) && weapon != 0) && ammo > 0 || GetPVarInt(playerid, "ac_checkenter") == 1)
	{
		SendClientMessage(playerid,-1,"Detekcja {CA2E36}S0beit'a{FFFFFF}. Zostajesz wyrzucony!");
        new nick[24];
        GetPlayerName(playerid, nick, 24);
        new str[128];
        format(str, 128, "SOBEIT: %s Kicked > %d,%d|%d,%d|%d|%.2f", nick,weapon1,weapon,GetPVarInt(playerid, "ac_gun"),ammo,GetPVarInt(playerid, "ac_checkenter"), NetStats_PacketLossPercent(playerid));
        CzitLog(str);
        KickEx(playerid);
    }
    else
    {
        BeforeSpawn(playerid);
    }
	return (true);
}

//EOF
