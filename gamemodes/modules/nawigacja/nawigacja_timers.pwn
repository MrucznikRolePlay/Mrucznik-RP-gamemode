//-----------------------------------------------<< Timers >>------------------------------------------------//
//                                                 nawigacja                                                 //
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
// Autor: Simeone
// Data utworzenia: 09.02.2020
//Opis:
/*
	Prosty system nawigacji, wskazuj¹cy punkt docelowy.
*/

//

//-----------------<[ Timery: ]>-------------------
public nawiStart(playerid)
{
	if(navigationCheckPoint[playerid] == INVALID_STREAMER_ID)
	{
		StopPlayerNavigation(playerid); 
		return 1;
	}
	UpdateNaviTextDrawsForPlayer(playerid);
	return 1;
}
public nawiStartEx(playerid)
{
	if(navigationCheckPoint[playerid] == INVALID_STREAMER_ID)
	{
		StopPlayerNavigation(playerid); 
		return 1;
	}
	new dLoc[64];
	new Float:dPosX, Float:dPosY, Float:dPosZ;
	dPosX = GetPVarFloat(playerid, "miejsceDoceloweX");
	dPosY = GetPVarFloat(playerid, "miejsceDoceloweY");
	dPosZ = GetPVarFloat(playerid, "miejsceDoceloweZ");
	GetPVarString(playerid, "miejsceDoceloweStr", dLoc, sizeof(dLoc));
	UpdateNaviTextDrawsForPlayerEx(playerid, dPosX, dPosY, dPosZ, dLoc); 
	return 1;
}
//end