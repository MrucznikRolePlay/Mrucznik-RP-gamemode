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

    if(uid <= 0 || uid > MAX_GROUPS || GroupInfo[uid][gUID] == 0)
    {
        sendTipMessage(playerid, "B³êdne UID grupy.");
        return 1;
    }

    sendTipMessageEx(id, COLOR_P@, sprintf("Administrator %s ustawi³ Ci przynale¿noœæ do grupy %s [UID %d]", GetNickEx(playerid), GroupInfo[uid][gName], uid)); 
    sendTipMessageEx(playerid, COLOR_P@, sprintf("Ustawi³eœ przynale¿noœæ do grupy %s [UID %d] dla %s", GroupInfo[uid][gName], uid, GetNick(id))); 
    Log(adminLog, INFO, "Admin %s ustawi³ graczowi %s przynale¿noœæ do grupy UID [%d]", GetPlayerLogName(playerid), GetPlayerLogName(id), uid);
    SetPlayerGroup(id, uid);
    return 1;
}

//end