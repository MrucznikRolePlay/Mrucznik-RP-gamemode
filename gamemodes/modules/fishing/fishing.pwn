//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  fishing                                                  //
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
// Data utworzenia: 03.03.2020
//Opis:
/*
	System ³owienia ryb.
*/

//

//-----------------<[ Funkcje: ]>-------------------
ClearFishes(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    PlayerFishes[playerid][pFid1] = 0; PlayerFishes[playerid][pFid2] = 0; PlayerFishes[playerid][pFid3] = 0;
		PlayerFishes[playerid][pFid4] = 0; PlayerFishes[playerid][pFid5] = 0;
		PlayerFishes[playerid][pWeight1] = 0; PlayerFishes[playerid][pWeight2] = 0; PlayerFishes[playerid][pWeight3] = 0;
		PlayerFishes[playerid][pWeight4] = 0; PlayerFishes[playerid][pWeight5] = 0;
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "None");
		strmid(PlayerFishes[playerid][pFish1], string, 0, strlen(string), 255);
		strmid(PlayerFishes[playerid][pFish2], string, 0, strlen(string), 255);
		strmid(PlayerFishes[playerid][pFish3], string, 0, strlen(string), 255);
		strmid(PlayerFishes[playerid][pFish4], string, 0, strlen(string), 255);
		strmid(PlayerFishes[playerid][pFish5], string, 0, strlen(string), 255);
	}
	return 1;
}

ClearFishID(playerid, fish)
{
	if(IsPlayerConnected(playerid))
	{
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "None");
		switch (fish)
		{
		    case 1:
		    {
		        strmid(PlayerFishes[playerid][pFish1], string, 0, strlen(string), 255);
		        PlayerFishes[playerid][pWeight1] = 0;
		        PlayerFishes[playerid][pFid1] = 0;
		    }
		    case 2:
		    {
		        strmid(PlayerFishes[playerid][pFish2], string, 0, strlen(string), 255);
		        PlayerFishes[playerid][pWeight2] = 0;
		        PlayerFishes[playerid][pFid2] = 0;
		    }
		    case 3:
		    {
		        strmid(PlayerFishes[playerid][pFish3], string, 0, strlen(string), 255);
		        PlayerFishes[playerid][pWeight3] = 0;
		        PlayerFishes[playerid][pFid3] = 0;
		    }
		    case 4:
		    {
		        strmid(PlayerFishes[playerid][pFish4], string, 0, strlen(string), 255);
		        PlayerFishes[playerid][pWeight4] = 0;
		        PlayerFishes[playerid][pFid4] = 0;
		    }
		    case 5:
		    {
		        strmid(PlayerFishes[playerid][pFish5], string, 0, strlen(string), 255);
		        PlayerFishes[playerid][pWeight5] = 0;
		        PlayerFishes[playerid][pFid5] = 0;
		    }
		}
	}
	return 1;
}

PlayerHasFishes(playerid)
{
	return PlayerFishes[playerid][pWeight1] > 0 || PlayerFishes[playerid][pWeight2] > 0 || PlayerFishes[playerid][pWeight3] > 0 || PlayerFishes[playerid][pWeight4] > 0 || PlayerFishes[playerid][pWeight5] > 0;
}

IsAtFishPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerToPoint(1.0,playerid,403.8266,-2088.7598,7.8359) || PlayerToPoint(1.0,playerid,398.7553,-2088.7490,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,396.2197,-2088.6692,7.8359) || PlayerToPoint(1.0,playerid,391.1094,-2088.7976,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,383.4157,-2088.7849,7.8359) || PlayerToPoint(1.0,playerid,374.9598,-2088.7979,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,369.8107,-2088.7927,7.8359) || PlayerToPoint(1.0,playerid,367.3637,-2088.7925,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		else if(PlayerToPoint(1.0,playerid,362.2244,-2088.7981,7.8359) || PlayerToPoint(1.0,playerid,354.5382,-2088.7979,7.8359))
		{//Fishplace at the bigwheel
		    return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 403.9787,-2088.7947,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 398.8863,-2088.4109,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 395.9289,-2088.2773,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 391.1751,-2088.2493,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 383.6028,-2088.4607,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 374.8348,-2088.3501,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 370.0244,-2088.3254,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 367.5755,-2088.2151,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 362.0309,-2088.1899,7.8359))
		{
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 354.6362,-2088.3010,7.8359))
		{
			return 1;
		}
	}
	return 0;
}

//end