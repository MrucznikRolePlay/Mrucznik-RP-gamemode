//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  fbadmin                                                  //
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
// Data utworzenia: 14.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_fbadmin_Impl(playerid, bizId, action[32], params[256])
{
    if(PlayerInfo[playerid][pAdmin] != 5000)
    {
        noAccessMessage(playerid);
        return 1;
    }

    if(bizId < 0 || bizId >= sizeof(FrontBusiness))
    {
        MruMessageFail(playerid, sprintf("ID biznesu od 0 do %d.", sizeof(FrontBusiness)));
        return 1;
    }

    if(strcmp(action, "takeover", true) == 0)
    {
        if(FrontBusiness[bizId][TakeoverActive]) 
        {
            StopFrontBizTakeover(bizId);
            MruMessageGoodInfo(playerid, "Zatrzyma³eœ przejmowanie biznesu.");
            Log(adminLog, INFO, "Admin %s zatrzyma³ przejmowanie biznesu %s", GetPlayerLogName(playerid), GetFrontBizLogName(bizId));
        }
        else
        {
            StartFrontBizTakeover(bizId);
            MruMessageGoodInfo(playerid, "Rozpocz¹³eœ przejmowanie biznesu.");
            Log(adminLog, INFO, "Admin %s rozpocz¹³ przejmowanie biznesu %s", GetPlayerLogName(playerid), GetFrontBizLogName(bizId));
        }
    }
    else if(strcmp(action, "give", true) == 0)
    {
        new org;
        if(sscanf(params, "d", org))
        {
            sendTipMessage(playerid, "U¿yj /fbadmin [bizID] give [orgID]");
            return 1;
        }

        if(org < 0 || org >= MAX_ORG)
        {
            MruMessageFail(playerid, "OrgID od 0 do "#MAX_ORG);
            return 1;
        }

        TakeOverFrontBusiness(bizId, org);
        MruMessageGoodInfoF(playerid, "Da³eœ biznes %d organizacji %d", bizId, org);
        Log(adminLog, INFO, "Admin %s da³ biznes %s organizacji %s", GetPlayerLogName(playerid), GetFrontBizLogName(bizId), GetOrgLogName(org));
    }
    else
    {
        MruMessageFail(playerid, "Dostêpne opcje: takeover / give");
    }
    return 1;
}

//end