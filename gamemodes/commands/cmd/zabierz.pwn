//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ zabierz ]------------------------------------------------//
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

YCMD:zabierz(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAPolicja(playerid))
        {
            if(PlayerInfo[playerid][pRank] < 1)
            {
                SendClientMessage(playerid, COLOR_GREY, "Potrzebujesz 1 rangi aby zabieraæ przedmioty!");
                return 1;
            }
            new x_nr[16];
			new giveplayerid;
            if(gettime() < GetPVarInt(playerid, "lic-timer")) return sendTipMessage(playerid, "Licencje oraz rzeczy mo¿esz zabieraæ co 30 sekund!");
			if( sscanf(params, "s[16] d", x_nr, giveplayerid))
			{
				SendClientMessage(playerid, COLOR_WHITE, "|__________________ Zabieranie rzeczy __________________|");
				SendClientMessage(playerid, COLOR_WHITE, "U¯YJ: /zabierz [nazwa] [playerid/CzêœæNicku]");
		  		SendClientMessage(playerid, COLOR_GREY, "Dostêpne nazwy: Prawojazdy, LicencjaLot, LicencjaLodz, LicencjaBron, Bron, Dragi, Mats");
				SendClientMessage(playerid, COLOR_WHITE, "|_______________________________________________________|");
				return 1;
			}

			if(!IsPlayerConnected(giveplayerid))
			{
				sendErrorMessage(playerid, "Nie ma takiego gracza!");
				return 1;
			}

			if (!ProxDetectorS(8.0, playerid, giveplayerid))
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest przy tobie !");
				return 1;
			}

			if(!isPlayerCuffed[giveplayerid])
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz nie jest skuty!");
				return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));

		    if(strcmp(x_nr,"prawojazdy",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s prawo jazdy.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ Ci prawo jazdy.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s prawo jazdy.", sendername, giveplayer);
				PlayerInfo[giveplayerid][pCarLic] = 0;
			}
			else if(strcmp(x_nr,"licencjalot",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s Licencje na latanie.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ Ci licencjê na latanie.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s licencjê na latanie.", sendername, giveplayer);
				PlayerInfo[giveplayerid][pFlyLic] = 0;

			}
			else if(strcmp(x_nr,"licencjabron",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s Licencjê na Broñ.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ Ci licencjê na broñ.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s licencjê na broñ.", sendername, giveplayer);
				SetTimerEx("AntySB", 5000, 0, "d", giveplayerid);
				AntySpawnBroni[giveplayerid] = 5;
				PlayerInfo[giveplayerid][pGunLic] = 0;
			}
			else if(strcmp(x_nr,"licencjalodz",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s Licencje na p³ywanie ³odziami.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ Ci twoj¹ licencjê na p³ywanie ³odziami.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s licencjê na lodz.", sendername, giveplayer);
				PlayerInfo[giveplayerid][pBoatLic] = 0;

			}
			else if(strcmp(x_nr,"bron",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s Bronie.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ twoj¹ broñ.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s broñ.", sendername, giveplayer);
				SetTimerEx("AntySB", 5000, 0, "d", giveplayerid);
				AntySpawnBroni[giveplayerid] = 5;
				ResetPlayerWeapons(giveplayerid);
				UsunBron(giveplayerid);
			}
			else if(strcmp(x_nr,"dragi",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s dragi.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ twoje narkotyki.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s dragi %d.", sendername, giveplayer, PlayerInfo[giveplayerid][pDrugs]);
				Log(serverLog, INFO, "%s zabra³ %s %d %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), PlayerInfo[giveplayerid][pDrugs], x_nr);
				PlayerInfo[giveplayerid][pDrugs] = 0;
    			SetPVarInt(playerid, "lic-timer", gettime() + 30);
				return 1;
			}
			else if(strcmp(x_nr,"mats",true) == 0)
			{
				format(string, sizeof(string), "* Zabra³eœ %s Materia³y.", giveplayer);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ twoje Materia³y.", sendername);
				SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string), "* Oficer %s zabra³ %s matsy %d.", sendername, giveplayer, PlayerInfo[giveplayerid][pMats]);
				Log(serverLog, INFO, "%s zabra³ %s %d %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), PlayerInfo[giveplayerid][pMats], x_nr);
				PlayerInfo[giveplayerid][pMats] = 0;
    			SetPVarInt(playerid, "lic-timer", gettime() + 30);
				return 1;
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Z³a nazwa");
				return 1;
			}

			Log(serverLog, INFO, "%s zabra³ %s %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), x_nr);
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ policjantem !");
            return 1;
        }
    }
    SetPVarInt(playerid, "lic-timer", gettime() + 30);
    return 1;
}
