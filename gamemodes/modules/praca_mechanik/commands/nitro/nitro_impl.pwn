//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    nos                                                    //
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
command_nitro_Impl(playerid, giveplayerid)
{
    new cost = 5000;
    if(IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_SPRAY))
    {
        cost /= 2;
    }

    // permission, paarmeters validation
    if(!TuneCommands_CheckRequirements(playerid, giveplayerid, cost))
    {
        return 1;
    }

    // helper variables
    new vehicleID = GetPlayerVehicleID(giveplayerid);
    new nitroSize, nitroComponentID;
    switch(GetPlayerJobSkill(playerid, JOB_MECHANIC))
    {
        case 1:
        {
            nitroComponentID = 1009;
            nitroSize = 2;
        }
        case 2:
        {
            nitroComponentID = 1008;
            nitroSize = 5;
        }
        case 3:
        {
            nitroComponentID = 1010;
            nitroSize = 10;
        }
        case 4:
        {
            nitroComponentID = 1010;
            nitroSize = 10;
        }
        case 5:
        {
            nitroComponentID = 1010;
            nitroSize = 10;
        }
        default:
        {
            nitroComponentID = 1009;
            nitroSize = 2;
        }
    }
    
    // functionality
    ZabierzKase(playerid, cost);
    AddVehicleComponent(vehicleID, nitroComponentID);
    new vehicleUID = VehicleUID[vehicleID][vUID];
    CarData[vehicleUID][c_Nitro] = nitroComponentID;

    // messages
    Log(payLog, INFO, "%s zamontowa³ %s nitro na pojazd %s za %d$",
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetVehicleLogName(vehicleID), cost
    );

    MruMessageGoodInfoF(playerid, "Zamontowa³eœ graczowi %s nitro(pojemnoœæ: %d) w jego samochodzie [-%d$] (wiêkszy skill = wiêksza pojemnoœæ)", GetNick(giveplayerid), nitroSize, cost);
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s zamontowa³ nitro o pojemnoœci %d w twoim samochodzie", GetNick(playerid), nitroSize);

    ChatMePrefixed(playerid, "Mechanik", sprintf(
        "wyci¹ga narzêdzia i montuje nitro w %s.", VehicleNames[GetVehicleModel(vehicleID)-400]
    ));

    GameTextForPlayer(playerid, sprintf("~r~-$%d", cost), 5000, 1);
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
    if(giveplayerid != playerid)
    {
        IncreasePlayerJobSkill(playerid, JOB_MECHANIC, 2);
        PlayerPlaySound(giveplayerid, 1133, 0.0, 0.0, 0.0);
    }
    return 1;
}

//end