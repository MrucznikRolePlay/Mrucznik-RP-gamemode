//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ przelew ]------------------------------------------------//
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

YCMD:przelew(playerid, params[], help)
{
	new string[128];
	
	if(IsPlayerConnected(playerid))
	{
		format(string, sizeof(string), "Konto Bankowe >> %s >> Przelew", GetNick(playerid, true));
		ShowPlayerDialogEx(playerid, 1072, DIALOG_STYLE_INPUT, string, "Wpisz poni¿ej ID odbiorcy", "Wykonaj", "Odrzuæ");
	}
/*=============[BLOKADA - WYKORZYSTANE W /KB]==============
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 1)
        {
			if(PlayerInfo[playerid][pLevel] < 3)
			{
				sendTipMessage(playerid, "Musisz mieæ 3 level!");
				return 1;
			}
			if(PlayerInfo[playerid][pLocal] != 103)
	        {
	            sendErrorMessage(playerid, "Nie jesteœ w Banku!");
	            return 1;
	        }
			new giveplayerid, moneys;
			if( sscanf(params, "k<fix>s[32]", giveplayerid, string))
			{
				sendTipMessage(playerid, "U¿yj /przelew [playerid/CzêœæNicku] [kwota]");
				return 1;
			}
			moneys = FunkcjaK(string);

			if (IsPlayerConnected(giveplayerid) && giveplayerid != playerid)
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new playermoney = PlayerInfo[playerid][pAccount] ;
					if (moneys > 0 && playermoney >= moneys)
					{
					    if(PlayerInfo[playerid][pConnectTime] >= 1)
					    {
							PlayerInfo[playerid][pAccount] -= moneys;
							PlayerInfo[giveplayerid][pAccount] += moneys;
							format(string, sizeof(string), "Dokona³eœ przelewu $%d na konto %s", moneys, giveplayer,giveplayerid);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "Otrzyma³eœ przelew $%d od %s", moneys, sendername, playerid);
							SendClientMessage(giveplayerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "%s przela³ $%d do %s", sendername, moneys, giveplayer);
			                if(moneys >= 50000)
							{
								ABroadCast(COLOR_YELLOW,string,1);
							}
							printf("%s", string);
							Log(payLog, INFO, string);
							PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
						}
						else
						{
						    PlayerInfo[playerid][pAccount] -= moneys;
							format(string, sizeof(string), "Dokona³eœ przelewu $%d na konto %s", moneys, giveplayer,giveplayerid);
							PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
							SendClientMessage(playerid, COLOR_GRAD1, string);
							format(string, sizeof(string), "%s przela³ $%d do %s (fikcyjny)", sendername, moneys, giveplayer);
			                if(moneys >= 50000)
							{
								ABroadCast(COLOR_YELLOW,string,1);
							}
							printf("%s", string);
							Log(payLog, INFO, string);
						}
					}
					else
					{
						sendTipMessage(playerid, "Nieprawid³owa kwota transakcji.");
					}
				}
			}
			else
			{
				format(string, sizeof(string), "Gracz o ID %d nie istnieje.", giveplayerid);
				sendErrorMessage(playerid, string);
			}
		}
	}*/
	return 1;
}
