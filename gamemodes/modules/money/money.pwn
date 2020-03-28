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
	format(logstring, sizeof(logstring), "%s dostal %d$ [kasa: %d$][bank: %d$]", GetPlayerLogName(playerid), money, kaska[playerid], PlayerInfo[playerid][pBankMoney]);

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
	return 1;
}

public ZabierzKase(playerid, money)
{
	new logstring[256];
	format(logstring, sizeof(logstring), "%s zabrano %d$ [kasa: %d$][bank: %d$]", GetPlayerLogName(playerid), money, kaska[playerid], PlayerInfo[playerid][pBankMoney]);

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
	return 1;
}

public UstawKase(playerid, money)
{
	new logstring[256];
	format(logstring, sizeof(logstring), "%s ustawiono %d$ [kasa: %d$][bank: %d$]", GetPlayerLogName(playerid), money, kaska[playerid], PlayerInfo[playerid][pBankMoney]);

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

//end