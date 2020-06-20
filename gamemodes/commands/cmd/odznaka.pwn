//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ odznaka ]------------------------------------------------//
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

YCMD:odznaka(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new giveplayerid;
		if(sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /odznaka [id gracza]");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
				if (ProxDetectorS(5.0, playerid, giveplayerid) && Spectate[giveplayerid] == INVALID_PLAYER_ID)
				{
					new string[64], sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME];
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					if(GetPlayerFraction(playerid) == FRAC_LSPD)
					{
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "|______________ Odznaka LSPD _____________|");
						format(string, sizeof(string), "Numer odznaki: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						if(PlayerInfo[playerid][pRank] < 2)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Ruchu Drogowego");
						}
						else if(PlayerInfo[playerid][pRank] == 2 || PlayerInfo[playerid][pRank] == 3)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Prewencyjny");
						}
						else if(PlayerInfo[playerid][pRank] >= 4)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Kryminalny");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Brak wydzia³u");
						}
                        format(string, sizeof(string), "Ranga: %s", FracRang[FRAC_LSPD][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] == 0)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Nie");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Tak");
						}
						SendClientMessage(giveplayerid,COLOR_GRAD2,"Posiadacz tej odznaki ma uprawnienia do przeprowadzania");
						SendClientMessage(giveplayerid,COLOR_GRAD2,"kontroli osób wzbudzaj¹cych podejrzenia ³amania prawa. Prezydent");
						SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "|_____ San Andreas Police Department _____|");
					}
					if(GetPlayerFraction(playerid) == FRAC_FBI)
					{
						SendClientMessage(giveplayerid, COLOR_FBI, "|______________ Odznaka FBI ______________|");
						format(string, sizeof(string), "Numer odznaki: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						if(PlayerInfo[playerid][pRank] < 3)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Œledczy");
						}
						else if(PlayerInfo[playerid][pRank] >= 9)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Kierowniczy");
						}
						else if(PlayerInfo[playerid][pRank] >= 7)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Wywiadowczy");
						}
						else if(PlayerInfo[playerid][pRank] >= 3)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Wydzia³: Walki z Przestêpczoœci¹ Zorganizowan¹");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Brak wydzia³u");
						}
                        format(string, sizeof(string), "Ranga: %s", FracRang[FRAC_FBI][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] == 0)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Nie");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Tak");
						}
						SendClientMessage(giveplayerid,COLOR_GRAD2,"Ta odznaka uprawnia do przejêcia dowodzenia nad");
						SendClientMessage(giveplayerid,COLOR_GRAD2,"wszytkimi jednostami s³u¿b. porz. podczas akcji. Prezydent.");
						SendClientMessage(giveplayerid, COLOR_FBI, "|____ Federal Bureau of Investigation ____|");
					}
					if(GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 21 || GetPlayerOrg(playerid) == 22)
					{
						SendClientMessage(giveplayerid, COLOR_GREEN, "|______________ Dokumenty GS ______________|");
						format(string, sizeof(string), "Numer seryjny: %d%d%d%d", PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Stopieñ: [%d]", PlayerInfo[playerid][pRank]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						SendClientMessage(giveplayerid,COLOR_WHITE,"* Upowa¿nia do posiadania materia³ów i sprzeda¿y broni");
						SendClientMessage(giveplayerid,COLOR_RED,"* Nie upowa¿nia do posiadania broni ciê¿kiej");
						SendClientMessage(giveplayerid, COLOR_GREEN, "|_________________ Gunshop ________________|");
					}
					if(GetPlayerFraction(playerid) == FRAC_NG)
					{
						SendClientMessage(giveplayerid, COLOR_GREEN, "|______________ Odznaka NGSA ______________|");
						format(string, sizeof(string), "Numer odznaki: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", FracRang[FRAC_NG][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] == 0 && PlayerInfo[playerid][pRank] < 7)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Nie");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_GREEN,"Mo¿liwoœæ interwencji: Tak");
						}
						SendClientMessage(giveplayerid,COLOR_GRAD2,"Posiadacz tej odznaki ma uprawnienia do wylegitymowania");
						SendClientMessage(giveplayerid,COLOR_GRAD2,"ka¿dego obywatela na terenie stanu San Andreas.");
						SendClientMessage(giveplayerid, COLOR_BLUE, "|____ National Guard of San Andreas ____|");
					}
					if(GetPlayerFraction(playerid) == FRAC_ERS)
					{
						SendClientMessage(giveplayerid, COLOR_ALLDEPT, "|______________ Identyfikator LSRS ______________|");
						format(string, sizeof(string), "Numer identyfikatora: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", FracRang[FRAC_ERS][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] == 0)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Nie");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Tak");
						}
						SendClientMessage(giveplayerid,COLOR_GRAD2,"Identyfikator uprawnia do uczestniczenia w akcjach");
						SendClientMessage(giveplayerid,COLOR_GRAD2,"s³u¿b. porz. oraz dowództwo w zakresie ochrony zdrowia");
						SendClientMessage(giveplayerid, COLOR_ALLDEPT, "|____ San Andreas Metropolitan Emergency Service ____|");
					}
					if (GetPlayerFraction(playerid) == FRAC_BOR)
					{
						SendClientMessage(giveplayerid, COLOR_PURPLE, "|______________ Odznaka USSS _____________|");
						format(string, sizeof(string), "Numer odznaki: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", FracRang[FRAC_BOR][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] == 0)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Nie");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Mo¿liwoœæ interwencji: Tak");
						}
						SendClientMessage(giveplayerid, COLOR_PURPLE, "|_____ United States Secret Service _____|");
					}
					if (GetPlayerOrg(playerid) == FAMILY_SAD)
					{
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|______________ Legitymacja SCoSA _____________|");
						format(string, sizeof(string), "Imiê i nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", FamRang[FAMILY_SAD][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(PlayerInfo[playerid][pRank] > 3)
						{
							SendClientMessage(giveplayerid,COLOR_GREEN,"TA OSOBA POSIADA IMMUNITET!");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_RED,"TA OSOBA NIE POSIADA IMMUNITETU!");
						}
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|______________ Legitymacja SCoSA _____________|");
					}
					if (GetPlayerFraction(playerid) == FRAC_GOV)
					{
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|___________ Legitymacja Urzêdu Miasta __________|");
						format(string, sizeof(string), "Imiê i nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Stopieñ: %s", FamRang[FAMILY_SAD][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(PlayerInfo[playerid][pRank] > 7)
						{
							SendClientMessage(giveplayerid,COLOR_GREEN,"TA OSOBA POSIADA IMMUNITET!");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_RED,"TA OSOBA NIE POSIADA IMMUNITETU!");
						}
						SendClientMessage(giveplayerid, COLOR_LIGHTGREEN, "|_____________ Podpis: Burmistrz & Posiadacz __________|");
					}
					if (GetPlayerFraction(playerid) == FRAC_SN)
					{
						SendClientMessage(giveplayerid, COLOR_NEWS, "|______________ Identyfikator SAN _____________|");
						format(string, sizeof(string), "Numer identyfikatora: %d%d%d%d%d", PlayerInfo[playerid][pMember], PlayerInfo[playerid][pSex], PlayerInfo[playerid][pRank], PlayerInfo[playerid][pPnumber], PlayerInfo[playerid][pCrimes]);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
						format(string, sizeof(string), "Imiê i Nazwisko: %s.", sendername);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
                        format(string, sizeof(string), "Ranga: %s", FracRang[FRAC_SN][PlayerInfo[playerid][pRank]]);
						SendClientMessage(giveplayerid,COLOR_WHITE,string);
						if(OnDuty[playerid] == 0)
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Uprawnienia: Ograniczone");
						}
						else
						{
							SendClientMessage(giveplayerid,COLOR_WHITE,"Uprawnienia: Pe³ne");
						}
						SendClientMessage(giveplayerid,COLOR_GRAD2,"Identyfikator uprawnia do obserwacji wszytkich dzia³añ");
						SendClientMessage(giveplayerid,COLOR_GRAD2,"jedn. adm. pub. oraz otrzymywania informacji o tych dzia³aniach.");
						SendClientMessage(giveplayerid, COLOR_NEWS, "|_____ San Andreas Network _____|");
					}
					//
					format(string, sizeof(string), "* %s pokazuje dokumenty %s.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				else
				{
					sendErrorMessage(playerid, "Gracz nie jest przed tob¹ !");
					return 1;
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Gracz jest OFFLINE!");
			return 1;
		}
	}
	return 1;
}
