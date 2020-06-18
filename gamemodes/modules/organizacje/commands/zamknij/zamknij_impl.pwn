//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  zamknij                                                  //
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
// Autor: Sanda³
// Data utworzenia: 18.06.2020


//

//------------------<[ Implementacja: ]>-------------------
command_zamknij_Impl(playerid)
{
    if(GetPlayerOrg(playerid) != 23)
    {
        sendTipMessage(playerid, "Komenda dostêpna tylko dla Gunshop Los Santos.");
        return 1;
    }
    if(PlayerInfo[playerid][pRank] <= 3)
    {
        sendTipMessage(playerid, "Komenda dostêpna od [4].");
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 1791.6248,-1164.4028,23.8281) || (IsPlayerInRangeOfPoint(playerid, 200.0, 1795.1212,-1158.1047,1023.8218) && GetPlayerVirtualWorld(playerid) == 5))
    {
        if(GunshopLSLock == 0)
        {
            GunshopLSLock = 1;
            new string[128];
            format(string, sizeof(string), "* %s przyk³ada kartê do drzwi i zamyka magnetyczne zamki.", GetNick(playerid));
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            format(string, sizeof(string), "* Stalowe rolety od okien i drzwi zaczynaj¹ opadaæ...");
			ProxDetector(30.0, playerid, string, 0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA,0xC2A2DAAA);
            return 1;
        }
        else
        {
            sendTipMessage(playerid, "Biznes jest ju¿ otwarty.");
            return 1;
        }
    }
    else
    {
        sendTipMessage(playerid, "Nie znajdujesz siê w œrodku/przy drzwiach wejœciowych!");
        return 1;
    }
}

//end