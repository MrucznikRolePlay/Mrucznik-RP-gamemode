//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  cooking                                                  //
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
	System gotowania potraw
*/

//

//-----------------<[ Funkcje: ]>-------------------
ClearCooking(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    Cooking[playerid][pCookID1] = 0; Cooking[playerid][pCookID2] = 0; Cooking[playerid][pCookID3] = 0;
		Cooking[playerid][pCookID4] = 0; Cooking[playerid][pCookID5] = 0;
		Cooking[playerid][pCook][0] = 0; Cooking[playerid][pCook][1] = 0; Cooking[playerid][pCook][3] = 0;
		Cooking[playerid][pCWeight][3] = 0; Cooking[playerid][pCWeight][4] = 0;
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "Nothing");
		strmid(Cooking[playerid][pCook][0], string, 0, strlen(string), 255);
		strmid(Cooking[playerid][pCook][1], string, 0, strlen(string), 255);
		strmid(Cooking[playerid][pCook][2], string, 0, strlen(string), 255);
		strmid(Cooking[playerid][pCook][3], string, 0, strlen(string), 255);
		strmid(Cooking[playerid][pCook][4], string, 0, strlen(string), 255);
	}
	return 1;
}

ClearCookingID(playerid, cook)
{
	if(IsPlayerConnected(playerid))
	{
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "Nothing");
		switch (cook)
		{
		    case 1:
		    {
		        strmid(Cooking[playerid][pCook][0], string, 0, strlen(string), 255);
		        Cooking[playerid][pCook][0] = 0;
		        Cooking[playerid][pCookID1] = 0;
		    }
		    case 2:
		    {
		        strmid(Cooking[playerid][pCook][1], string, 0, strlen(string), 255);
		        Cooking[playerid][pCook][1] = 0;
		        Cooking[playerid][pCookID2] = 0;
		    }
		    case 3:
		    {
		        strmid(Cooking[playerid][pCook][2], string, 0, strlen(string), 255);
		        Cooking[playerid][pCook][3] = 0;
		        Cooking[playerid][pCookID3] = 0;
		    }
		    case 4:
		    {
		        strmid(Cooking[playerid][pCook][3], string, 0, strlen(string), 255);
		        Cooking[playerid][pCWeight][3] = 0;
		        Cooking[playerid][pCookID4] = 0;
		    }
		    case 5:
		    {
		        strmid(Cooking[playerid][pCook][4], string, 0, strlen(string), 255);
		        Cooking[playerid][pCWeight][4] = 0;
		        Cooking[playerid][pCookID5] = 0;
		    }
		}
	}
	return 1;
}

ClearGroceries(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    Groceries[playerid][pChickens] = 0; Groceries[playerid][pChicken] = 0;
	    Groceries[playerid][pHamburgers] = 0; Groceries[playerid][pHamburger] = 0;
	    Groceries[playerid][pPizzas] = 0; Groceries[playerid][pPizza] = 0;
	}
	return 1;
}

IsAtCookPlace(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerToPoint(3.0,playerid,369.9786,-4.0798,1001.8589))
	    {//Cluckin Bell
	        return 1;
	    }
	    else if(PlayerToPoint(3.0,playerid,376.4466,-60.9574,1001.5078) || PlayerToPoint(3.0,playerid,378.1215,-57.4928,1001.5078))
		{//Burgershot
		    return 1;
		}
		else if(PlayerToPoint(3.0,playerid,374.1185,-113.6361,1001.4922) || PlayerToPoint(3.0,playerid,377.7971,-113.7668,1001.4922))
		{//Well Stacked Pizza
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 6.0, 2127.2664,-1800.8334,-54.9897))
		{//Nowa Pizzeria
			return 1;
		}
	}
	return 0;
}

//end