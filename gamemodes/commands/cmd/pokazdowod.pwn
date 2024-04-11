//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ pokazdowod ]----------------------------------------------//
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

YCMD:pokazdowod(playerid, params[], help)
{
	new string[64];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /dowod [id gracza]");
			return 1;
		}
		if (PlayerInfo[playerid][pDowod] == 0)
		{
			sendErrorMessage(playerid, "Nie posiadasz dowodu, wyrób go w urzêdzie !");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
			if(giveplayerid != INVALID_PLAYER_ID)
			{
			    if (ProxDetectorS(8.0, playerid, giveplayerid))
				{

				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
				    new atext[20];
				    //new otext[20];
				    new jtext[32];
                    new otext[8];
				    new age = PlayerInfo[playerid][pAge];
                    if(PlayerInfo[playerid][pSex] == 1) { atext = "Mê¿czyzna"; }
	                else if(PlayerInfo[playerid][pSex] == 2) { atext = "Kobieta"; }
	                /*if(PlayerInfo[playerid][pOrigin] == 1) { otext = "Los Santos"; }
                    else if(PlayerInfo[playerid][pOrigin] == 2) { otext = "San Fierro"; }
	                else if(PlayerInfo[playerid][pOrigin] == 3) { otext = "LV"; }*/
	                //
	                new ttext[20];
					if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1) { ttext = "Komisariat LSPD"; }
					else if(PlayerInfo[playerid][pMember] == 2 || PlayerInfo[playerid][pLider] == 2) { ttext = "Biuro FBI"; }
					else if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3) { ttext = "NG"; }
					else if(PlayerInfo[playerid][pMember] == 4 || PlayerInfo[playerid][pLider] == FRAC_ERS) { ttext = "Szpital"; }
					else if(PlayerInfo[playerid][pMember] == 5 || PlayerInfo[playerid][pLider] == 5) { ttext = "Jetty Lounge"; }
					else if(PlayerInfo[playerid][pMember] == 6 || PlayerInfo[playerid][pLider] == 6) { ttext = "Agencja Ochrony"; }
					else if(PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLider] == 7) { ttext = "BOR"; }
					else if(PlayerInfo[playerid][pMember] == 8 || PlayerInfo[playerid][pLider] == 8) { ttext = "Cieciarnia"; }
					else if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9) { ttext = "SAN News"; }
					else if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10) { ttext = "Taxi Corporation"; }
					else if(PlayerInfo[playerid][pMember] == 11 || PlayerInfo[playerid][pLider] == 11) { ttext = "Urz¹d Miasta"; }
					else if(PlayerInfo[playerid][pMember] == 12 || PlayerInfo[playerid][pLider] == 12) { ttext = "Bar Green Bottles"; }
					else if(PlayerInfo[playerid][pMember] == 13 || PlayerInfo[playerid][pLider] == 13) { ttext = "Glen Park"; }
					else if(PlayerInfo[playerid][pMember] == 14 || PlayerInfo[playerid][pLider] == 14) { ttext = "Salon tatua¿u"; }
					else if(PlayerInfo[playerid][pMember] == 15 || PlayerInfo[playerid][pLider] == 15) { ttext = "Warsztat tuningu"; }//NoA
					else if(PlayerInfo[playerid][pMember] == 16 || PlayerInfo[playerid][pLider] == 16) { ttext = "Bonehead Club"; }//WPS
					else { ttext = "Cywil"; }
	                // 1 usa 2 europa 3 azja
                    new pochodzenie = PlayerInfo[playerid][pOrigin];
                    switch(pochodzenie) {
                        case 1: otext = "USA";
                        case 2: otext = "Europa";
                        case 3: otext = "Azja";
                    }
                    // 
                    if(PlayerInfo[playerid][pJob] != 0) { strcat(jtext, GetJobName(GetPlayerJob(playerid))); }
                    else { jtext = "Bezrobotny"; }
			       //
       				SendClientMessage(giveplayerid, COLOR_NEWS, "|______________ Dowód Osobisty ______________|");
					format(string, sizeof(string), "- Imie i Nazwisko: %s", sendername);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- SSN: %d%d%d%d%d%d%d", PlayerInfo[playerid][pMember],age,PlayerInfo[playerid][pLider],PlayerInfo[playerid][pPnumber],PlayerInfo[playerid][pJob],PlayerInfo[playerid][pSex],PlayerInfo[playerid][pLevel]);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- P³eæ: %s", atext);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- Pochodzenie: %s", otext);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					format(string, sizeof(string), "- Wiek: %d", age);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					if(PlayerInfo[playerid][pJob] >= 1 && PlayerInfo[playerid][pJob] != 9 && PlayerInfo[playerid][pJob] != 4 && PlayerInfo[playerid][pJob] != 5)
					{
						format(string, sizeof(string), "- Praca: %s", jtext);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
					}
					if(PlayerInfo[playerid][pMember] >= 1 || PlayerInfo[playerid][pLider] >= 1)
					{
						format(string, sizeof(string), "- Zatrudnienie: %s", ttext);
						SendClientMessage(giveplayerid, COLOR_WHITE, string);
					}
					format(string, sizeof(string), "- Numer telefonu: %d", PlayerInfo[playerid][pPnumber]);
					SendClientMessage(giveplayerid, COLOR_WHITE, string);
					SendClientMessage(giveplayerid,COLOR_NEWS,"|______________________________________________|");
					//
					format(string, sizeof(string), "* %s pokaza³ Ci swój dowód osobisty.", sendername);
					SendClientMessage(giveplayerid, COLOR_PURPLE, string);
					format(string, sizeof(string), "* Pokaza³eœ dowód graczowi %s.", giveplayer);
					SendClientMessage(playerid, COLOR_PURPLE, string);
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
            sendErrorMessage(playerid, "Nie ma takiego gracza!");
            return 1;
        }
	}
    return 1;
}
