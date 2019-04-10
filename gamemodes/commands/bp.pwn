//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ bp ]--------------------------------------------------//
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

CMD:bp(playerid, params[])//blokada pisania
{
	new giveplayerid, czas, text[32];
	if(sscanf(params, "k<fix>ds[32]", giveplayerid, czas, text))
	{
		sendTipMessage(playerid, "Uøyj /bp [ID gracza] [czas (w gozinach)] [nazwa chatu]");
		return 1;
	}
	if (PlayerInfo[playerid][pAdmin] >= 1)
	{
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if(czas <= 8 && czas >= 0)
				{
					new string[256], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					PlayerInfo[giveplayerid][pBP] = czas;
					format(string, sizeof(string), "AdmCmd: %s otrzyma≥ zakaz pisania od administratora %s. Czas: %d godzin. Powod: Z≥e uøycie globalnego chatu %s", giveplayer, sendername, czas, text);
                    SendPunishMessage(string, giveplayerid);
					format(string, sizeof(string), "Zosta≥eú ukarany blokadπ pisania na globalnych czatach na %d godzin.", czas);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					SendClientMessage(giveplayerid, COLOR_NEWS, "Sprawdü czy otrzymana kara jest zgodna z listπ kar i zasad, znajdziesz jπ na www.Mrucznik-RP.pl");
					format(string, sizeof(string), "AdmCmd: %s dostal BP od %s na %d godzin, z powodem %s", giveplayer, sendername, czas, text);
					KickLog(string);
					//opis
                    //Opis_Usun(giveplayerid);
                    Update3DTextLabelText(PlayerInfo[giveplayerid][pDescLabel], 0xBBACCFFF, "");
                    PlayerInfo[giveplayerid][pDesc][0] = EOS;
					return 1;
				}
				else
				{
					sendTipMessage(playerid, "Czas od 0 do 8");
				}
			}
		}
	}
	else
	{
		new string[64];
		format(string, sizeof(string), "%d jest nieaktywny.", giveplayerid);
		sendErrorMessage(playerid, string);
	}
	return 1;
}

