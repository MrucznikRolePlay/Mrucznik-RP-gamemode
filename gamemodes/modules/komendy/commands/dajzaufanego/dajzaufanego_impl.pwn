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
command_dajzaufanego_Impl(playerid, params[256])
{
    if(Uprawnienia(playerid, ACCESS_ZG))
    {
		new para1, level;
        new string[128];
    	new giveplayer[MAX_PLAYER_NAME];
    	new sendername[MAX_PLAYER_NAME];
		if( sscanf(params, "k<fix>d", para1, level))
		{
			sendTipMessage(playerid, "U¿yj /dajzaufanego [playerid/CzêœæNicku] [1- 10]");
			return 1;
		}
	    if(IsPlayerConnected(para1))
	    {
            if(level >= 0 && level <= 10)
            {
                GetPlayerName(para1, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "Zosta³eœ mianowany na %d level zaufanego gracza przez %s", level, sendername);
				SendClientMessage(para1, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "Da³eœ %s zaufanego o levelu %d.", giveplayer,level);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            	Log(adminLog, INFO, "Admin %s mianowa³ %s na %d level zaufanego", GetPlayerLogName(playerid), GetPlayerLogName(para1), level);

                PlayerInfo[para1][pZG] = level;
            }
			else
			{
				sendTipMessageEx(playerid, COLOR_NEWS, "Level od 1 do 10 !");
			}
		}
	}
	return 1;
}

//end
