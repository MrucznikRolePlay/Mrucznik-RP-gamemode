//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wezwij ]------------------------------------------------//
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

YCMD:wezwij(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJailed] == 0 && GetPlayerInterior(playerid) == 0)
        {
            if(AntySpam[playerid] != 0)
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Spróbuj za 30 sekund !");
                return 1;
            }
			new x_nr[16];
			if( sscanf(params, "s[16]", x_nr))
			{
				SendClientMessage(playerid, COLOR_WHITE, "|__________________ Service Names __________________|");
				SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: /wezwij [nazwa]");
		  		SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Taxi, Bus, Medyk, Mechanik, Heli, Prawnik");
				SendClientMessage(playerid, COLOR_WHITE, "|________________________________________________|");
				return 1;
			}
			if(strcmp(x_nr, "Prawnik", true) == 0)
			{
				if(CheckAntySpamForPlayer(playerid, ASPAM_PRAWNIK))
				{
					sendErrorMessage(playerid, "Odczekaj 30 sekund przed wezwaniem kolejnego prawnika!"); 
					return 1;
				}
				SetAntySpamForPlayer(playerid, ASPAM_PRAWNIK);
				new bool:jestPrawnik=false; 
				format(string, sizeof(string), "%s [ID: %d] potrzebuje pomocy prawnika w wiêzieniu! JedŸ tam i uwoolnij go za op³at¹!", GetNick(playerid), playerid); 
				foreach(new checkPrawnik : Player)
				{
					if(PlayerInfo[checkPrawnik][Job] == 2)
					{
						jestPrawnik=true; 
						sendTipMessageEx(checkPrawnik, COLOR_P@, string); 
					}
				}
				if(jestPrawnik)
				{
					sendTipMessage(playerid, "Wezwa³eœ prawnika, oczekuj na przyjazd!"); 
				}
				else
				{
					sendTipMessage(playerid, "Nie ma obecnie ¿adnych prawników w mieœcie! Odczekaj kilka minut"); 
				}
			}
		    else if(strcmp(x_nr,"taxi",true) == 0)
			{
			    if(TaxiDrivers < 0)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma taksówkarzy, spróbuj póŸniej !");
		        }
		        if(TransportDuty[playerid] > 0)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnych taksówkarzy !");
		        }
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(PlayerInfo[playerid][Level] <= 3)
				{
					format(string, sizeof(string), "**[NEW_PLAYER] %s potrzebuje transportu. (wpisz /akceptuj taxi aby zaaceptowaæ zg³oszenie)", sendername);
					SendFamilyMessage(10, 0xE88A2DFF, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po taksówkê, czekaj na akceptacje.");
					TaxiCall = playerid;
					AntySpam[playerid] = 1;
					SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
				}
				else
				{
					format(string, sizeof(string), "** %s potrzebuje transportu. (wpisz /akceptuj taxi aby zaaceptowaæ zg³oszenie)", sendername);
					SendFamilyMessage(10, 0xE88A2DFF, string);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po taksówkê, czekaj na akceptacje.");
					TaxiCall = playerid;
					AntySpam[playerid] = 1;
					SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
				}
		    	return 1;
			}
			else if(strcmp(x_nr,"heli",true) == 0)
			{
			    if(HeliDrivers < 0)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma pilota, spróbuj póŸniej !");
		        }
		        if(TransportDuty[playerid] > 0)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnego pilota !");
		        }
		        GetPlayerName(playerid, sendername, sizeof(sendername));
			    format(string, sizeof(string), "** %s potrzebuje transportu. (wpisz /akceptuj heli aby zaaceptowaæ zg³oszenie)", sendername);
		    	SendFamilyMessage(10, 0xE88A2DFF, string);
		    	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wezwa³eœ helikopter, czekaj na miejscu.");
		    	HeliCall = playerid;
		    	AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
		    	return 1;
			}
			else if(strcmp(x_nr,"bus",true) == 0)
			{
			    if(BusDrivers < 1)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma kierowców autobusu, spróbuj póŸniej !");
		            return 1;
		        }
		        if(TransportDuty[playerid] > 0)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma wolnych autobusów !");
		            return 1;
		        }
		        GetPlayerName(playerid, sendername, sizeof(sendername));
			    format(string, sizeof(string), "** %s potrzebuje autobusu. (wpisz /akceptuj bus aby zaakceptowaæ zlecenie)", sendername);
		    	SendFamilyMessage(10, 0xE88A2DFF, string);
		    	SendJobMessage(10, 0xE88A2DFF, string);
		    	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po autobus, czekaj na akceptacje.");
		    	BusCall = playerid;
		    	AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
		    	return 1;
			}
			else if(strcmp(x_nr,"medyk",true) == 0)
			{
			    if(Medics < 1)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma lekarzy na s³u¿bie, spróbuj potem !");
		            return 1;
		        }
		        foreach(new i : Player)
				{
				    if(JobDuty[i] >= 1 && IsAMedyk(i))
				    {
				    	GetPlayerName(playerid, sendername, sizeof(sendername));
				    	format(string, sizeof(string), "** %s potrzebuje pomocy. (wpisz /akceptuj medyk aby zaakceptowaæ zlecenie)", sendername);
				   		SendClientMessage(i, TEAM_AZTECAS_COLOR, string);
				   	}

			   	}
				PlayerRequestMedic[playerid] = 0;
			   	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po lekarza, czekaj na akceptacje.");
			   	MedicCall = playerid;
			   	AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
		    	return 1;
			}
			else if(strcmp(x_nr,"mechanik",true) == 0)
			{
			    if(Mechanics < 1)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma mechaników na s³u¿bie, spróbuj potem !");
		            return 1;
		        }
		        foreach(new i : Player)
				{
				    if(JobDuty[i] >= 1 && PlayerInfo[i][Job] == 7)
				    {
				    	GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "** %s potrzebuje mechanika. (wpisz /akceptuj mechanik aby zaakceptowaæ zlecenie)", sendername);
					   	SendClientMessage(i, TEAM_AZTECAS_COLOR, string);
					}
				}
			   	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni³eœ po mechanika, czekaj na akceptacje.");
			   	MechanicCall = playerid;
			   	AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
		    	return 1;
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Z³a nazwa!");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz wzywaæ w AJ/interiorze !");
		}
	}
	return 1;
}
