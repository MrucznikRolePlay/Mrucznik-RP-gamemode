//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ naprawpojazd ]-----------------------------------------------//
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
// Autor: werem
// Data utworzenia: 25.02.2020

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/
YCMD:naprawpojazd(playerid, params[], help)
{
    new vehicleid = GetClosestCar(playerid, 1.2);
    new Float:health;
    new string[128];
    GetVehicleHealth(vehicleid, health);
    if(vehicleid == -1) return SendClientMessage(playerid, COLOR_RED, "Nie znaleziono aut w pobli¿u.");
    if(health >= 400) return SendClientMessage(playerid, COLOR_RED, "Auto nie wymaga naprawy!(<40hp)");
    if(GetPlayerState(playerid) == 1)
    {
        format(string, sizeof(string), "* %s naprawia auto z u¿yciem podrêcznego zestawu.", GetNick(playerid));
		ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        new timer = SetTimerEx("ZestawNaprawczy_CountDown", 1000, true, "ii", playerid, vehicleid);
    	SetPVarInt(playerid, "timer_ZestawNaprawczy", timer);
    }
    else SendClientMessage(playerid, COLOR_RED, "Musisz wyjsæ z auta.");
    
    return 1;
}