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
		if(GetPLocal(playerid) != PLOCAL_INNE_BANK)
		{
			sendErrorMessage(playerid, "Nie znajdujesz siê w banku lub nie posiadasz smartfona!"); 
			return 1;
		}
		if(PlayerPersonalization[playerid][PERS_KB] == 0)
		{
			format(string, sizeof(string), "Konto Bankowe >> %s >> Przelew", GetNick(playerid));
			ShowPlayerDialogEx(playerid, 1072, DIALOG_STYLE_INPUT, string, "Wpisz poni¿ej ID odbiorcy", "Wykonaj", "Odrzuæ");
		}
		else
		{
			new giveplayerid, value;
			if( sscanf(params, "k<fix>d", giveplayerid, value))
			{
				sendTipMessage(playerid, "U¿yj /przelew [ID_GRACZA] [KWOTA]");
				return 1;
			}
			if(IsPlayerConnected(giveplayerid))
			{
				if(GetPlayerVirtualWorld(giveplayerid) == 1488)
				{
					sendErrorMessage(playerid, "Ten gracz jest w trakcie logowania!"); 
					return 1;
				}
				if(giveplayerid != playerid)
				{
					if(PlayerInfo[playerid][pBankMoney] < value)
					{	
						sendErrorMessage(playerid, "Nie masz takiej kwoty na swoim koncie!"); 
						return 1;
					}
					if(value <= 0)
					{
						sendErrorMessage(playerid, "Nie mo¿esz wykonywaæ przelewów na minus / zero.");
						return 1;
					}
					if(PlayerInfo[giveplayerid][pBankMoney]+value > MAX_MONEY_IN_BANK)
					{
						sendErrorMessage(playerid, "Gracz do którego próbowa³eœ przelaæ gotówkê - ma zbyt du¿o pieniêdzy na koncie."); 
						return 1;
					}
					//Czynnoœci:
					PlayerInfo[playerid][pBankMoney] -= value;
					PlayerInfo[giveplayerid][pBankMoney] += value;
				
					//komunikaty:
					format(string, sizeof(string), "Otrzyma³eœ przelew w wysokoœci %d$ od %s . Pieni¹dze znajduj¹ siê na twoim koncie.", value, GetNick(playerid));
					SendClientMessage(giveplayerid, COLOR_RED, string);
				
					format(string, sizeof(string), "Wys³a³eœ przelew dla %s w wysokoœci %d$. Pieni¹dze zosta³y pobrane z twojego konta bankowego", GetNick(giveplayerid), value);
					SendClientMessage(playerid, COLOR_RED, string); 
				
					Log(payLog, INFO, "%s przela³ %s kwotê %d$", 
					GetPlayerLogName(playerid),
					GetPlayerLogName(giveplayerid),
					value);
				
					if(value >= 5_000_000)//Wiadomosc dla adminow
					{
						format(string, sizeof(string), "Gracz %s wys³a³ przelew do %s w wysokoœci %d$", GetNick(playerid), GetNick(giveplayerid), value);
						SendAdminMessage(COLOR_YELLOW, string);
						return 1;
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie mo¿esz przelaæ gotówki samemu sobie!");
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Nie ma na serwerze takiego gracza!"); 
				return 1;
			}
		}
	}
	return 1;
}
