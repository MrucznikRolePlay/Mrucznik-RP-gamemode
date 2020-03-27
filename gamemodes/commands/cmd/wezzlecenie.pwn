//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ wezzlecenie ]----------------------------------------------//
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

YCMD:wezzlecenie(playerid, params[], help)
{
    if(PlayerInfo[playerid][Job] == JOB_TRUCKER)
    {
        new veh = GetPlayerVehicleID(playerid);
        if(veh == 0) return sendTipMessage(playerid, "Musisz byÊ w pojeüdzie firmowym.");
        if(Car_GetOwnerType(veh) != CAR_OWNER_JOB || Car_GetOwner(veh) != JOB_TRUCKER) return sendTipMessage(playerid, "Musisz byÊ w pojeüdzie firmowym.");
        if(GetVehicleModel(veh) != 578) return sendErrorMessage(playerid, " Tym pojazdem nie weümiesz zlecenia.");

        if(GetPVarInt(playerid, "trans") == 0)
        {
            ShowPlayerDialogEx(playerid, D_TRANSPORT, DIALOG_STYLE_LIST, "Rodzaj zlecenia", "Szybkie zlecenie\nCentrum transportu", "Wybierz", "Wyjdü");
        }
        else return sendErrorMessage(playerid, "Masz juø zlecenie.");
        return 1;
    }

	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] != 0)
        {
            if(PlayerInfo[playerid][Job] == 1)
            {
                new playa;
				if( sscanf(params, "k<fix>", playa))
				{
					sendTipMessage(playerid, "Uøyj /zlecenie [Nick/ID]");
					SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: ta komenda daje zlecenie na przestÍpce, moøesz go wtedy zabiÊ za kase lub zaoferowaÊ poddanie siÍ.");
					return 1;
				}


				//
				if(IsPlayerConnected(playa))
			    {
	   				if(playa != INVALID_PLAYER_ID)
				    {
				        if(PoziomPoszukiwania[playa] >= 2)
					    {
					        if(playa != playerid)
					        {
					            if(PlayerToPoint(5.0,playerid,325.0463,306.9240,999.1484))
					            {
						    		if(PlayerInfo[playerid][pDetSkill] <= 50)
						    		{
										if(PoziomPoszukiwania[playa] == 2 || PoziomPoszukiwania[playa] == 10)
						    			{
											lowcaz[playerid] = playa;
						        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									        format(string, sizeof(string), "Wziπ≥eú zlecenie na %s. Aby namierzyÊ jego pozycje wpisz /znajdz. Za martwego otrzymasz: %d000$ Za øywego: %d$",giveplayer, PoziomPoszukiwania[playa], PoziomPoszukiwania[playa]*2500);
									        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						    			}
						    			else
						    			{
						    			    sendTipMessage(playerid, "Masz za ma≥y skill aby wziπÊ zlecenie na tego gracza");
						    			}
						    		}
                                    else if(PlayerInfo[playerid][pDetSkill] > 50 && PlayerInfo[playerid][pDetSkill] < 100)
						    		{
                                        if(PoziomPoszukiwania[playa] >= 2 && PoziomPoszukiwania[playa] <= 3 || PoziomPoszukiwania[playa] == 10)
							    		{
                                            lowcaz[playerid] = playa;
						        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									        format(string, sizeof(string), "Wziπ≥eú zlecenie na %s. Za martwego otrzymasz: %d000$ Za øywego: %d$",giveplayer, PoziomPoszukiwania[playa], PoziomPoszukiwania[playa]*2500);
									        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							    		}
							    		else
						    			{
						    			    sendTipMessage(playerid, "Masz za ma≥y skill aby wziπÊ zlecenie na tego gracza");
						    			}
						    		}
						    		else if(PlayerInfo[playerid][pDetSkill] >= 100 && PlayerInfo[playerid][pDetSkill] < 200)
						    		{
                                        if(PoziomPoszukiwania[playa] >= 2 && PoziomPoszukiwania[playa] <= 4 || PoziomPoszukiwania[playa] == 10)
						    			{
						    			    lowcaz[playerid] = playa;
						        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									        format(string, sizeof(string), "Wziπ≥eú zlecenie na %s. Za martwego otrzymasz: %d000$ Za øywego: %d$",giveplayer, PoziomPoszukiwania[playa], PoziomPoszukiwania[playa]*2500);
									        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						    			}
						    			else
						    			{
						    			    sendTipMessage(playerid, "Masz za ma≥y skill aby wziπÊ zlecenie na tego gracza");
						    			}
						    		}
						    		else if(PlayerInfo[playerid][pDetSkill] >= 200 && PlayerInfo[playerid][pDetSkill] < 400)
						    		{
                                        if(PoziomPoszukiwania[playa] >= 2 && PoziomPoszukiwania[playa] <= 5 || PoziomPoszukiwania[playa] == 10)
						    			{
						    			    lowcaz[playerid] = playa;
						        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									        format(string, sizeof(string), "Wziπ≥eú zlecenie na %s. Za martwego otrzymasz: %d000$ Za øywego: %d$",giveplayer, PoziomPoszukiwania[playa], PoziomPoszukiwania[playa]*2500);
									        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						    			}
						    			else
						    			{
						    			    sendTipMessage(playerid, "Masz za ma≥y skill aby wziπÊ zlecenie na tego gracza");
						    			}
						    		}
						    		else if(PlayerInfo[playerid][pDetSkill] >= 400)
						    		{
                                        if(PoziomPoszukiwania[playa] >= 2 && PoziomPoszukiwania[playa] <= 7 || PoziomPoszukiwania[playa] == 10)
						    			{
						    			    lowcaz[playerid] = playa;
						        			GetPlayerName(playa, giveplayer, sizeof(giveplayer));
									        format(string, sizeof(string), "Wziπ≥eú zlecenie na %s. Za martwego otrzymasz: %d000$ Za øywego: %d$",giveplayer, PoziomPoszukiwania[playa], PoziomPoszukiwania[playa]*2500);
									        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
										}
										else
						    			{
						    			    sendTipMessage(playerid, "Masz za ma≥y skill aby wziπÊ zlecenie na tego gracza");
						    			}
						    		}
						    		else
						    		{
						    		    SendClientMessage(playerid, COLOR_PANICRED, "B≥πd, zg≥oú okolicznoúci na forum: www.Mrucznik-RP.pl");
						    		}
						    	}
						    	else
						    	{
                                    sendErrorMessage(playerid, "Nie jesteú w biurze £owcy NagrÛd");
                                }
					    	}
					    	else
					    	{
					    	    sendErrorMessage(playerid, "Nie moøesz daÊ zlecenia na samego siebie");
					    	}
					    }
					    else
					    {
					        sendErrorMessage(playerid, "Ten gracz nie ma WL");
					    }
                    }
					else
					{
                        sendErrorMessage(playerid, "Taki gracz nie istnieje");
                    }
                }
				else
				{
 					sendErrorMessage(playerid, "Taki gracz nie istnieje");
      			}
	    	}
	    	else
	    	{
	    	    sendErrorMessage(playerid, "Nie jesteú ≥owcπ nagrÛd");
	    	}
    	}
    }
	return 1;
}
