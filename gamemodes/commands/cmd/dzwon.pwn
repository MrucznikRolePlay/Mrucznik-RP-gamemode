//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ dzwon ]-------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:dzwon(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];
    if(!IsPlayerConnected(playerid))
	{
		return 1;
	}
	
	if(gPlayerLogged[playerid] == 0)
	{
		return 1;
	}
	
	if(PlayerInfo[playerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu !");
		return 1;
	}
	if(Kajdanki_JestemSkuty[playerid])
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ telefonu podczas bycia skutym!");
		return 1;
	}
	if(PlayerInfo[playerid][pJailed] != 0)
	{
		sendErrorMessage(playerid, "Nie posiadasz telefonu w wiêzieniu!"); 
		return 1;
	}
	new numerTelefonuOdbiorcy;
	if( sscanf(params, "d", numerTelefonuOdbiorcy))
	{
		sendTipMessage(playerid, "U¿yj /dzwon [numer telefonu]");
		return 1;
	}
	
	if(numerTelefonuOdbiorcy == PlayerInfo[playerid][pPnumber])
	{
		sendErrorMessage(playerid, "Nie mo¿esz zadzwoniæ sam do siebie.");
		return 1;
	}
	
	if(numerTelefonuOdbiorcy < 1)
	{
		sendErrorMessage(playerid, "Niepoprawny numer telefonu.");
		return 1;
	}
	
	if(Mobile[playerid] != INVALID_PLAYER_ID)
	{
		sendErrorMessage(playerid, "Dzwonisz ju¿ do kogoœ.");
		return 1;
	}

	if(PhoneOnline[playerid] == 1)
	{
		sendTipMessage(playerid, "Twój telefon jest wy³¹czony! W³¹cz go za pomoc¹ /togtel");
		return 1;
	}

	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		sendErrorMessage(playerid, "Nie mo¿esz u¿ywaæ telefonu podczas s³u¿by administratora!"); 
		return 1;
	}
	
	new reciverid;
	if(numerTelefonuOdbiorcy != 911)
	{
		reciverid = FindPlayerByNumber(numerTelefonuOdbiorcy);
		if(reciverid == INVALID_PLAYER_ID)
		{
			sendErrorMessage(playerid, "Gracz o takim numerze jest offline.");
			return 1;
		}

		if(GetPlayerAdminDutyStatus(reciverid) == 1)
		{
			sendErrorMessage(playerid, "Osoba do której próbujesz zadzwoniæ jest nieosi¹galna!"); 
			return 1;
		}
		
		if(PhoneOnline[reciverid] == 1)
		{
			sendErrorMessage(playerid, "Gracz ma wy³¹czony telefon.");
			return 1;
		}
		
		if(Mobile[reciverid] != INVALID_PLAYER_ID)
		{
			sendErrorMessage(playerid, "Gracz ju¿ z kimœ rozmawia.");
			return 1;
		}
	}
	
	//all ok, lecim
	GetPlayerName(playerid, sendername, sizeof(sendername));
	format(string, sizeof(string), "* %s wyjmuje telefon, wybiera numer i wykonuje po³¹czenie.", sendername);
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	
	SendClientMessage(playerid, COLOR_WHITE, "Trwa ³¹czenie, proszê czekaæ...");
	SendClientMessage(playerid, COLOR_WHITE, "WSKAZÓWKA: U¿yj chatu IC aby rozmawiaæ przez telefon i /z aby sie roz³¹czyæ.");
	PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);

	if(numerTelefonuOdbiorcy == 911)
	{
		if(GUIExit[playerid] == 0)
		{
			//ShowPlayerDialogEx(playerid, 112, DIALOG_STYLE_LIST, "Numer alarmowy", "Policja\nStra¿ Po¿arna\nMedyk\nSheriff", "Wybierz", "Roz³¹cz siê");
			ShowPlayerDialogEx(playerid, 112, DIALOG_STYLE_LIST, "Numer alarmowy", "Policja\nSzpital\nStra¿ Po¿arna", "Wybierz", "Roz³¹cz siê");
		}
		else
		{
			sendErrorMessage(playerid, "Masz ju¿ otwarte inne okienko GUI, zamknij je i spróbuj jeszcze raz.");
		}
		return 1;
	}
	else
	{
		StartACall(playerid, reciverid);
	}
	return 1;
}
