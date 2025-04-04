//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wymiana_Impl(playerid, params[256])
{
    new string[256];
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

	if(IsPlayerInAnyVehicle(playerid))
    {
   		new playa, cena;
		if(sscanf(params, "k<fix>s[32]", playa, string))
		{
			sendTipMessage(playerid, "U�yj /wymiana [Nick/ID] [cena]");
			return 1;
		}
		if(GetPlayerAdminDutyStatus(playerid) == 1) return sendErrorMessage(playerid, "Nie mo�esz tego u�y� podczas @Duty");
		if(playerid == playa) return sendErrorMessage(playerid, "Nie mo�esz wymieni� si� z samym sob�.");
        if(!IsPlayerConnected(playa)) return sendErrorMessage(playerid, "Brak takiego gracza.");
        if(!IsPlayerInAnyVehicle(playa)) return sendTipMessage(playerid, "Gracz musi by� w poje�dzie.");
		//
        new lVeh = GetPlayerVehicleID(playerid);
		if(!IsCarOwner(playerid, lVeh)) return sendTipMessage(playerid, "Nie jeste� w�a�cicielem tego pojazdu.");
		if(!IsCarOwner(playa, GetPlayerVehicleID(playa))) return sendTipMessage(playerid, "Gracz nie jest w�a�cicielem pojazdu.");
		if(PlayerInfo[playa][pLevel] == 1) return sendTipMessage(playerid, "Nie mo�esz wymieni� si� z tym graczem, poniewa� ma 1 lvl");
		if(PlayerInfo[playerid][pLevel] == 1) return sendTipMessage(playerid, "Nie mo�esz wymieni� pojazdu, poniewa� masz 1 lvl");
		
		new vehid = VehicleUID[lVeh][vUID];

 		if(!ProxDetectorS(10.0, playerid, playa)) return sendErrorMessage(playerid, "Ten gracz jest za daleko !");
		
		cena = FunkcjaK(string);
		if(!(cena >= 0 && cena < 900000001)) return sendTipMessage(playerid, "Cena od 0 do 900 000 000$ !");

        if(Car_IsStealable(lVeh)) return sendErrorMessage(playerid, "Tego pojazdu nie mo�na sprzeda�.");

	    if(kaska[playa] == 0) return sendErrorMessage(playerid, "B��d");

	    GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));

	    format(string, sizeof(string), "%s oferuje ci wymian� %s za %s z twoj� dop�at� %d$. Je�li si� zgadzasz, wpisz /akceptuj wymiana.", sendername, VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid))-400], VehicleNames[GetVehicleModel(GetPlayerVehicleID(playa))-400], cena);
        SendClientMessage(playa, 0xFFC0CB, string);

        if(!IsPlayerPremiumOld(playerid))
        {
            if(CarData[vehid][c_Neon] != 18652 && CarData[vehid][c_Neon] != 0)
            {
                SendClientMessage(playa, 0xFF0000FF, "UWAGA!: Ten samoch�d ma kolorowe neony dost�pne tylko dla kont premium. Gdy zakupisz to auto neony automatycznie zmieni� kolor na {FFFFFF}bia�y!");
            }
        }
        if(!IsPlayerPremiumOld(playerid))
        {
            if(CarData[IDAuta[playerid]][c_Neon] != 18652 && CarData[IDAuta[playerid]][c_Neon] != 0)
            {
                SendClientMessage(playerid, 0xFF0000FF, "UWAGA!: Ten samoch�d ma kolorowe neony dost�pne tylko dla kont premium. Gdy zakupisz to auto neony automatycznie zmieni� kolor na {FFFFFF}bia�y!");
            }
        }
        format(string, sizeof(string), "Oferujesz %s wymian� twojego %s za %s z jego dop�at� %d$", giveplayer, VehicleNames[GetVehicleModel(lVeh)-400], VehicleNames[GetVehicleModel(GetPlayerVehicleID(playa))-400], cena);
        SendClientMessage(playerid, 0xFFC0CB, string);
        GraczWymieniajacy[playa] = playerid;
		CenaWymienianegoAuta[playa] = cena;
		IDWymienianegoAuta[playa] = GetPlayerVehicleID(playa);
		IDAuta[playa] = vehid;
	}
 	else
 	{
		sendTipMessage(playerid, "Musisz by� w poje�dzie.");
    }
	return 1;
}

//end
