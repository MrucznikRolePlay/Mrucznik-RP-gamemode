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
command_polej_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pRank] >=3) //RANGA
	{
		new bizId = GetIbizaOrVinyl(playerid);
		if (bizId == -1) return 1;
		// if(!IsPlayerInRangeOfPoint(playerid, 50.0, 1904.3759,-2494.4448,13.6266) || GetPlayerVirtualWorld(playerid) != 1) return sendTipMessageEx(playerid, 0xB52E2BFF, "Jeste� za daleko od baru klubu Ibiza");
		new id, drink, maxDrinks = bizId == FRONTBIZ_IBIZA ? sizeof(IbizaDrinkiCeny) : sizeof(vinylDrinkCosts);
		if(sscanf(params, "dd", id, drink)) return sendTipMessageEx(playerid, 0xB52E2BFF, "U�yj /polej [id] [nr_drinka]");
		if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Ten gracz nie jest zalogowany");
		if(drink < 1 || drink > maxDrinks) return sendTipMessageEx(playerid, 0xB52E2BFF, "Niepoprawne ID drinka, u�yj: /cennik");
		new Float:x, Float:y, Float:z, tmp[128];
		GetPlayerPos(id, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z)) return sendTipMessageEx(playerid, 0xB52E2BFF, "Ten gracz nie jest ko�o ciebie");
		--drink;
		SetPVarInt(id, "polejBizId", bizId);
		SetPVarInt(id, "polejBarman", playerid);
		SetPVarInt(id, "polejDrink", drink);
		if (bizId == FRONTBIZ_IBIZA) {
			format(tmp, sizeof(tmp), "Barman %s proponuje Ci drinka %s za %d$", PlayerName(playerid), IbizaDrinkiNazwy[drink], IbizaDrinkiCeny[drink]);
			ShowPlayerDialogEx(id, DIALOG_KLUB_BAR, DIALOG_STYLE_MSGBOX, "Bar", tmp, "Akceptuj", "Odm�w");
			format(tmp, sizeof tmp, "Proponujesz %s sprzeda� drinka %s", PlayerName(id), IbizaDrinkiNazwy[drink]);
			SendClientMessage(playerid, 0x0080D0FF, tmp);
		}
		else if (bizId == FRONTBIZ_VINYL) {
			format(tmp, sizeof(tmp), "Barman %s proponuje Ci drinka %s za %d$", PlayerName(playerid), vinylDrinkNames[drink], vinylDrinkCosts[drink]);
			ShowPlayerDialogEx(id, DIALOG_KLUB_BAR, DIALOG_STYLE_MSGBOX, "Bar", tmp, "Akceptuj", "Odm�w");
			format(tmp, sizeof tmp, "Proponujesz %s sprzeda� drinka %s", PlayerName(id), vinylDrinkNames[drink]);
			SendClientMessage(playerid, 0x0080D0FF, tmp);
		}
	}
	return 1;
}

//end
