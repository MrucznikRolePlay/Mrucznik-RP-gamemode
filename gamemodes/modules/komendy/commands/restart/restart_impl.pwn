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
command_restart_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if (PlayerInfo[playerid][pAdmin] >= 4999 || IsAScripter(playerid))
		{
			new string[128];
			new playerNick[MAX_PLAYER_NAME];
			GetPlayerName(playerid, playerNick, sizeof(playerNick));
			format(string, sizeof(string), "%s zarz�dzi� restart serwera! Trwa pr�ba ponownego po��czenia", playerNick);
			foreach(new i : Player)
			{
				TogglePlayerControllable(i, 0);
				MruMySQL_SaveAccount(i);
				sendErrorMessage(i, string);
			}
			ZapiszDomy();
			SendRconCommand("gmx");
		}
		else
		{
			sendErrorMessage(playerid, "BRAK UPRAWNIE�!");
			return 1;
		}
	}
	return 1;
}

//end
