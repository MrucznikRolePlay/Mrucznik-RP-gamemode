//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zmiendom ]-----------------------------------------------//
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

YCMD:zmiendom(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new para1, level;
        if( sscanf(params, "k<fix>d", para1, level))
        {
            sendTipMessage(playerid, "U¿yj /setdom [playerid/CzêœæNicku] [id domu]");
            return 1;
        }

        if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
        {
            if(IsPlayerConnected(para1))
            {
                if(para1 != INVALID_PLAYER_ID)
                {
                    GetPlayerName(para1, giveplayer, sizeof(giveplayer));
                    GetPlayerName(playerid, sendername, sizeof(sendername));
                    PlayerInfo[para1][pDom] = level;
                    format(string, sizeof(string), "   Twój dom zosta³ zmieniony na dom nr %d przez %s", level, sendername);
                    SendClientMessage(para1, COLOR_LIGHTBLUE, string);
                    format(string, sizeof(string), "   Zmieni³eœ dom graczowi %s na dom nr %d.", giveplayer,level);
                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                    Log(adminLog, INFO, "Admin %s zmieni³ %s dom na %s", GetPlayerLogName(playerid), GetPlayerLogName(para1), GetHouseLogName(level));
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
