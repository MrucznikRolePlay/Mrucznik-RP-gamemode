//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                praca_medyk                                                //
//----------------------------------------------------*------------------------------------------------------//
//----[                                                                                                 ]----//
//----[         |||||             |||||                       ||||||||||       ||||||||||               ]----//
//----[        ||| |||           ||| |||                      |||     ||||     |||     ||||             ]----//
//----[       |||   |||         |||   |||                     |||       |||    |||       |||            ]----//
//----[       ||     ||         ||     ||                     |||       |||    |||       |||            ]----//
//----[      |||     |||       |||     |||                    |||     ||||     |||     ||||             ]----//
//----[      ||       ||       ||       ||     __________     ||||||||||       ||||||||||               ]----//
//----[     |||       |||     |||       |||                   |||    |||       |||                      ]----//
//----[     ||         ||     ||         ||                   |||     ||       |||                      ]----//
//----[    |||         |||   |||         |||                  |||     |||      |||                      ]----//
//----[    ||           ||   ||           ||                  |||      ||      |||                      ]----//
//----[   |||           ||| |||           |||                 |||      |||     |||                      ]----//
//----[  |||             |||||             |||                |||       |||    |||                      ]----//
//----[                                                                                                 ]----//
//----------------------------------------------------*------------------------------------------------------//
// Autor: PECET & mrucznik
// Data utworzenia: 16.10.2024
//Opis:
/*
	Praca medyka
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock AddFire(Float:x, Float:y, Float:z, Health)
{
    TotalFires++;
	new fireID = TotalFires;
	FireObj[fireID] = CreateDynamicObject(18689, x, y, z, 0, 0, 0.0, 150.0);
	FirePos[fireID][0] = x, FirePos[fireID][1] = y, FirePos[fireID][2] = z;
	FireHealth[fireID] = Health;
	FireHealthMax[fireID] = Health;
	FireSmoke[fireID] = 0;
}

stock DeleteFire(fireID)
{
	DestroyDynamicObject(FireObj[fireID]);
	TotalFires--;
	FirePos[fireID][0] = 0, FirePos[fireID][1] = 0, FirePos[fireID][2] = 0;
}

stock DeleteAllFire()
{
	for(new fireID; fireID<MaxFire; fireID++)
	{
		DestroyDynamicObject(FireObj[fireID]);
		TotalFires= 0;
		FirePos[fireID][0] = 0, FirePos[fireID][1] = 0, FirePos[fireID][2] = 0;
	}
}
stock IsValidFire(fireID)
{
	if((FirePos[fireID][0] != 0) && (FirePos[fireID][1] != 0) && (FirePos[fireID][2] != 0) ) return true;
	else return false;
}

stock GetClosestFire(playerid)
{
	for(new i; i<MaxFire; i++)
	{
	    if(IsValidFire(i) && IsPlayerInRangeOfPoint(playerid, 2, FirePos[i][0],  FirePos[i][1],  FirePos[i][2]))
	    {
	        return i;
		}
	}
	return 0;
}

OgienUgaszony(playerid)
{
	GameTextForPlayer(playerid, "~g~+1000$", 2000, 1);
	DajKase(playerid, 1000);
}

PozarUgaszony(fireid, playerid)
{
	if(FireSmoke[fireid] == 1)
	{
		DestroyDynamicObject(SmokeObj[fireid]);
	}
	DeleteFire(fireid);
	CallRemoteFunction("OnFireDeath", "dd", fireid, playerid);

	SendClientMessage(playerid, 0x33AA33AA, "[ERS] Dostajesz 5 000$! [ERS]");
	DajKase(playerid, 5000);

	SendFamilyMessage(FRAC_ERS, 0xFFFFFFAA, "--------[Los Santos Rescue Service]--------");
	SendFamilyMessage(FRAC_ERS, 0xAA3333AA, "[RADIO] Centrala do LSRS: Po¿ar zosta³‚ ugaszony!");

	SendJobMessage(JOB_MEDIC, 0xFFFFFFAA, "--------[Los Santos Rescue Service]--------");
	SendJobMessage(JOB_MEDIC, 0xAA3333AA, "[RADIO] Centrala do LSRS: Po¿ar zosta³‚ ugaszony!");
	ActiveFire = -1;
}


Float:DistanceCameraTargetToLocation(Float:CamX, Float:CamY, Float:CamZ,   Float:ObjX, Float:ObjY, Float:ObjZ,   Float:FrX, Float:FrY, Float:FrZ) {

	new Float:TGTDistance;
	TGTDistance = floatsqroot((CamX - ObjX) * (CamX - ObjX) + (CamY - ObjY) * (CamY - ObjY) + (CamZ - ObjZ) * (CamZ - ObjZ));
	new Float:tmpX, Float:tmpY, Float:tmpZ;
	tmpX = FrX * TGTDistance + CamX;
	tmpY = FrY * TGTDistance + CamY;
	tmpZ = FrZ * TGTDistance + CamZ;
	return floatsqroot((tmpX - ObjX) * (tmpX - ObjX) + (tmpY - ObjY) * (tmpY - ObjY) + (tmpZ - ObjZ) * (tmpZ - ObjZ));
}

stock PlayerFaces(playerid, Float:x, Float:y, Float:z, Float:radius)
{
	new Float:cameraX,Float:cameraY,Float:cameraZ,Float:fx,Float:fy,Float:fz;
	GetPlayerCameraPos(playerid, cameraX, cameraY, cameraZ);
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);
	return (radius >= DistanceCameraTargetToLocation(cx, cy, cz, x, y, z, fx, fy, fz));
}

IsAFireman(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new skin = GetPlayerSkin(playerid);
	    if(skin==277 || skin==278 || skin==279)
		{
		    return 1;
		}
	}
	return 0;
}


//end