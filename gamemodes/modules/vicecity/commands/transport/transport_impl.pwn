//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 transport                                                 //
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
// Data utworzenia: 18.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_transport_Impl(playerid)
{
    if(command_transport_checks(playerid))
    {
        return 1;
    }

    command_transport_ShowDialog(playerid);
    return 1;
}

command_transport_checks(playerid)
{
    if(!IsPlayerInAnyVehicle(playerid))
    {
        MruMessageFail(playerid, "Musisz by� w poje�dzie by u�y� tej komendy.");
        return 1;
    }

    if(!GetPlayerShippingPlace(playerid))
    {
        MruMessageFail(playerid, "Musisz by� przy terminalu baga�owym w Los Santos lub przy Vice City Cargo Terminal.");
        return 1;
    }

    new vehicleID = GetPlayerVehicleID(playerid);
    if(!IsCarOwner(playerid, vehicleID) && !IsPlayerOwnFractionCar(playerid, vehicleID)) 
    { 
        MruMessageFail(playerid, "Mo�esz transportowa� tylko pojazdy, kt�rych jeste� w�a�cicielem.");
        return 1;
    }

    if(kaska[playerid] < VEHICLE_TRANSPORT_COST)
    {
        MruMessageFailF(playerid, "Nie sta� ci�, transport pojazdu kosztuje %d$.", VEHICLE_TRANSPORT_COST);
        return 1;
    }
    return 0;
}

command_transport_ShowDialog(playerid)
{
    new terminalType = GetPlayerShippingPlace(playerid);

    ShowPlayerDialogEx(playerid, 7110, DIALOG_STYLE_MSGBOX, "Transport samochodu", 
        sprintf("Tutaj mo�esz zleci� transport swojego pojazdu %s!\nPo zleceniu transportu, Tw�j pojazd pojawi si� na jednym z parking�w w dokach\na Ty zostaniesz przetransportowany wraz z nim.\nKoszt: $%d", GetTransportDestinationName(terminalType), VEHICLE_TRANSPORT_COST),
        "Transportuj", "Wyjd�");
}

command_transport_OnDialogResp(playerid, dialogid, response, listitem, inputtext[])
{
    #pragma unused listitem, inputtext
    if(dialogid == 7110)
    {
        if(response)
        {
            if(command_transport_checks(playerid))
            {
                return 1;
            }
            new terminalType = GetPlayerShippingPlace(playerid);
            TransportPlayerVehicle(playerid, terminalType);

            MruMessageGoodInfoF(playerid, "Tw�j pojazd zosta� przetransportowany %s! Zostajesz przetransportowany razem z nim.", GetTransportDestinationName(terminalType));
            GameTextForPlayer(playerid, sprintf("~r~-%d$", VEHICLE_TRANSPORT_COST), 5000, 1);

            ZabierzKase(playerid, VEHICLE_TRANSPORT_COST);
            Log(payLog, INFO, "%s przetransportowa� auto %s za %d$", GetPlayerLogName(playerid), GetVehicleLogName(GetPlayerVehicleID(playerid)), VEHICLE_TRANSPORT_COST);
        }
        return 1;
    }
    return 0;
}

TransportPlayerVehicle(playerid, terminalType)
{
    GetTransportDestinationName(terminalType);

    new Float:x, Float:y, Float:z, Float:a;
    switch(terminalType)
    {
        case 1: // From Los Santos to Vice City
        {
            new rand = random(sizeof(ViceCityVehCargoParking));
            x = ViceCityVehCargoParking[rand][0];
            y = ViceCityVehCargoParking[rand][1];
            z = ViceCityVehCargoParking[rand][2];
            a = ViceCityVehCargoParking[rand][3];
        }
        case 2: // From Vice City to Los Santos
        {
            new rand = random(sizeof(LosSantosVehCargoParking));
            x = LosSantosVehCargoParking[rand][0];
            y = LosSantosVehCargoParking[rand][1];
            z = LosSantosVehCargoParking[rand][2];
            a = LosSantosVehCargoParking[rand][3];
        }
    }
    
    new vehicleID = GetPlayerVehicleID(playerid);
    new vehicleUID = VehicleUID[vehicleID][vUID];
    RemovePlayerFromVehicle(playerid);
    SetPlayerPos(playerid, x, y, z);
	defer TeleportVehicle(playerid, vehicleID, vehicleUID, x, y, z, a);
}

timer TeleportVehicle[2500](playerid, vehicleID, vehicleUID, Float:x, Float:y, Float:z, Float:a)
{
	CarData[vehicleUID][c_Pos][0] = x;
	CarData[vehicleUID][c_Pos][1] = y;
	CarData[vehicleUID][c_Pos][2] = z;
	CarData[vehicleUID][c_Rot] = a;
	CarData[vehicleUID][c_VW] = 0; 
	Car_Save(vehicleUID, CAR_SAVE_STATE);

    Car_Unspawn(vehicleID);
    new vehicleid = Car_Spawn(vehicleUID);
    PutPlayerInVehicle(playerid, vehicleid, 0);
}

//end