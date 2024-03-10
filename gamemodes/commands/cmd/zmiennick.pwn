//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmiennick ]-----------------------------------------------//
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

YCMD:zmiennick(playerid, params[], help)
{
	new sendername[MAX_PLAYER_NAME];

	if (PlayerInfo[playerid][pLevel] >= 2)
	{
        //Nowy system
        if(PlayerInfo[playerid][pZmienilNick] < 1) return sendTipMessage(playerid, "Nie posidasz pakietu zmiany nicku.");

        if(PlayerInfo[playerid][pDom] == 0)
	    {
	        if(PlayerInfo[playerid][pPbiskey] == 255)
	        {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(isnull(params))
				{
					sendTipMessage(playerid, "U¿yj /zmiennick [nowy nick]");
                    sendTipMessage(playerid, "UWAGA!! Przy zmianie nicku kasuje ci siê frakcja/rodzina.", COLOR_PANICRED);
					return 1;
				}
				else
				{
					new nick[24];
					if(GetPVarString(playerid, "maska_nick", nick, 24))
					{
						SendClientMessage(playerid, COLOR_GREY, " Musisz œci¹gn¹æ maskê z twarzy! (/maska).");
						return 1;
					}

                    if(ChangePlayerName(playerid, params))
                    {
                    	SendClientMessageToAll(COLOR_LIGHTRED, sprintf("%s[%d] zmieni³ sobie nick - Nowy nick: %s", sendername,PlayerInfo[playerid][pUID],params));
                    	Log(nickLog, INFO, "{Player: %s[%d]} zmieni³ nick na: %s", sendername, PlayerInfo[playerid][pUID], params);
						PlayerPersonalization[playerid][PERS_GUNSCROLL] = 1;
						ShowPlayerDialogEx(playerid, 70, DIALOG_STYLE_MSGBOX, "Zmiana nicku", "W³aœnie zmieni³eœ nick. Nastêpuj¹ce elementy zosta³y wyzerowane:\n\nPraca\nFrakcja\nWanted Level\nRodzina\nLider\nRanga\nSkin\n\n\nPamiêtaj, ¿e ka¿da zmiana nicku jest na wagê z³ota wiêc nie trwoñ ich pochopnie!\nJe¿eli dosz³o do b³êdnej zmiany zg³oœ ten fakt prêdko na forum w panelu strat!\nPamiêtaj: nowa postaæ = nowe ¿ycie.", "Dalej", "");
                    }
                }
			}
			else
			{
			    sendTipMessage(playerid, "Masz biznes, nie mo¿esz zmieniæ nicku");
			}
		}
		else
		{
		    sendTipMessage(playerid, "Masz lub wynajmujesz dom, nie mo¿esz zmieniæ nicku");
		    sendTipMessage(playerid, "U¿yj /sprzedajdom lub /unrent");
		}
	}
	else
 	{
 		sendTipMessage(playerid, "Musisz mieæ 3 level aby zmieniæ sobie nick.");
  	}
	return 1;
}
