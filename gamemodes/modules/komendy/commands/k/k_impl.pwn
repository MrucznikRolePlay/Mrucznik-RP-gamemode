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
command_k_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
        if(PlayerInfo[playerid][pMuted] == 1)
        {
            sendTipMessage(playerid, "Jesteœ uciszony! Nie mo¿esz mówiæ");
            return 1;
        }
        if(GetPlayerAdminDutyStatus(playerid) == 1)
        {
            sendErrorMessage(playerid, "Dobry admin nie powinien robiæ OOC w IC! U¿yj /b [treœæ]");
            return 1;
        }
        if(isnull(params))
        {
            sendTipMessage(playerid, "U¿yj /(k) krzycz [tekst]");
            return 1;
        }

        PlayerTalkIC(playerid, params, "krzyczy", 18.0, true);
	    Log(chatLog, INFO, "%s krzyk: %s", GetPlayerLogName(playerid), params);
    }
    if(!IsPlayerInAnyVehicle(playerid))
    {
        ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
        ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}

//end
