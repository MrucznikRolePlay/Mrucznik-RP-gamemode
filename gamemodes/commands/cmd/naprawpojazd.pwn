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
    if(PlayerInfo[playerid][pFixKit] <= 0) return SendClientMessage(playerid, COLOR_RED, "Nie masz ¿adnych zestawów do naprawy aut. Zakupisz je u mechanika!");
    new vehicleid = GetClosestCar(playerid, 4.0);
    new string[128];
    if(vehicleid == -1) return SendClientMessage(playerid, COLOR_RED, "Nie znaleziono aut w pobli¿u.");
    if(GetPVarInt(playerid, "Use_ZestawNaprawczy")) return SendClientMessage(playerid, COLOR_RED, "Naprawiasz ju¿ pojazd.");
    if(GetPlayerState(playerid) == 1)
    {
        format(string, sizeof(string), "* %s naprawia auto z u¿yciem podrêcznego zestawu.", GetNick(playerid));
        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        format(string, sizeof(string), "Rozpoczêto naprawê pojazdu (ID: [%d]). Aby anulowaæ odejdŸ od pojazdu.", vehicleid);
        SendClientMessage(playerid, COLOR_RED, string);
        ZestawNaprawczy_Timer[playerid] = 30;
		ZestawNaprawczy_Warning[playerid] = 0;
        ZestawNaprawczy_CountDown(playerid, vehicleid);
        SetPVarInt(playerid, "Use_ZestawNaprawczy", 1);
    }
    else SendClientMessage(playerid, COLOR_RED, "Musisz wyjsæ z auta.");
    
    return 1;
}