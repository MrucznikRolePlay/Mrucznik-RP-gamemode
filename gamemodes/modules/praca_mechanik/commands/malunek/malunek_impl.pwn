//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  malunek                                                  //
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
command_malunek_Impl(playerid, giveplayerid, paintjob)
{
    new cost = 20_000;
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY))
    {
        cost /= 2;
    }

    // permission, paarmeters validation
    if(!TuneCommands_CheckRequirements(playerid, giveplayerid, cost))
    {
        return 1;
    }

    if(GetPlayerJobSkill(playerid, JOB_MECHANIC) < 3)
    {
        MruMessageFail(playerid, "Musisz mie� 3 skill mechanika aby nak�ada� malunki na pojazdy.");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(giveplayerid);
    new model = GetVehicleModel(vehicleID);
    if(!(model == 412 || model >= 534 && model <= 536 || model >= 558 && model <= 562 || model >= 565 && model <= 567 || model == 575 || model == 576 || model == 483))
    {
        MruMessageFail(playerid, "Na ten pojazd nie mo�na na�o�y� malunku.");
        return 1; 
    }

    if(paintjob < 0 || paintjob > 3)
    {
        MruMessageFail(playerid, "ID malunku od 0 do 3 (wpisz /malunki aby zobaczy� dost�pne malunki).");
        return 1;
    }

    // functionality
    new vehicleUID = VehicleUID[vehicleID][vUID];
    ChangeVehiclePaintjob(vehicleID, paintjob);
    CarData[vehicleUID][c_Malunek] = paintjob;
    ZabierzKase(playerid, cost);

    // messages
    Log(payLog, INFO, "%s zamontowa� %s malunek %d na pojazd %s za %d$",
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), paintjob, GetVehicleLogName(vehicleID), cost
    );

    MruMessageGoodInfoF(playerid, "Zrobi�e� graczowi %s malunek samochodu (-%d$)", GetNick(giveplayerid), cost);
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s zrobi� malunek na twoim %s", GetNick(playerid), VehicleNames[model-400]);

    ChatMePrefixed(playerid, "Mechanik", sprintf(
        "wyci�ga sprey i tworzy malunek na %s.", VehicleNames[model-400]
    ));
    
    GameTextForPlayer(playerid, sprintf("~r~-$%d", cost), 5000, 1);
    PlayerPlaySound(playerid, 1134, 0.0, 0.0, 0.0);
    if(giveplayerid != playerid)
    {
        IncreasePlayerJobSkill(playerid, JOB_MECHANIC, 3);
        PlayerPlaySound(giveplayerid, 1134, 0.0, 0.0, 0.0);
    }
    return 1;
}

//end