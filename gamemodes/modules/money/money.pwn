//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   money                                                   //
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
// Autor: Mrucznik
// Data utworzenia: 01.07.2019
//Opis:
/*
	Modu³ odpowiadaj¹cy za operacje na pieni¹dzach gracza.
*/

//

//-----------------<[ Funkcje: ]>-------------------
public DajKase(playerid, money)
{
	new logstring[256];
	format(logstring, sizeof(logstring), "%s dostal %d$ [kasa: %d$][bank: %d$]", GetPlayerLogName(playerid), money, kaska[playerid], PlayerInfo[playerid][pAccount]);

	kaska[playerid] += money;
	GivePlayerMoney(playerid, money);
	
	if(money < 0)
	{
		Log(errorLog, ERROR, logstring);
	}
	else
	{
		Log(moneyLog, INFO, logstring);
	}

	ZabezpieczenieUjemnyHajs(playerid);
	return 1;
}

public ZabierzKase(playerid, money)
{
	new logstring[256];
	format(logstring, sizeof(logstring), "%s zabrano %d$ [kasa: %d$][bank: %d$]", GetPlayerLogName(playerid), money, kaska[playerid], PlayerInfo[playerid][pAccount]);

	kaska[playerid] -= money;
	GivePlayerMoney(playerid, -money);
	
	if(money < 0)
	{
		Log(errorLog, ERROR, logstring);
	}
	else
	{
		Log(moneyLog, INFO, logstring);
	}
	ZabezpieczenieUjemnyHajs(playerid);
	return 1;
}

public UstawKase(playerid, money)
{
	new logstring[256];
	format(logstring, sizeof(logstring), "%s ustawiono %d$ [kasa: %d$][bank: %d$]", GetPlayerLogName(playerid), money, kaska[playerid], PlayerInfo[playerid][pAccount]);

	kaska[playerid] = money;
	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, money);
	
	Log(moneyLog, INFO, logstring);
	return 1;
}

public ResetujKase(playerid)
{
	kaska[playerid]=0;
	ResetPlayerMoney(playerid);
	return 1;
}

ZabezpieczenieUjemnyHajs(playerid)
{
	if(kaska[playerid] < -10000000)
	{
		MruMySQL_Banuj(playerid, "zbyt du¿e d³ugi");
		Log(punishmentLog, INFO, "%s zosta³ zbanowany za -10.000.000$ na koncie", GetPlayerLogName(playerid));
		KickEx(playerid);
	}
	return 1;
}


CreateMoneyPickup(Float:x, Float:y, Float:z, int, vw, money, wantedLevel, blockedPlayer = -1)
{
	new pickupID = CreateDynamicPickup(1212, 19, x, y, z, vw, int);
	new string[16];
	format(string, sizeof(string), "%d$", money);
	new STREAMER_TAG_3D_TEXT_LABEL:text3d = CreateDynamic3DTextLabel(string, COLOR_LIGHTGREEN, x, y, z, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vw);

	new moneyPickupData[eMoneyPickup];
	moneyPickupData[MONEY_PICKUP_CASH] = money;
	moneyPickupData[MONEY_PICKUP_WANTED_LEVEL] = wantedLevel;
	moneyPickupData[MONEY_PICKUP_BLOCKED_PLAYER] = blockedPlayer;
	moneyPickupData[MONEY_PICKUP_3D_TEXT] = text3d;
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

	if(moneyPickupData[MONEY_PICKUP_BLOCKED_PLAYER] == PlayerInfo[playerid][pUID])
	{
		return;
	}

	DestroyDynamicPickup(pickupID);
	DestroyDynamic3DTextLabel(moneyPickupData[MONEY_PICKUP_3D_TEXT]);
	MAP_remove_val(MoneyPickupsMap, pickupID);

	new money =  moneyPickupData[MONEY_PICKUP_CASH];
	DajKase(playerid, money);
	Log(payLog, INFO, "%s podnosi %d$ z money pickupa (stworzony przez gracza o UID %d)", GetPlayerLogName(playerid), money, moneyPickupData[MONEY_PICKUP_BLOCKED_PLAYER]);

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