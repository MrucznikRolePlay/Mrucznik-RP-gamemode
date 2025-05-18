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
command_po_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if( (IsABOR(playerid) || IsAPolicja(playerid)) && OnDuty[playerid] == 1)
        {
    		if (PlayerInfo[playerid][pMember] == 2 && PlayerInfo[playerid][pRank] == 3 && PlayerInfo[playerid][pRank] == 4)
    		{
    			sendTipMessage(playerid, "Tajniacy nie mog� dawa� WL, popro� o danie WL koleg�w na /r !");
                return 1;
    		}
    		new giveplayerid, result[64];
    		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
    		{
    			sendTipMessage(playerid, "U�yj /(su)spect [playerid/Cz��Nicku] [popelnione przestepstwo]");
    			return 1;
    		}
    		if(IsPlayerConnected(giveplayerid))
    		{
    			if(giveplayerid != INVALID_PLAYER_ID)
    			{
    				if (!(IsAPolicja(giveplayerid) && OnDuty[giveplayerid] == 1))
    				{
    					if(spamwl[giveplayerid] == 0)
    					{
    						GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
    						GetPlayerName(playerid, sendername, sizeof(sendername));
							
							spamwl[giveplayerid] = 1;
    						SetTimerEx("spamujewl",60000,0,"d",giveplayerid);
							PlayCrimeReportForPlayer(playerid,giveplayerid,5);

			    			NadajWL(giveplayerid, 1, result, playerid);

    						format(string, sizeof(string), "%s ma teraz %d WL. Jest poszukiwany za: %s", giveplayer, PoziomPoszukiwania[giveplayerid], result);
    						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
							
							if(IsReasonAPursuitReason(result))
							{
								PursuitMode(playerid, giveplayerid);
							}
    						return 1;
    					}
    					else
    					{
    						sendErrorMessage(playerid, "Da�e� ju� poziom poszukiwania, poczekaj 1 minute (zapobiega spamowaniu WL)");
    					}
    				}
    				else
    				{
    					sendTipMessage(playerid, "   Nie mo�esz dawa� Wanted Level policjantom na s�u�bie!");
    				}
    			}
    		}
    		else
    		{
    			format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
    			sendErrorMessage(playerid, string);
    			return 1;
    		}
        } else sendErrorMessage(playerid, " Nie jeste� funkcjonariuszem PD/FBI/NG/BOR na s�u�bie!");
	}
	return 1;
}

//end
