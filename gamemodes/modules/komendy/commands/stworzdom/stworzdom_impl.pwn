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
				sendTipMessage(playerid, "U¿yj /zrobdom [interior] [dodatkowa op³ata]");
				return 1;
			}

			if(interior >= 1 && interior <= MAX_NrDOM)
			{
			    if(kesz >= 0 && kesz <= 1000000000)
			    {
					new domid = StworzDom(playerid, interior, kesz);
					Log(adminLog, INFO, "Admin %s stworzy³ dom %s o interiorze %d z dodatkow¹ op³at¹ %d$", 
						GetPlayerLogName(playerid),
						GetHouseLogName(domid),
						interior,
						kesz);
			    }
			    else
			    {
			        sendTipMessage(playerid, "Dodatkowa op³ata 0 do 1mld (1 000 000 000)");
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
