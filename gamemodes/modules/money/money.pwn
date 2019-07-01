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
	new logstring[256], nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(logstring, sizeof(logstring), "%s dostal %d$", nick, money);

	kaska[playerid] += money;
	GivePlayerMoney(playerid, money);
	
	if(money < 0)
	{
		Log(moneyLog, ERROR, logstring);
	}
	else
	{
		Log(moneyLog, INFO, logstring);
	}
	return 1;
}

public ZabierzKase(playerid, money)
{
	new logstring[256], nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(logstring, sizeof(logstring), "%s zabrano %d$", nick, money);

	kaska[playerid] -= money;
	GivePlayerMoney(playerid, -money);
	
	if(money < 0)
	{
		Log(moneyLog, ERROR, logstring);
	}
	else
	{
		Log(moneyLog, INFO, logstring);
	}
	return 1;
}

public UstawKase(playerid, money)
{
	new logstring[256], nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(logstring, sizeof(logstring), "%s ustawiono %d$", nick, money);

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