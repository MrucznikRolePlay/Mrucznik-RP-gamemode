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
command_szturmowy_Impl(playerid)
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(IsAPolicja(playerid))
		{
			if (IsAtDutyPlace(playerid))
			{
				if(OnDuty[playerid] == 1 && DodatkiPD[playerid] == 0)
				{
					format(string, sizeof(string), "* %s wyci¹ga z szafki i ubiera zestaw szturmowy.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					SetPlayerAttachedObject(playerid,2,19141,2,0.11,0.0,0.0,0.0,0.0,0.0);//Cask
					SetPlayerAttachedObject(playerid,3,18637,13,0.35,0.0,0.0,0.0,0.0,180.0);//Shield
					DodatkiPD[playerid] = 1;
				}
				else if(OnDuty[playerid] == 1 && DodatkiPD[playerid] == 1)
				{
        			RemovePlayerAttachedObject(playerid,2);
       				RemovePlayerAttachedObject(playerid,3);
                	format(string, sizeof(string), "* %s œci¹ga z siebie zestaw szturmowy i chowa do szafki.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					DodatkiPD[playerid] = 0;
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
