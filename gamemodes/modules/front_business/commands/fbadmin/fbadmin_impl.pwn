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
command_fbadmin_Impl(playerid, bizId, params[256])
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

    if(strcmp(params, "takeover", true) == 0)
    {
        if(FrontBusiness[bizId][TakeoverActive]) 
        {
            StopFrontBizTakeover(bizId);
            MruMessageGoodInfo(playerid, "Zatrzyma³eœ przejmowanie biznesu.");
        }
        else
        {
            StartFrontBizTakeover(bizId);
            MruMessageGoodInfo(playerid, "Rozpocz¹³eœ przejmowanie biznesu.");
        }
    }
    else
    {
        MruMessageFail(playerid, "Dostêpne opcje: takeover");
    }
    return 1;
}

//end