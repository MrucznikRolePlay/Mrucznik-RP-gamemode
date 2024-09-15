//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   felga                                                   //
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
// Data utworzenia: 01.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_felga_Impl(playerid, giveplayerid, felga)
{
    new cost = 15_000;
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
        MruMessageFail(playerid, "Musisz mieæ 3 skill mechanika aby montowaæ felgi.");
        return 1;
    }

    // helper variables
    new vehicleID = GetPlayerVehicleID(giveplayerid);
    new vehicleUID = VehicleUID[vehicleID][vUID];
    new componentID = felga + 1072;
    if(componentID >= 1086 && componentID <= 1088)
    {
        componentID += 10;
    }
    else if(felga == 17)
    {
        componentID = 1025;
    }

    // functionality
    AddVehicleComponent(vehicleID, componentID); //felga1079
    CarData[vehicleUID][c_Felgi] = componentID;
    ZabierzKase(playerid, cost);

    // messages
    Log(payLog, INFO, "%s zamontowa³ %s felgi %d na pojazd %s za %d$",
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), felga, GetVehicleLogName(vehicleID), cost
    );

    MruMessageGoodInfoF(playerid, "Zamontowa³eœ nowe felgi graczowi %s (koszt -%d$)", GetNick(giveplayerid), cost);
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s zamontowa³ ci w twoim %s nowe felgi", GetNick(playerid), VehicleNames[GetVehicleModel(vehicleID)-400]);

    ChatMePrefixed(playerid, "Mechanik", sprintf(
        "wyci¹ga narzêdzia i montuje nowe felgi w %s.", VehicleNames[GetVehicleModel(vehicleID)-400]
    ));
    
    GameTextForPlayer(playerid, sprintf("~r~-$%d", cost), 5000, 1);
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
   
    if(giveplayerid != playerid)
    {
        IncreasePlayerJobSkill(playerid, JOB_MECHANIC, 3);
        PlayerPlaySound(giveplayerid, 1133, 0.0, 0.0, 0.0);
    }
    return 1;
}

//end