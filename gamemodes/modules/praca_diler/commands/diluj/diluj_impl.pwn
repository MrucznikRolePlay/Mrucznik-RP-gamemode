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

    if(price < DRUG_SELL_PRICE || price > DRUG_SELL_MAX_PRICE)
    {
        MruMessageFailF(playerid, "Stawka za gram narkotyku musi byæ od %d$ do %d$.", DRUG_SELL_PRICE, DRUG_SELL_MAX_PRICE);
        return 1;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    EnableDrugDealing(playerid, vehicleid, price);

	MruMessageGoodInfoF(playerid, "Aktywowa³eœ sprzeda¿ narkotyków za %d$ per gram. Za ka¿dy sprzedany gram ponosisz koszt %d$", price, DRUG_SELL_PRICE);
    return 1;
}

//end