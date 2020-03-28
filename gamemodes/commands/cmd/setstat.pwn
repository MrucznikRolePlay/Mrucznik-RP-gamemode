//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setstat ]------------------------------------------------//
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

YCMD:setstat(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, stat, amount;
		if( sscanf(params, "k<fix>dd", giveplayerid, stat, amount))
		{
			sendTipMessage(playerid, "U¿yj /setstat [playerid/CzêœæNicku] [statcode] [amount]");
			SendClientMessage(playerid, COLOR_GRAD4, "|1 Level |2 SpawnHealth |3 UpgradePoints |4 Skin ");
			SendClientMessage(playerid, COLOR_GRAD3, "|5 KontoBankowe |6 NumerTelefonu |7 PunktyRespektu ");
			SendClientMessage(playerid, COLOR_GRAD2, "|8 KluczDomowy |9 KluczBiznesu |10 KontoPremium |11 Rodzina");
			SendClientMessage(playerid, COLOR_GRAD2, "|12 £owca Nagród |13 Prawnik |14 Mechanik |15 Reporter |16 ZlodziejAut |17 Diler Zio³a");
            SendClientMessage(playerid, COLOR_GRAD2, "|18 Prostututka |19 Bokser |20 Diler Broni |21 Rybak |22 Busiarz |23 Kurier | 24 Praca | 25 Czas Kontraktu");
			return 1;
		}

        if(IsPlayerConnected(giveplayerid))
    	{
    	    if(giveplayerid != INVALID_PLAYER_ID)
    	    {
				if (PlayerInfo[playerid][pAdmin] >= 5000)
				{
					switch (stat)
					{
						case 1:
						{
							PlayerInfo[giveplayerid][pLevel] = amount;
							format(string, sizeof(string), "Level gracza zmieniony na %d", amount);
						}
						case 2:
						{
							PlayerInfo[giveplayerid][pSHealth] = amount;
							format(string, sizeof(string), "¯ycie na spawnie gracza wynosi teraz %d ", amount);
						}
						case 3:
						{
							PlayerInfo[giveplayerid][pUpgradeLvl] = amount;
							format(string, sizeof(string), "Punkty Ulepszenia gracza zmienione na %d", amount);
						}
						case 4:
						{
							PlayerInfo[giveplayerid][pSkin] = amount;
							format(string, sizeof(string), "Skin gracza zmieniony na %d", amount);
						}
						case 5:
						{
						    if(IsAHeadAdmin(playerid))
						    {
								PlayerInfo[giveplayerid][pBankMoney] = amount;
								format(string, sizeof(string), "Kwota w Koncie Bankowym gracza zmieniona na $%d", amount);
							}
							else
							{
							    SendClientMessage(playerid, COLOR_GRAD1, "Nie ma");
							    return 1;
							}
						}
						case 6:
						{
							PlayerInfo[giveplayerid][pPnumber] = amount;
							format(string, sizeof(string), "Numer telefonu gracza zmieniony na %d", amount);
						}
						case 7:
						{
							PlayerInfo[giveplayerid][pExp] = amount;
							format(string, sizeof(string), "Punkty respektu gracza zmienione na %d", amount);
						}
						case 8:
						{
							PlayerInfo[giveplayerid][pDom] = amount;
							format(string, sizeof(string), "Klucz domowy gracza zmieniony na %d", amount);
						}
						case 9:
						{
							PlayerInfo[giveplayerid][pPbiskey] = amount;
							format(string, sizeof(string), "Klucz do biznesu gracza zmieniony na %d", amount);
						}
						case 10:
						{
							format(string, sizeof(string), "Ta funkcja zosta³a wy³¹czona", amount);
						}
						case 11:
						{
                            orgInvitePlayer(giveplayerid, amount);
							format(string, sizeof(string), "Rodzina gracza zmieniono na %d", amount);
						}
						case 12:
						{
							PlayerInfo[giveplayerid][pDetSkill] = amount;
							format(string, sizeof(string), "Skill £owcy Nagród gracza zmieniony na %d", amount);
						}
						case 13:
						{
							PlayerInfo[giveplayerid][pLawSkill] = amount;
							format(string, sizeof(string), "Skill prawnika gracza zmieniony na %d", amount);
						}
						case 14:
						{
							PlayerInfo[giveplayerid][pMechSkill] = amount;
							format(string, sizeof(string), "Skill mechanika gracza zmieniony na %d", amount);
						}
						case 15:
						{
							PlayerInfo[giveplayerid][pNewsSkill] = amount;
							format(string, sizeof(string), "Skill reportera gracza zmieniony na %d", amount);
						}
						case 16:
						{
							PlayerInfo[giveplayerid][pJackSkill] = amount;
							format(string, sizeof(string), "Skill z³odzieja samochodów gracza zmieniony na %d", amount);
						}
						case 17:
						{
							PlayerInfo[giveplayerid][pDrugsSkill] = amount;
							format(string, sizeof(string), "Skill Dilera Zio³a gracza zmieniony na %d", amount);
						}
						case 18:
						{
							PlayerInfo[giveplayerid][pSexSkill] = amount;
							format(string, sizeof(string), "Skill prostytutki gracza zmieniony na %d", amount);
						}
						case 19:
						{
							PlayerInfo[giveplayerid][pBoxSkill] = amount;
							format(string, sizeof(string), "Skill Boksera gracza zmieniony na %d", amount);
						}
						case 20:
						{
							PlayerInfo[giveplayerid][pGunSkill] = amount;
							format(string, sizeof(string), "Skill Dilera Broni gracza zmieniony na %d", amount);
						}
						case 21:
						{
							PlayerInfo[giveplayerid][pFishSkill] = amount;
							format(string, sizeof(string), "Skill Rybaka gracza zmieniony na %d", amount);
						}
						case 22:
						{
							PlayerInfo[giveplayerid][pCarSkill] = amount;
							format(string, sizeof(string), "Skill Busiarza gracza zmieniony na %d", amount);
						}
                        case 23:
						{
							PlayerInfo[giveplayerid][pTruckSkill] = amount;
							format(string, sizeof(string), "Skill kuriera gracza zmieniony na %d", amount);
						}
						case 24:
						{
							PlayerInfo[giveplayerid][Job] = amount;
							format(string, sizeof(string), "Praca gracza zmieniona na %d", amount);
						}
						case 25:
						{
							PlayerInfo[giveplayerid][pContractTime] = amount;
							format(string, sizeof(string), "Czas kontraktu gracza zmieniony na %d", amount);
						}
						case 1337:
						{
							PlayerInfo[giveplayerid][pOnlineHours] = amount;
							format(string, sizeof(string), "Czas gry gracza zmieniony na %d", amount);
						}
						default:
						{
							format(string, sizeof(string), "Z³y kod statystyk", amount);
						}

					}
					SendClientMessage(playerid, COLOR_GRAD1, string);
					Log(adminLog, INFO, "Admin %s zmieni³ %s statystykê: %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), string);
				}
				else
				{
					noAccessMessage(playerid);
				}
			}//not valid id
		}//not connected
	}
	return 1;
}
