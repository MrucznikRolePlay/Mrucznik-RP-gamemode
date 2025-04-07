//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               praca_kierowca                                              //
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
// Data utworzenia: 31.03.2024
//Opis:
/*
	Praca kierowcy.
*/

//

//-----------------<[ Obs�uga komendy /wezwij: ]>-------------------
wezwij_taxi(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
	if(TaxiDrivers <= 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma taks�wkarzy, spr�buj p�niej !");
		return 1;
	}
	if(TransportDuty[playerid] > 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnych taks�wkarzy!");
		return 1;

	}
	format(string, sizeof(string), "** %s potrzebuje transportu. (wpisz /akceptuj taxi aby zaakceptowa� zg�oszenie)", GetNick(playerid));
	SendFamilyMessage(10, 0xE88A2DFF, string);
	SendJobMessage(JOB_DRIVER, 0xE88A2DFF, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni�e� po taks�wk�, czekaj na akceptacje.");
	TaxiCall = playerid;
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
	return 1;
}

wezwij_heli(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
	if(HeliDrivers <= 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma pilota, spr�buj p�niej !");
		return 1;
	}
	if(TransportDuty[playerid] > 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnego pilota !");
		return 1;
	}

	format(string, sizeof(string), "** %s potrzebuje transportu. (wpisz /akceptuj heli aby zaakceptowa� zg�oszenie)", GetNick(playerid));
	SendFamilyMessage(10, 0xE88A2DFF, string);
	SendJobMessage(JOB_DRIVER, 0xE88A2DFF, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wezwa�e� helikopter, czekaj na miejscu.");
	HeliCall = playerid;
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
	return 1;
}

wezwij_bus(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
	if(BusDrivers <= 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma kierowc�w autobusu, spr�buj p�niej!");
		return 1;
	}
	if(TransportDuty[playerid] > 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnych autobus�w!");
		return 1;
	}
	format(string, sizeof(string), "** %s potrzebuje autobusu. (wpisz /akceptuj bus aby zaakceptowa� zlecenie)", GetNick(playerid));
	SendFamilyMessage(10, 0xE88A2DFF, string);
	SendJobMessage(JOB_DRIVER, 0xE88A2DFF, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni�e� po autobus, czekaj na akceptacje.");
	BusCall = playerid;
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
	return 1;
}