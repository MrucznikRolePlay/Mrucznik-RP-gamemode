//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ sprzedajzestaw ]-----------------------------------------------//
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
// Data utworzenia: 29.02.2020

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/
YCMD:sprzedajzestaw(playerid, params[], help)
{
	if(PlayerInfo[playerid][Job] == JOB_MECHANIC)
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /sprzedajzestaw [id]");
		if(IsPlayerConnected(id))
		{
			if(id != INVALID_PLAYER_ID)
			{
				if(id == playerid)  return sendTipMessage(playerid, "Nie mo¿esz sprzedaæ sobie zestawu.");
				if(AntySpam[playerid] == 1)
				{
					sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 15 sekund");
					return 1;
				}
				new Float:x, Float:y, Float:z, tmp[128];
				GetPlayerPos(id, x, y, z);
				if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz nie jest ko³o ciebie");
				if(PlayerInfo[id][pFixKit] >= 3) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz posiada maksymaln¹ iloœæ zestawów");
				format(tmp, sizeof tmp, "Proponujesz %s kupno zestawu za 15000$", GetNick(id));
				SendClientMessage(playerid, -1, tmp);
				format(tmp, sizeof tmp, "Mechanik %s proponuje Ci kupno zestawu za 15000$", GetNick(playerid));
				SetPVarInt(id, "FixKitOffer", playerid);
				ShowPlayerDialogEx(id, D_MECH_SPRZEDAZ_FIXKIT, DIALOG_STYLE_MSGBOX, "Mechanik", tmp, "Kup", "Anuluj");
				SetTimerEx("AntySpamTimer",15000,0,"d",playerid);
       			AntySpam[playerid] = 1;
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza.");
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie ma takiego gracza.");
		}
	}
    else
    {
        sendErrorMessage(playerid, "Komenda dostêpna tylko dla mechanika.");
    }
	return 1;
}