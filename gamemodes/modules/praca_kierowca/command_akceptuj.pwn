//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               praca_kierowca                                              //
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
//Opis:
/*
	Praca kierowcy.
*/

//

//-----------------<[ Obs³uga komendy /akceptuj: ]>-------------------
akceptuj_taxi(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
    if(TransportDuty[playerid] != 1)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ taksówkrzem !");
        return 1;
    }
    if(TaxiCallTime[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
        return 1;
    }
    if(TaxiCall < 999)
    {
        if(IsPlayerConnected(TaxiCall))
        {
            format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, jedŸ do czerwonego markera.", GetNick(TaxiCall));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "* Taksówkarz %s akceptowa³ twoje zlecenie, czekaj na niego i nie ruszaj siê z miejsca.", GetNick(playerid));
            SendClientMessage(TaxiCall, COLOR_LIGHTBLUE, string);
            GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerwonego punktu", 5000, 1);
            TaxiCallTime[playerid] = 1;
            TaxiAccepted[playerid] = TaxiCall;
            TaxiCall = 999;
            return 1;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia³ taksówki !");
        return 1;
    }
    return 1;
}

akceptuj_heli(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
    if(TransportDuty[playerid] != 1)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ pilotem !");
        return 1;
    }
    new newcar = GetPlayerVehicleID(playerid);
    if(!IsAPlane(newcar))
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie pilotujesz helikoptera !");
        return 1;
    }
    if(TaxiCallTime[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
        return 1;
    }
    if(HeliCall < 999)
    {
        if(IsPlayerConnected(HeliCall))
        {
            format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, leæ do czerwonego markera.", GetNick(HeliCall));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "* Pilot %s akceptowa³ twoje zlecenie, czekaj na niego i nie ruszaj siê z miejsca.", GetNick(playerid));
            SendClientMessage(HeliCall, COLOR_LIGHTBLUE, string);
            GameTextForPlayer(playerid, "~w~Lec do~n~~r~czerwonego punktu", 5000, 1);
            TaxiCallTime[playerid] = 1;
            TaxiAccepted[playerid] = HeliCall;
            HeliCall = 999;
            return 1;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia³ helikoptera !");
        return 1;
    }
    return 1;
}

akceptuj_bus(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
    if(TransportDuty[playerid] != 2)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie jesteœ kierowc¹ autobusu na s³u¿bie !");
        return 1;
    }
    if(BusCallTime[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Masz ju¿ zlecenie !");
        return 1;
    }
    if(GetPlayerJob(playerid) == JOB_DRIVER && PlayerInfo[playerid][pCarSkill] < 400)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Potrzebujesz 5 skilla kierowcy autobusu aby móc odbieraæ wezwania !");
        return 1;
    }
    if(BusCall < 999)
    {
        if(IsPlayerConnected(BusCall))
        {
            format(string, sizeof(string), "* Akceptowa³eœ zlecenie od %s, jedŸ do czerwonego markera.", GetNick(BusCall));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "* Kierowca Autobusu %s akceptowa³ twoje wezwanie, czekaj na niego i nie ruszaj siê z miejsca.", GetNick(playerid));
            SendClientMessage(BusCall, COLOR_LIGHTBLUE, string);
            new Float:X,Float:Y,Float:Z;
            GetPlayerPos(BusCall, X, Y, Z);
            SetPlayerCheckpoint(playerid, X, Y, Z, 5);
            GameTextForPlayer(playerid, "~w~Jedz do~n~~r~czerwonego punktu", 5000, 1);
            BusCallTime[playerid] = 1;
            BusAccepted[playerid] = BusCall;
            BusCall = 999;
            return 1;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie dzwoni³ po autobus !");
        return 1;
    }
    return 1;
}