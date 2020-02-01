//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   sekta                                                   //
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
command_sekta_Impl(playerid, opcja[24], giveplayerid)
{
    if(GetPlayerOrg(playerid) == FAMILY_SEKTA && PlayerInfo[playerid][pRank] >= 1)
    {
        if(strcmp(opcja,"klucz",true) == 0)
		{
            if(SektaKey[giveplayerid] == 0)
            {
                format(var, sizeof(var), "Da³eœ klucz do wrot %s", GetNick(giveplayerid));
                sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
                sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Otrzyma³eœ klucz do wrot.");
                SektaKey[giveplayerid] = 1;
            }
            else
            {
                format(var, sizeof(var), "Zabra³eœ klucz do wrot %s", GetNick(giveplayerid));
                sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
                sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Zabrano ci klucz do wrot.");
                SektaKey[giveplayerid] = 0;
            }
        }
        if(strcmp(opcja,"wepchnij",true) == 0)
		{
            sendTipMessage(playerid, "komenda wepchnij");
        }
        if(strcmp(opcja,"wypusc",true) == 0)
		{
            sendTipMessage(playerid, "komenda wypusc");
        }
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end