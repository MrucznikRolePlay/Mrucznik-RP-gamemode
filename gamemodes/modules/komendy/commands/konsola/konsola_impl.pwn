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
command_konsola_Impl(playerid)
{
    if(IsFrontBusinnesOwnedByPlayerOrg(playerid, FRONTBIZ_VINYL))
    {
        if(PlayerInfo[playerid][pRank] < 4) return sendErrorMessage(playerid, "Tylko dla stopni od 4 wzwy�!");
        if(!IsPlayerInRangeOfPoint(playerid, 5.0, 816.3592,-1384.7954,-20.1095)) return 1;
        ShowPlayerDialogEx(playerid, DIALOG_KONSOLA_VINYL, DIALOG_STYLE_INPUT, "Konsola DJ'a", "Tutaj mo�esz zmieni� muzyk� graj�c� w klubie.\nWprowad� poni�ej adres URL.", "Ustaw", "Wyjd�");
    }
    else if(IsFrontBusinnesOwnedByPlayerOrg(playerid, FRONTBIZ_IBIZA))
    {
        if(PlayerInfo[playerid][pRank] < 4) return sendErrorMessage(playerid, "Tylko dla stopni od 4 wzwy�!");
        if(!IsPlayerInRangeOfPoint(playerid, 2.5, 433.1950, -1845.3390, -64.2206)) return 1;
        ShowPlayerDialogEx(playerid, DIALOG_KONSOLA_IBIZA, DIALOG_STYLE_INPUT, "Konsola DJ'a", "Tutaj mo�esz zmieni� muzyk� graj�c� w klubie.\nWprowad� poni�ej adres URL.", "Ustaw", "Wyjd�");
    }
    return 1;
}

//end
