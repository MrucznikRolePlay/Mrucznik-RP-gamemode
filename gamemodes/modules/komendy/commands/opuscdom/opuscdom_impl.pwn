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
command_opuscdom_Impl(playerid)
{
    new string[128];

    if(gPlayerLogged[playerid] == 1)
    {
	    if(PlayerInfo[playerid][pDom] != 0)
	    {
			if(Dom[PlayerInfo[playerid][pDom]][hKupiony] != 0)
			{
			    if(IsPlayerInRangeOfPoint(playerid, 5.0, Dom[PlayerInfo[playerid][pDom]][hWej_X], Dom[PlayerInfo[playerid][pDom]][hWej_Y], Dom[PlayerInfo[playerid][pDom]][hWej_Z]))
			    {
			        if(Dom[PlayerInfo[playerid][pDom]][hBlokada] == 0)
			        {
			            if(GUIExit[playerid] == 0)
	    				{
						    /*new doplata = Dom[PlayerInfo[playerid][pDom]][hOplata];
							new interior = IntInfo[Dom[PlayerInfo[playerid][pDom]][hDomNr]][Cena];
							new mnoznik;
							new pZone[MAX_ZONE_NAME];
							GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
							//
							mnoznik = Mnoznik(pZone);
							new cenadomu = ((((interior*mnoznik)/10)+doplata)/3);//cena domu*/
							new cenadomu = Dom[PlayerInfo[playerid][pDom]][hCena];
							format(string, sizeof(string), "Czy na pewno chcesz opuœciæ ten dom?\nZarobisz na tym tylko %d$, wszystkie przedmioty i ulepszenia domu przepadn¹", cenadomu/2);
						    ShowPlayerDialogEx(playerid, 87, DIALOG_STYLE_MSGBOX, "Opuszczanie domu", string, "Tak", "Nie");
						}
					}
					else
					{
					    sendErrorMessage(playerid, "Masz zablokowan¹ mo¿liwoœæ opuszczenia tego domu.");
					}
				}
				else
				{
				    sendTipMessage(playerid, "Aby opuœciæ dom musisz staæ przed nim.");
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Twój dom nie jest kupiony (???) Zg³oœ ten b³¹d na forum.");
			}
	    }
	    else
	    {
	        sendErrorMessage(playerid, "Nie masz wlasnego domu.");
	    }
	}
	return 1;
}

//end
