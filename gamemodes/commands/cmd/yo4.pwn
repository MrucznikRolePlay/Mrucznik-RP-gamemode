//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ yo4 ]--------------------------------------------------//
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

YCMD:yo4(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /yo4 [ID gracza]");
			return 1;
		}

		if(dialAccess[playerid] == 1)
		{
			sendErrorMessage(playerid, "Musisz odczekaæ 15 sekund przed ponown¹ interakcj¹!"); 
			return 1;
		}

		if (ProxDetectorS(5.0, playerid, playa) && Spectate[playa] == INVALID_PLAYER_ID)
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
                    new string[128], nick[MAX_PLAYER_NAME], witany[MAX_PLAYER_NAME];
                    GetPlayerName(playa, witany, sizeof(witany));
                    GetPlayerName(playerid, nick, sizeof(nick));
                    format(string, sizeof(string), "Witasz siê z %s", witany);
                    SendClientMessage(playerid, COLOR_WHITE, string);
                    format(string, sizeof(string), "Witasz siê z %s", nick);
                    SendClientMessage(playa, COLOR_WHITE, string);
					SendClientMessage(playa, COLOR_WHITE, "Witasz siê");
					dialTimer[playerid] = SetTimerEx("timerDialogs", 5000, true, "i", playerid);
					dialAccess[playerid] = 1; 
					ApplyAnimation(playerid,"GANGS","hndshkea",4.1,0,1,1,1,1);//11
					ApplyAnimation(playa,"GANGS","hndshkea",4.1,0,1,1,1,1);//11
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Jesteœ za daleko !");
		}
	}
	return 1;
}
