//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setname ]------------------------------------------------//
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

YCMD:setname(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

	new newname[MAX_PLAYER_NAME];
	if (PlayerInfo[playerid][pAdmin] >= 5000)//(Uprawnienia(playerid, ACCESS_OWNER))
	{
		new giveplayerid;
		if( sscanf(params, "k<fix>s[25]", giveplayerid, newname))
		{
			sendTipMessage(playerid, "U¿yj /setname [playerid] [nowynick]");
			return 1;
		}
		if(strlen(newname) >= MAX_PLAYER_NAME)
		{
			format(string, sizeof(string), "Nowy nick nie mo¿e byæ d³u¿szy jak %d znaków", MAX_PLAYER_NAME); 
			sendErrorMessage(playerid, string); 
			return 1;
		}
		new nick[24];
		if(GetPVarString(giveplayerid, "maska_nick", nick, 24))
		{
			SendClientMessage(playerid, COLOR_GREY, " Gracz musi œci¹gn¹æ maskê z twarzy! (/maska).");
			return 1;
		}

		if(giveplayerid != INVALID_PLAYER_ID)
		{
		    if(PlayerInfo[giveplayerid][pDom] == 0)
		    {
		        if(PlayerInfo[giveplayerid][pBusinessOwner] == INVALID_BIZ_ID)
		        {
                    GetPlayerName(giveplayerid, giveplayer, MAX_PLAYER_NAME);
					new sender_log_name[50];
					new giveplayer_log_name[50];
					format(sender_log_name, sizeof(sender_log_name), "%s", GetPlayerLogName(playerid));
					format(giveplayer_log_name, sizeof(giveplayer_log_name), "%s", GetPlayerLogName(giveplayerid));
                    if(ChangePlayerName(giveplayerid, newname))
                    {
    					format(string, sizeof(string), "Administrator %s zmieni³ nick %s[%d] - Nowy nick: %s", GetNickEx(playerid),giveplayer,PlayerInfo[giveplayerid][UID],newname);
    					SendClientMessageToAll(COLOR_LIGHTRED, string);
						Log(adminLog, INFO, "Admin %s zmieni³ %s nick na %s", sender_log_name, giveplayer_log_name, newname);
						Log(nickLog, INFO, "Admin %s zmieni³ %s nick na %s", sender_log_name, giveplayer_log_name, newname);

                        ShowPlayerDialogEx(giveplayerid, 70, DIALOG_STYLE_MSGBOX, "Zmiana nicku", "W³aœnie zmieni³eœ nick. Nastêpuj¹ce elementy zosta³y wyzerowane:\n\nPraca\nFrakcja\nWanted Level\nRodzina\nLider\nRanga\nSkin\nZaufany Gracz\n\n\nPamiêtaj, ¿e ka¿da zmiana nicku jest na wagê z³ota wiêc nie trwoñ ich pochopnie!\nJe¿eli dosz³o do b³êdnej zmiany zg³oœ ten fakt prêdko na forum w panelu strat!\nPamiêtaj: nowa postaæ = nowe ¿ycie.", "Dalej", "");

    					SetPlayerName(giveplayerid, newname);
                    }
				}
				else
				{
				    sendErrorMessage(playerid, "Ten gracz ma biznes, nie mo¿esz zmieniæ mu nicku");
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Ten gracz ma dom, nie mo¿esz zmieniæ mu nicku");
			}
		}
		else if(giveplayerid == INVALID_PLAYER_ID)
		{
			format(string, sizeof(string), "%d nie jest aktywnym graczem.", giveplayerid);
			sendErrorMessage(playerid, string);
		}
	}
	return 1;
}
