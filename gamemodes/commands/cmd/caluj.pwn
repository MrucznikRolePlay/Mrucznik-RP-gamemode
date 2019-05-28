//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ caluj ]-------------------------------------------------//
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

YCMD:caluj(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /caluj [ID gracza]");
			return 1;
		}
		if(spamujeCaluj[playerid] == 1)
		{
			sendErrorMessage(playerid, "Odczekaj 2 minuty!"); 
			return 1;
		}
		if(playa == playerid)
		{
			sendErrorMessage(playerid, "Nie mo¿esz poca³owaæ samego siebie!"); 
			return 1;
		}
		if (ProxDetectorS(5.0, playerid, playa) && Spectate[playa] == INVALID_PLAYER_ID)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					format(string, sizeof(string), "%s chce siê z tob¹ poca³owaæ - jeœli go kochasz kliknij ''Ca³uj''!", GetNick(playerid, true));
  					ShowPlayerDialogEx(playa, 1092, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play - poca³unek", string, "Ca³uj", "Odrzuæ");
					format(string, sizeof(string), "Zaoferowa³eœ poca³unek %s - oczekuj na reakcje!", GetNick(playa, true));
					sendTipMessage(playerid, string);
					kissPlayerOffer[playa] = playerid;
					spamujeCaluj[playerid] = 1;
					timerCaluj[playerid] = SetTimerEx("SpamujeCalowaniem",60000,0,"i",playerid);//odczekaj 2 minuty
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Jesteœ za daleko !");
		}
	}
	return 1;
}
