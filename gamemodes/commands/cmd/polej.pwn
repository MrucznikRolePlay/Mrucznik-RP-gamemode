//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ polej ]-------------------------------------------------//
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

YCMD:polej(playerid, params[], help)
{
	if(PlayerInfo[playerid][Rank] >=3 && GetPlayerOrg(playerid) == FAMILY_IBIZA) //RANGA
	{
		if(!IsPlayerInRangeOfPoint(playerid, 50.0, 1904.3759,-2494.4448,13.6266) || GetPlayerVirtualWorld(playerid) != 1) return sendTipMessageEx(playerid, 0xB52E2BFF, "Jesteœ za daleko od baru klubu Ibiza");
		new id, drink;
		if(sscanf(params, "dd", id, drink)) return sendTipMessageEx(playerid, 0xB52E2BFF, "U¿yj /polej [id] [nr_drinka]");
		if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Ten gracz nie jest zalogowany");
		if(drink < 1 || drink > sizeof(IbizaDrinkiCeny) )  return sendTipMessageEx(playerid, 0xB52E2BFF, "Niepoprawne ID drinka, u¿yj: /cennik");
		new Float:x, Float:y, Float:z, tmp[128];
		GetPlayerPos(id, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz nie jest ko³o ciebie");
		--drink;
		format(tmp, sizeof(tmp), "Barman %s proponuje Ci drinka %s za %d$", PlayerName(playerid), IbizaDrinkiNazwy[drink], IbizaDrinkiCeny[drink]);
		ShowPlayerDialogEx(id, DIALOG_IBIZA_BAR, DIALOG_STYLE_MSGBOX, "Bar", tmp, "Akceptuj", "Odmów");
		SetPVarInt(id, "IbizaBar", playerid); SetPVarInt(id, "IbizaDrink", drink);
		format(tmp, sizeof tmp, "Proponujesz %s sprzeda¿ drinka %s", PlayerName(id), IbizaDrinkiNazwy[drink]);
		SendClientMessage(playerid, 0x0080D0FF, tmp);
	}
	return 1;
}
