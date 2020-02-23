//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 nawigacja                                                 //
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
// Autor: Simeone
// Data utworzenia: 09.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mnawigacja_Impl(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid))
    {
        sendErrorMessage(playerid, "Nie jesteœ w pojeŸdzie!"); 
        return 1;
    }
    if(GetPlayerVehicleID(playerid) == 448 
    || GetPlayerVehicleID(playerid) == 461 
    || GetPlayerVehicleID(playerid) == 462
    || GetPlayerVehicleID(playerid) == 463
    || GetPlayerVehicleID(playerid) == 468 
    || GetPlayerVehicleID(playerid) == 471 
    || GetPlayerVehicleID(playerid) == 481
    || GetPlayerVehicleID(playerid) == 509 
    || GetPlayerVehicleID(playerid) == 510 
    || GetPlayerVehicleID(playerid) == 521 //FCR
    || GetPlayerVehicleID(playerid) == 522//NRG
    || GetPlayerVehicleID(playerid) == 523//HPV
    || GetPlayerVehicleID(playerid) == 531//Tractor 
    || GetPlayerVehicleID(playerid) == 572//turbowózek
    || GetPlayerVehicleID(playerid) == 586//Wayfarer
    || GetPlayerVehicleID(playerid) == 604//Bity 1
    || GetPlayerVehicleID(playerid) == 605)//bity 2
    {
        sendErrorMessage(playerid, "Ten pojazd nie obs³uguje systemu nawigacji!"); 
        return 1;
    }
    if(PlayerInfo[playerid][pNawigacja] != 1)
    {
        sendErrorMessage(playerid, "Nie posiadasz nawigacji!"); 
        return 1;
    }
    ShowNawiDialog(playerid, DIALOG_NAWI_MAIN); 
    return 1;
}

//end