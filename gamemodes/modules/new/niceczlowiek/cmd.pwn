/*CMD:o(playerid, params[]) {
    return cmd_oferuj(playerid, params);
}
CMD:oferuj(playerid, params[]) {
    new type[24], other[64], query[128];
    if(sscanf(params, "s[24]S()[64]", type, other)) {
        return sendTipMessage(playerid, "Dostepne /o: vcard");
    }
    new giveplayerid, value1, price;
    if(!strcmp(type, "vcard", true)) {
    	price = 0;
        if(PhoneOnline[playerid]) return sendTipMessage(playerid, "Twój telefon jest wyłączozny, nie możesz wysłać vCarda"); 
        if(PlayerInfo[playerid][pPnumber] == 0) return sendTipMessage(playerid, "Nie masz telefonu!");
        if(sscanf(other, "d", giveplayerid)) return sendTipMessage(playerid, "Parametry dla /o vcard: [id gracza]");
        if(!gPlayerLogged[giveplayerid]) {
            return guiMsg(playerid, "Twoja Oferta", "Gracz nie jest zalogowany!");
        }
        if(giveplayerid == playerid) return sendTipMessage(playerid, "Nie możesz wysłać vCard samemu sobie!");
        if(giveplayerid == INVALID_PLAYER_ID) return sendTipMessage(playerid, "Podałeś nieprawidłowe ID!");
        if(PlayerInfo[giveplayerid][pPnumber] == 0) return sendTipMessage(playerid, "Ten gracz nie posiada telefonu!");
        if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 5) {
            return guiMsg(playerid, "Twoja Oferta", "Jesteś zbyt daleko od osoby, której składasz ofertę!");
        }
        format(query, sizeof(query), "SELECT * FROM mru_kontakty WHERE contact_number=%d AND contact_owner=%d", PlayerInfo[playerid][pPnumber], PlayerInfo[giveplayerid][pPnumber]);
        mysql_query(query);
        printf("%s", query);
		mysql_store_result();
		if(mysql_num_rows())
		{
			mysql_free_result();
			return guiMsg(playerid, "Twoja Oferta", "Ten gracz posiada już Twój vCard!");
		}
		mysql_free_result();
        offer_sendToPlayer(playerid, giveplayerid, OFFER_VCARD, "vCard", price, 0);
    }
    return true;
}*/


CMD:ooc(playerid, params[]) return cmd_o(playerid, params);
CMD:o(playerid, params[])
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
		if ((noooc) && PlayerInfo[playerid][pAdmin] < 1)
		{
		    if(PlayerInfo[playerid][pNewAP] < 1)
		    {
		        if(PlayerInfo[playerid][pZG] < 5)
		        {
				    if(PlayerInfo[playerid][pDonateRank] < 3)
				    {
						sendErrorMessage(playerid, "Kanał OOC został zablokowany przez administratora !");
						return 1;
					}
				}
			}
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Nie możesz mówić gdyż zostałeś uciszony!", TEAM_CYAN_COLOR);
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
		    format(string, sizeof(string), "Nie możesz napisać na tym czacie, gdyż masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "Użyj (/o)oc [ooc chat]");
			return 1;
		}
		if (strfind(params , "ip:" , true)>=0 ||strfind(params , "-roleplay" , true)>=0 || strfind(params , "Nicolson" , true)>=0 || strfind(params , "roleplay." , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , "794" , true)>=0 || strfind(params , "772" , true)>=0 || strfind(params , "797" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , "775" , true)>=0 || strfind(params , "91." , true)>=0 || strfind(params , "91," , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, 128, "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			CzitLog(string);
		}
		else if (strfind(params , "kurwa" , true)>=0 ||strfind(params , "huj" , true)>=0 || strfind(params , "pizda" , true)>=0 || strfind(params , "cipa" , true)>=0  || strfind(params , "n00b" , true)>=0 || strfind(params , "noob" , true)>=0 || strfind(params , "pierdole" , true)>=0 || strfind(params , "debil" , true)>=0 || strfind(params , "fiut" , true)>=0 || strfind(params , "kutas" , true)>=0 || strfind(params , "jeb" , true)>=0 || strfind(params , "ssij" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Okaż trochę kultury na kanale OOC! Nie przeklinaj.");
			format(string, 128, "AdmWarning: [%d] %s Przeklina: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			WarningLog(string);
		}
		else if (strfind(params , ":1" , true)>=0 || strfind(params , ":2" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0 || strfind(params , ":9" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, 128, "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			CzitLog(string);
		}
		else
		{

			format(string, sizeof(string), "(( %s [%d]: %s ))", sendername, playerid, params);
			OOCOff(COLOR_OOC,string);
			printf("%s", string);
		}
	}
	return 1;
}

/*CMD:telefon(playerid, params[]) return cmd_tel(playerid, params);
CMD:tel(playerid, params[]) {
	new string[256];
	if(PlayerInfo[playerid][pPnumber] == 0) return sendErrorMessage(playerid, "Nie posiadasz telefonu!");
	inline D_TELEFON_MAIN(playeridx, dialogid, response, listitem, string:inputtext[]) {
		#pragma unused playeridx, dialogid, inputtext
		if(!response) return false;
		if(listitem == 2) {
			new kontakty[1000], nick[26], tel;
			format(string, 256, "SELECT `contact_number`, `contact_name` FROM `mru_kontakty` WHERE `contact_owner`=%d ", PlayerInfo[playerid][pPnumber]);
			mysql_query(string);
			mysql_store_result();
			format(kontakty, sizeof(kontakty), "Numer telefonu\tNazwa");
			while(mysql_fetch_row_format(string, "|"))
            {
                sscanf(string, "p<|>ds[26]", tel, nick);
                format(kontakty, sizeof(kontakty), "%s\n%d\t%s", kontakty, tel, nick);
            }
			mysql_free_result();
			inline D_OSOBA(playerid1, dialogid1, response1, listitem1, string:inputtext1[]) {
				#pragma unused playerid1, dialogid1, listitem1
				if(response1) {
					new numer = strval(inputtext1);
					// menu numeru
					new nazwa[26];
					format(string, sizeof(string), "SELECT contact_name FROM mru_kontakty WHERE contact_number=%d AND contact_owner=%d", numer, PlayerInfo[playerid][pPnumber]);
			        mysql_query(string);
			        printf("%s", string);
					mysql_store_result();
					while(mysql_fetch_row_format(string, "|"))
		            {
		                sscanf(string, "p<|>s[26]", nazwa);
		                format(string, 256, "Kontakt %s\n \nZmień nazwę\nUsuń", nazwa, PlayerInfo[playerid][pPnumber]);
		            }
					mysql_free_result();
					inline D_OSOBA_OPTION(playeridz, dialogidz, responsez, listitemz, string:inputtextz[]) {
						#pragma unused playeridz, dialogidz, inputtextz
						if(responsez) {
							if(listitemz == 2) {
								inline D_OSOBA_ZMIENN(playeridc, dialogidc, responsec, listitemc, string:inputtextc[]) {
									#pragma unused playeridc, dialogidc, listitemc
									if(responsec) {
										if(strlen(inputtextc) > 25 || strlen(inputtextc) < 1) {
											sendErrorMessage(playerid, "Nazwa kontaktu może mieć max. 25 znaków");
											return Dialog_ShowCallback(playerid, using inline D_OSOBA_ZMIENN, DIALOG_STYLE_INPUT, ("Edytuj Kontakt"), "Wpisz nową nazwę dla kontaktu", "Potwierdź", "Anuluj");		    
										}
										format(string, sizeof(string), "UPDATE mru_kontakty SET contact_name = '%s' WHERE contact_number=%d AND contact_owner=%d", inputtextc, numer, PlayerInfo[playerid][pPnumber]);
			        					mysql_query(string);
			        					sendTipMessage(playerid, "Zmieniono nazwę kontaktu");
			        					return cmd_tel(playerid, "");
									}
								}
								Dialog_ShowCallback(playerid, using inline D_OSOBA_ZMIENN, DIALOG_STYLE_INPUT, ("Edytuj Kontakt"), "Wpisz nową nazwę dla kontaktu", "Potwierdź", "Anuluj");		    
							} else if (listitemz == 3) {
								format(string, sizeof(string), "DELETE FROM mru_kontakty WHERE contact_number=%d AND contact_owner=%d", numer, PlayerInfo[playerid][pPnumber]);
			        			mysql_query(string);
			        			sendTipMessage(playerid, "Usunięto kontakt");
			        			return cmd_tel(playerid, "");
							}
						}
					}
					Dialog_ShowCallback(playerid, using inline D_OSOBA_OPTION, DIALOG_STYLE_LIST, ("Edycja Kontaktu"), string, "Wybierz", "Anuluj");
				}
			}
			Dialog_ShowCallback(playerid, using inline D_OSOBA, DIALOG_STYLE_TABLIST_HEADERS, ("Kontakty"), kontakty, "Ok", "Anuluj");
		} else if(listitem == 3) {
			new dodaj_numer;
			inline D_VCARD_ADD(playeridxxx, dialogidx, responsex, listitemx, string:inputtextx[]) {
				#pragma unused playeridxxx, dialogidx, listitemx
	    	    if(responsex) {
	    	    	dodaj_numer = strval(inputtextx);
	    	    	format(string, sizeof(string), "SELECT * FROM mru_kontakty WHERE contact_number=%d AND contact_owner=%d", dodaj_numer, PlayerInfo[playerid][pPnumber]);
			        mysql_query(string);
			        printf("%s", string);
					mysql_store_result();
					if(mysql_num_rows())
					{
						mysql_free_result();
						return Dialog_ShowCallback(playerid, using inline D_VCARD_ADD, DIALOG_STYLE_INPUT, ("Dodaj Kontakt"), "Ten numer figuruje już na liście!\n\nWpisz numer telefonu do dodania", "Potwierdź", "Anuluj");
					}
					mysql_free_result();
	    	    }
	    		inline D_VCARD_ADDx(playeridxx, dialogidxx, responsexx, listitemxx, string:inputtextxx[]) {
					#pragma unused playeridxx, dialogidxx, listitemxx
		    	    if(responsexx) {
		    	    	if(strlen(inputtextxx) > 25 || strlen(inputtextxx) < 1) {
							sendErrorMessage(playerid, "Nazwa kontaktu może mieć max. 25 znaków");
							return Dialog_ShowCallback(playerid, using inline D_VCARD_ADDx, DIALOG_STYLE_INPUT, ("Dodaj Kontakt"), "Wpisz nazwę dodanego kontaktu", "Potwierdź", "Anuluj");		    
						}
		    	    	format(string, 128, "INSERT INTO `mru_kontakty` (contact_number, contact_name, contact_owner) VALUES (%d, '%s', %d)", dodaj_numer, inputtextxx, PlayerInfo[playerid][pPnumber]);
		    	    	mysql_query(string);
		    	    	sendTipMessage(playerid, "Dodano nowy kontakt!");
		    	    	return cmd_tel(playerid, "");
		    	    }    
	    		}
	    		Dialog_ShowCallback(playerid, using inline D_VCARD_ADDx, DIALOG_STYLE_INPUT, ("Dodaj Kontakt"), "Wpisz nazwę dodanego kontaktu", "Potwierdź", "Anuluj");		    
			}
			Dialog_ShowCallback(playerid, using inline D_VCARD_ADD, DIALOG_STYLE_INPUT, ("Dodaj Kontakt"), "Wpisz numer telefonu do dodania", "Potwierdź", "Anuluj");
		}
	}
	format(string, 256, "{DADADA}Numer Telefonu: %d\n \n\n{DADADA}Kontakty\n{DADADA}Dodaj kontakt", PlayerInfo[playerid][pPnumber]);
	Dialog_ShowCallback(playerid, using inline D_TELEFON_MAIN, DIALOG_STYLE_LIST, ("{DADADA}Telefon"), string, "Ok", "Anuluj");
	return 1;
} */


CMD:przejazd(playerid, params[]) {
	if(!gPlayerLogged[playerid]) return sendErrorMessage(playerid, "Nope!");
	if(GetPVarInt(playerid, "wybramkowany") == 1) return sendErrorMessage(playerid, "Poczekaj na zamknięcie się poprzedniej bramki!");
	for(new i; i < sizeof(bramki_sasd); i++)
	{
		new Float:x,Float:y,Float:z;
		GetDynamicObjectPos(bramki_sasd[i], x, y, z);
		if(IsPlayerInRangeOfPoint(playerid, 7.4, x,y,z))
		{
			if(bramki_sasd_state[i] == true) return sendErrorMessage(playerid, "Ta bramka jest aktualnie w użyciu");
			for(new j; j<iloscbram; j++)
			{
				if(bramy[j][b_obiekt] == bramki_sasd[i])
				{
					MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x1],  bramy[j][b_y1], bramy[j][b_z1], bramy[j][b_speed], bramy[j][b_rx1],  bramy[j][b_ry1], bramy[j][b_rz1]);
					bramy[j][b_flaga] = false;
					SetTimerEx("closeGate", 5000, false, "iii", i, j, playerid);
					bramki_sasd_state[i] = true;
					DajKase(playerid, -1750);
					Sejf_Add(FRAC_NG, 1750);
					SetPVarInt(playerid, "wybramkowany", 1);
					return showTimedMsgBox(playerid, 6, "~y~~h~Oplata pobrana~n~~y~~h~Masz~r~ 5s ~n~~y~~h~na przejazd");
				}
			}
		}
	}
	return 1;
}


forward closeGate(i, j, playerid);
public closeGate(i, j, playerid)
{
    bramki_sasd_state[i] = false;
    SetPVarInt(playerid, "wybramkowany", 0);
    MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x2],  bramy[j][b_y2], bramy[j][b_z2], bramy[j][b_speed], bramy[j][b_rx2],  bramy[j][b_ry2], bramy[j][b_rz2]);
    return 1;
}