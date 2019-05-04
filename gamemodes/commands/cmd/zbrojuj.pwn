//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zbrojuj ]------------------------------------------------//
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

// YCMD:zbrojka(playerid, params[], help) return cmd_zbrojuj(playerid, help);
// YCMD:zbrojownia(playerid, params[], help) return cmd_zbrojuj(playerid, help);
YCMD:zbrojuj(playerid, params[], help)
{
	/*
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        if(GUIExit[playerid] == 0)
	    	{
	    	    if(PlayerInfo[playerid][pDom] == PlayerInfo[playerid][pDomWKJ])
		        {
		            new dom = PlayerInfo[playerid][pDom];
		            if(Dom[dom][hZbrojownia] == 1)
		            {
		                if(Dom[dom][hS_PG0] == 0 && Dom[dom][hS_PG1] == 0 && Dom[dom][hS_PG2] == 0 && Dom[dom][hS_PG3] == 0 && Dom[dom][hS_PG4] == 0 && Dom[dom][hS_PG5] == 0 && Dom[dom][hS_PG6] == 0 && Dom[dom][hS_PG7] == 0 && Dom[dom][hS_PG8] == 0 && Dom[dom][hS_PG9] == 0 && Dom[dom][hS_PG10] == 0 && Dom[dom][hS_PG11] == 0)
		                {
		                    SendClientMessage(playerid, COLOR_GRAD3, "Twoja zbrojownia nie jest przystosowana do przechowywania jakiejkolwiek broni.");
		                }
		                else
		                {
		                    ShowPlayerDialogEx(playerid, 8240, DIALOG_STYLE_LIST, "Zbrojownia", "Wyjmij broñ\nSchowaj broñ\nZawartoœæ zbrojowni", "Wybierz", "Anuluj");
		                }
		            }
		            else
		            {
                        SendClientMessage(playerid, COLOR_GRAD3,"Nie posiadasz zbrojowni.");
		            }
		        }
		        else
		        {
		            SendClientMessage(playerid, COLOR_GRAD3,"Ten dom nie jest twój.");
		        }
	    	}
	    }
	}
	*/
	return 1;
}





