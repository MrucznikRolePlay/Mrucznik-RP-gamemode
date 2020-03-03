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
	    Fishes[playerid][pFid1] = 0; Fishes[playerid][pFid2] = 0; Fishes[playerid][pFid3] = 0;
		Fishes[playerid][pFid4] = 0; Fishes[playerid][pFid5] = 0;
		Fishes[playerid][pWeight1] = 0; Fishes[playerid][pWeight2] = 0; Fishes[playerid][pWeight3] = 0;
		Fishes[playerid][pWeight4] = 0; Fishes[playerid][pWeight5] = 0;
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "None");
		strmid(Fishes[playerid][pFish1], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish2], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish3], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish4], string, 0, strlen(string), 255);
		strmid(Fishes[playerid][pFish5], string, 0, strlen(string), 255);
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
		        strmid(Fishes[playerid][pFish1], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight1] = 0;
		        Fishes[playerid][pFid1] = 0;
		    }
		    case 2:
		    {
		        strmid(Fishes[playerid][pFish2], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight2] = 0;
		        Fishes[playerid][pFid2] = 0;
		    }
		    case 3:
		    {
		        strmid(Fishes[playerid][pFish3], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight3] = 0;
		        Fishes[playerid][pFid3] = 0;
		    }
		    case 4:
		    {
		        strmid(Fishes[playerid][pFish4], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight4] = 0;
		        Fishes[playerid][pFid4] = 0;
		    }
		    case 5:
		    {
		        strmid(Fishes[playerid][pFish5], string, 0, strlen(string), 255);
		        Fishes[playerid][pWeight5] = 0;
		        Fishes[playerid][pFid5] = 0;
		    }
		}
	}
	return 1;
}

PlayerHasFishes(playerid)
{
	return Fishes[playerid][pWeight1] > 0 || Fishes[playerid][pWeight2] > 0 || Fishes[playerid][pWeight3] > 0 || Fishes[playerid][pWeight4] > 0 || Fishes[playerid][pWeight5] > 0;
}

//end