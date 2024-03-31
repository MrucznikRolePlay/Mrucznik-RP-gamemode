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
command_nos_Impl(playerid, giveplayerid)
{
    // permissions, validation
    if(!IsAMechazordWarsztatowy(playerid) && PlayerInfo[playerid][pJob] != 7)
    {
        MruMessageFail(playerid, "Nie jesteœ mechanikiem lub pracownikiem warsztatu.");
        return 1;
    }

    if(!IsAtWarsztat(playerid)) 
    {
        MruMessageFail(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
        return 1;
    }

    if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 10)
    {
        MruMessageFail(playerid, "Gracz nie jest za daleko");
        return 1;
    }

    if(!IsPlayerInAnyVehicle(giveplayerid))
    {
        MruMessageFail(playerid, "Gracz nie jest w samochodzie");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(giveplayerid);
    if(!IsCarOwner(giveplayerid, vehicleID))
    {
        MruMessageFail(playerid, "Ten pojazd nie nale¿y do tego gracza.");
        return 1;
    }

    new cost = 5000;
    if(IsAMechazordWarsztatowy(playerid))
    {
        cost /= 2;
    }
    if(kaska[playerid] < cost)
    {
        MruMessageFailF(playerid, "Nie masz wystarczaj¹cej iloœci pieniêdzy (%d$)", cost);
        return 1;
    }

    // helper variables
    new nitroSize, nitroComponentID;
    switch(GetPlayerSkill(playerid, JOB_MECHANIC))
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
    Log(payLog, INFO, "Gracz %s zamontowa³ %s nitro na pojazd %s za %d$",
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetVehicleLogName(vehicleID), cost
    );

    MruMessageInfoF(playerid, "Zamontowa³eœ graczowi %s nitro(pojemnoœæ: %d) w jego samochodzie [-%d$] (wiêkszy skill = wiêksza pojemnoœæ)", GetNick(giveplayerid), nitroSize, cost);
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s zamontowa³ nitro o pojemnoœci %d w twoim samochodzie", GetNick(playerid), nitroSize);

    ChatMePrefixed(playerid, "Mechanik",
        sprintf("%s wyci¹ga narzêdzia i montuje nitro w %s.", 
        GetNick(playerid), VehicleNames[GetVehicleModel(vehicleID)-400]
    ));

    GameTextForPlayer(playerid, sprintf("~r~-$%d", cost), 5000, 1);
    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
    if(giveplayerid != playerid)
    {
        PlayerInfo[playerid][pMechSkill] ++;
        MruMessageSkillInfo(playerid, "Skill +1");
        PlayerPlaySound(giveplayerid, 1133, 0.0, 0.0, 0.0);
    }
    return 1;
}

//end