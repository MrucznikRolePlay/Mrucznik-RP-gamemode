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
command_dajskryptera_Impl(playerid, params[256])
{
    new string[128];
    new giveplayer[MAX_PLAYER_NAME];

    new para1;
    if( sscanf(params, "k<fix>d", para1))
    {
        sendTipMessage(playerid, "U¿yj /dajskryptera [playerid/CzêœæNicku]");
        return 1;
    }

    GetPlayerName(para1, giveplayer, sizeof(giveplayer));
    if(!Uprawnienia(playerid, ACCESS_OWNER)) return noAccessMessage(playerid);
    if(IsPlayerConnected(para1))
    {
        if(para1 != INVALID_PLAYER_ID)
        {
            ACCESS[para1] ^= ACCESS_SKRYPTER;
            MruMySQL_ZapiszUprawnienia(para1);
            format(string, sizeof(string), "Zosta³eœ mianowany na skryptera przez %s", GetNickEx(playerid));
            SendClientMessage(para1, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "Da³eœ %s skryptera - to ustawienie mo¿e byæ ryzykowne!", giveplayer);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Log(adminLog, INFO, "Admin %s mianowa³ %s na skryptera", GetPlayerLogName(playerid), GetPlayerLogName(para1));
        }
    }
    return 1;
}

//end
