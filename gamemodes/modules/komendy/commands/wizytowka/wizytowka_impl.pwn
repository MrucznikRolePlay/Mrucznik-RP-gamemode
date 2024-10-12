//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wizytowka_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Nie masz telefonu, nie mo¿esz dawaæ graczom wizytówek.");
		return 1;
	}

	new giveplayerid, nazwa[MAX_KONTAKT_NAME_1], string[128];
	format(string, sizeof(string), "k<fix>S(%s)["#MAX_KONTAKT_NAME_1"]", GetNick(playerid));
	if(sscanf(params, string, giveplayerid, nazwa))
	{
		sendTipMessage(playerid, "U¿yj /wizytowka [ID/Nick Gracza] (nazwa - domyœlnie nick)");
		return 1;
	}
	
	if(!IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza.");
		return 1;
	}
	
	if(!ProxDetectorS(10.0, playerid, giveplayerid))
	{
		sendErrorMessage(playerid, "Jesteœ za daleko od tego gracza.");
		return 1;
	}
	
	if(PlayerInfo[giveplayerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Ten gracz nie ma telefonu, nie mo¿esz daæ mu wizytówki.");
		return 1;
	}
	
	if(giveplayerid == playerid) 
	{
		sendErrorMessage(playerid, "Nie mo¿esz daæ wizytówki samemu sobie!"); 
		return 1;
	}
	
	if(GetPVarInt(giveplayerid, "wizytowka") == playerid)
	{
		sendErrorMessage(playerid, "Ju¿ oferujesz temu graczowi swoj¹ wizytówkê."); 
		return 1;
	}
	
	if(strlen(nazwa) > MAX_KONTAKT_NAME)
	{
		sendErrorMessage(playerid, "Nazwa kontaktu mo¿e mieæ maksymalnie "#MAX_KONTAKT_NAME" znaki!");
		return 1;
	}
	
	format(string, sizeof(string), "* Oferujesz %s wizytówkê.", GetNick(giveplayerid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	format(string, sizeof(string), "* %s proponuje wizytówkê o treœci: %s, (wpisz /akceptuj wizytowka) aby akceptowaæ.", GetNick(playerid), nazwa);
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	SetPVarString(giveplayerid, "wizytowka-nazwa", nazwa);
	SetPVarInt(giveplayerid, "wizytowka", playerid);
	return 1;
}

//end
