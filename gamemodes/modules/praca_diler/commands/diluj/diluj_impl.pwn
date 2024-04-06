//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   diluj                                                   //
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
command_diluj_Impl(playerid, price)
{
    if(!IsPlayerInDrugCar(playerid))
    {
        MruMessageFail(playerid, "Aby dilowaæ narkotykami, musisz znajdowaæ w lodziarni.");
        return 1;
    }

    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        MruMessageFail(playerid, "Aby dilowaæ narkotykami, musisz znajdowaæ w lodziarni jako kierowca.");
        return 1;
    }

    if(price < 100 || price > 20000) 
    {
        MruMessageFail(playerid, "Stawka za gram narkotyku musi byæ od 100$ do 20 000$.");
        return 1;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    EnableDrugDealing(playerid, vehicleid, price);
    return 1;
}

//end