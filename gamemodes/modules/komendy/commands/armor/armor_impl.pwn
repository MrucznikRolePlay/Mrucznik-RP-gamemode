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
command_armor_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pDom] || PlayerInfo[playerid][pDomWKJ] == PlayerInfo[playerid][pWynajem] && Dom[PlayerInfo[playerid][pDom]][hUL_D] != 0)
		{
			new dom = PlayerInfo[playerid][pDom];
			if(IsPlayerInRangeOfPoint(playerid, 50.0, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]))
			{
				if(Dom[dom][hKami] != 0)
				{
					new Float:ARMOR;
					GetPlayerArmour(playerid, ARMOR);
					if(Dom[dom][hKami] == 1)
					{
					    if(ARMOR >= 10.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 10.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (10 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 2)
					{
					    if(ARMOR >= 20.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 20.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (20 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 3)
					{
					    if(ARMOR >= 30.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 30.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (30 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 4)
					{
					    if(ARMOR >= 40.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 40.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (40 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 5)
					{
					    if(ARMOR >= 50.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 50.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (50 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 6)
					{
					    if(ARMOR >= 60.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 60.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (60 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 7)
					{
					    if(ARMOR >= 70.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 70.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (70 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 8)
					{
					    if(ARMOR >= 80.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie ptrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 80.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (80 pancerza).");
    				}
    				else if(Dom[dom][hKami] == 9)
					{
					    if(ARMOR >= 90.0)
						{
						    sendTipMessageEx(playerid, COLOR_GRAD2, "Nie potrzebujesz pancerza.");
						    return 1;
						}
		    			SetPlayerArmour(playerid, 90.0);
					    //Dom[dom][hMagazyn]--;
    					sendTipMessageEx(playerid, COLOR_GRAD2, "Skorzysta³eœ z domowego pancerza (90 pancerza).");
    				}
 					return 1;
				}
				else
				{
				    sendTipMessageEx(playerid, COLOR_GRAD2, "W tym domu nie ma pancerza / brak uprawnieñ.");
				    return 1;
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie jesteœ w domu.");
			    return 1;
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ w domu.");
			return 1;
		}
	}
	return 1;
}

//end
