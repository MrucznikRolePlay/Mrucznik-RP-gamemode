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
command_idz_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0)
        {
            ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "{FF542E}Jesteœ ranny!\n{FFFFFF}Nie mo¿esz zatrzymaæ animacji.");
            return 1;
        }
        ShowPlayerDialogEx(playerid, 1213, DIALOG_STYLE_LIST,"Automatyczna animacja","Pijak\nNormalny\nBabcia\nGangsta\nGangsta 2\nGarbaty\nZ broni¹\nNormalny 2\nStaruszka\nDziwka\nPaker\nKobieta\nTuptuœ\nNormalny 3","Akceptuj","Anuluj");    
    }
    return 1;
}

//end
