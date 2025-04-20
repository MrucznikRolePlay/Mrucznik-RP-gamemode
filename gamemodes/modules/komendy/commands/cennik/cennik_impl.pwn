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
command_cennik_Impl(playerid)
{
    new bizId = GetIbizaOrVinyl(playerid);
	if (bizId == -1) return 1;
	new string[300];
	if (bizId == FRONTBIZ_IBIZA) {
		for(new i=0; i< sizeof IbizaDrinkiCeny; i++)
		{
			format(string, sizeof string, "%s%d. %s - $%d\n", string, i+1, IbizaDrinkiNazwy[i], IbizaDrinkiCeny[i]);
		}
	}
	else if (bizId == FRONTBIZ_VINYL) {
		for (new i=0; i<sizeof(vinylDrinkCosts); i++) {
			format(string, sizeof(string), "%s%d. %s - $%d\n", string, i+1, vinylDrinkNames[i], vinylDrinkCosts[i]);
		}
	}
	ShowPlayerDialogEx(playerid, DIALOG_IBIZA_CENNIK, DIALOG_STYLE_LIST, "Cennik drinków", string, "Ok", "");
	return 1;
}

//end
