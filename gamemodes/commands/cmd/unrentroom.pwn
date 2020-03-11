//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ unrentroom ]----------------------------------------------//
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

YCMD:unrentroom(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        if(PlayerInfo[playerid][pWynajem] != 0)
	        {
				new lokator[MAX_PLAYER_NAME];
			    new kox12[MAX_PLAYER_NAME];
			    format(kox12, sizeof(kox12), "Brak");
				lokator = GetNickEx(playerid);
			    new dom = PlayerInfo[playerid][pWynajem];
			    if(strcmp(Dom[dom][hL1], lokator, true) == 0)
			    {
			        Dom[dom][hL1] = kox12;
			    }
			    if(strcmp(Dom[dom][hL2], lokator, true) == 0)
			    {
			        Dom[dom][hL2] = kox12;
			    }
			    if(strcmp(Dom[dom][hL3], lokator, true) == 0)
			    {
			        Dom[dom][hL3] = kox12;
			    }
			    if(strcmp(Dom[dom][hL4], lokator, true) == 0)
			    {
			        Dom[dom][hL4] = kox12;
			    }
			    if(strcmp(Dom[dom][hL5], lokator, true) == 0)
			    {
			        Dom[dom][hL5] = kox12;
			    }
			    if(strcmp(Dom[dom][hL6], lokator, true) == 0)
			    {
			        Dom[dom][hL6] = kox12;
			    }
			    if(strcmp(Dom[dom][hL7], lokator, true) == 0)
			    {
			        Dom[dom][hL7] = kox12;
			    }
			    if(strcmp(Dom[dom][hL8], lokator, true) == 0)
			    {
			        Dom[dom][hL8] = kox12;
			    }
			    if(strcmp(Dom[dom][hL9], lokator, true) == 0)
			    {
			        Dom[dom][hL9] = kox12;
			    }
			    if(strcmp(Dom[dom][hL10], lokator, true) == 0)
			    {
    				Dom[dom][hL10] = kox12;
			    }
			    Dom[dom][hPW] --;
    			Dom[dom][hPDW] ++;
				PlayerInfo[playerid][pWynajem] = 0;
				sendTipMessage(playerid, "Nie wynajmujesz ju¿ domu");
	        }
	        else
	        {
	            sendErrorMessage(playerid,"Nie wynajmujesz domu.");
	        }
	    }
	}
	return 1;
}
