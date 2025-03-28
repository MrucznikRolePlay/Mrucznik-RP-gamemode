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
command_stworzdom_Impl(playerid, params[256])
{
    if(gPlayerLogged[playerid] == 1)
    {
	    if(PlayerInfo[playerid][pAdmin] == 5000)
		{
   			new interior, kesz;
			if( sscanf(params, "dd", interior, kesz))
			{
				sendTipMessage(playerid, "U�yj /zrobdom [interior] [dodatkowa op�ata]");
				return 1;
			}

			if(interior >= 1 && interior <= MAX_NrDOM)
			{
			    if(kesz >= 0 && kesz <= 1000000000)
			    {
					new string[128];
                    new domid = StworzDom(playerid, interior, kesz);
					format(string, sizeof(string), "%s stworzyl nowy dom o (id %d)", GetNickEx(playerid), domid);
					Log(adminLog, INFO, "Admin %s stworzy� dom %s o interiorze %d z dodatkow� op�at� %d$", 
						GetPlayerLogName(playerid),
						domid,
						interior,
						kesz);
			    }
			    else
			    {
			        sendTipMessage(playerid, "Dodatkowa op�ata 0 do 1mld (1 000 000 000)");
			    }
			}
			else
			{
			    sendTipMessage(playerid, "Interior od 1 do 46");
			}
		}
	}
	return 1;
}

//end
