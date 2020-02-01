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
// Autor: Sanda�
// Data utworzenia: 02.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_klucz_Impl(playerid, giveplayerid)
{
    if(!GetPlayerOrg(playerid) == FAMILY_SEKTA)
    {
        noAccessMessage(playerid);
        return 1;
    }
    if(SektaKey[giveplayerid] == 0)
    {
        format(var, sizeof(var), "Da�e� klucz do wrot %s", GetNick(giveplayerid));
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
        sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Otrzyma�e� klucz od wrot.");
        SektaKey[giveplayerid] = 1;
    }
    else
    {
        format(var, sizeof(var), "Zabra�e� klucz do wrot %s", GetNick(giveplayerid));
        sendTipMessageEx(playerid, COLOR_LIGHTBLUE, var);
        sendTipMessageEx(giveplayerid, COLOR_LIGHTBLUE, "Zabrano ci klucz od wrot.");
        SektaKey[giveplayerid] = 0;
    }
    return 1;
}

//end