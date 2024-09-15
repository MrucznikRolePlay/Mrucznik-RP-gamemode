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
command_wyscig_start_Impl(playerid)
{
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_RACE))
    {
		if(PlayerInfo[playerid][pRank] >= 2)
		{
            if(owyscig[playerid] != 666)
            {
                if(Scigamy == 666)
                {
					if(tworzenietrasy[playerid] == 666)
					{
						sendErrorMessage(playerid, "Nie wybra³eœ trasy wyœcigu!");
						return 1;
					}

	            	ScigaSie[playerid] = owyscig[playerid];
	            	owyscig[playerid] = 666;
	            	Scigamy = ScigaSie[playerid];
	            	SetTimerEx("Odlicz",5000,0,"d",Scigamy);
	            	foreach(new i : Player)
	            	{
	            	    if(ScigaSie[i] == Scigamy)
	            	    {
	            	        if(IsPlayerInRangeOfPoint(i, 10.0, wCheckpoint[Scigamy][0][0], wCheckpoint[Scigamy][0][1], wCheckpoint[Scigamy][0][2]))
	            	        {
	            	            TogglePlayerControllable(i, 0);
					            GameTextForPlayer(i, "Za chwile rozpocznie sie wyscig", 5000, 6);
					            IloscZawodnikow ++;//rupxnup69
								Ukonczyl = 1;
	            	        }
	            	        else
	            	        {
	            	            DisablePlayerRaceCheckpoint(i);
	            	            ScigaSie[i] = 666;
	            	        }
	            	    }
	            	}

					new string[128];
					format(string, sizeof(string), "Komunikat frakcyjny: wyœcig %s wystartowa³", Wyscig[tworzenietrasy[playerid]][wNazwa]);
					SendFamilyMessage(15, COLOR_YELLOW, string);
					SendFamilyMessage(1, COLOR_YELLOW, "UWAGA!");
					format(string, sizeof(string), "DO WSZYSTKICH JEDNOSTEK: ktoœ zorganizowa³ nielegalny wyœcig %s", Wyscig[tworzenietrasy[playerid]][wNazwa]);
					SendFamilyMessage(1, COLOR_DBLUE, string);
					SendFamilyMessage(1, COLOR_YELLOW, "UWAGA!");
					SendClientMessage(playerid, COLOR_LIGHTGREEN, "Wyscig zaraz siê zacznie!!");
	            }
	            else
	            {
	                sendErrorMessage(playerid, "Ju¿ trwa jeden wyœcig! Poczekaj, a¿ siê skoñczy lub u¿yj /wyscig-stop");
	            }
			}
			else
			{
			    sendErrorMessage(playerid, "Nie organizujesz wyœcigu, aby to zrobiæ, u¿yj panelu tras (/wyscigi)");
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie posiadasz uprawnieñ (wymagana 2 ranga)");
		}
	}
	else
	{
		sendErrorMessage(playerid, "Twoja organizacja nie posiada biznesu Toru wyœcigowego.");
	}
	//rup
	return 1;
}

//end
