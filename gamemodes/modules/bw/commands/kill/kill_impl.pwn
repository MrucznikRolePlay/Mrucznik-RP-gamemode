//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    kill                                                   //
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
// Data utworzenia: 23.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kill_Impl(playerid)
{
    if(PlayerInfo[playerid][pInjury] == 0) {
        sendTipMessage(playerid, "Twoja postaæ nie jest ranna, nie mo¿esz u¿yæ tej komendy.");
        return 1;
    }

    new message[128];
    new moneyLost = floatround(kaska[playerid] * 0.02, floatround_ceil);
    if (moneyLost < 0) {
        moneyLost = 0;
    }
    format(message, sizeof(message), "Czy na pewno chcesz uœmierciæ (memory kill) swoj¹ postaæ?\nStracisz %d$ ze swojego portfela.", moneyLost);
    ShowPlayerDialogEx(playerid, DIALOG_ID_KILL, DIALOG_STYLE_MSGBOX, "Uœmiercenie postaci", message, "Akceptuj", "Anuluj");
    return 1;
}

//end