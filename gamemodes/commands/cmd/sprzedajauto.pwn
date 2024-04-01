//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ sprzedajauto ]---------------------------------------------//
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

YCMD:sprzedajauto(playerid, params[], help)
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

	if(IsPlayerInAnyVehicle(playerid))
    {
   		new playa, cena;
		if( sscanf(params, "k<fix>s[32]", playa, string))
		{
			sendTipMessage(playerid, "U¿yj /dajauto [Nick/ID] [cena]");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo¿esz tego u¿yæ  podczas @Duty! ZejdŸ ze s³u¿by u¿ywaj¹c /adminduty");
			return 1;
		}
        if(GetPVarInt(playa, "CanDoIt") == 1) return sendErrorMessage(playerid, "Ten gracz otrzyma³ ju¿ ofertê kupna pojazdu! Zaczekaj 15 sekund");
        if(!IsPlayerConnected(playa)) return sendErrorMessage(playerid, "Brak takiego gracza.");
		cena = FunkcjaK(string);
		//
        new lVeh = GetPlayerVehicleID(playerid);
		if(!IsCarOwner(playerid, lVeh)) return sendTipMessage(playerid, "Nie jesteœ w³aœcicielem tego pojazdu.");
		if(PlayerInfo[playa][pLevel] == 1) return sendTipMessage(playerid, "Nie mo¿esz sprzedaæ temu graczowi pojazdu poniewa¿ ma 1lvl");
		if(PlayerInfo[playerid][pLevel] == 1) return sendTipMessage(playerid, "Nie mo¿esz sprzedawaæ pojazdu bo masz 1 lvl");
		if(GetPVarInt(playerid, "CanDoIt") == 1) return sendErrorMessage(playerid, "Oferowa³eœ ju¿ komuœ zakup auta, odczekaj 15 s");
        new vehid = VehicleUID[lVeh][vUID];
 		if(GetDistanceBetweenPlayers(playerid,playa) > 5) return sendErrorMessage(playerid, "Ten gracz jest za daleko!");
		if(!(cena > 0 && cena < 900000001)) return sendErrorMessage(playerid, "Cena od 1 do 900 000 000$ !");

        if(Car_IsStealable(lVeh)) return sendErrorMessage(playerid, "Tego pojazdu nie mo¿na sprzedaæ");

	    if(kaska[playa] == 0) return sendErrorMessage(playerid, "B³¹d");

		if(playa == INVALID_PLAYER_ID || playerid == playa) return 1;
		
	    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));

        //SetPVarInt(playa, "offer-car", gettime() + 30);
		odczekajTimer[playa] = SetTimerEx("odczekaj15sec", 15000, false, "i", playa);
		SetPVarInt(playa, "CanDoIt", 1);
		SetPVarInt(playa, "WhatToDo", 1);
		SetPVarInt(playerid, "WhatToDo", 2);
		SetPVarInt(playerid, "CanDoIt", 1);
		odczekajTimer[playerid] = SetTimerEx("odczekaj15sec", 15000, false, "i", playerid);
	    format(string, sizeof(string), "%s oferuje ci sprzeda¿ %s za %d$. Jeœli chcesz kupiæ to auto wpisz /akceptuj pojazd aby kupiæ.", sendername, VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400], cena);
        SendClientMessage(playa, 0xFFC0CB, string);
        //TODO
        if(!IsPlayerPremiumOld(playa))
        {
            if(CarData[vehid][c_Neon] != 18652 && CarData[vehid][c_Neon] != 0)
            {
                SendClientMessage(playa, 0xFF0000FF, "UWAGA!: Ten samochód ma kolorowe neony dostêpne tylko dla kont premium. Gdy zakupisz to auto neony automatycznie zmieni¹ kolor na {FFFFFF}bia³y!");
            }
        }
        format(string, sizeof(string), "Oferujesz %s kupno twojego %s za %d$", giveplayer, VehicleNames[GetVehicleModel(lVeh)-400], cena);
        SendClientMessage(playerid, 0xFFC0CB, string);
        GraczDajacy[playa] = playerid;
		CenaDawanegoAuta[playa] = cena;
		IDAuta[playa] = vehid;
	}
 	else
 	{
		sendTipMessage(playerid, "Nie jesteœ w pojeŸdzie");
    }
	return 1;
}
