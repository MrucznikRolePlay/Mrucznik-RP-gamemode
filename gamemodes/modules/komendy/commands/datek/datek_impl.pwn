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
command_datek_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new moneys;
		if( sscanf(params, "s[16]", string))
		{
			sendTipMessage(playerid, "U¿yj /charity [kwota]");
			return 1;
		}
		moneys = FunkcjaK(string);

		if(PlayerInfo[playerid][pLocal] == 106)
		{
			sendErrorMessage(playerid, "Komenda nie dzia³a w tym miejscu");
			return 1;
		}
		if(moneys < 1)
		{
			sendTipMessage(playerid, "Datek 0$ nie jest datkiem.");
			return 1;
		}
		if(kaska[playerid] < moneys)
		{
		    sendTipMessage(playerid, "Nie masz a¿ tyle pieniêdzy.");
			return 1;
		}
		if(moneys < 100000)
		{
		    sendTipMessage(playerid, "¯artujesz sobie? Nie chcemy takich groszy!");
			return 1;
		}
		ZabierzKase(playerid, moneys);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s bardzo dziêkujemy za przekazan¹ sumê $%d.",sendername, moneys);
		SendAdminMessage(COLOR_YELLOW, string);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COLOR_GRAD1, string);
		Log(payLog, INFO, "%s wp³aci³ datek %d$", GetPlayerLogName(playerid), moneys);
	}
	return 1;
}

//end
