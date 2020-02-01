//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   klucz                                                   //
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
// Data utworzenia: 02.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_klucz_Impl(playerid, giveplayerid)
{
    new var[128];
    if(GetPlayerOrg(playerid) == FAMILY_SEKTA && PlayerInfo[playerid][pRank] >= 1)
    {
        if(SektaKey[giveplayerid] == 0)
        {
            format(var, sizeof(var), "Da³eœ klucz do wrot %s", GetNick(giveplayerid));
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
            sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Otrzyma³eœ klucz od wrot.");
            SektaKey[giveplayerid] = 1;
        }
        else
        {
            format(var, sizeof(var), "Zabra³eœ klucz do wrot %s", GetNick(giveplayerid));
            sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
            sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Zabrano ci klucz od wrot.");
            SektaKey[giveplayerid] = 0;
        }
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end