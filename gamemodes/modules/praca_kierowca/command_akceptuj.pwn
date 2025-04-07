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

//-----------------<[ Obs�uga komendy /akceptuj: ]>-------------------
akceptuj_taxi(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
    if(TransportDuty[playerid] != 1)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� taks�wkrzem !");
        return 1;
    }
    if(TaxiCallTime[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
        return 1;
    }
    if(TaxiCall < 999)
    {
        if(IsPlayerConnected(TaxiCall))
        {
            format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, jed� do czerwonego markera.", GetNick(TaxiCall));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "* Taks�wkarz %s akceptowa� twoje zlecenie, czekaj na niego i nie ruszaj si� z miejsca.", GetNick(playerid));
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
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia� taks�wki !");
        return 1;
    }
    return 1;
}

akceptuj_heli(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
    if(TransportDuty[playerid] != 1)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� pilotem !");
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
        SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
        return 1;
    }
    if(HeliCall < 999)
    {
        if(IsPlayerConnected(HeliCall))
        {
            format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, le� do czerwonego markera.", GetNick(HeliCall));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "* Pilot %s akceptowa� twoje zlecenie, czekaj na niego i nie ruszaj si� z miejsca.", GetNick(playerid));
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
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie zamawia� helikoptera !");
        return 1;
    }
    return 1;
}

akceptuj_bus(playerid)
{
    new string[MAX_MESSAGE_LENGTH];
    if(TransportDuty[playerid] != 2)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Nie jeste� kierowc� autobusu na s�u�bie !");
        return 1;
    }
    if(BusCallTime[playerid] > 0)
    {
        SendClientMessage(playerid, COLOR_GREY, "   Masz ju� zlecenie !");
        return 1;
    }
    if(BusCall < 999)
    {
        if(IsPlayerConnected(BusCall))
        {
            format(string, sizeof(string), "* Akceptowa�e� zlecenie od %s, jed� do czerwonego markera.", GetNick(BusCall));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string), "* Kierowca Autobusu %s akceptowa� twoje wezwanie, czekaj na niego i nie ruszaj si� z miejsca.", GetNick(playerid));
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
        SendClientMessage(playerid, COLOR_GREY, "   Nikt nie dzwoni� po autobus !");
        return 1;
    }
    return 1;
}