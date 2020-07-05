//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ k ]---------------------------------------------------//
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

YCMD:k(playerid, params[], help)
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
        ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
        ApplyPlayerAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0, 0, 0, 0, 0, 0);
    }
    return 1;
}
