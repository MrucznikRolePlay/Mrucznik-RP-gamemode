//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                moneypickup                                                //
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
// Data utworzenia: 23.03.2024
//Opis:
/*
	Pickupy z hajsem
*/

//

//-----------------<[ Funkcje: ]>-------------------

CreateMoneyPickup(Float:x, Float:y, Float:z, int, vw, money, wantedLevel, blockedPlayer = -1)
{
	new pickupID = CreateDynamicPickup(1212, 19, x, y, z, vw, int);

	new moneyPickupData[eMoneyPickup];
	moneyPickupData[MONEY_PICKUP_CASH] = money;
	moneyPickupData[MONEY_PICKUP_WANTED_LEVEL] = wantedLevel;
	moneyPickupData[MONEY_PICKUP_BLOCKED_PLAYER] = blockedPlayer;
	MAP_insert_val_arr(MoneyPickupsMap, pickupID, moneyPickupData, sizeof(moneyPickupData));
	return;
}

CollectMoneyPickup(playerid, pickupID)
{
	if(!MAP_contains_val(MoneyPickupsMap, pickupID))
	{
		return;
	}

	new moneyPickupData[eMoneyPickup];
	MAP_get_val_arr(MoneyPickupsMap, pickupID, moneyPickupData);
	DestroyDynamicPickup(pickupID);
	MAP_remove_val(MoneyPickupsMap, pickupID);

	if(moneyPickupData[MONEY_PICKUP_BLOCKED_PLAYER] == PlayerInfo[playerid][pUID])
	{
		return;
	}

	new money =  moneyPickupData[MONEY_PICKUP_CASH];
	DajKase(playerid, money);
	Log(payLog, INFO, "%s podnosi %d$ z money pickupa", GetPlayerLogName(playerid), money);

	new string[64];
	new addWL = moneyPickupData[MONEY_PICKUP_WANTED_LEVEL];
	if(addWL > 0)
	{
		PoziomPoszukiwania[playerid] += addWL;
		format(string, sizeof(string), "kradzie¿ %d$", money);
		SetPlayerCriminal(playerid, INVALID_PLAYER_ID, string);
	}

	format(string, sizeof(string), "podnosi %d$", money);
	ChatMe(playerid, string);
	return;
}

//end