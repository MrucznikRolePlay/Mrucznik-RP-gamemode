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
command_elo_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U�yj /elo [ID gracza]");
			return 1;
		}

		if(dialAccess[playerid] == 1)
		{
			sendErrorMessage(playerid, "Musisz odczeka� 15 sekund przed ponown� interakcj�!"); 
			return 1;
		}

		if (ProxDetectorS(5.0, playerid, playa))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
                    new string[128], nick[MAX_PLAYER_NAME], witany[MAX_PLAYER_NAME];
                    GetPlayerName(playa, witany, sizeof(witany));
                    GetPlayerName(playerid, nick, sizeof(nick));
                    format(string, sizeof(string), "Witasz si� z %s", witany);
                    SendClientMessage(playerid, COLOR_WHITE, string);
                    format(string, sizeof(string), "Witasz si� z %s", nick);
                    SendClientMessage(playa, COLOR_WHITE, string);
					dialTimer[playerid] = SetTimerEx("timerDialogs", 5000, true, "i", playerid);
					dialAccess[playerid] = 1; 
					//SendClientMessage(playa, COLOR_WHITE, "Witasz si�");
					ApplyAnimation(playerid,"GANGS","hndshkcb",4.1,0,1,1,1,1);//8
					ApplyAnimation(playa,"GANGS","hndshkcb",4.1,0,1,1,1,1);//8
				}
			}
		}
		else
		{
			sendErrorMessage(playerid, "Jeste� za daleko !");
		}
	}
	return 1;
}

//end
