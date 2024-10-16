//----------------------------------------------<< Callbacks >>----------------------------------------------//
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
// Autor: mrucznik
// Data utworzenia: 16.10.2024
//Opis:
/*
	Praca medyka
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
public systempozarow_init()
{
	SetTimer("OnFire", 1000, 1);
}	

public EndSmoke(id)
{
	if(FireSmoke[id] == 1)
	{
		DestroyObject(SmokeObj[id]);
		FireSmoke[id] = 0;
	}
	return 1;
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
						if(FireSmoke[i] == 0)
						{
							FireSmoke[i]=1;
							SmokeObj[i] = CreateObject(18716,  FirePos[i][0],  FirePos[i][1],  FirePos[i][2], 0, 0, 0.0);
							SetTimerEx("EndSmoke", 500, false, "i", i);
						}
			    		if(FireHealth[i] <= 0 && TotalFires == 1)
			    		{
			    		    PozarUgaszony(i, playerid);
			    		}
					    if(FireHealth[i] <= 0 && TotalFires != 1)
					    {
							if(FireSmoke[i] == 1)
							{
								DestroyObject(SmokeObj[i]);
							}
							OgienUgaszony(playerid);
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
						if(FireSmoke[i] == 0)
						{
							FireSmoke[i]=1;
							SmokeObj[i] = CreateObject(18716,  FirePos[i][0],  FirePos[i][1],  FirePos[i][2], 0, 0, 0.0);
							SetTimerEx("EndSmoke", 500, false, "i", i);
						}
			    		if(FireHealth[i] <= 0 && TotalFires == 1)
			    		{
			    		    PozarUgaszony(i, playerid);
			    		}
					    else if(FireHealth[i] <= 0)
					    {
							if(FireSmoke[i] == 1)
							{
								DestroyObject(SmokeObj[i]);
							}
							DeleteFire(i);
							CallRemoteFunction("OnFireDeath", "dd", i, playerid);
						}
					}
				}
			}
		}
	}
	else if(Holding(KEY_HANDBRAKE))
	{
        if(GetPVarInt(playerid, "firehose_on") == 1)
        {
			
            for(i = 0; i<MaxFire; i++)
 	    	{
 	        	if(IsValidFire(i))
 	        	{
 	        	    if(PlayerFaces(playerid, FirePos[i][0],  FirePos[i][1],  FirePos[i][2], 1) && IsPlayerInRangeOfPoint(playerid, 10, FirePos[i][0],  FirePos[i][1],  FirePos[i][2]))
 	        		{
			    		FireHealth[i]-=2;
						if(FireSmoke[i] == 0)
						{
							FireSmoke[i]=1;
							SmokeObj[i] = CreateObject(18716,  FirePos[i][0],  FirePos[i][1],  FirePos[i][2], 0, 0, 0.0);
							SetTimerEx("EndSmoke", 500, false, "i", i);
						}
			    		if(FireHealth[i] <= 0 && TotalFires == 1)
			    		{
			    		    PozarUgaszony(i, playerid);
			    		}
					    else if(FireHealth[i] <= 0)
					    {
							if(FireSmoke[i] == 1)
							{
								DestroyObject(SmokeObj[i]);
							}
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

hook OnVehicleDeath(vehicleid, killerid)
{
	LastFireVehicles[vehicleid] = false;
	return 1;
}

public OnFire()
{
	for(new i = 0; i<MaxFire; i++)
	{
		if(IsValidFire(i))
		{
			foreach(new p : Player)
			{
				if(IsPlayerInAnyVehicle(p))
				{
					LastFireVehicles[GetPlayerVehicleID(p)] = false;
				}
				else if(!IsAFireman(p) && IsPlayerInRangeOfPoint(p, 2, FirePos[i][0], FirePos[i][1], FirePos[i][2]))
				{
	  				new Float:HP;
		    		GetPlayerHealth(p, HP);
	  				SetPlayerHealth(p, HP-4);
				}	
			}
			for(new v = 0; v < MAX_VEHICLES; v++)
			{
				if(LastFireVehicles[v] || (IsValidVehicle(v) && GetVehicleModel(v) != 407 && GetVehicleDistanceFromPoint(v, FirePos[i][0], FirePos[i][1], FirePos[i][2]) < 5.0))
				{
					new Float:HP;
					GetVehicleHealth(v, HP);
					SetVehicleHealth(v, HP-30);
					LastFireVehicles[v] = true;
				}
			}
		}
	}
}

//end