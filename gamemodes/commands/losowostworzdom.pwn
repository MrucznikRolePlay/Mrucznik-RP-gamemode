//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ losowostworzdom ]--------------------------------------------//
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

CMD:lzrobdom(playerid, params[]) return cmd_losowostworzdom(playerid, params);
CMD:lstworzdom(playerid, params[]) return cmd_losowostworzdom(playerid, params);
CMD:lcreatehouse(playerid, params[]) return cmd_losowostworzdom(playerid, params);
CMD:lpostawdom(playerid, params[]) return cmd_losowostworzdom(playerid, params);
CMD:ltworzdom(playerid, params[]) return cmd_losowostworzdom(playerid, params);
CMD:losowostworzdom(playerid, params[])
{
    if(gPlayerLogged[playerid] == 1)
    {
	    if(PlayerInfo[playerid][pAdmin] >= 5000 )
		{
   			new kategoria, kesz;
			if( sscanf(params, "dd", kategoria, kesz))
			{
				sendTipMessage(playerid, "U¿yj /lzrobdom [kategoria] [dodatkowa op³ata]");
				return 1;
			}

			if(kategoria >= 1 && kategoria <= 7)
			{
			    if(kesz >= 0 && kesz <= 1000000000)
			    {
                    L_StworzDom(playerid, kategoria, kesz);
			    }
			    else
			    {
			        sendTipMessage(playerid, "Dodatkowa op³ata 0 do 1mld (1 000 000 000)");
			    }
			}
			else
			{
			    sendTipMessage(playerid, "kategoria od 1 do 7");
			}
		}
	}
	return 1;
}



