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
command_caluj_Impl(playerid, params[256])
{
    if(!IsPlayerConnected(playerid))
	{
		return 1;
	}

	new string[128];
	new playa;
	
	if( sscanf(params, "k<fix>", playa))
	{
		sendTipMessage(playerid, "U¿yj /caluj [ID gracza]");
		return 1;
	}
	if(playa == playerid)
	{
		sendErrorMessage(playerid, "Nie mo¿esz poca³owaæ samego siebie!"); 
		return 1;
	}
	if(GetPlayerAdminDutyStatus(playa) == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz ca³owaæ administratora!"); 
		return 1;
	}
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz ca³owaæ siê bêd¹c na s³u¿bie @"); 
		return 1;
	}
	if(dialAccess[playerid] == 1)
	{
		sendErrorMessage(playerid, "Musisz odczekaæ 15 sekund przed ponownym poca³unkiem!"); 
		return 1;
	}
	if (!ProxDetectorS(5.0, playerid, playa))
	{
		sendErrorMessage(playerid, "Jesteœ za daleko !");
		return 1;
	}
	if(playa == INVALID_PLAYER_ID || !IsPlayerConnected(playa))
	{
		sendErrorMessage(playerid, "Takiego gracza nie ma na serwerze!");
		return 1;
	}
	if(kissPlayerOffer[playa] == playerid)
	{
		sendErrorMessage(playerid, "Ju¿ zaoferowa³eœ/³aœ poca³unek temu graczowi, poczekaj na reakcjê!");
		return 1;
	}

	if(kissPlayerOffer[playerid] == playa)
	{
			format(string, sizeof(string),"* %s kocha %s wiêc ca³uj¹ siê.", GetNick(playerid), GetNick(playa));
			ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			format(string, sizeof(string), "%s mówi: Kocham ciê.", GetNick(playa));
			ProxDetector(20.0, playerid, string, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);
			format(string, sizeof(string), "%s mówi: Ja ciebie te¿.", GetNick(playerid));
			ProxDetector(20.0, playerid, string, COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE);

			ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(playa, "KISSING", "Playa_Kiss_01", 4.0, 0, 0, 0, 0, 0);
			
			kissPlayerOffer[playerid] = INVALID_PLAYER_ID;
	}
	else if(kissPlayerOffer[playa] == INVALID_PLAYER_ID)
	{
		dialAccess[playa] = 0; // limit czasowy - jedna propozycja poca³unku na 15 sekund

		format(string, sizeof(string), "%s chce siê z tob¹ poca³owaæ - jeœli go kochasz odwzajemnij >> /caluj <<, masz na to 10 sekund!", GetNick(playerid));
		SendClientMessage(playa, COLOR_LIGHTBLUE, string);
		sendTipMessage(playerid, "Zaoferowa³eœ poca³unek - oczekuj na reakcjê!");

		kissPlayerOffer[playa] = playerid;
		SetTimerEx("KissRejectTimer", 10000, false, "dd", playerid, playa);
	}
	else
	{
		format(string, sizeof(string), "Poczekaj, ktoœ inny próbuje ju¿ poca³owaæ %s!", GetNick(playa));
		sendErrorMessage(playerid, string);
	}

	return 1;
}

//end
