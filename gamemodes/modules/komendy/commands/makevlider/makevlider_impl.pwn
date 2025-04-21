//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_makevlider_Impl(playerid, params[256])
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
					sendTipMessage(playerid, "U�yj /makevleader [Nick] [Poziom Lidera]"); 
					sendTipMessage(playerid, "Poziom 0 - NIKT [Zabiera lidera pomocniczego]");
					sendTipMessage(playerid, "Poziom 2 - VLD [Pe�ny dost�p, nie mo�e mianowa� innych VLD]");
					sendTipMessage(playerid, "Poziom 3 - Kierownik [Tylko /przyjmij, /awans /zwolnij"); 
					return 1; 
				}
				if(giveplayerid == playerid)
				{
					sendErrorMessage(playerid, "Nie mo�esz wykona� tej operacji na sobie!"); 
					return 1;
				}
				if(IsPlayerConnected(giveplayerid))
				{
					if(value == 0)
					{
						if(PlayerInfo[giveplayerid][pLider] != PlayerInfo[playerid][pLider])
						{
							sendErrorMessage(playerid, "Nie mo�esz wyrzuci� gracza, kt�ry jest liderem innej frakcji."); 
							return 1;
						}

						Remove_MySQL_Leader(giveplayerid); 
						format(string, sizeof(string), "* Zosta�e� wyrzucony z frakcji przez %s.", GetNickEx(playerid));
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Jeste� cywilem.");
						Log(serverLog, INFO, "Lider %s usun�� gracza [VLD] %s z jego frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetFractionLogName(PlayerInfo[playerid][pMember]));
						PlayerInfo[giveplayerid][pMember] = 0;
						PlayerInfo[giveplayerid][pLider] = 0;
						PlayerInfo[giveplayerid][pJob] = 0;
						RemovePlayerFromOrg(giveplayerid);
						MedicBill[giveplayerid] = 0;
						SetPlayerSpawn(giveplayerid);
						format(string, sizeof(string), "  Wyrzuci�es %s z frakcji.", GetNick(giveplayerid));
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						return 1;
					}
					if(PlayerInfo[giveplayerid][pLider] > 0 || PlayerInfo[giveplayerid][pMember] > 0)
					{	
						sendErrorMessage(playerid, "Ten Gracz jest ju� w jakiej� frakcji!");
						return 1;
					}
					new Frac = GetPlayerFraction(playerid); 
					if((LeadersValue[LEADER_FRAC][Frac]+1) > MAX_LEADERS_ON_FRAC)
					{
						sendErrorMessage(playerid, "Nie mo�esz przyj�� kolejnego lidera!"); 
						return 1;
					}
					PlayerInfo[giveplayerid][pLider] = Frac; 
					PlayerInfo[giveplayerid][pLiderValue] = value; 
					PlayerInfo[giveplayerid][pMember] = Frac; 
					SetDefaultUniform(giveplayerid);
					Create_MySQL_Leader(giveplayerid, Frac, value);//Tworzenie konta LD
					Save_MySQL_Leader(giveplayerid);  
					format(string, sizeof(string), "%s mianowa� Ci� liderem [%d] organizacji %s [%d]", GetNickEx(playerid), value, FractionNames[Frac], Frac); 
					sendTipMessageEx(giveplayerid, COLOR_P@, string); 
					format(string, sizeof(string), "Mianowa�e�/a� %s liderem na stopien %d dla swojej frakcji!", GetNick(giveplayerid), value); 
					sendTipMessageEx(playerid, COLOR_P@, string); 
					Log(serverLog, INFO, "Lider %s da� lidera %s {Moc: %d} dla %s", GetPlayerLogName(playerid), GetFractionLogName(Frac), value,  GetPlayerLogName(giveplayerid));
				}
				else{
					sendErrorMessage(playerid, "Nie ma takiego gracza"); 
				}
			}
			else{
				sendErrorMessage(playerid, "Nie jeste� G��wnym Liderem!");
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jeste� liderem organizacji!"); 
		}
	}
	return 1;
}

//end
