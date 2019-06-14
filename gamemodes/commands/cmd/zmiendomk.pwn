//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ zmiendomk ]-----------------------------------------------//
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

YCMD:zmiendomk(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        new para1, level;
        if( sscanf(params, "k<fix>d", para1, level))
        {
            sendTipMessage(playerid, "U¿yj /setdomk [playerid/CzêœæNicku] [id domu]");
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
                    Dom[PlayerInfo[para1][pDom]][hKupiony] = level;
                    ZapiszDom(PlayerInfo[para1][pDom]);
                    printf("AdmCmd: %s zmieni³ kupno domu %s na %d.", sendername, giveplayer, level);
                    format(string, sizeof(string), "   Twój stan domu zosta³ zmieniony na dom nr %d przez %s", level, sendername);
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
