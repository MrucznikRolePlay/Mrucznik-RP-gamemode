//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wypuscrybe ]----------------------------------------------//
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

CMD:releasefish(playerid, params[]) return cmd_wypuscrybe(playerid, params);
CMD:wyrzucrybe(playerid, params[]) return cmd_wypuscrybe(playerid, params);
CMD:wypuscrybe(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new fishid;
		if( sscanf(params, "d", fishid))
		{
			SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: /wypuscrybe [ryba]");
			return 1;
		}

		if(fishid < 1 || fishid > 5) { sendTipMessageEx(playerid, COLOR_GREY, "Numer ryby od 1 do 5 !"); return 1; }
		else if(fishid == 1 && Fishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(1) !"); return 1; }
		else if(fishid == 2 && Fishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(2) !"); return 1; }
		else if(fishid == 3 && Fishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(3) !"); return 1; }
		else if(fishid == 4 && Fishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(4) !"); return 1; }
		else if(fishid == 5 && Fishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(5) !"); return 1; }
		ClearFishID(playerid, fishid);
		Fishes[playerid][pLastFish] = 0;
		Fishes[playerid][pFishID] = 0;
	}
	return 1;
}
