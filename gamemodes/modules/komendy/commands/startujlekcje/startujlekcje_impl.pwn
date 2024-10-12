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
command_startujlekcje_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

	const EGZAMIN_PRICE = 12500;

    if(IsPlayerConnected(playerid))
    {
        if(IsAnInstructor(playerid))
        {
            new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
			    sendTipMessage(playerid, "U¿yj /startlekcja [playerid/CzêœæNicku]");
			    return 1;
			}

			if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(kaska[playerid] >= EGZAMIN_PRICE)
			        {
				        if(PlayerInfo[giveplayerid][pCarLic] == 2)
				        {
					        GetPlayerName(playerid, sendername, sizeof(sendername));
					        GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					        format(string, sizeof(string), "* Zacz¹³eœ egzamin z %s.",giveplayer);
					        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					        format(string, sizeof(string), "* Urzêdnik %s zacz¹³ z tob¹ egzamin.",sendername);
					        SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					        TakingLesson[giveplayerid] = 1;
					        ZabierzKase(playerid, EGZAMIN_PRICE);
                            Sejf_Add(FRAC_GOV, EGZAMIN_PRICE);
				        }
				        else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie zaliczy³ jeszcze testu teoretycznego!");
						    return 1;
						}
					}
					else
					{
						sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie ma tyle kasy!");
	    				return 1;
					}
			    }
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza!");
			    return 1;
			}
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ urzêdnikiem !");
            return 1;
        }
    }
    return 1;
}

//end
