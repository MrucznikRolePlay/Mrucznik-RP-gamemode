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

    new bool:opcjaParkuj = strcmp(akcja, "parkuj", true) == 0;
    new bool:opcjaPrzemaluj = strcmp(akcja, "przemaluj", true) == 0;
    new bool:opcjaRanga = strcmp(akcja, "ranga", true) == 0;
    new bool:opcjaPrzejmij = strcmp(akcja, "przejmij", true) == 0;
    new bool:checkFractionOwnership = opcjaParkuj || opcjaPrzemaluj || opcjaRanga;
    new bool:checkPlayerOwnership = opcjaPrzejmij;

    new vehicleID = GetPlayerVehicleID(playerid);
    new vehicleUID = VehicleUID[vehicleID][vUID];
	if(checkFractionOwnership && !IsPlayerOwnFractionCar(playerid, vehicleID))
	{
        sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Twojej organizacji!");
        return 1;
    }

    if(checkPlayerOwnership && !IsCarOwner(playerid, vehicleID))
    {
        sendErrorMessage(playerid, "Ten pojazd nie nale¿y do Ciebie!");
        return 1;
    }

    if(strcmp(akcja, "", true) != 0)
        Log(serverLog, INFO, "Lider %s u¿y³ /lidercar, akcja: %s, pojazd %s", GetPlayerLogName(playerid), akcja, GetVehicleLogName(vehicleID));

    // choose command action
	if(opcjaParkuj) {
        command_lidercar_parkuj(playerid);
    } else if(opcjaPrzemaluj) {
        command_lidercar_przemaluj(playerid, vehicleID, opcje);
    } else if(opcjaRanga) {
        command_lidercar_ranga(playerid, vehicleUID, opcje);
    } else if(opcjaPrzejmij) {
        command_lidercar_przejmij(playerid, vehicleUID);
    } else {
        sendErrorMessage(playerid, "Niepoprawna opcja!");
        StaryCzas[playerid] -= 200;
        Command_ReProcess(playerid, "lidercar", true);
    }

    return 1;
}

command_lidercar_parkuj(playerid)
{
    StaryCzas[playerid] -= 200;
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

    if(rank < 0 || rank > 9) 
    {
        sendErrorMessage(playerid, "Ranga od 0 do 9!");
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

command_lidercar_przejmij(playerid, vehicleUID)
{
    if(PlayerInfo[playerid][pLider] != 0 )
    {
        CarData[vehicleUID][c_OwnerType] = CAR_OWNER_FRACTION;
        CarData[vehicleUID][c_Owner] = PlayerInfo[playerid][pLider];
    }
    else if(orgIsLeader(playerid))
    {
        CarData[vehicleUID][c_OwnerType] = CAR_OWNER_FAMILY;
        CarData[vehicleUID][c_Owner] = gPlayerOrg[playerid];
    }
    else
    {
        return 1;
    }

    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == vehicleUID)
        {
            PlayerInfo[playerid][pCars][i] = 0;
        }
    }
    Car_Save(vehicleUID, CAR_SAVE_OWNER);

    // send message
    new string[128];
    format(string, sizeof(string), "Od teraz Twoja frakcja jest w³aœcicielem tego pojazdu.");
    SendClientMessage(playerid, COLOR_PINK, string);
    return 1;
}

//end