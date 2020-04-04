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
EatCookedMeal(playerid, name[], weight, type)
{
	new Float:hp;
	SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Zjad³eœ: %s o wadze %dg i dosta³eœ +%dhp.", name, weight, weight/10));
	ChatMe(playerid, sprintf("zjada %s.", name));
	GetPlayerHealth(playerid, hp);
	SetPlayerHealth(playerid, hp+weight/10);

	//handle food types
	if(type == 16 || type == 18)
	{//Dolphin or Turtle
		PoziomPoszukiwania[playerid] += 1;
		SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Spo¿ywanie zagro¿onych gatunków");
	}
	else if(type == 33 && random(2) == 1)
	{//wuhan bat
		InfectPlayer(playerid, KORONAWIRUS);
		SendClientMessage(playerid, COLOR_RED, "Zarazi³eœ siê coronawirusem! Lepiej idŸ do lekarza.");
	}
	if(type < sizeof(FishNames))
	{
		if(PlayerImmunity[playerid] < 5)
			PlayerImmunity[playerid] ++;
	}
	if(random(20) == 0) 
	{//5% szans na zatrucie
		InfectPlayer(playerid, ZATRUCIE);
		SendClientMessage(playerid, COLOR_RED, "To co zjad³eœ, chyba Ci zaszkodzi³o!");
	}
}

ClearGroceries(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    Groceries[playerid][pChicken] = 0;
	    Groceries[playerid][pHamburger] = 0;
	    Groceries[playerid][pPizza] = 0;
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

cooking_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == DIALOG_EATING)
	{
		if(response)
		{
			MruMySQL_EatCookedMeal(playerid, DynamicGui_GetValue(playerid, listitem));
			MruMySQL_CookedMealsDialog(playerid);
		}
		return 1;
	}
	if(dialogid == DIALOG_COOKING)
	{
		if(response)
		{
			ugotuj_OnDialogResponse(playerid, listitem);
		}
		return 1;
	}
    return 1;
}

//end