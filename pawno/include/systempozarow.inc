#include <a_samp>

#define Holding(%0) \
	((newkeys & (%0)) == (%0))
#define MaxFire 80
forward systempozarow_OnPlayerUpdate(playerid);
forward systempozarow_init();
forward OnFire();

public systempozarow_init()
{
		SetTimer("OnFire", 1000, 1);
}	


new
    FireObj[MaxFire],
    Float:FirePos[MaxFire][3],
	TotalFires = 0,
	FireHealth[MaxFire],
	FireHealthMax[MaxFire];

stock AddFire(Float:x, Float:y, Float:z, Health)
{
    TotalFires++;
	new ID = TotalFires;
	FireObj[ID] = CreateObject(18689, x, y, z, 0, 0, 0.0);
	FirePos[ID][0] = x, FirePos[ID][1] = y, FirePos[ID][2] = z;
	FireHealth[ID] = Health;
	FireHealthMax[ID] = Health;
}
stock DeleteFire(ID)
{
	DestroyObject(FireObj[ID]);
	TotalFires--;
	FirePos[ID][0] = 0, FirePos[ID][1] = 0, FirePos[ID][2] = 0;
}
stock DeleteAllFire()
{
	new ID;
	for(ID = 0; ID<MaxFire; ID++)
	{
		DestroyObject(FireObj[ID]);
		TotalFires= 0;
		FirePos[ID][0] = 0, FirePos[ID][1] = 0, FirePos[ID][2] = 0;
	}
}
stock IsValidFire(ID)
{
	if( (FirePos[ID][0] != 0) && (FirePos[ID][1] != 0) && (FirePos[ID][2] != 0) ) return true;
	else return false;
}

stock GetClosestFire(playerid)
{
	new i;
	for(i = 0; i<MaxFire; i++)
	{
	    if(IsValidFire(i) && IsPlayerInRangeOfPoint(playerid, 2, FirePos[i][0],  FirePos[i][1],  FirePos[i][2]))
	    {
	        return i;
		}
	}
	return 0;
}


public systempozarow_OnPlayerUpdate(playerid)
{
	new newkeys,l,u;
	GetPlayerKeys(playerid, newkeys, l, u);
	new i;
	if(Holding(KEY_FIRE))
	{
        if(GetPlayerWeapon(playerid) == 42)
        {
            for(i = 0; i<MaxFire; i++)
 	    	{
 	        	if(IsValidFire(i))
 	        	{
 	        	    if(PlayerFaces(playerid, FirePos[i][0],  FirePos[i][1],  FirePos[i][2]+2, 1) && IsPlayerInRangeOfPoint(playerid, 10, FirePos[i][0],  FirePos[i][1],  FirePos[i][2]))
 	        		{
			    		FireHealth[i]-=2;

			    		if(FireHealth[i] <= 0 && TotalFires == 1)
			    		{
			    		    DeleteFire(i);
			    		    SendFamilyMessage(17, 0xFFFFFFAA, "--------[LOS SANTOS FIRE DEPARTMENT]--------");
    						SendFamilyMessage(17, 0xAA3333AA, "[RADIO] Centrala do LSFD: Po¿ar zosta³ ugaszony!");
    						SendFamilyMessage(17, 0x33AA33AA, "[LSFD] Do sejfu frakcji wp³ywa 20 000$! [LSFD]");
			    		    Sejf_Add(17, 20000);
							CallRemoteFunction("OnFireDeath", "dd", i, playerid);
			    		}
					    else if(FireHealth[i] <= 0)
					    {
							DeleteFire(i);
							CallRemoteFunction("OnFireDeath", "dd", i, playerid);
						}
					}
				}
			}
		}
		else if(IsPlayerInAnyVehicle(playerid) && GetVehicleModel(GetPlayerVehicleID(playerid)) == 407 && PLAYER_STATE_DRIVER)
        {
            for(i = 0; i<MaxFire; i++)
 	    	{
 	        	if(IsValidFire(i))
 	        	{
 	        	    if(PlayerFaces(playerid, FirePos[i][0],  FirePos[i][1],  FirePos[i][2], 5) && IsPlayerInRangeOfPoint(playerid, 20, FirePos[i][0],  FirePos[i][1],  FirePos[i][2]))
 	        		{
			    		FireHealth[i]-=1;
			    		if(FireHealth[i] <= 0 && TotalFires == 1)
			    		{
			    		    DeleteFire(i);
			    		    SendFamilyMessage(17, 0xFFFFFFAA, "--------[LOS SANTOS FIRE DEPARTMENT]--------");
    						SendFamilyMessage(17, 0xAA3333AA, "[RADIO] Centrala: Po¿ar zosta³ ugaszony!");
    						SendFamilyMessage(17, 0x33AA33AA, "[LSFD] Do sejfu frakcji wp³ywa 20 000$! [LSFD]");
			    		    Sejf_Add(17, 20000);
							CallRemoteFunction("OnFireDeath", "dd", i, playerid);
			    		}
					    else if(FireHealth[i] <= 0)
					    {
							DeleteFire(i);
							CallRemoteFunction("OnFireDeath", "dd", i, playerid);
						}
					}
				}
			}
		}
	}
	return 1;
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
        new Float:cx,Float:cy,Float:cz,Float:fx,Float:fy,Float:fz;
        GetPlayerCameraPos(playerid, cx, cy, cz);
        GetPlayerCameraFrontVector(playerid, fx, fy, fz);
        return (radius >= DistanceCameraTargetToLocation(cx, cy, cz, x, y, z, fx, fy, fz));
}

public OnFire()
{
	new i,v,p;
	for(i = 0; i<MaxFire; i++)
	{
		if(IsValidFire(i))
		{
			for(p = 0; p<MAX_PLAYERS; p++)
			{
				if(IsPlayerInRangeOfPoint(p, 2, FirePos[i][0], FirePos[i][1], FirePos[i][2]) && !IsPlayerInAnyVehicle(p) && (GetPlayerSkin(p) != 277 || GetPlayerSkin(p) != 278 || GetPlayerSkin(p) != 279))
				{
	  				new Float:HP;
		    		GetPlayerHealth(p, HP);
	  				SetPlayerHealth(p, HP-4);
				}	
			}
			for(v = 0; v<MAX_VEHICLES; v++)
			{
				if(VehicleToPoint(5, v, FirePos[i][0], FirePos[i][1], FirePos[i][2]))
				{
					new Float:HP;
		    		GetVehicleHealth(v, HP);
	  				SetVehicleHealth(v, HP-30);
				}
			}
		}
	}
}
