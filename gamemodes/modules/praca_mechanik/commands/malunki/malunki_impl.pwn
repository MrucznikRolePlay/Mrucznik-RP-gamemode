//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  malunki                                                  //
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
// Data utworzenia: 31.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_malunki_Impl(playerid)
{
    if(GUIExit[playerid] == 0)
    {
        ShowPlayerDialogEx(playerid, 50, DIALOG_STYLE_MSGBOX, "DostÍpne malunki wozÛw","LovRider`s:\n(Savanna,Tornado,Blade)\n0- ØÛ≥te p≥omienie\n1- Czerwono øÛ≥te paski\n2- Czerwone p≥omienie z przodu\n3- WyczyúÊ malunek\n\nRemington\n\n0- Brπzowe hieroglify\n1- Czerwono øÛ≥te p≥omienie\n2- Niebieskie p≥omienie\n3- WyczyúÊ malunek\n\nSlamvan \n\n0- Czarny z rÛøowymi paskami\n1- Kolorowe p≥omyczki\n2- ØÛ≥te p≥omienie\n3- WyczyúÊ malunek\n\nNaciúnij DALEJ aby zobaczyÊ dalszπ listÍ","DALEJ","WYJDè");
    }
    return 1;
}

//end