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
command_swat_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(IsAPolicja(playerid))
		{
			if (PlayerToPoint(3, playerid,255.3,77.4,1003.6)
			|| PlayerToPoint(3,playerid,266.7904,118.9303,1004.6172)
			|| PlayerToPoint(3,playerid,225.9369,157.1783,1003.0300)
			|| PlayerToPoint(5, playerid, 185.3000488281,-1571.0999755859,-54.5)
			|| PlayerToPoint(5, playerid, 1189.5999755859,-1574.6999511719,-54.5 )
			|| PlayerToPoint(10.0,playerid, 2515.0200, -2459.5896, 13.8187)
			|| (PlayerToPoint(4,playerid, 1562.0536,-1649.9120,28.5040) && GetPlayerVirtualWorld(playerid) == 27)//nowe komi by charlie
			|| PlayerToPoint(3.8, playerid, 597.1039,-1474.2688,80.4357))//nowe FBI by ubunteq
			{
				if(OnDuty[playerid] == 1)
				{
					format(string, sizeof(string), "* %s bierze mundur i tarczê SWAT.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	    		    SetPlayerSkin(playerid, 285);
					SetPlayerColor(playerid, 0x000000FF); // czarny
                    SetPlayerArmour(playerid, 90);
	    		    if(IsPlayerAttachedObjectSlotUsed(playerid, 2))
	    		    {
	    		    	RemovePlayerAttachedObject(playerid, 2);
	    		    }
	    		    else
	    		    {
	    		        SetPlayerAttachedObject(playerid, 2, 18637, 13, 0.35, 0.0, 0.0, 0, 0, 180);
	    		    }
				}
				else
				{
				    sendTipMessage(playerid, "Nie jesteœ na s³u¿bie !");
				}
			}
			else
			{
				sendTipMessage(playerid, "Nie jesteœ w szatni !");
				return 1;
			}
		}
        else
		{
			sendErrorMessage(playerid, "Nie jesteœ ze s³u¿b porz¹dkowych !");
			return 1;
		}
	}
	return 1;
}

//end
