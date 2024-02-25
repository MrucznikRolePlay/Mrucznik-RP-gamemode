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
		if (ProxDetectorS(5.0, playerid, playa))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
					dialAccess[playa] = 0; 
					format(string, sizeof(string), "%s chce siê z tob¹ poca³owaæ - jeœli go kochasz kliknij ''Ca³uj''!", GetNick(playerid));
  					ShowPlayerDialogEx(playa, 1092, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play - poca³unek", string, "Ca³uj", "Odrzuæ", false);
					ShowPlayerInfoDialog(playerid, "Mrucznik Role-Play", "Zaoferowa³eœ poca³unek - oczekuj na reakcje!", true);
					format(string, sizeof(string), "Zaoferowa³eœ poca³unek %s - oczekuj na reakcje!", GetNick(playa));
					sendTipMessage(playerid, string);
					kissPlayerOffer[playa] = playerid;
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
