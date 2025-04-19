//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                naprawpojazd                                               //
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
command_naprawpojazd_Impl(playerid)
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
		SetPVarInt(playerid, "Use_ZestawNaprawczy", 1);
        ZestawNaprawczy_CountDown(playerid, vehicleid);
    }
    else SendClientMessage(playerid, COLOR_RED, "Musisz wyjsæ z auta.");
    return 1;
}

public ZestawNaprawczy_CountDown(playerid, vehicleid)
{
    if(GetPVarInt(playerid, "Use_ZestawNaprawczy") == 0)
    {
        return 1;
    }
    
	new Float:pos[3];
	new string[128];
	GetVehiclePos(vehicleid, pos[0],pos[1],pos[2]);
	if(GetVehicleSpeed(vehicleid) > 10)
	{
		ZestawNaprawczy_Warning[playerid] = 8;
	}
	if(ZestawNaprawczy_Warning[playerid] == 8)
	{
		SendClientMessage(playerid, COLOR_PANICRED, "* [ZESTAW NAPRAWCZY] Anulowano naprawê pojazdu.");
		ZestawNaprawczy_Timer[playerid] = 30;
		ZestawNaprawczy_Warning[playerid] = 0;
		DeletePVar(playerid, "Use_ZestawNaprawczy");
		return 1;
	}
	if (ZestawNaprawczy_Timer[playerid] > 0)
	{
		if (IsPlayerInRangeOfPoint(playerid, 3.0, pos[0], pos[1], pos[2]))
		{
			format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~y~Pozostalo %ds", ZestawNaprawczy_Timer[playerid]);
			GameTextForPlayer(playerid, string, 2500, 3);
			SetPlayerChatBubble(playerid, "** naprawia pojazd **", COLOR_PURPLE, 30.0, 2500);
			ZestawNaprawczy_Timer[playerid]--;
			ZestawNaprawczy_Warning[playerid] = 0;
			SetTimerEx("ZestawNaprawczy_CountDown", 1000, false, "ii", playerid, vehicleid);
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, pos[0], pos[1], pos[2]))
		{
			format(string, sizeof(string), "~n~~n~~n~~n~~n~~n~~r~Podejdz do auta! %ds", 8-ZestawNaprawczy_Warning[playerid]);
			GameTextForPlayer(playerid, string, 2500, 3);
			ZestawNaprawczy_Warning[playerid]++;
			SetTimerEx("ZestawNaprawczy_CountDown", 1000, false, "ii", playerid, vehicleid);
		}
		else
		{
			SendClientMessage(playerid, COLOR_PANICRED, "* [ZESTAW NAPRAWCZY] Anulowano naprawê pojazdu. Nie by³eœ w dostatecznie blisko pojazdu.");
			ZestawNaprawczy_Timer[playerid] = 30;
			ZestawNaprawczy_Warning[playerid] = 0;
			DeletePVar(playerid, "Use_ZestawNaprawczy");
		}
	}
	else
	{
		GameTextForPlayer(playerid, "~g~Naprawiono!", 2500, 6);
		ZestawNaprawczy_Timer[playerid] = 30;
		ZestawNaprawczy_Warning[playerid] = 0;
		PlayerInfo[playerid][pFixKit]--;
		RepairVehicle(vehicleid);
        SetVehicleHealth(vehicleid, 1000);
		CarData[VehicleUID[vehicleid][vUID]][c_HP] = 1000.0;
		DeletePVar(playerid, "Use_ZestawNaprawczy");
	}
	return 1;
}

//end