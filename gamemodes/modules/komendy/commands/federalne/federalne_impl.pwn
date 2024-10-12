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
command_federalne_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	 	if(!IsAPolicja(playerid))
	 	{
	 		sendErrorMessage(playerid, "Nie jesteœ z s³u¿b porz¹dkowych!");
		    return 1;
		}
	    if(OnDuty[playerid] != 1 )
		{
		    sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie!");
		    return 1;
		}
		new giveplayerid, result[128];
		if( sscanf(params, "k<fix>s[128]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj (/fed)eralne [playerid/CzêœæNicku] [popelnione przestepstwo]");
			return 1;
		}

		if (IsAPolicja(playerid) || IsAFBI(playerid))
		{
			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
					if (!(IsAPolicja(giveplayerid) && OnDuty[giveplayerid] == 1))
					{
						if(spamwl[giveplayerid] == 0)
						{
						    if(PoziomPoszukiwania[giveplayerid] <= 6)
						    {
								GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
								GetPlayerName(playerid, sendername, sizeof(sendername));
								PoziomPoszukiwania[giveplayerid] = 6;
								spamwl[giveplayerid] = 1;
								SetTimerEx("spamujewl",60000,0,"d",giveplayerid);
								PlayCrimeReportForPlayer(playerid,giveplayerid,5);
								SetPlayerCriminal(giveplayerid,playerid, result);
								SendClientMessage(giveplayerid, COLOR_LFBI, "   Pope³ni³eœ przestêpstwo federalne, twoj¹ sprawê przejê³o FBI !");
								SendClientMessage(playerid, COLOR_LFBI, "   Oskar¿y³eœ gracza o przestêpstwo federalne. Ma on teraz 6 Poziom Poszukiwania !");
								
								if(IsReasonAPursuitReason(result))
								{
									PursuitMode(playerid, giveplayerid);
								}
								return 1;
							}
							else
							{
							    sendErrorMessage(playerid, "Ten gracz jest ju¿ œcigany za przestêpstwo federalne");
							}
						}
						else
						{
							sendErrorMessage(playerid, "Da³eœ ju¿ poziom poszukiwania, poczekaj 1 minute (zapobiega spamowaniu WL)");
						}
					}
					else
					{
						sendErrorMessage(playerid, "Nie mo¿esz dawaæ Wanted Level policjantom na s³u¿bie!");
					}
				}
			}
			else
 			{
				format(string, sizeof(string), "Gracz o ID %d nie istnieje.", giveplayerid);
				sendErrorMessage(playerid, string);
				return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ z s³u¿b porz¹dkowych!");
		}
	}
	return 1;
}

//end
