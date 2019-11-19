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
GiveInjury(playerid, bool:injury, bool:bw)
{
	if(injury)
	{
		new Float:angle;
		GetPlayerFacingAngle(playerid, angle);
		PlayerInfo[playerid][pInjury] = INJURY_TIME;
		//SetPlayerColor(playerid,COLOR_PANICRED);
		GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
		SetPVarInt(playerid, "bw-skin",  GetPlayerSkin(playerid));
		SetPVarInt(playerid, "bw-vw", GetPlayerVirtualWorld(playerid));
		SetPVarInt(playerid, "bw-int", GetPlayerInterior(playerid));
		SetPVarInt(playerid, "bw-angle", angle);
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