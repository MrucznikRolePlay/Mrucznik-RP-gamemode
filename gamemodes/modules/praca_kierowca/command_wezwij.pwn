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

//-----------------<[ Obs³uga komendy /wezwij: ]>-------------------
wezwij_taxi(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
	if(TaxiDrivers <= 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma taksówkarzy, spróbuj póŸniej !");
		return 1;
	}
	if(TransportDuty[playerid] > 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnych taksówkarzy !");
		return 1;

	}
	format(string, sizeof(string), "** %s potrzebuje transportu. (wpisz /akceptuj taxi aby zaakceptowaæ zg³oszenie)", GetNick(playerid));
	SendFamilyMessage(10, 0xE88A2DFF, string);
	SendJobMessage(JOB_DRIVER, 0xE88A2DFF, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po taksówkê, czekaj na akceptacje.");
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
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma pilota, spróbuj póŸniej !");
		return 1;
	}
	if(TransportDuty[playerid] > 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnego pilota !");
		return 1;
	}

	format(string, sizeof(string), "** %s potrzebuje transportu. (wpisz /akceptuj heli aby zaakceptowaæ zg³oszenie)", GetNick(playerid));
	SendFamilyMessage(10, 0xE88A2DFF, string);
	SendJobMessage(JOB_DRIVER, 0xE88A2DFF, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wezwa³eœ helikopter, czekaj na miejscu.");
	HeliCall = playerid;
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
	return 1;
}

wezwij_bus(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
	if(BusDrivers <= 1)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma kierowców autobusu, spróbuj póŸniej !");
		return 1;
	}
	if(TransportDuty[playerid] > 0)
	{
		sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnych autobusów !");
		return 1;
	}
	format(string, sizeof(string), "** %s potrzebuje autobusu. (wpisz /akceptuj bus aby zaakceptowaæ zlecenie)", GetNick(playerid));
	SendFamilyMessage(10, 0xE88A2DFF, string);
	SendJobMessage(JOB_DRIVER, 0xE88A2DFF, string);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po autobus, czekaj na akceptacje.");
	BusCall = playerid;
	AntySpam[playerid] = 1;
	SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
	return 1;
}