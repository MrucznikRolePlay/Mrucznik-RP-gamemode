//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ og ]--------------------------------------------------//
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

YCMD:og(playerid, params[], help)
{
    new string[256];
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0) return SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ zalogowany!");
		else if(PlayerInfo[playerid][pConnectTime] == 0 && PlayerInfo[playerid][pLevel] == 1) return sendErrorMessage(playerid, "Aby pisaæ og³oszenia musisz przegraæ 1h na serwerze!");
		else if(GetPlayerAdminDutyStatus(playerid) == 1) return sendErrorMessage(playerid, "Nie mo¿esz pisaæ og³oszeñ podczas s³u¿by administratora!");
		else if(PlayerInfo[playerid][pJailed] != 0) return sendErrorMessage(playerid, "Nie posiadasz telefonu w wiêzieniu!");
        else if(PlayerInfo[playerid][pPnumber] == 0) return SendClientMessage(playerid, COLOR_GREY, "Nie masz telefonu. Kup go w 24/7 !");
        else if(isnull(params)) return SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: (/og)loszenie [tekst og³oszenia]");
		else if(sprawdzReklame(params, playerid) == 1) return 1;
		else if(sprawdzWulgaryzmy(params, playerid) == 1) return 1;
		else if(PlayerInfo[playerid][pBP] >= 1)
		{
			format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			return SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
		}
		else if ((!adds) && (!IsPlayerPremiumOld(playerid)) && PlayerInfo[playerid][pAdmin] < 10)
		{
			format(string, sizeof(string), "Spróbuj póŸniej, %d sekund miêdzy og³oszeniami !",  (addtimer/1000));
			return SendClientMessage(playerid, COLOR_GRAD2, string);
		}
		else
		{
			new payout = strlen(params) * 25;
			if(kaska[playerid] < payout)
			{
				format(string, sizeof(string), "* U¿y³eœ %d znaków i masz zap³aciæ $%d, nie posiadasz a¿ tyle.", strlen(params), payout);
				return SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			}
			ZabierzKase(playerid, payout);
			format(string, sizeof(string), "Og³oszenie: %s, Kontakt: %d", params, PlayerInfo[playerid][pPnumber]);
			OOCNews(TEAM_GROVE_COLOR,string);
			Log(chatLog, INFO, "%s og³oszenie: %s", GetPlayerLogName(playerid), params);
			format(string, sizeof(string), "~r~Zaplaciles $%d~n~~w~Za: %d Znakow", payout, strlen(params));
			GameTextForPlayer(playerid, string, 5000, 5);
			if (PlayerInfo[playerid][pAdmin] < 1 && (!IsPlayerPremiumOld(playerid)))
			{
				SetTimer("AddsOn", addtimer, 0);adds = 0;
			}
		}   
    }
    return 1;
}
