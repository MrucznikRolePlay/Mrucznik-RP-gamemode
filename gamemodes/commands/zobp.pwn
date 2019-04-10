//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ zobp ]-------------------------------------------------//
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

CMD:checkprawko(playerid, params[]) return cmd_zobp(playerid, params);
CMD:zobaczprawko(playerid, params[]) return cmd_zobp(playerid, params);
CMD:zobp(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
		if( sscanf(params, "k<fix>", giveplayerid))
		{
			sendTipMessage(playerid, "U¿yj /zobp(pokazlicencje) [playerid/CzêœæNicku]");
			return 1;
		}

		if(IsPlayerConnected(giveplayerid))
		{
		    if(PlayerInfo[playerid][pZG] >=5 || PlayerInfo[playerid][pAdmin] >=1 )
		    {
				if(giveplayerid != INVALID_PLAYER_ID)
				{
    				if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz pokazaæ licencji samemu sobie, u¿yj /licencje!"); return 1; }
				    GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
	    			new text1[8];
					if(PlayerInfo[giveplayerid][pCarLic] == 1) { text1 = "Tak"; } else { text1 = "Brak"; }
  					format(string, sizeof(string), "|__________ %s __________|", giveplayer);
		        	SendClientMessage(playerid, COLOR_WHITE, string);
			        format(string, sizeof(string), "** Prawo jazdy: %s.", text1);
        			SendClientMessage(playerid, COLOR_WHITE, string);
				}
			}
			else
	        {
	            noAccessMessage(playerid);
	            return 1;
	        }
		}
        else
        {
            sendErrorMessage(playerid, "Nie ma takiego gracza !");
            return 1;
        }
	}
    return 1;
}
