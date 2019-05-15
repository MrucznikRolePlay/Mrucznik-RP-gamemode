//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ wylogujgracz ]---------------------------------------------//
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

YCMD:wylogujgracz(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /wylogujgracz [playerid/CzêœæNicku]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 100)
		{
		    if(IsPlayerConnected(giveplayerid)&&giveplayerid != INVALID_PLAYER_ID)
		    {
                MruMySQL_SaveAccount(giveplayerid);
				gPlayerLogged[giveplayerid] = 0;
				SendClientMessage(playerid, COLOR_GRAD1, "Gracz zosta³ wylogowany.");
                new str[128];
                format(str, 128, "* Zosta³es wylogowany przez admina %s [%d].", GetNick(playerid), playerid);
                SendClientMessage(giveplayerid, COLOR_GRAD1,str);
                format(str, 128, "* Admin %s wylogowa³ %s", GetNick(playerid), GetNick(giveplayerid));
                Log(statsLog, INFO, str);
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
