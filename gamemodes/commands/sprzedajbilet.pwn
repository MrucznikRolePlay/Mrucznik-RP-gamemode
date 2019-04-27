//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ sprzedajbilet ]---------------------------------------------//
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

CMD:sprzedajbilet(playerid, params[])
{
	if(GetPlayerOrg(playerid) == FAMILY_IBIZA) //RANGA
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /sprzedajbilet [id]");
		if(!IsPlayerConnected(id) ) return sendErrorMessage(playerid, "Ten gracz nie jest zalogowanay");
		new Float:x, Float:y, Float:z, tmp[128];
		GetPlayerPos(id, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz nie jest ko³o ciebie");
		format(tmp, sizeof tmp, "Proponujesz %s kupno biletu do Ibiza Club!", GetNick(id));
		SendClientMessage(playerid, -1, tmp);
		format(tmp, sizeof tmp, "%s proponuje Ci kupno biletu do Ibiza Club za %d$", GetNick(playerid), IbizaBilet);
		SetPVarInt(id, "IbizaBiletSell", playerid);
		ShowPlayerDialogEx(id, DIALOG_IBIZA_BILET, DIALOG_STYLE_MSGBOX, "Ibiza Club", tmp, "Kup", "Anuluj");
	}
	return 1;
}
