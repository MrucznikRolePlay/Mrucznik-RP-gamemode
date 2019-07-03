//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ uleczmnie ]-----------------------------------------------//
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

YCMD:uleczmnie(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
   	{
        if (PlayerToPoint(3, playerid,1173.2563,-1323.3102,15.3943)||PlayerToPoint(3, playerid,2029.5945,-1404.6426,17.2512))
		{
            if(STDPlayer[playerid] > 0)
            {
                if(PlayerInfo[playerid][pPainPerk] >= 1)
				{
				    new painpreking = PlayerInfo[playerid][pPainPerk]*300;
				    new placenie = 1000-painpreking;
					STDPlayer[playerid] = 0;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ zdrowy dziêki szpitalnej pomocy !");
					ZabierzKase(playerid, placenie);
					format(string, sizeof(string), "Doktor: Koszt pobytu w szpitalu wynosi $%d,-. Mi³ego dnia!", placenie);
					SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
				}
				else
 				{
 				    STDPlayer[playerid] = 0;
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Jesteœ zdrowy dziêki szpitalnej pomocy !");
					ZabierzKase(playerid, 1000);
					SendClientMessage(playerid, TEAM_CYAN_COLOR, "Doktor: Koszt pobytu w szpitalu wynosi $1000,-. Mi³ego dnia!");
				}
			}
			else
			{
			    sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ chory, nie potrzebujesz leczenia !");
			    return 1;
			}
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ w szpitalu !");
        }
    }
	return 1;
}
