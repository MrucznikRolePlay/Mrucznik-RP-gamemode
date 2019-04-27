//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wypisz ]------------------------------------------------//
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

CMD:wydaj(playerid, params[]) return cmd_wypisz(playerid, params);
CMD:wypisz(playerid, params[])
{
	//new string[128];
	//new giveplayer[MAX_PLAYER_NAME];
	//new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAUrzednik(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
        {
            new x_nr[16];
			new giveplayerid;
			if( sscanf(params, "s[16] k<fix>", x_nr, giveplayerid))
			{
                sendTipMessage(playerid, "U¿yj /wydaj [nazwa dokumentu] [playerid]");
                sendTipMessage(playerid, "Dostêpne dokumenty: dowod");
				return 1;
			}
		    if(strcmp(x_nr,"dowod",true) == 0)
			{
				if(IsPlayerConnected(giveplayerid))
				{
				    if(giveplayerid != INVALID_PLAYER_ID)
				    {
                        SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("Da³eœ dowód osobisty %s", GetNick(giveplayerid, true)));
                        if(giveplayerid != playerid)
                            SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("Urzêdnik %s da³ Tobie dowód osobisty", GetNick(playerid, true)));

				        PlayerInfo[giveplayerid][pDowod] = 1;
				        return 1;
			        }
				}
				else
				{
				    sendErrorMessage(playerid, "Gracz jest nieaktywny!");
				    return 1;
				}
			}
        }
        else
        {
            sendErrorMessage(playerid, "Tylko urzêdnicy maj¹ prawo do wydawania dowodów!");
            return 1;
        }
    }
    return 1;
}



