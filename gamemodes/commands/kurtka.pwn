//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ kurtka ]------------------------------------------------//
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

CMD:kurtka(playerid)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(IsAFBI(playerid))
		{
			if (PlayerToPoint(3.5, playerid, 592.5598,-1477.5116,82.4736))//nowe fbi by ubunteq
			{
				if(GetPlayerVirtualWorld(playerid) == 2)
				{
					if(OnDuty[playerid] == 1 && PlayerInfo[playerid][pSex] == 1)
					{
						format(string, sizeof(string), "* %s zak³ada kurtkê z naszywkami FBI.", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetPlayerSkin(playerid, 286);
						SetPlayerColor(playerid, COLOR_FBI); // czarny
					}
					else if(OnDuty[playerid] == 1 && PlayerInfo[playerid][pSex] == 2)
					{
						format(string, sizeof(string), "* %s zak³ada luŸny strój agentki FBI.", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetPlayerSkin(playerid, 141);
						SetPlayerColor(playerid, COLOR_FBI); // czarny
					}
					else
					{
						sendTipMessage(playerid, "Nie jesteœ na s³u¿bie!");
					}
				}
				else
				{
					sendErrorMessage(playerid, "Nie jesteœ w szatni!"); 
				}
			}
			else
			{
				sendTipMessage(playerid, "Nie jesteœ w szatni !");
				return 1;
			}
		}
	}
	return 1;
}
