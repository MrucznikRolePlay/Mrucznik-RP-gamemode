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
public EatingUnblock(playerid) DeletePVar(playerid, "EatingBlock");

EatCookedMeal(playerid, name[], weight, type)
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	SetPlayerHealth(playerid, (hp+weight/10) > 100.0 ? 100.0 : (hp+weight/10));
	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 1, 1, 1);
	SetPVarInt(playerid, "EatingBlock", 1);
	SetTimerEx("EatingUnblock",6000,0,"d", playerid);
	//handle food types
	if(type == 16 || type == 18)
	{//Dolphin or Turtle
		PoziomPoszukiwania[playerid] += 1;
		SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Spo�ywanie zagro�onych gatunk�w");
	}
	if(type < sizeof(FishNames))
	{
		new immunityBonus = weight/100;
		if(immunityBonus == 0) immunityBonus = 1;
		IncreasePlayerImmunity(playerid, immunityBonus);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Zjad�e�: %s o wadze %dg i dosta�e� +%dhp i %dpkt odporno�ci.", 
			name, weight, weight/10, immunityBonus));
	}
	else
	{
		SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Zjad�e�: %s o wadze %dg i dosta�e� +%dhp.", name, weight, weight/10));
	}

	ChatMe(playerid, sprintf("zjada %s.", name));
	ApplyAnimation(playerid, "FOOD", "EAT_Pizza", 4.1, 0, 1, 1, 0, 0, 1);

	if(random(100) == 0 && InfectOrDecreaseImmunity(playerid, ZATRUCIE, 25)) 
	{//1% szans na zatrucie
		SendClientMessage(playerid, COLOR_RED, "To co zjad�e�, chyba Ci zaszkodzi�o!");
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
		else if(PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pDom] || PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pWynajem] && Dom[PlayerInfo[playerid][pDom]][hUL_D] != 0)
		{
			new dom = PlayerInfo[playerid][pDom];
			if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]))
			{
				return 1;
			}
		}
	}
	return 0;
}

InitializeFoodPlaces()
{
	for(new i; i<sizeof(FoodPlaces); i++)
	{
		CreateDynamicPickup(1582, 2, FoodPlaces[i][0], FoodPlaces[i][1], FoodPlaces[i][2]);
		CreateDynamic3DTextLabel("/zjedz", COLOR_NEWS, 
			FoodPlaces[i][0], FoodPlaces[i][1], FoodPlaces[i][2] + 0.5,
			10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true);
	}
}

IsAtFoodPlace(playerid)
{
	for(new i; i<sizeof(FoodPlaces); i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5.0, FoodPlaces[i][0], FoodPlaces[i][1], FoodPlaces[i][2]))
		{
			return 1;
		}
	}
	return 0;
}
//end