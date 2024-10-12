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
command_zmiendomk_Impl(playerid, params[256])
{
    new string[128];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new para1, level;
        if( sscanf(params, "k<fix>d", para1, level))
        {
            sendTipMessage(playerid, "U¿yj /setdomk [playerid/CzêœæNicku] [id domu]");
            return 1;
        }


        if (PlayerInfo[playerid][pAdmin] == 5000)
        {
            if(IsPlayerConnected(para1))
            {
                if(para1 != INVALID_PLAYER_ID)
                {
                    GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                    Dom[PlayerInfo[para1][pDom]][hKupiony] = level;
                    ZapiszDom(PlayerInfo[para1][pDom]);
					Log(adminLog, INFO, "Admin %s zmieni³ %s stan kupienia domu na %d", GetPlayerLogName(playerid), GetPlayerLogName(para1), level);
                    format(string, sizeof(string), "   Twój stan domu zosta³ zmieniony na dom nr %d przez %s", level, GetNickEx(playerid));
                    SendClientMessage(para1, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "   Zmieni³eœ stan dom graczowi %s na dom nr %d.", giveplayer,level);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                }
            }
        } 
				else
        {
            noAccessMessage(playerid);
        }
    }
    return 1;
}

//end
