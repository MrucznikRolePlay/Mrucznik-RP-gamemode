//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------[ disabletruckerjob ]-------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

CMD:disabletruckerjob(playerid)
{
    if(PlayerInfo[playerid][pAdmin] != 5000) return 1;
    if(!GLOBAL_DISABLETRUCKER) GLOBAL_DISABLETRUCKER = true;
    else GLOBAL_DISABLETRUCKER = false;
    SendClientMessage(playerid, COLOR_GRAD2, " OK");
    return 1;
}

/*CMD:rentcar(playerid)
{
    if(HireCar[playerid] == 0) return 1;
    if(PlayerInfo[playerid][pDonateRank] == 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten pojazd wypo¿yczyæ mo¿e tylko Konto Premium!");
    new veh = GetPlayerVehicleID(playerid);
    if(veh == 0) return 1;
    if(Car_GetOwner(veh) != RENT_CAR || Car_GetOwnerType(veh) != CAR_OWNER_SPECIAL) return sendTipMessageEx(playerid, COLOR_GRAD2, "Tego pojazdu nie mo¿na wypo¿yczyæ.");
    if(CarData[VehicleUID[veh][vUID]][c_Rang] != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten pojazd jest aktualnie wypo¿yczony przez inn¹ osobê.");
    if(GetPVarInt(playerid, "rentTimer") != 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Aktualnie wypo¿yczasz pewien pojazd.");

    CarData[VehicleUID[veh][vUID]][c_Rang] = (playerid+1);

    SetPVarInt(playerid, "rentTimer", SetTimerEx("UnhireRentCar", 15*60*1000, 0, "ii", playerid, veh));

    sendTipMessageEx(playerid, COLOR_YELLOW, "Wypo¿yczy³es pojazd na 15 minut.");
    TogglePlayerControllable(playerid, 1);
    DajKase(playerid, -5000);
    HireCar[playerid] = veh;
    SetPVarInt(playerid, "rentCar", veh);
    return 1;
}*/


