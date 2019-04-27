//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ sprzedajbiznes ]--------------------------------------------//
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

CMD:sprzedajbiznes(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new giveplayerid, valueCost;
		new string[256];
		if(sscanf(params, "k<fix>d", giveplayerid, valueCost))
		{
			return sendTipMessage(playerid, "U¿yj /sprzedajbiznes [ID_GRACZA] [Cena]"); 
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid == playerid)
			{
				sendTipMessage(playerid, "Nie mo¿esz zaoferowaæ sprzeda¿y samemu sobie"); 
				return 1;
			}
			if(ProxDetectorS(8.0, playerid, giveplayerid))
			{
				if(IsPlayerInRangeOfPoint(playerid, 
				5.0, 
				BizData[PlayerInfo[playerid][pPbiskey]][eBizWejX], 
				BizData[PlayerInfo[playerid][pPbiskey]][eBizWejY],
				BizData[PlayerInfo[playerid][pPbiskey]][eBizWejZ]))
				{
				
					if(valueCost <= BIZ_SELL_MONEY_LIMIT)
					{
						if(GetPlayerMoney(giveplayerid) >= valueCost)
						{
							if(GetPVarInt(playerid, "wpisal_sprzedaj_biz") == 0)
							{
								sendTipMessage(playerid, "Pamiêtaj, ¿e Wydzia³ Planowania otr¹ci podatek w wysokoœci 1/5 podanej kwoty."); 
								sendTipMessage(playerid, "Je¿eli akceptujesz podane warunki wpisz ponownie komendê"); 
								SetPVarInt(playerid, "wpisal_sprzedaj_biz", 1); 
							}
							else
							{
								format(string, sizeof(string), "Wys³a³eœ ofertê do %s odnoœnie kupna biznesu [ID %d] za %d", GetNick(giveplayerid, true), PlayerInfo[playerid][pPbiskey], valueCost);
								sendTipMessage(playerid, string);
								sendTipMessage(playerid, "Oczekuj na akceptacje"); 
								
								
								//do giveplayerid
								format(string, sizeof(string), "Gracz %s oferuje Ci kupno biznesu [ID: %d] za kwotê %d$, wpisz /akceptuj biznes", GetNick(playerid, true), PlayerInfo[playerid][pPbiskey], valueCost); 
								sendTipMessage(giveplayerid, string); 
								SetPVarInt(giveplayerid, "Oferujacy_ID", playerid);
								SetPVarInt(giveplayerid, "Oferujacy_Cena", valueCost); 
								SetPVarInt(giveplayerid, "Oferujacy_biz_ID", PlayerInfo[playerid][pPbiskey]); 
							}
						}
						else
						{
							sendTipMessage(playerid, "Ten gracz nie ma przy sobie takiej kwoty"); 
							return 1;
						}
					}
					else
					{
						sendTipMessage(playerid, "Przy sprzeda¿y biznesu za wiêksz¹ cene wymagana jest obecnoœæ cz³onka Wydzia³u Planowania"); 
						return 1;
					}
				}
				else
				{
					sendTipMessage(playerid, "Nie znajdujesz siê pod swoim biznesem"); 
					return 1;
				}
			}
			else
			{
				sendErrorMessage(playerid, "Ten gracz nie znajduje siê obok Ciebie!"); 
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie ma takiego gracza"); 
		}
	}
	return 1;
}
