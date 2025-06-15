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
command_worek_Impl(playerid, params[256])
{
    new string[128];
	new giveplayername[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(!IsPlayerConnected(playerid))
    {
		return 1;
	}
	if(!IsAKidnapper(playerid) && PlayerInfo[playerid][pAdmin] < 1)
	{
		noAccessMessage(playerid);
		return 1;
	}

	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U�yj /worek [playerid/Cz��Nicku]");
		return 1;
	}
	if(giveplayerid == playerid) 
	{ 
		sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz za�o�y�/�ci�gn�� sobie samemu worka!"); 
		return 1; 
	}
	if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
	{
		sendErrorMessage(playerid, "Nie ma takiego gracza!");
		return 1;
	}
	if(!ProxDetectorS(8.0, playerid, giveplayerid))
	{
		sendTipMessageEx(playerid, COLOR_GREY, "U�yj /worek [playerid/Cz��Nicku] b�d�c w pobli�u ofiary !");
		return 1;
	}

	if(Worek_MamWorek[giveplayerid])
	{
		GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* %s �ci�gn�� Ci worek z g�owy, odzyska�e� orientacj� w terenie.", sendername);
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* �ci�gn��e� %s worek z g�owy.", giveplayername);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* %s �ci�ga %s worek z g�owy.", sendername ,giveplayername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		
		UnHave_Worek(giveplayerid);
	}
	else if (IsAKidnapper(playerid))
	{	
		if(Worek_Uzyty[playerid])
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Masz tylko jeden worek, zdejmij go poprzedniej osobie !");
			return 1;
		}
		if(PlayerTied[giveplayerid])
		{
			sendErrorMessage(playerid, "Mo�esz za�o�y� worek na g�ow� tylko graczowi, kt�ry jest zwi�zany.");
			return 1;
		}

		GetPlayerName(giveplayerid, giveplayername, sizeof(giveplayername));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* %s za�o�y� Ci worek na g�ow�, straci�e� orientacj� w terenie.", sendername);
		SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* Za�o�y�e� %s worek na g�ow�.", giveplayername);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "* %s zak�ada %s worek na g�ow�.", sendername ,giveplayername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

		Have_Worek(giveplayerid, playerid);

		//SetTimerEx("timer_MaWorek",2000,0,"d",giveplayerid);
		//todo timer:
		//osoba musi byc ranna/pobita, jezeli zakladajacy worek oddali sie na ~50 metrow lub wyjdzie z gry lub pojdzie afk dluzej niz 2 minuty worek zostanie zdjety
	}

	return 1;
}

//end
