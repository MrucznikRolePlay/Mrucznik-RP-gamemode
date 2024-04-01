//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 hydraulika                                                //
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
command_hydraulika_Impl(playerid, giveplayerid)
{
    new cost = 10_000;
    if(IsAMechazordWarsztatowy(playerid))
    {
        cost /= 2;
    }

    // permission, paarmeters validation
    if(!TuneCommands_CheckRequirements(playerid, giveplayerid, cost))
    {
        return 1;
    }

    if(GetPlayerJobSkill(playerid, JOB_MECHANIC) < 2)
    {
        MruMessageFail(playerid, "Musisz mieæ 2 skill mechanika aby montowaæ hydraulike.");
        return 1;
    }

    // helper variables
    new vehicleID = GetPlayerVehicleID(giveplayerid);
    new vehicleUID = VehicleUID[vehicleID][vUID];

    // functionality
    ZabierzKase(playerid, cost);
    AddVehicleComponent(vehicleID, 1087); //hydraulika
    CarData[vehicleUID][c_bHydraulika] = true;

    // messages
    Log(payLog, INFO, "%s zamontowa³ %s hydraulikê na pojazd %s za %d$",
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetVehicleLogName(vehicleID), cost
    );

    MruMessageInfoF(playerid, "Zamontowa³eœ graczowi %s hydraulike (-%d$)", GetNick(giveplayerid), cost);
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s zamontowa³ hydraulike w twoim samochodzie", GetNick(playerid));

    ChatMePrefixed(playerid, "Mechanik", sprintf(
        "wyci¹ga narzêdzia i montuje hydraulike w %s.", VehicleNames[GetVehicleModel(vehicleID) - 400]
    ));

    GameTextForPlayer(playerid, sprintf("~r~-$%d", cost), 5000, 1);
    PlayerPlaySound(playerid, 1141, 0.0, 0.0, 0.0);
    if(giveplayerid != playerid)
    {
        IncreasePlayerJobSkill(playerid, JOB_MECHANIC, 2);
        PlayerPlaySound(giveplayerid, 1141, 0.0, 0.0, 0.0);
    }
    return 1;
}

//end