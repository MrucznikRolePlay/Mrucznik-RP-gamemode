//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    bw                                                     //
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
//Opis:
/*
	Zawiera system rannego i BW.
*/
// Autor: Creative
// Data utworzenia: 19.11.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
stock IsPlayerAiming(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
    (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}
GiveInjury(playerid, bool:injury, bool:bw)
{
	if(injury)
	{
		new Float:playerangle;
		GetPlayerFacingAngle(playerid, playerangle);
		PlayerInfo[playerid][pInjury] = INJURY_TIME;
		//SetPlayerColor(playerid,COLOR_PANICRED);
		GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
		SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
		SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
		SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "bw-angle", playerangle);
		/*for(new i = 0; i < MAX_VEHICLES; i ++)
		{
			SetVehicleParamsForPlayer(i, playerid, 0, 1);
		}*/
		//komunikat do ERS o rannym jako funkcja
        //GetPlayerPos(playerid, x, y, z);
        //GetPlayerFacingAngle(playerid, angle);
	}
	else if(bw)
	{
		
	}
	return 1;
}
//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end