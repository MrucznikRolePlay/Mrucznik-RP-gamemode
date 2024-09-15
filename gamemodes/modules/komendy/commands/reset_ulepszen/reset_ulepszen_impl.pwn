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
command_reset_ulepszen_Impl(playerid, params[256])
{
    new string[128];

    if(IsPlayerConnected(playerid))
    {
		if (gPlayerLogged[playerid] == 0)
		{
			SendClientMessage(playerid, COLOR_GRAD1, "Nie jesteœ zalogowany!");
			return 1;
		}
		if (kaska[playerid] < 100000)
		{
			sendTipMessage(playerid, "To kosztuje $100000 ($100k)");
			return 1;
		}
		if (PlayerInfo[playerid][pLevel] < 2)
		{
			sendTipMessage(playerid, "Musisz mieæ wiêcej ni¿ 2 level");
			return 1;
		}
		PlayerInfo[playerid][gPupgrade] = (PlayerInfo[playerid][pLevel]-1)*2;
		PlayerInfo[playerid][pSHealth] = 0.0;
		PlayerInfo[playerid][pAlcoholPerk] = 0;
		PlayerInfo[playerid][pDrugPerk] = 0;
		PlayerInfo[playerid][pMiserPerk] = 0;
		PlayerInfo[playerid][pPainPerk] = 0;
		PlayerInfo[playerid][pTraderPerk] = 0;
		ZabierzKase(playerid,100000);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		format(string, sizeof(string), "   Masz teraz %d niewykorzystanych Punktów Ulepszenia !",PlayerInfo[playerid][gPupgrade]);
		SendClientMessage(playerid, COLOR_GRAD2, string);
	}
	return 1;
}

//end
