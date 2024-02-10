//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  lidercar                                                 //
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
// Data utworzenia: 10.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_lidercar_Impl(playerid, akcja[16], opcje[256])
{
    if(!orgIsLeader(playerid) && PlayerInfo[playerid][pLider] == 0)
    {
        sendErrorMessage(playerid, "Nie jesteœ liderem!");
        return 1;
    }

	if(!IsPlayerInAnyVehicle(playerid))
	{
        sendErrorMessage(playerid, "Musisz byæ w pojeŸdzie, który chcesz edytowaæ!");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(playerid);
    new vehicleUID = VehicleUID[vehicleID][vUID];
    new lider = PlayerInfo[playerid][pLider];
    new org = gPlayerOrg[playerid];

    new liderOwner = CarData[vehicleUID][c_OwnerType] == CAR_OWNER_FRACTION && \
        lider == CarData[vehicleUID][c_Owner] && 
        lider > 0;
    new orgOwner = CarData[vehicleUID][c_OwnerType] == CAR_OWNER_FAMILY && \
        gPlayerOrgLeader[playerid] == CarData[vehicleUID][c_Owner] && \
        org > 0;

	if(!liderOwner && !orgOwner)
	{
        sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Twojej organizacji!");
        return 1;
    }

    // choose command action
	if(strcmp(akcja, "parkuj", true) == 0) {
        command_lidercar_parkuj(playerid);
    } else if(strcmp(akcja, "przemaluj", true) == 0) {
        command_lidercar_przemaluj(playerid, vehicleID, opcje);
    } else if(strcmp(akcja, "ranga", true) == 0) {
        command_lidercar_ranga(playerid, vehicleUID, opcje);
    } /*else if(strcmp(akcja, "opis", true) == 0) {
        command_lidercar_opis(playerid, vehicleID, vehicleUID, lider, org, opcje);
    }*/ else {
        sendErrorMessage(playerid, "Niepoprawna opcja!");
        Command_ReProcess(playerid, "lidercar", true);
    }

    return 1;
}

command_lidercar_parkuj(playerid)
{
    Command_ReProcess(playerid, "zaparkuj", false);
    return 1;
}

command_lidercar_przemaluj(playerid, vehicleID, opcje[256])
{
    new color1, color2;
    if(sscanf(opcje, "dd", color1, color2))
    {
        sendTipMessage(playerid, "U¿yj /lidercar przemaluj [kolor 1] [kolor 2]");
        sendTipMessage(playerid, "Uwaga! Koszt przemalowania: 1500$");
        return 1;
    }

    // change color
    ChangeVehicleColor(vehicleID, color1, color2);
    MRP_ChangeVehicleColor(vehicleID, color1, color2);

    // send message, take money
    SendClientMessage(playerid, COLOR_PINK, "Pojazd przemalowany! -1500$");
    ZabierzKase(playerid, 1500);
    return 1;
}

command_lidercar_ranga(playerid, vehicleUID, opcje[256])
{
    new rank;
    if(sscanf(opcje, "d", rank))
    {
        sendTipMessage(playerid, "U¿yj /lidercar ranga [ranga od której mo¿na u¿ywaæ pojazdu]");
        return 1;
    }

    // save rank
    CarData[vehicleUID][c_Rang] = rank;
    Car_Save(vehicleUID, CAR_SAVE_OWNER);

    // send message
    new string[128];
    format(string, sizeof(string), "Od teraz tylko osoby z %d rang¹ bêd¹ mog³y u¿ywaæ tego pojazdu.", rank);
    SendClientMessage(playerid, COLOR_PINK, string);
    return 1;
}

// command_lidercar_opis(playerid, vehicleID, vehicleUID, lider, org, opcje[256])
// {
//     new description[256];
//     if(sscanf(opcje, "s[256]", description))
//     {
//         sendTipMessage(playerid, "U¿yj /lidercar opis [opis pojazdu]");
//         return 1;
//     }

//     // change description

//     // send message
//     new string[256];
//     format(string, sizeof(string), "Nowy opis pojazdu: %s", description);
//     SendClientMessage(playerid, COLOR_PINK, string);
// }

//end