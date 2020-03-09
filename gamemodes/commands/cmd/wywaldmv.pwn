//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ wywaldmv ]-----------------------------------------------//
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

YCMD:wywaldmv(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(IsABOR(playerid))
	    {
            new giveplayerid;
			if( sscanf(params, "k<fix>", giveplayerid))
			{
				sendTipMessage(playerid, "U¿yj /wywalzdmv [playerid/CzêœæNicku]");
				return 1;
			}

		    if(IsPlayerConnected(giveplayerid))
			{
			    if(giveplayerid != INVALID_PLAYER_ID)
			    {
			        if(IsABOR(giveplayerid) || IsAPolicja(giveplayerid))
			        {
			            sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz wywaliæ policjanta/bor !");
				        return 1;
			        }
					if (ProxDetectorS(8.0, playerid, giveplayerid))
					{
					    if(GetPlayerVirtualWorld(playerid) == 50)
					    {
                            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
							GetPlayerName(playerid, sendername, sizeof(sendername));
							format(string, sizeof(string), "* %s szybkim ruchem ³apie %s i chwytem transportowym wywala go.", sendername, giveplayer);
							ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
							format(string, sizeof(string), "* Zosta³eœ wywalony z DMV przez %s na 10 minut.", sendername);
							SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
							format(string, sizeof(string), "* Wywali³eœ z dmv %s na 10 minut.", giveplayer);
							wywalzdmv[giveplayerid] = 1;
							SetTimerEx("Wywalonyzdmv",600000,0,"d",giveplayerid);
							SetPlayerPos(giveplayerid,1481.1531,-1770.0277,18.7958);
							SetPlayerInterior(giveplayerid,0);
						}
						else
						{
						    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w DMV !");
						}
					}
					else
					{
					    sendTipMessageEx(playerid, COLOR_GREY, "Gracz jest za daleko !");
					}
				}
			}
	    }
	    else
	    {
	        sendErrorMessage(playerid, "Nie jesteœ z USSS !");
	    }
	}
	return 1;
}
