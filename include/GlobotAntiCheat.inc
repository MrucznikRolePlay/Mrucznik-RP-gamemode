#include <float>

#if defined _GlobotAntiCheat_included
  #endinput
#endif
#define _GlobotAntiCheat_included
#pragma library GlobotAntiCheat
#include <a_samp>

#if defined COLOR_ALERT
#else
#define COLOR_ALERT 0xAA3333AA
#endif
#if defined COLOR_WARNING
#else
#define COLOR_WARNING 0xAA3333AA
#endif
/*
#if defined MAX_PLANE_ID_NUM
#else
#define MAX_PLANE_ID_NUM 10
#endif
*/
#if defined MAX_OVERSPEED_WARNING
#else
#define MAX_OVERSPEED_WARNING 2
#endif

#if defined MAX_ALLOWED_SPEED
#else
#define MAX_ALLOWED_SPEED 325
#endif

#if defined MAX_ALLOWED_CAR_SPEED
#else
#define MAX_ALLOWED_CAR_SPEED 260
#endif

#if defined LAST_SPEED
#else
#define LAST_SPEED 5
#endif
/* not implemented (now only 1 min and 1 max are filtered)
#if defined EXTREMUM
#else
#define EXTREMUM 2
#endif
*/
#if defined CHECK_INTERVAL
#else
#define CHECK_INTERVAL 250
#endif

#if defined MAX_IDLE_TIME
#else
#define MAX_IDLE_TIME 120
#endif

#if defined COLOR_GREY
#else
#define COLOR_GREY 0xAFAFAFAA
#endif

#if defined COLOR_GREEN
#else
#define COLOR_GREEN 0x33AA33AA
#endif

#if defined COLOR_RED
#else
#define COLOR_RED 0xAA3333AA
#endif

#if defined COLOR_YELLOW
#else
#define COLOR_YELLOW 0xFFFF00AA
#endif

#if defined COLOR_BLUE
#else
#define COLOR_BLUE 0x5555AFAA
#endif

#if defined MAX_PLANE_NUM
#else
#define MAX_PLANE_NUM -1
#endif

#if defined MAX_TEAMKILL
#else
#define MAX_TEAMKILL 4
#endif

#if defined TEAM_1_RATIO
#else
#define TEAM_1_RATIO 1
#endif
#if defined TEAM_2_RATIO
#else
#define TEAM_2_RATIO 1
#endif
#if defined MAX_EARNED_MONEY
#else
#define MAX_EARNED_MONEY 50000
#endif

#if defined CHEAT_REPORT_NUMBER
#else
#define CHEAT_REPORT_NUMBER 2
#endif

#if defined RESPAWN_TEAM_1_INTERIOR
#else
#define RESPAWN_TEAM_1_INTERIOR 0
#endif

#if defined RESPAWN_TEAM_2_INTERIOR
#else
#define RESPAWN_TEAM_2_INTERIOR 0
#endif

#define WEAPON_NUMBER 55
#define STR_LEN 512


//native GetVehicleArmor(vehicleid, Float:health);


//new str[STR_LEN];
new Max_Players;
new gPlayerActive[MAX_PLAYERS];
new gPlayerRespawning[MAX_PLAYERS];
#if defined NO_TEAMKILL
new gTeamKillCount[MAX_PLAYERS];
new lTeamKillCount[MAX_PLAYERS];
#endif
new gPlayerFrag[MAX_PLAYERS];
new gTeam[MAX_PLAYERS];
new gClassid[MAX_PLAYERS];
new Float:gPlayerPos[MAX_PLAYERS][3];
new gPlayerIdle[MAX_PLAYERS];
new gPlayerKickList[MAX_PLAYERS];
new gPlayerKickNum = 0;
new Float:gPlayerAngle[MAX_PLAYERS];
new Float:gPlayerLastMove[MAX_PLAYERS];
new Float:gPlayerSpeed[MAX_PLAYERS];
new Float:gPlayerSpeedTab[MAX_PLAYERS][LAST_SPEED];
new Float:gPlayerXSpeedTab[MAX_PLAYERS][LAST_SPEED];
new Float:gPlayerYSpeedTab[MAX_PLAYERS][LAST_SPEED];
new Float:gPlayerZSpeedTab[MAX_PLAYERS][LAST_SPEED];
new gPlayerOverAccelerateCount[MAX_PLAYERS];
new gPlayerOverSpeedCount[MAX_PLAYERS];
new gPlayerSuperJumpCount[MAX_PLAYERS];
new gPlayerFlyCarCount[MAX_PLAYERS];
new gBumpDetection[MAX_PLAYERS];

new gPlayerWarp[MAX_PLAYERS];

new gTotalCheatCount[MAX_PLAYERS];

new Float:gPlayerHealth[MAX_PLAYERS];
new gPlayerHealthCount[MAX_PLAYERS];
//new gPlayerHealthCheck2[MAX_PLAYERS];

#if defined AUTOBALANCE
new gSpawnOrder[MAX_PLAYERS];
new gTeamBalance;
#endif

new gVoteInProgress;
new gVoteCount;
new gVoteParams[3];
new gVoteStr[STR_LEN];
new gVoteReminder;
new gVoteTicket[MAX_PLAYERS];
new gReportCheat[MAX_PLAYERS][MAX_PLAYERS];
new gReportCheatCount[MAX_PLAYERS];

new gDisableCheckMove[MAX_PLAYERS];
new gDisableCheckHealth[MAX_PLAYERS];
new gDisableCheckMoney[MAX_PLAYERS];
new gPlayerMoney[MAX_PLAYERS];

public GlobotAntiCheatInit()
{
	print("init()");
	SendClientMessageToAll(COLOR_ALERT, "-/\\-\\/- anticheat by Globot (v1.0) -\\/-/\\-");
	Max_Players = GetMaxPlayers();

#if defined AUTOBALANCE
	SetTimer("AutoTeamBalance", 5000, -1);
#endif
	SetTimer("CheckPlayerMove", CHECK_INTERVAL, -1);
	SetTimer("CheckPlayerMoney", CHECK_INTERVAL, -1);
	SetTimer("CheckPlayerHealth", CHECK_INTERVAL, -1);
	SetTimer("CheckIdlePlayer", 1000, -1);
	SetTimer("CheckPlayerTeam", 50, -1);
}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

public ChangePlan(&Float:x, &Float:y, Float:ang) {

}

public Float:AverageFilter(Float:SpeedTab[LAST_SPEED], &Float:newSpeed)
{
	new iter;
	new Float:speed = Float:newSpeed;
	new Float:mini= SpeedTab[1];
	new Float:maxi= SpeedTab[1];

	for (iter = 1; iter < LAST_SPEED; iter++) {
	    SpeedTab[iter-1] = Float:SpeedTab[iter];
	    if (Float:SpeedTab[iter] < mini)
	        mini = Float:SpeedTab[iter];
		if (Float:SpeedTab[iter] > maxi)
	        maxi = Float:SpeedTab[iter];
	}
	SpeedTab[LAST_SPEED-1] = Float:newSpeed;
    if (Float:speed < mini)
        mini = Float:speed;
	if (Float:speed > maxi)
        maxi = Float:speed;

	speed = Float:0.0;
	for (iter = 0; iter < LAST_SPEED; iter++) {
	    speed = Float:speed + Float:SpeedTab[iter];
	}
	speed = Float:speed - (Float:mini + Float:maxi);
	speed = Float:speed / (LAST_SPEED-2);

	newSpeed = Float:speed;

	return Float:newSpeed;
}


public CheckPlayerMove()
{
	new i;
	new Float:x,Float:y,Float:z,Float:Ang;
	new Float:x2,Float:y2,Float:z2,Float:Ang2;
	new Float:speed = 0.0;
	new Float:acceleration;
	new str[STR_LEN] = "";

	//print("CheckPlayerMove()");
	for (i=0; i<Max_Players; i++) {
		GetPlayerPos(i, x, y, z);
		GetPlayerFacingAngle(i, Ang);
		//format (str, STR_LEN, "x=%f y=%f z=%f --",x,y,z);
		//SendClientMessage(i, COLOR_BLUE, str);
		x2 = gPlayerPos[i][0];
		y2 = gPlayerPos[i][1];
		z2 = gPlayerPos[i][2];
		gPlayerPos[i][0] = x;
		gPlayerPos[i][1] = y;
		gPlayerPos[i][2] = z;
		gPlayerIdle[i] += 1;
		
		// here there are two very particular case when very close to 0 and 360
		// but we will considere those cas as almost impossible and don't manage them
		Ang2 = Ang-0.01;
		Ang2 += (Ang2<0.0)?360.0:0.0;
		if (gPlayerActive[i] && IsPlayerConnected(i) && (gPlayerAngle[i] > ((Ang+0.01))  || gPlayerAngle[i] < Ang2)) {
		    //printf("%f <=> %f", gPlayerAngle[i], Ang);
			gPlayerIdle[i] = 0;
		}
        gPlayerAngle[i] = Ang;
        
        
		if (x == x2 && y == y2 && z == z2 && gPlayerLastMove[i] <= (Float:(1000/CHECK_INTERVAL)*2)) {
			gPlayerLastMove[i] += 1.0;
		}
	    else if (gPlayerActive[i] == 1 && IsPlayerConnected(i) && gPlayerRespawning[i] == 0) {
	        //new Float:tmpnum;
	        //tmpnum = gPlayerLastMove[i];
	        //printf ("idle time %d",gPlayerIdle[i]);
			if (x != x2 || y != y2 || z != z2 ) {
				gPlayerIdle[i] = 0;
			}
	        new isDown = 0;
	        
		    x = Float:x - Float:x2;
		    y = Float:y - Float:y2;
		    z = Float:z - Float:z2;
			    
			new Float:a;
			a = CHECK_INTERVAL*gPlayerLastMove[i];
			gPlayerLastMove[i] = 1.0;
			
			z=Float:(Float:z*1000)/a;
			y=Float:(Float:y*1000)/a;
			x=Float:(Float:x*1000)/a;

			AverageFilter(gPlayerXSpeedTab[i], x);
			AverageFilter(gPlayerYSpeedTab[i], y);
			AverageFilter(gPlayerZSpeedTab[i], z);

			if (z<0) {
			    isDown = 1;
			}

			z = (z < 0.0) ? z*-1.0: z*1.0;
			y = (y < 0.0) ? y*-1.0: y*1.0;
			x = (x < 0.0) ? x*-1.0: x*1.0;

 			//GetPlayerPos(i, gPlayerPos[i][0], gPlayerPos[i][1], gPlayerPos[i][2]);

			//format (str, STR_LEN, "x=%f y=%f z=%f --",x,y,z);
			//SendClientMessage(i,COLOR_BLUE,str);
 			if (IsPlayerInCar(i) && (z > 20 || (x<1 && y < 1 && x>=0 && y >= 0 && z > 5)) && isDown==0 && gDisableCheckMove[i] == 0) {
 				gPlayerFlyCarCount[i]++;
 				if (gPlayerFlyCarCount[i]>=2) {
	 			    new name[64] = "";
 				    GetPlayerName(i, name, 64);
	        	 	gTotalCheatCount[i]++;
 				    format(str, STR_LEN, "Alert: %s id %d is using flying car cheat and have been find", name, i);
					SendClientMessageToAll(COLOR_ALERT, str);

	 			    print(str);
					printf("vertical speed %f m/s", z);
	    	    	PunishPlayer(i, 2);
				}
				else {
	 			    new name[64] = "";
 				    GetPlayerName(i, name, 64);
 				    format(str, STR_LEN, "Warning: %s id %d suspected using flying car cheat", name, i);
					SendClientMessage(i,COLOR_WARNING, str);
				}
 			}
			else if (!IsPlayerInAnyVehicle(i) && isDown == 0 && (/*(z > 3.0 && z < 5.1)||*/ z > 13 && z < 25) && gDisableCheckMove[i] == 0) {
				gPlayerSuperJumpCount[i] ++;
				printf("vertical speed %f m/s", z);
			    //printf ("player %d is on foot !!!", i);
				if ( gPlayerSuperJumpCount[i]>=3) {

 			    	new name[64] = "";
 			    	GetPlayerName(i, name, 64);
	        	 	gTotalCheatCount[i]++;
 			    	format(str, STR_LEN, "Alert: %s id %d is using superjump cheat and have been find", name, i);
					SendClientMessageToAll(COLOR_ALERT, str);

 			    	print(str);

	    	    	PunishPlayer(i, 1);
				}
			}
			else {
				gPlayerFlyCarCount[i] = 0;
			}

			//format (str, STR_LEN, "x=%f y=%f z=%f ",x,y,z);
			//SendClientMessage(i,COLOR_BLUE,str);
				speed = Float:floatpower(x,2) + Float:floatpower(y,2);
				speed = Float:floatsqroot(Float:speed);
				speed = Float:floatpower(speed,2) + Float:floatpower(z,2);
				speed = Float:(floatsqroot(Float:speed)*3.6);
				
				AverageFilter(gPlayerSpeedTab[i], speed);

			if (speed > 0.01){
				gPlayerIdle[i] = 0;
			}

			acceleration = Float:((speed - gPlayerSpeed[i])/3.6);

			//format (str, STR_LEN, "x=%f y=%f z=%f -- Speed=%f km/h %d -- acc=%f m/s2 %d",x,y,z,speed,speed,acceleration,acceleration);
			//SendClientMessage(i,COLOR_BLUE,str);

			if (((acceleration > 15 && IsPlayerInCar(i)) || (acceleration > 30 && IsPlayerInAnyVehicle(i))) && gDisableCheckMove[i] == 0) {
				gPlayerOverAccelerateCount[i]++;
			    if (gPlayerOverAccelerateCount[i] > MAX_OVERSPEED_WARNING) {
	 			    new name[64] = "";
 				    GetPlayerName(i, name, 64);
	        	 	gTotalCheatCount[i]++;
 				    format(str, STR_LEN, "Alert: %s id %d is using overacceleration cheat (%f m/s2) and have been find", name, i, acceleration);
					SendClientMessageToAll(COLOR_ALERT, str);
					print (str);
	    	    	PunishPlayer(i, 2);
			    }
			    else if (gPlayerOverAccelerateCount[i] > 1) {
					SendClientMessage(i, COLOR_WARNING, "Warning: You are overaccelerating... cheater will be find !");
					printf ("warning: overaccelerate player %d, acceleration = %f m/s2", i, acceleration);
			    }
			}
			else {
			    gPlayerOverAccelerateCount[i] = 0;
			}
			if (((acceleration < -15 && IsPlayerInCar(i)) || (acceleration < -25 && IsPlayerInAnyVehicle(i))) && gDisableCheckMove[i] == 0) {
				//SendClientMessage(i, COLOR_WARNING, "warning: it look like you bump something");
				printf("warning: it look like player %d bump something, acceleration %f m/s2", i, acceleration);
				gBumpDetection[i]++;

			}


			///////////////////////////////////////////////////////////////////
			// end of speed test
			///////////////////////////////////////////////////////////////////
			gPlayerSpeed[i] = speed;

 			if ((speed >= MAX_ALLOWED_SPEED ||
			 	(IsPlayerInCar(i) && speed > MAX_ALLOWED_CAR_SPEED) ||
				 (!IsPlayerInAnyVehicle(i) && speed > MAX_ALLOWED_CAR_SPEED)) && gDisableCheckMove[i] == 0) {
 			    if (gPlayerOverSpeedCount[i]>0) {
					SendClientMessage(i, COLOR_WARNING, "Warning: You are overspeeding... cheater will be find !");
					printf ("warning: overspeed player %d, speed = %f km/h %d", i, speed, speed);
				}
 				gPlayerOverSpeedCount[i]++;
			}
			else {
 				gPlayerOverSpeedCount[i] = 0;
			}
 			//format(str, STR_LEN, "id: %d -v- x=%f y=%f z=%f --- speed = %fkm/h\0", i, x, y, z,speed);
 			//print(str);

 			if (gPlayerOverSpeedCount[i] > MAX_OVERSPEED_WARNING && gDisableCheckMove[i] == 0) {
 			    new name[64] = "";
 			    GetPlayerName(i, name, 64);
	        	gTotalCheatCount[i]++;
 			    format(str, STR_LEN, "Alert: %s id %d is using overspeed (%f km/h %d) cheat and have been find", name, i, speed, speed);
				SendClientMessageToAll(COLOR_ALERT, str);
				print(str);
	    	    PunishPlayer(i, 2);
 			}
 			if ((gPlayerWarp[i] <= 0 && gPlayerSpeedTab[i][LAST_SPEED-1] > 2500 && z > 250 && z < 900 && gDisableCheckMove[i] == 0 && isDown == 0)/* ||
			 	(gPlayerWarp[i] <= 0 && gPlayerSpeedTab[i][LAST_SPEED-1] > 2500 && z > 250 && z < 900 && gDisableCheckMove[i] == 0 && isDown == 1)*/) {
 			    new name[64] = "";
 			    GetPlayerName(i, name, 64);
	        	gTotalCheatCount[i]++;
 			    format(str, STR_LEN, "Alert: %s id %d is using teleportation (%f km/h) and have been find", name, i, gPlayerSpeedTab[i][LAST_SPEED-1]);
 			    printf("x=%f y=%f z=%f", x, y, z);
				SendClientMessageToAll(COLOR_ALERT, str);
				print(str);
	    	    PunishPlayer(i, 2);
 			}
 			else if (gPlayerSpeedTab[i][LAST_SPEED-1] > 2500 && z >= (900))
 			{
				gPlayerSpeedTab[i][LAST_SPEED-1] = 0.0;
 			}
 			if (gPlayerWarp[i]>0) {
				gPlayerWarp[i]--;
				gPlayerSpeedTab[i][LAST_SPEED-1] = 0.0;
			}
		}
	}
	//SetTimer("CheckPlayerMove", CHECK_INTERVAL, 0);
	return true;
}




/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

public CheckPlayerHealth() {
	new i;
	new Float:health;
	new Float:x, Float:y, Float:z;
    new str[STR_LEN];

	//print("checkPlayerHealth()");
	for (i=0; i<Max_Players; i++) {
    	GetPlayerPos(i, x, y, z);
    	GetPlayerHealth(i, health);
		if (gPlayerActive[i] == 1 && IsPlayerConnected(i) && gPlayerRespawning[i] == 0 && gPlayerFrag[i] == 0 && gDisableCheckHealth[i] == 0) {
	    	if ((health > gPlayerHealth[i] && z < 950.0) || health > 200.0) {
     			new name[64] = "";
			    GetPlayerName(i, name, 64);
				gPlayerHealthCount[i]++;
   				format(str, STR_LEN, "Warning: '%s' id %d is cheating on health", name, i);
				print(str);
				if (gPlayerHealthCount[i] > 1) {
		    	    SendClientMessage(i, COLOR_WARNING, "Warning: presumed cheating on health");
	    		}
				if (gPlayerHealthCount[i] > 1) {
	        	 	gTotalCheatCount[i]++;
			        format(str, STR_LEN, "Alert: '%s' id %d is cheating on health", name, i);
		    	    SendClientMessageToAll(COLOR_ALERT, str);
			        print(str);
					DisableCheckHealth(i,2);
		    	    PunishPlayer(i, 1);
				}
	    	}
   		}
   		else
			gPlayerHealth[i] = health;
    	if (gPlayerFrag[i]>0)
			gPlayerFrag[i]--;

		gPlayerHealth[i] = health;
	}
	return true;
}

public CheckPlayerMoney()
{
	new i;
	new money;
	new name[64] = "";
	new str[STR_LEN] = "";
	for (i=0; i<Max_Players; i++) {
	    money = GetPlayerMoney(i);
		if (gPlayerActive[i] == 1 && IsPlayerConnected(i) && gDisableCheckMoney[i] == 0) {
		    if (gPlayerMoney[i] < (money-MAX_EARNED_MONEY)) {
		        GetPlayerName(i,name,64);
	        	gTotalCheatCount[i]++;
			    format(str, STR_LEN, "Alert: '%s' id %d is cheating on money", name, i);
		    	SendClientMessageToAll(COLOR_ALERT, str);
			    print(str);
				DisableCheckMoney(i,2);
		        ResetPlayerMoney(i);
		        GivePlayerMoney(i, -10000);
		    }
		}
	    gPlayerMoney[i] = money;
	}
	return true;
}


public CheckIdlePlayer()
{
	new i;
	//new tmp;
    new str[STR_LEN];
	new name[64] = "";
	if (gPlayerKickNum > 0) {
		for (i=0; gPlayerKickNum > 0; i++) {
		    gPlayerKickNum--;
	     	Kick(gPlayerKickList[i]);
		}
	}
	
	for (i=0; i<Max_Players;i++) {
	    if (gDisableCheckMove[i] > 0) {
	        gDisableCheckMove[i]--;
	    }
	    if (gDisableCheckHealth[i] > 0) {
	        gDisableCheckHealth[i]--;
	    }
	    if (gDisableCheckMoney[i] > 0) {
	        gDisableCheckMoney[i]--;
	    }
	    if (IsPlayerConnected(i)) {
	        /*
	        tmp = gPlayerIdle[i]%(30*CHECK_INTERVAL/1000);
		    printf ("player %d idle for %d -- %f",i, gPlayerIdle[i], gPlayerIdle[i]);
		    if (gPlayerActive[i] == 1 && gPlayerIdle[i]>(CHECK_INTERVAL/1000) &&
				tmp <= (CHECK_INTERVAL/1000)) {
				GetPlayerName(i,name,64);
				format(str, STR_LEN, "player '%s' id %d is idle since %d seconds",name,i,((gPlayerIdle[i]*CHECK_INTERVAL)/1000));
		        print(str);
				format(str, STR_LEN, "you should movesometime you are idle since %d seconds",((gPlayerIdle[i]*CHECK_INTERVAL)/1000));
				SendClientMessage(i, COLOR_WARNING, str);
		    }
		    */
		    if (((gPlayerIdle[i]*CHECK_INTERVAL)/1000) > (MAX_IDLE_TIME) && gPlayerActive[i] == 1) {
				GetPlayerName(i,name,64);
				format(str, STR_LEN, "player '%s' id %d have been kicked for long idle time (%d s)",name,i,((gPlayerIdle[i]*CHECK_INTERVAL)/1000));
				gPlayerKickList[gPlayerKickNum++] = i;
		        SendClientMessageToAll(COLOR_ALERT, str);
		        print(str);
		        //Kick(i);
		    }
    	}
	}
}

public CheckPlayerTeam()
{
	new t;
	for (new i = 0; i < Max_Players; i++) {
	    if (IsPlayerConnected(i) && gPlayerActive[i] == 1) {
			t = GetPlayerTeam(i);
			gTeam[i] = t;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////
//////////////////////////   public functions   //////////////////////////////
//////////////////////////                     //////////////////////////////
/////////////////////////////////////////////////////////////////////////////


public IsPlayerInCar(playerid) {
	new /*len,i,*/carid;

	//len = sizeof(gCarTab);
	carid=GetPlayerVehicleID(playerid);
	//printf ("is player %d in carid = %d", playerid, carid);
	if (carid > MAX_PLANE_NUM && IsPlayerInAnyVehicle(playerid))
	    return true;
	/*
	for (i= 0; i < len; i++) {
	    if (carid == gCarTab[i]) {
	        return 1;
	    }
	}
	*/
	return false;
}

public IsPlayerInPlane(playerid) {
	new /*len,i,*/carid;

	carid=GetPlayerVehicleID(playerid);

	if (carid <= MAX_PLANE_NUM && IsPlayerInAnyVehicle(playerid))
	    return true;
	return false;
}

/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

public PunishPlayer(playerid, penality)
{
	new score;
	if (gPlayerRespawning[playerid] == 0) {
		score = GetPlayerScore(playerid);
		if (IsPlayerInAnyVehicle(playerid)) {
		    RemovePlayerFromVehicle(playerid);
		}
		SetPlayerHealth(playerid, 0.0);
	 	gTotalCheatCount[playerid]++;
		SetPlayerPos(playerid, 11679.757446, 11609.862915, -10.820312);
		gPlayerPos[playerid][0] = 11679.757446;
		gPlayerPos[playerid][1] = 11609.862915;
		gPlayerPos[playerid][2] = -10.820312;
		SetPlayerScore(playerid, score-penality);
	}
	DisableCheckMove(playerid,3);
}




/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////


#if defined AUTOBALANCE
public RespawnInterval()
{
	new i;
	for (i=0; i< Max_Players; i++) {
	    gPlayerRespawning[i] = 0;
	}
	gTeamBalance = 0;
	//SetTimer("RespawnInterval", 10000, 0);
}

public KeepSpawnOrder(playerid)
{
	new i;

    gSpawnOrder[Max_Players-1] = playerid;
	//print("KeepSpawnOrder");
	for (i = 1; i < Max_Players; i++) {
	    gSpawnOrder[i-1] = gSpawnOrder[i];
	}
	gSpawnOrder[Max_Players-1] = -1;
	return 1;
}

public AutoTeamBalance()
{
	new count[3];
	new total;
	new i;

	//print("AutoTeamBalance()");
	for (total = count[0] = count[1] = count[2] = i = 0; i < Max_Players; i++) {
		if (IsPlayerConnected(i) && gPlayerActive[i] == 1) {
			total++;
			if (gTeam[i] == 0)
			    count[0]++;
			else
			    count[1]++;
	 		//if (gClassid[i] == 2)
	 		//    count[2]++;
    	}
	}
	if (count[0]*(TEAM_1_RATIO+TEAM_2_RATIO)/TEAM_1_RATIO < total && gTeamBalance == 0)
	{
		new PlayerTab[MAX_PLAYERS];
		new cnt = 0;
		new j;
		new isIn = 0;
		new res;
		new str[STR_LEN] = "";

		res = total*TEAM_1_RATIO/(TEAM_1_RATIO+TEAM_2_RATIO);
		res -= count[0];
		if (res > 0) {
			GameTextForAll("~w~there are too many ~g~terrorists ~w~ autobalancing now...", 5000, 3);
		    for (i = Max_Players-1; i >= 0 && res > 0; i--) {
				if (gSpawnOrder[i] >= 0 && gSpawnOrder[i] < Max_Players) {
			        for (j = isIn = 0; j < Max_Players && j < cnt; j++) {
						if (PlayerTab[j] == gSpawnOrder[i]){
						    isIn = 1;
						    break;
					    }
			        }
					if (gTeam[gSpawnOrder[i]] != 0 && !IsPlayerInAnyVehicle(gSpawnOrder[i]) && isIn==0) {
					    PlayerTab[cnt] = gSpawnOrder[i];
					    cnt++;
						DisablePlayerCheckpoint(gSpawnOrder[i]);
						SetPlayerInterior(gSpawnOrder[i],RESPAWN_TEAM_1_INTERIOR);
						SetPlayerTeam(gSpawnOrder[i],0);
						SetPlayerSkin(gSpawnOrder[i],RESPAWN_TEAM_1_ID);
						SetPlayerPos(gSpawnOrder[i], RESPAWN_TEAM_1);
						gPlayerPos[gSpawnOrder[i]] = Float:{RESPAWN_TEAM_1};
						SetPlayerColor(gSpawnOrder[i], RESPAWN_TEAM_1_COLOR);
						format(str,STR_LEN,"~w~ change team too ~b~%s~w~ !!!",RESPAWN_TEAM_1_MSG);
						GameTextForPlayer(gSpawnOrder[i], str, 2000, 0);
						gTeam[gSpawnOrder[i]] = 0;
						ResetPlayerWeapons(gSpawnOrder[i]);
						GivePlayerWeapon(gSpawnOrder[i] WEAPONS_TEAM_1_1);
						GivePlayerWeapon(gSpawnOrder[i] WEAPONS_TEAM_1_2);
						GivePlayerWeapon(gSpawnOrder[i] WEAPONS_TEAM_1_3);
						gClassid[gSpawnOrder[i]] = RESPAWN_TEAM_1_CLASSID;
						SetSpawnInfo(gSpawnOrder[i],0,RESPAWN_TEAM_1_ID,RESPAWN_TEAM_1, 269.1425 WEAPONS_TEAM_1_1 WEAPONS_TEAM_1_2 WEAPONS_TEAM_1_3 );

 	    				gPlayerRespawning[gSpawnOrder[i]] = 1;
 	    				gPlayerWarp[gSpawnOrder[i]]++;
 	    				if(gTeamBalance != 2) {
							SetTimer("RespawnInterval", 2000, 0);
 	    					gTeamBalance = 2;
 	    					DisableCheckMove(gSpawnOrder[i], 3);
 	    				}
						res--;
					}
				}
		    }

		}
	}
	else if (gTeamBalance == 0)
	{
		new PlayerTab[MAX_PLAYERS];
		new cnt = 0;
		new j;
		new isIn = 0;
		new res;
		new str[STR_LEN] = "";

		res = total*TEAM_2_RATIO/(TEAM_1_RATIO+TEAM_2_RATIO);
		res -= count[1];
		if (res > 0) {
			GameTextForAll("~w~there are too many ~b~Defenders ~w~ autobalancing now...", 5000, 3);
		    for (i = Max_Players-1; i >= 0 && res > 0; i--) {
				if (gSpawnOrder[i] >= 0 && gSpawnOrder[i] < Max_Players) {
			        for (j = isIn = 0; j < Max_Players && j < cnt; j++) {
						if (PlayerTab[j] == gSpawnOrder[i]){
						    isIn = 1;
						    break;
					    }
			        }
					if (gTeam[gSpawnOrder[i]] == 0 && !IsPlayerInAnyVehicle(gSpawnOrder[i]) && isIn==0) {
					    PlayerTab[cnt] = gSpawnOrder[i];
					    cnt++;
						DisablePlayerCheckpoint(gSpawnOrder[i]);
						SetPlayerInterior(gSpawnOrder[i],RESPAWN_TEAM_2_INTERIOR);
						SetPlayerTeam(gSpawnOrder[i],1);
						SetPlayerSkin(gSpawnOrder[i],RESPAWN_TEAM_2_ID);
						SetPlayerPos(gSpawnOrder[i], RESPAWN_TEAM_2);
						gPlayerPos[gSpawnOrder[i]] = Float:{RESPAWN_TEAM_2};
						SetPlayerColor(gSpawnOrder[i], RESPAWN_TEAM_2_COLOR);
						format(str,STR_LEN,"~w~ change team too ~b~%s~w~ !!!",RESPAWN_TEAM_2_MSG);
						GameTextForPlayer(gSpawnOrder[i], str, 2000, 0);
						gTeam[gSpawnOrder[i]] = 1;
						ResetPlayerWeapons(gSpawnOrder[i]);
						GivePlayerWeapon(gSpawnOrder[i] WEAPONS_TEAM_2_1);
						GivePlayerWeapon(gSpawnOrder[i] WEAPONS_TEAM_2_2);
						GivePlayerWeapon(gSpawnOrder[i] WEAPONS_TEAM_2_3);
						gClassid[gSpawnOrder[i]] = RESPAWN_TEAM_2_CLASSID;
						SetSpawnInfo(gSpawnOrder[i], 1,RESPAWN_TEAM_2_ID,RESPAWN_TEAM_2, 88.829063 WEAPONS_TEAM_2_1 WEAPONS_TEAM_2_2 WEAPONS_TEAM_2_3 );
						
 	    				gPlayerRespawning[gSpawnOrder[i]] = 1;
 	    				gPlayerWarp[gSpawnOrder[i]]++;
 	    				if(gTeamBalance != 2) {
							SetTimer("RespawnInterval", 2000, 0);
 	    					gTeamBalance = 2;
 	    					DisableCheckMove(gSpawnOrder[i], 3);
 	    				}
						res--;
					}
				}
			}


		}
		//GameTextForAll("~w~there are too much ~g~defender", 5000, 3);
	}


	//SetTimer("AutoTeamBalance", 5000, 0);
	return true;
}
#endif

/////////////////////////////////////////////////////////////////////////////
//////////////////////////   Events functions  //////////////////////////////
//////////////////////////                     //////////////////////////////
/////////////////////////////////////////////////////////////////////////////



public OnPlayerRequestClass(playerid, classid)
{
    //gPlayerActive[playerid] = 0;
    MyOnPlayerRequestClass(playerid, classid);
	gClassid[playerid] = classid;
	return 1;
}

public OnPlayerConnect(playerid)
{
	new i;
	MyOnPlayerConnect(playerid);
	//printf("OnPlayerConnect(%d)", playerid);
    gPlayerActive[playerid] = 0;
	gTotalCheatCount[playerid] = 0;
	gPlayerFrag[playerid] = 0;
	gPlayerWarp[playerid] = 0;

    for (i=0; i<Max_Players; i++) {
		gReportCheat[playerid][i] = 0;
    }
    for (i=0; i<Max_Players; i++) {
		gReportCheat[i][playerid] = 0;
    }
	gReportCheatCount[playerid] = 0;
	gPlayerIdle[playerid] = 0;

    gDisableCheckMove[playerid] = 0;
    gDisableCheckHealth[playerid] = 0;
    gDisableCheckMoney[playerid] = 0;
    
	SendClientMessage(playerid, COLOR_BLUE, "-/\\-\\/- anticheat by Globot (v1.0) -\\/-/\\-");
	SendClientMessage(playerid, COLOR_YELLOW, "use /? or /help form commands list");
	return 1;
}

public OnPlayerDisconnect(playerid)
{
	//printf("OnPlayerDisconnect(%d)", playerid);
	MyOnPlayerDisconnect(playerid);
    gPlayerActive[playerid] = 0;

    gDisableCheckMove[playerid] = 0;
    gDisableCheckHealth[playerid] = 0;
    gDisableCheckMoney[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid/*, Float:x, Float:y, Float:z*/)
{
    MyOnPlayerSpawn(playerid);
    
	gPlayerIdle[playerid] = 0;
	//printf("OnPlayerSpawn(%d)", playerid);
#if defined NO_TEAMKILL
 	lTeamKillCount[playerid] = 0;
#endif
 	gPlayerRespawning[playerid] = 1;
	SetTimer("RespawnInterval", 1000, 0);
	/*
	gPlayerPos[playerid][0] = x;
	gPlayerPos[playerid][1] = y;
	gPlayerPos[playerid][2] = z;
	*/
	DisableCheckMove(playerid, 1);
	DisableCheckHealth(playerid,1);

 	gPlayerActive[playerid] = 1;
 	gPlayerOverSpeedCount[playerid] = 0;
    gPlayerSuperJumpCount[playerid] = 0;
    gPlayerFlyCarCount[playerid] = 0;
    

	gBumpDetection[playerid] = 0;

	gPlayerSpeed[playerid] = 0;
	gPlayerOverAccelerateCount[playerid] = 0;

	//GetPlayerHealth(playerid, health);
	gPlayerHealth[playerid] = 200.0;
	gPlayerHealthCount[playerid] = 0;
    //gPlayerHealthCheck2[playerid] = 0;
	//gTeam[playerid] = GetPlayerTeam(playerid);
	new it;
	for (it = 0; it < LAST_SPEED; it++) {
	    gPlayerSpeedTab[playerid][it] = 0;
	    gPlayerXSpeedTab[playerid][it] = 0;
	    gPlayerYSpeedTab[playerid][it] = 0;
	    gPlayerZSpeedTab[playerid][it] = 0;
	}
#if defined AUTOBALANCE
    KeepSpawnOrder(playerid);
#endif
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	//printf("OnPlayerDeath(%d, %d, %d)", playerid, killerid, reason);
	MyOnPlayerDeath(playerid, killerid, reason);
 	gPlayerActive[playerid] = 0;
 	gPlayerRespawning[playerid] = 1;
    gDisableCheckMove[playerid] = 0;
    gDisableCheckHealth[playerid] = 0;
    gDisableCheckMoney[playerid] = 0;
#if defined NO_TEAMKILL
	new score;
	//printf ("player id %d team %d, killer id %d team %d", playerid, gTeam[playerid], killerid, (killerid<Max_Players) ? gTeam[killerid]: -1);
	if (killerid >= 0 && killerid < Max_Players && gTeam[playerid] == gTeam[killerid]) {
	    lTeamKillCount[killerid]++;
	    if (IsPlayerInAnyVehicle(killerid)) {
	    	RemovePlayerFromVehicle(killerid);
	    }
	    if (lTeamKillCount[killerid] >= 1 ) {
	    	new name[64] = "";
		    SetPlayerHealth(killerid, 0.0);
	    	gTeamKillCount[killerid]++;
	    	GameTextForPlayer(killerid, "You just kill a teammate sucker!!!", 1, 0);
	    	GetPlayerName(killerid, name, 64);
	    	printf("'%s' id %d just kill a teammate!!", name, killerid);
	    }
	    if (gTeamKillCount[killerid] >= MAX_TEAMKILL) {
	    	GameTextForPlayer(killerid, "You have been kicked out for team killing!!!", 1, 0);
	    	SendClientMessage(killerid, COLOR_ALERT, "You have been kicked out for team killing!!!");
	    	new str[STR_LEN] = "";
	    	new name[64] = "";
	    	GetPlayerName(killerid, name, 64);
	    	printf("'%s' have been kicked for teamkilling", name);
	    	format(str, STR_LEN, "%s (%d) have been kicked for team killing !!!\n\0", name, killerid);
	    	SendClientMessageToAll(COLOR_ALERT, str);
	    	gPlayerKickList[gPlayerKickNum++] = killerid;
	    	//Kick(killerid);
	    }
		score = GetPlayerScore(killerid);
		SetPlayerScore(killerid, score-2);
	}
#endif
	/*
	else {
	    new Float:health;
	    GetPlayerHealth(killerid, health);
	    if (health < 100.0)
		    SetPlayerHealth(killerid, health+15.0);
		gPlayerHealth[killerid] = 200;//health+15.0;
	}
 	*/
#if defined ALL_WEAPONS
#else
	new i,forbidden;
 	for (i=0, forbidden=1; i< sizeof(gAllowedWeapons); i++) {
 	    if (reason == gAllowedWeapons[i]) {
 	        forbidden = 0;
 	        break;
	 	}
 	}
	if (forbidden == 1 && reason > 1 && reason < 44 && killerid >= 0 && killerid < Max_Players) {
	    //if ( reason != 27 && reason != 28 && reason != 29 && reason != 30 && reason != 33 && reason < 44) {
	    	new name[64] = "";
	    	new str[STR_LEN] = "";
	    	GetPlayerName(killerid, name, 64);
	    	format(str, STR_LEN, "'%s' have been punish for forbiden weapon (%d)", name, reason);
	    	print(str);
	    	SendClientMessageToAll(COLOR_ALERT, str);
	  		PunishPlayer(killerid, 2);
	    	/*
			score = GetPlayerScore(killerid);
			SetPlayerScore(killerid, score-5);
			SetPlayerPos(killerid, 11679.757446, 11609.862915, -10.820312);
			//GetPlayerPos(i, gPlayerPos[i][0], gPlayerPos[i][1], gPlayerPos[i][2]);
			*/

	    //}
	}
#endif
	gPlayerFrag[playerid]++;
    //gPlayerHealthCheck2[playerid] = 0;
	//gTeam[playerid] = -1;
	SetPlayerTeam(playerid, 255);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new res;
	res = MyOnPlayerText(playerid, text);
	//printf("OnPlayerText(%d)", playerid);
	gPlayerIdle[playerid] = 0;
	
	if (!res)
		return 0;
		
	if (text[0] == '!' && strlen(text) > 1) {
	    new i;
	    new msg[1024];
	    new name[64];
	    text[0] = ' ';
	    
	    GetPlayerName(playerid,name,64);
	    format(msg, 1024, "[TEAM] %s : %s", name, text);
	    for (i=0; i<Max_Players; i++) {
	        if (IsPlayerConnected(i) && gTeam[i] >=0 &&	gTeam[playerid] >=0 && gTeam[i] == gTeam[playerid]) {
	        	SendClientMessage(i, COLOR_GREY, msg);
	        }
	    }
	    return 0;
	}
		
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new str[STR_LEN] = "";

	gPlayerIdle[playerid] = 0;
	if (MyOnPlayerCommandText(playerid, cmdtext) == 1)
	    return 1;
	// parsing commnd text
	if (strcmp(cmdtext, "/where", true)==0)
	{
		new Float:x;
		new Float:y;
		new Float:z;
		new Float:ang;
		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, ang);
		format(str, STR_LEN, "x=%f y=%f z=%f ang=%f\n\0", x, y, z, ang);
		print(str);
		SendClientMessage(playerid,COLOR_YELLOW, str);
	    return 1;
	}
	if (strcmp(cmdtext, "/time", true)==0)
	{
	    new year;
	    new month;
	    new day;
	    new hour;
	    new minute;
	    new second;
	    getdate(year, month, day);
	    gettime(hour,minute,second);
	    format(str, STR_LEN, "%d/%d/%d -- %d:%d:%d", year,month,day,hour,minute,second);
		SendClientMessage(playerid,COLOR_YELLOW, str);
	    return 1;
	}
	if (strcmp(cmdtext, "/restartserver", true)==0)
	{/*
		GameTextForAll("~y~Game Mod End", 5000, 1);
		SetTimer("GameModeExitFunc", 5000, 0);
		// if i where you i won't keep this block ;)
		*/
	    return 1;
	}

	if (strcmp(cmdtext, "/help", true)==0 || strcmp(cmdtext, "/?", true)==0)
	{
		SendClientMessage(playerid,COLOR_YELLOW, "/help, /?");
		SendClientMessage(playerid,COLOR_YELLOW, "! => used for team speak");
		SendClientMessage(playerid,COLOR_YELLOW, "/time (give the server time)");
		SendClientMessage(playerid,COLOR_YELLOW, "/where (show your position)");
		SendClientMessage(playerid,COLOR_YELLOW, "/vote kick id, /vote end (end the mod), /vote (yes/no)");
		SendClientMessage(playerid,COLOR_YELLOW, "/report id (to report cheater)");
		return 1;
	}
	if (strcmp(cmdtext, "/vote kick ", true, 11)==0 && gVoteInProgress == 0) {
	    new id_str[32] = "";
	    new id;
	    strmid(id_str, cmdtext, 11, strlen(cmdtext), 32);
	    id = strval(id_str);
	 	printf ("kick id : %s => %d => %f", id_str, id, id);
	    if(id >=0 && id < Max_Players && IsPlayerConnected(id) && gTotalCheatCount[id] > 1) {
	        new name[32] = "";
	        gVoteInProgress = 1;
	        GetPlayerName(id, id_str, 32);
	        GetPlayerName(playerid, name, 32);
	        format(gVoteStr,STR_LEN, "'%s' ask if you want to kick '%s' (%d) (tape: /vote yes)", name, id_str, id);
	        print(gVoteStr);
	        SendClientMessageToAll(COLOR_BLUE, gVoteStr);
	        SetTimer("VoteReminder", 20000, 0);
	        gVoteReminder = 0;
	        gVoteCount = 1;
	        gVoteParams[0] = 1;
	        gVoteParams[1] = id;
	        gVoteParams[2] = playerid;
	        for (id=0; id < Max_Players; id++) {
	            gVoteTicket[id] = 0;
	        }
            gVoteTicket[playerid] = 1;
	    }
	    else if (id >=0 && id < Max_Players && !IsPlayerConnected(id)) {
	        SendClientMessage(playerid, COLOR_BLUE, "This player is not connected now");
     	}
	    else if (id >=0 && id < Max_Players && gTotalCheatCount[id] <= 1) {
	        SendClientMessage(playerid, COLOR_BLUE, "This player do not seem to be a cheater");
	    }
     	return 1;
	}
	else if (strcmp(cmdtext, "/vote end", true, 9)==0 && gVoteInProgress == 0) {
	        new id;
	        GetPlayerName(playerid, str, STR_LEN);
	        format(gVoteStr,STR_LEN, "'%s' want to end the mod (tape: /vote yes)", str);
	        print(gVoteStr);
	        SendClientMessageToAll(COLOR_BLUE, gVoteStr);
	        gVoteInProgress = 1;
	        gVoteReminder = 0;
	        gVoteCount = 1;
	        gVoteParams[0] = 2;
	        gVoteParams[1] = -1;
	        gVoteParams[2] = playerid;
	        for (id=0; id < Max_Players; id++) {
	            gVoteTicket[id] = 0;
	        }
            gVoteTicket[playerid] = 1;
	        SetTimer("VoteReminder", 20000, 0);
	        return 1;
	}
	else if (strcmp(cmdtext, "/vote ", true, 5)==0) {
	    strmid(str, cmdtext, 6, strlen(cmdtext), 32);
	    printf ("vote answer => '%s'", str);
	    if (strcmp(str, "yes", true)==0 && gVoteTicket[playerid] == 0) {
	        gVoteTicket[playerid] = 1;
	        gVoteCount++;
	    }
	    else if (strcmp(str, "no", true)==0 && gVoteTicket[playerid] == 1) {
	        gVoteTicket[playerid] = 0;
	        gVoteCount--;
	    }
	    else if (gVoteInProgress == 1 && gVoteTicket[playerid] == 0) {
	        SendClientMessageToAll(COLOR_BLUE, "other vote already in progress");
	    }
	    return 1;
	}
	else if (strcmp(cmdtext, "/report ",true, 7) == 0) {
	    new id_str[32] = "";
	    new id;
	    new lstr[STR_LEN] = "";
	    strmid(id_str, cmdtext, 8, strlen(cmdtext), 32);
	    id = strval(id_str);
	    GetPlayerName(playerid, str,STR_LEN);
	    if (id >=0 && id < Max_Players)
	    	GetPlayerName(id, id_str, 32);
	    if (id >=0 && id < Max_Players && gReportCheat[playerid][id] == 0 && IsPlayerConnected(id) && id != playerid) {
			gReportCheat[playerid][id] = 1;
         	gReportCheatCount[id] += 1;
   			printf("'%s' reported '%s' (%d) for cheating", str, id_str, id);
         	if (gReportCheatCount[id] >= CHEAT_REPORT_NUMBER) {
         	    gTotalCheatCount[id] += 2;
         	    format(lstr,STR_LEN, "'%s' id %d have been repported as a cheater, you can use: /vote kick %d", id_str, id, id);
	    		SendClientMessageToAll(COLOR_WARNING, lstr);
         	}
         	else {
         	    format(lstr,STR_LEN,"You have reported '%s' id %d as a cheater",id_str, id);
	    		SendClientMessage(playerid, COLOR_BLUE, lstr);
 			}
	    }
	    else if (id != playerid && !IsPlayerConnected(id))
	    	SendClientMessage(playerid, COLOR_WARNING, "You can't report a player who is not connected");
	    else if (id != playerid)
	    	SendClientMessage(playerid, COLOR_WARNING, "You already reported this player as a cheater");
		else
	    	SendClientMessage(playerid, COLOR_WARNING, "You can't report yourself as cheater :)");
		return 1;
	}

	return 0;
}
public VoteReminder()
{
	new i,req;
	for(i = 0; i < Max_Players; i++) {
	    if (IsPlayerConnected(i)) {
	        req++;
	    }
	}
	req /= 2;
	req += 1;

	gVoteReminder++;
	if (gVoteReminder < 3 && req > gVoteCount) {
	    //if (!(gVoteReminder%10)) {
	        SendClientMessageToAll(COLOR_BLUE, gVoteStr);
	        new str[STR_LEN] = "";
	        format(str, STR_LEN, "%d votes yes, %d votes needed !", gVoteCount, req);
	        SendClientMessageToAll(COLOR_BLUE, str);
	 		print(str);
	        SetTimer("VoteReminder", 20000, 0);
    	//}
        return 1;
	}
	else if (req <= gVoteCount) {
	    if (gVoteParams[0] == 1) {
		    new name1[64] = "";
		    new name2[64] = "";
		    new str[STR_LEN] = "";
		    GetPlayerName(gVoteParams[1], name1, 64);
		    GetPlayerName(gVoteParams[2], name2, 64);
		    format(str,STR_LEN,"'%s' kicked player '%s' (%d Votes)", name1, name2, gVoteCount);
		    SendClientMessageToAll(COLOR_ALERT, str);
		    print(str);
		    gPlayerKickList[gPlayerKickNum++] = gVoteParams[2];
		    //Kick(gVoteParams[2]);
	    }
	    else if (gVoteParams[0] == 2) {
		    new name1[64] = "";
		    new str[STR_LEN] = "";
		    GetPlayerName(gVoteParams[2], name1, 64);
		    format(str,STR_LEN,"'%s' has Stoped the Mod (%d Votes)", name1, gVoteCount);
		    SendClientMessageToAll(COLOR_ALERT, str);
		    print(str);
			GameTextForAll("~y~Game Mod End", 5000, 1);
			SetTimer("GameModeExitFunc", 5000, 0);
	    }
	}
	else {
	    new name[64] = "";
	    new str[STR_LEN] = "";
	    if (gVoteParams[0] == 1) {
	    	GetPlayerName(gVoteParams[1], name, 64);
		    format(str,STR_LEN,"vote against '%s' failed !", name);
	    }
	 	else if (gVoteParams[0] == 2) {
	    	GetPlayerName(gVoteParams[2], name, 64);
		    format(str,STR_LEN,"vote restart mod by '%s' failed !", name);
   		}
	    SendClientMessageToAll(COLOR_ALERT, str);
	    print(str);
	}
	gVoteInProgress = 0;
	return 1;
}


public OnPlayerInfoChange(playerid)
{
	MyOnPlayerInfoChange(playerid);
	//printf("OnPlayerInfoChange(%d)");
	gPlayerIdle[playerid] = 0;
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	//printf("OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);
	MyOnPlayerEnterVehicle(playerid, vehicleid, ispassenger);
	gBumpDetection[playerid] = 0;
	gPlayerIdle[playerid] = 0;
	if (vehicleid >= 255)
		RemovePlayerFromVehicle(vehicleid);
	if (ispassenger) {
	    DisableCheckMove(playerid, 360000);
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	//printf("OnPlayerExitVehicle(%d, %d)", playerid, vehicleid);
	MyOnPlayerExitVehicle(playerid, vehicleid);
	gBumpDetection[playerid] = 0;
	gPlayerIdle[playerid] = 0;
    DisableCheckMove(playerid, 1);
	if (vehicleid >= MAX_VEHICLES)
		RemovePlayerFromVehicle(vehicleid);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	//printf("OnPlayerStateChange(%d, %d, %d)", playerid, newstate, oldstate);
	MyOnPlayerStateChange(playerid, newstate, oldstate);
	gPlayerIdle[playerid] = 0;
	if (newstate == oldstate)
	    return 0;
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	MyOnPlayerEnterCheckpoint(playerid);
	//printf("OnPlayerEnterCheckpoint(%d)", playerid);
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
    MyOnPlayerLeaveCheckpoint(playerid);
	//printf("OnPlayerLeaveCheckpoint(%d)", playerid);
	return 1;
}

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

public DisableCheckMove(playerid,time) {
	gDisableCheckMove[playerid] = time;
}
public DisableCheckHealth(playerid,time) {
	gDisableCheckHealth[playerid] = time;
}
public DisableCheckMoney(playerid,time) {
	gDisableCheckMoney[playerid] = time;
}

public GameModeExitFunc()
{
	GameModeExit();
}
/*
public FuckYouInit();
public IsPlayerInCar();
public IsPlayerInPlane();
public PunishPlayer(playerid, penality);
public DisableCheckMove(playerid,time);
public DisableCheckHealt(playerid,time);
public DisableCheckMoney(playerid,time);
*/