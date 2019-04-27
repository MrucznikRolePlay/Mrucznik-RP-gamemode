//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ sprzedajrybe ]---------------------------------------------//
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

CMD:sprzedajrybe(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new fishid;
  		new string[128];
		if( sscanf(params, "d", fishid))
		{
			SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: /sprzedajrybe [nr ryby]");
			SendClientMessage(playerid, COLOR_WHITE, "Numer ryby mo¿esz sprawdziæ komend¹ /ryby !");
			return 1;
		}
        if (!PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
		{
		    SendClientMessage(playerid, COLOR_WHITE, "Rybê mo¿esz sprzedaæ tylko w 24/7!");
			return 1;
		}
		if(FishGood[playerid] == 1)
		{
		    new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "AdmCmd: %s zostal zkickowany przez Admina: Marcepan_Marks, powód: teleport(ryby)", sendername);
            SendPunishMessage(string, playerid);
			KickLog(string);
			KickEx(playerid);
			return 1;
		}
		if(fishid < 1 || fishid > 5) { sendTipMessageEx(playerid, COLOR_GREY, "Numer ryby od 1 do 5 !"); return 1; }
		else if(fishid == 1 && Fishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(1) !"); return 1; }
		else if(fishid == 2 && Fishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(2) !"); return 1; }
		else if(fishid == 3 && Fishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(3) !"); return 1; }
		else if(fishid == 4 && Fishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(4) !"); return 1; }
		else if(fishid == 5 && Fishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(5) !"); return 1; }
		else if(fishid == 1 && Fishes[playerid][pWeight1] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "Sprzeda³eœ rybê numer 1!");
			format(string, sizeof(string), "Sprzeda³eœ rybê: %s, wa¿¹c¹ %d kg. Otrzymujesz %d$.", Fishes[playerid][pFish1], Fishes[playerid][pWeight1], Fishes[playerid][pWeight1]*20);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			DajKase(playerid, Fishes[playerid][pWeight1]*25);
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
			Fishes[playerid][pFishID] = 0;
			FishGood[playerid] = 0;
		}
		else if(fishid == 2 && Fishes[playerid][pWeight2] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "Sprzeda³eœ rybê numer 2!");
			format(string, sizeof(string), "Sprzeda³eœ rybê: %s, wa¿¹c¹ %d kg. Otrzymujesz %d$.", Fishes[playerid][pFish2], Fishes[playerid][pWeight2], Fishes[playerid][pWeight2]*20);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			DajKase(playerid, Fishes[playerid][pWeight2]*25);
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
			Fishes[playerid][pFishID] = 0;
			FishGood[playerid] = 0;
		}
		else if(fishid == 3 && Fishes[playerid][pWeight3] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "Sprzeda³eœ rybê numer 3!");
			format(string, sizeof(string), "Sprzeda³eœ rybê: %s, wa¿¹c¹ %d kg. Otrzymujesz %d$.", Fishes[playerid][pFish3], Fishes[playerid][pWeight3], Fishes[playerid][pWeight3]*20);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			DajKase(playerid, Fishes[playerid][pWeight3]*25);
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
			Fishes[playerid][pFishID] = 0;
			FishGood[playerid] = 0;
		}
		else if(fishid == 4 && Fishes[playerid][pWeight4] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "Sprzeda³eœ rybê numer 4!");
			format(string, sizeof(string), "Sprzeda³eœ rybê: %s, wa¿¹c¹ %d kg. Otrzymujesz %d$.", Fishes[playerid][pFish4], Fishes[playerid][pWeight4], Fishes[playerid][pWeight4]*20);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			DajKase(playerid, Fishes[playerid][pWeight4]*25);
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
			Fishes[playerid][pFishID] = 0;
			FishGood[playerid] = 0;
		}
		else if(fishid == 5 && Fishes[playerid][pWeight5] >= 1)
		{
			SendClientMessage(playerid, COLOR_GREY, "Sprzeda³eœ rybê numer 5!");
			format(string, sizeof(string), "Sprzeda³eœ rybê: %s, wa¿¹c¹ %d kg. Otrzymujesz %d$.", Fishes[playerid][pFish5], Fishes[playerid][pWeight5], Fishes[playerid][pWeight5]*20);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			DajKase(playerid, Fishes[playerid][pWeight5]*25);
			ClearFishID(playerid, fishid);
			Fishes[playerid][pLastFish] = 0;
			Fishes[playerid][pFishID] = 0;
			FishGood[playerid] = 0;
		}
	}
	return 1;
}

