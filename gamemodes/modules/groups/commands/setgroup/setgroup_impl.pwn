//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 setgroup                                                  //
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
// Autor: Creative
// Data utworzenia: 28.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_setgroup_Impl(playerid, id, uid)
{
    if(!IsAScripter(playerid) && !Uprawnienia(playerid, ACCESS_MAKELEADER) && !Uprawnienia(playerid, ACCESS_MAKELEADER)) return 1;

    if(GroupInfo[uid][UID] == 0 || uid > MAX_GROUPS)
    {
        sendTipMessage(playerid, "B³êdne UID grupy.");
        return 1;
    }

    sendTipMessageEx(id, COLOR_P@, sprintf("Administrator %s ustawi³ Ci przynale¿noœæ do grupy %s [UID %d]", GetNickEx(playerid), GroupInfo[uid][Name], uid)); 
    sendTipMessageEx(playerid, COLOR_P@, sprintf("Ustawi³eœ przynale¿noœæ do grupy %s [UID %d] dla %s", GroupInfo[uid][Name], uid, GetNick(id))); 
    SetPlayerGroup(id, uid);
    return 1;
}

//end