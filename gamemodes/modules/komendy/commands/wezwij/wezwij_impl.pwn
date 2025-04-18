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
command_wezwij_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJailed] == 0 && GetPlayerInterior(playerid) == 0)
        {
            if(AntySpam[playerid] != 0)
            {
                sendTipMessageEx(playerid, COLOR_GREY, "Spr�buj za 30 sekund !");
                return 1;
            }
			new x_nr[16];
			if( sscanf(params, "s[16]", x_nr))
			{
				SendClientMessage(playerid, COLOR_WHITE, "|__________________ Service Names __________________|");
				SendClientMessage(playerid, COLOR_WHITE, "U�YJ: /wezwij [nazwa]");
		  		SendClientMessage(playerid, COLOR_GREY, "Dost�pne nazwy: Taxi, Bus, Medyk, Mechanik, Heli, Prawnik");
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
				format(string, sizeof(string), "%s [ID: %d] potrzebuje pomocy prawnika w wi�zieniu! Jed� tam i uwoolnij go za op�at�!", GetNick(playerid), playerid); 
				foreach(new checkPrawnik : Player)
				{
					if(PlayerInfo[checkPrawnik][pJob] == 2)
					{
						jestPrawnik=true; 
						sendTipMessageEx(checkPrawnik, COLOR_P@, string); 
					}
				}
				if(jestPrawnik)
				{
					sendTipMessage(playerid, "Wezwa�e� prawnika, oczekuj na przyjazd!"); 
				}
				else
				{
					sendTipMessage(playerid, "Nie ma obecnie �adnych prawnik�w w mie�cie! Odczekaj kilka minut"); 
				}
			}
		    else if(strcmp(x_nr,"taxi",true) == 0)
			{
			    wezwij_taxi(playerid);
			}
			else if(strcmp(x_nr,"heli",true) == 0)
			{
				wezwij_heli(playerid);
			}
			else if(strcmp(x_nr,"bus",true) == 0)
			{
			    wezwij_bus(playerid);
			}
			else if(strcmp(x_nr,"medyk",true) == 0)
			{
			    if(Medics < 1)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma lekarzy na s�u�bie, spr�buj potem !");
		            return 1;
		        }
		        foreach(new i : Player)
				{
				    if(JobDuty[i] >= 1 && (IsAMedyk(i)))
				    {
				    	GetPlayerName(playerid, sendername, sizeof(sendername));
				    	format(string, sizeof(string), "** %s potrzebuje pomocy. (wpisz /akceptuj medyk aby zaakceptowa� zlecenie)", sendername);
				   		SendClientMessage(i, TEAM_AZTECAS_COLOR, string);
				   	}

			   	}
			   	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni�e� po lekarza, czekaj na akceptacje.");
			   	MedicCall = playerid;
			   	AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
		    	return 1;
			}
			else if(strcmp(x_nr,"mechanik",true) == 0)
			{
			    if(Mechanics < 1)
		        {
		            sendTipMessageEx(playerid, COLOR_GREY, "Nie ma mechanik�w na s�u�bie, spr�buj potem !");
		            return 1;
		        }
		        foreach(new i : Player)
				{
				    if(JobDuty[i] >= 1 && PlayerInfo[i][pJob] == 7)
				    {
				    	GetPlayerName(playerid, sendername, sizeof(sendername));
					    format(string, sizeof(string), "** %s potrzebuje mechanika. (wpisz /akceptuj mechanik aby zaakceptowa� zlecenie)", sendername);
					   	SendClientMessage(i, TEAM_AZTECAS_COLOR, string);
					}
				}
			   	SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Zadzwoni�e� po mechanika, czekaj na akceptacje.");
			   	MechanicCall = playerid;
			   	AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
		    	return 1;
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Z�a nazwa!");
			    return 1;
			}
		}
		else
		{
		    sendTipMessageEx(playerid, COLOR_GREY, "Nie mo�esz wzywa� w AJ/interiorze !");
		}
	}
	return 1;
}

//end
