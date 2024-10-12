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
command_sprzedajapteczka_Impl(playerid, params[256])
{
    if(GetPlayerFraction(playerid) == FRAC_ERS)
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /sprzedajapteczka [id]");
		if(!IsPlayerConnected(id) ) return sendErrorMessage(playerid, "Ten gracz nie jest zalogowanay");
		new Float:x, Float:y, Float:z, tmp[128];
		GetPlayerPos(id, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz nie jest ko³o ciebie");
		if(PlayerInfo[id][pHealthPacks] >= MAX_HEALTH_PACKS) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz posiada maksymaln¹ iloœæ apteczek");
		format(tmp, sizeof tmp, "Proponujesz %s kupno apteczki za %d$", GetNick(id), (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR));
		SendClientMessage(playerid, -1, tmp);
		format(tmp, sizeof tmp, "Lekarz %s proponuje Ci kupno apteczki za %d$", GetNick(playerid), (HEALTH_PACK_PRICE + HEALTH_PACK_AMOUNTDOCTOR));
		SetPVarInt(id, "HealthPackOffer", playerid);
		ShowPlayerDialogEx(id, D_ERS_SPRZEDAZ_APTECZKI, DIALOG_STYLE_MSGBOX, "SAM-ERS", tmp, "Kup", "Anuluj");
	}
	return 1;
}

//end
