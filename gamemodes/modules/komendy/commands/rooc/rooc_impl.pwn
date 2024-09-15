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
command_rooc_Impl(playerid, params[256])
{
    new string[256];
    if(IsPlayerConnected(playerid))
    {
        if(isnull(params))
        {
            sendTipMessage(playerid, "U¿yj (/r)adio [tekst]");
            return 1;
        }
        if(gRO[playerid] == 1) return sendTipMessage(playerid, "Nie mo¿esz pisaæ na (/ro), zablokowa³eœ ten czat (U¿yj /togro)");
        new member = GetPlayerFraction(playerid);
        if(0 < member <= 4 || member == 11 || member == 7 || member == 17)
        {
            
            format(string, sizeof(string), "** (( %s [%d] %s: %s )) **", FracRang[member][PlayerInfo[playerid][pRank]],PlayerInfo[playerid][pRank],GetNickEx(playerid), params);
            SendRadioMessage(member, TEAM_BLUE_COLOR, string, 1);
            SendDiscordFracMessage(member, string);
        }
		else
        {
            noAccessMessage(playerid);
            return 1;
        }
        Log(chatLog, INFO, "%s radio policyjne %d OOC: %s", GetPlayerLogName(playerid), member, params);
    }
    return 1;
}

//end
