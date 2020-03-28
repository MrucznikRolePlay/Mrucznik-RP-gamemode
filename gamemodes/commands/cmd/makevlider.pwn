//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ makevleader ]----------------------------------------------//
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

YCMD:makevleader(playerid, params[], help)
{
	new string[256]; 
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pLider] > 0)
		{
			if(PlayerInfo[playerid][pLiderValue] == 1)
			{
				new giveplayerid, value; 
				if(sscanf(params, "k<fix>d", giveplayerid, value))
				{
					sendTipMessage(playerid, "U¿yj /makevleader [Nick] [Poziom Lidera]"); 
					sendTipMessage(playerid, "Poziom 0 - NIKT [Zabiera lidera pomocniczego]");
					sendTipMessage(playerid, "Poziom 2 - VLD [Pe³ny dostêp, nie mo¿e mianowaæ innych VLD]");
					sendTipMessage(playerid, "Poziom 3 - Kierownik [Tylko /przyjmij, /awans /zwolnij"); 
					return 1; 
				}
				if(giveplayerid == playerid)
				{
					sendErrorMessage(playerid, "Nie mo¿esz wykonaæ tej operacji na sobie!"); 
					return 1;
				}
				if(IsPlayerConnected(giveplayerid))
				{
					if(value == 0)
					{
						if(PlayerInfo[giveplayerid][pLider] != PlayerInfo[playerid][pLider])
						{
							sendErrorMessage(playerid, "Nie mo¿esz wyrzuciæ gracza, który jest liderem innej frakcji."); 
							return 1;
						}

						Remove_MySQL_Leader(giveplayerid); 
						format(string, sizeof(string), "* Zosta³eœ wyrzucony z frakcji przez %s.", GetNickEx(playerid));
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Jesteœ cywilem.");
						Log(serverLog, INFO, "Lider %s usun¹³ gracza [VLD] %s z jego frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetFractionLogName(PlayerInfo[playerid][pMember]));
						PlayerInfo[giveplayerid][pMember] = 0;
						PlayerInfo[giveplayerid][pLider] = 0;
						PlayerInfo[giveplayerid][pJob] = 0;
						orgUnInvitePlayer(giveplayerid);
						MedicBill[giveplayerid] = 0;
						SetPlayerSpawn(giveplayerid);
						format(string, sizeof(string), "  Wyrzuci³es %s z frakcji.", GetNick(giveplayerid));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						return 1;
					}
					if(PlayerInfo[giveplayerid][pLider] > 0 || PlayerInfo[giveplayerid][pMember] > 0)
					{	
						sendErrorMessage(playerid, "Ten Gracz jest ju¿ w jakiejœ frakcji!");
						return 1;
					}
					new Frac = GetPlayerFraction(playerid); 
					if((LeadersValue[LEADER_FRAC][Frac]+1) > MAX_LEADERS_ON_FRAC)
					{
						sendErrorMessage(playerid, "Nie mo¿esz przyj¹æ kolejnego lidera!"); 
						return 1;
					}
					PlayerInfo[giveplayerid][pLider] = Frac; 
					PlayerInfo[giveplayerid][pLiderValue] = value; 
					PlayerInfo[giveplayerid][pMember] = Frac; 
					Create_MySQL_Leader(giveplayerid, Frac, value);//Tworzenie konta LD
					Save_MySQL_Leader(giveplayerid);  
					format(string, sizeof(string), "%s mianowa³ Ciê liderem [%d] organizacji %s [%d]", GetNickEx(playerid), value, FractionNames[Frac], Frac); 
					sendTipMessageEx(giveplayerid, COLOR_P@, string); 
					format(string, sizeof(string), "Mianowa³eœ/aœ %s liderem na stopien %d dla swojej frakcji!", GetNick(giveplayerid), value); 
					sendTipMessageEx(playerid, COLOR_P@, string); 
					Log(serverLog, INFO, "GLD %s dal lidera %s {Moc: %d} dla %s", GetPlayerLogName(playerid), GetFractionLogName(Frac), value,  GetPlayerLogName(giveplayerid));
				}
				else{
					sendErrorMessage(playerid, "Nie ma takiego gracza"); 
				}
			}
			else{
				sendErrorMessage(playerid, "Nie jesteœ G³ównym Liderem!");
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ liderem organizacji!"); 
		}
	}
	return 1;
}
