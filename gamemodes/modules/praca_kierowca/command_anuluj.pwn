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

//-----------------<[ Obs³uga komendy /anuluj: ]>-------------------
anuluj_taxi(playerid)
{
    if(TaxiCall < 999 ||  TaxiCallTime[playerid] > 0)
    {
        if(TransportDuty[playerid] == 1 && TaxiCallTime[playerid] > 0)
        {
            GameTextForPlayer(TaxiAccepted[playerid], "~w~Kierowca anulowal~n~~r~wezwanie", 5000, 1);
            TaxiAccepted[playerid] = 999;
            GameTextForPlayer(playerid, "~w~Anulowales~n~~r~Wezwanie", 5000, 1);
            TaxiCallTime[playerid] = 0;
            DisablePlayerCheckpoint(playerid);
            TaxiCall = 999;
        }
        else
        {
            if(IsPlayerConnected(TaxiCall)) { if(TaxiCall == playerid) { TaxiCall = 999; } }
            foreach(new i : Player)
            {
                if(IsPlayerConnected(i))
                {
                    if(TaxiAccepted[i] < 999)
                    {
                        if(TaxiAccepted[i] == playerid)
                        {
                            TaxiAccepted[i] = 999;
                            GameTextForPlayer(i, "~w~Klient~n~~r~Anulowal wezwanie", 5000, 1);
                            SendClientMessage(TaxiCall, COLOR_RED, "Klient Anulowal wezwanie");
                            TaxiCallTime[i] = 0;
                            DisablePlayerCheckpoint(i);
                            DisablePlayerCheckpoint(TaxiCall);

                        }
                    }
                }
            }
        }
    }
}

// anluowanie wezwania taxi
anuluj_taxicall(playerid)
{
    if(PlayerInfo[playerid][pMember]==10 || PlayerInfo[playerid][pLider]==10)
    {
        if(TaxiCall < 999)
        {
            if(TransportDuty[playerid] == 1 && TaxiCallTime[playerid] > 0)
            {
                TaxiAccepted[playerid] = 999;
                GameTextForPlayer(playerid, "~w~Anulowano~n~~r~wezwanie", 5000, 1);
                TaxiCallTime[playerid] = 0;
                DisablePlayerCheckpoint(playerid);
                TaxiCall = 999;
                DisablePlayerCheckpoint(TaxiCall);
                }
                else
                {
                if(IsPlayerConnected(TaxiCall)) { if(TaxiCall == playerid) { TaxiCall = 999; } }
                foreach(new i : Player)
                {
                    if(IsPlayerConnected(i))
                    {
                        if(TaxiAccepted[i] < 999)
                        {
                            if(TaxiAccepted[i] == playerid)
                            {
                                TaxiAccepted[i] = 999;
                                GameTextForPlayer(i, "~r~Anulowano wezwanie", 5000, 1);
                                TaxiCallTime[i] = 0;
                                DisablePlayerCheckpoint(i);
                            }
                            }
                        }
                    }
                }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ kierowc¹ / pracownikiem Korporacji Transportowej !");
        }
    }
}

anuluj_bus(playerid)
{
    if(BusCall < 999)
    {
        if(TransportDuty[playerid] == 2 && BusCallTime[playerid] > 0)
        {
            BusAccepted[playerid] = 999;
            GameTextForPlayer(playerid, "~w~Anulowales~n~~r~Wezwanie", 5000, 1);
            BusCallTime[playerid] = 0;
            DisablePlayerCheckpoint(playerid);
            BusCall = 999;
            DisablePlayerCheckpoint(BusCall);
        }
        else
        {
            if(IsPlayerConnected(BusCall)) { if(BusCall == playerid) { BusCall = 999; } }
            foreach(new i : Player)
            {
                if(IsPlayerConnected(i))
                {
                    if(BusAccepted[i] < 999)
                    {
                        if(BusAccepted[i] == playerid)
                        {
                            BusAccepted[i] = 999;
                            GameTextForPlayer(BusCall, "~w~Klient~n~~r~Anulowal wezwanie", 5000, 1);
                            SendClientMessage(BusCall, COLOR_RED, "Klient Anulowal wezwanie");
                            BusCallTime[i] = 0;
                            DisablePlayerCheckpoint(i);
                            DisablePlayerCheckpoint(BusCall);
                        }
                    }
                }
            }
        }
    }
}