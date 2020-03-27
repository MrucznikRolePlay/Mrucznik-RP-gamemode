//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  komendy                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 13.05.2019
//Opis:
/*
	Podstawowe komendy.
*/

//

#include <YSI\y_hooks>


//-----------------<[ Callbacki: ]>-----------------
/*
        Error & Return type

    COMMAND_ZERO_RET      = 0 , // The command returned 0.
    COMMAND_OK            = 1 , // Called corectly.
    COMMAND_UNDEFINED     = 2 , // Command doesn't exist.
    COMMAND_DENIED        = 3 , // Can't use the command.
    COMMAND_HIDDEN        = 4 , // Can't use the command don't let them know it exists.
    COMMAND_NO_PLAYER     = 6 , // Used by a player who shouldn't exist.
    COMMAND_DISABLED      = 7 , // All commands are disabled for this player.
    COMMAND_BAD_PREFIX    = 8 , // Used "/" instead of "#", or something similar.
    COMMAND_INVALID_INPUT = 10, // Didn't type "/something".
*/ 
public e_COMMAND_ERRORS:OnPlayerCommandPerformed(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	if(success == COMMAND_OK) {
		Log(commandLog, E_LOGLEVEL:DEBUG, "%s wykona³ komendê %s", GetPlayerLogName(playerid), cmdtext);
	}
	return COMMAND_OK;
}

/*
        Error & Return type

    COMMAND_ZERO_RET      = 0 , // The command returned 0.
    COMMAND_OK            = 1 , // Called corectly.
    COMMAND_UNDEFINED     = 2 , // Command doesn't exist.
    COMMAND_DENIED        = 3 , // Can't use the command.
    COMMAND_HIDDEN        = 4 , // Can't use the command don't let them know it exists.
    COMMAND_NO_PLAYER     = 6 , // Used by a player who shouldn't exist.
    COMMAND_DISABLED      = 7 , // All commands are disabled for this player.
    COMMAND_BAD_PREFIX    = 8 , // Used "/" instead of "#", or something similar.
    COMMAND_INVALID_INPUT = 10, // Didn't type "/something".
*/ 
public e_COMMAND_ERRORS:OnPlayerCommandReceived(playerid, cmdtext[], e_COMMAND_ERRORS:success)
{
	//antyspam
    if(GetTickDiff(GetTickCount(), StaryCzas[playerid]) < 100)
	{
		SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Odczekaj chwilê zanim wpiszesz nastêpn¹ komende!");
		return COMMAND_ZERO_RET;
	}
	else 
	{
		StaryCzas[playerid] = GetTickCount();
	}

	if(GUIExit[playerid] != 0 || gPlayerLogged[playerid] == 0)
	{
		SendClientMessage(playerid, COLOR_WHITE, "SERWER: "SZARY"Nie jesteœ zalogowany/Masz otwarte okno dialogowe!");
		return COMMAND_ZERO_RET;
	}

	if(cmdtext[0] == '@')
	{
		return COMMAND_OK;
	}

	switch(success)
	{
		case COMMAND_ZERO_RET:
		{
			sendErrorMessage(playerid, "Komenda zwróci³a wartoœæ zerow¹.");
		}
		case COMMAND_BAD_PREFIX:
		{
			sendErrorMessage(playerid, "Z³y prefix! U¿yj \"/\".");
		}
		case COMMAND_DENIED:
		{
			sendErrorMessage(playerid, "Nie jesteœ uprawniony do u¿ywania tej komendy.");
		}
		case COMMAND_INVALID_INPUT:
		{
			sendErrorMessage(playerid, "Podano nieprawid³owe argumenty do komendy.");
		}
		case COMMAND_NO_PLAYER:
		{
			sendErrorMessage(playerid, "Nie powinieneœ istnieæ.");
		}
		case COMMAND_UNDEFINED, COMMAND_HIDDEN:
		{
			sendErrorMessage(playerid, "Ta komenda nie istnieje. Wpisz /komendy aby zobaczyæ listê dostêpnych komend.");
			/*if(PlayerInfo[playerid][Level] <= 1)//Anty slapper X_D - na LVL 1, pomo¿e troszkê ogarn¹æ sytuacje
			{
				if(IsPlayerInAnyVehicle(playerid))
				{
					if(GetPlayerVehicleSeat(playerid) != 0)
					{
						Player_RemoveFromVeh(playerid);
						sendTipMessageEx(playerid, COLOR_GREEN, "[Mru-AC] Zosta³eœ wyrzucony z pojazdu z powodu podejrzeñ slappera!"); 
					}
				}
			}
			*/
		}
	}

	if(success == COMMAND_OK) {
		Log(commandLog, E_LOGLEVEL:DEBUG, "%s wpisa³ komendê %s", GetPlayerLogName(playerid), cmdtext);
	}

	return COMMAND_OK;
}

//-----------------<[ Funkcje: ]>-------------------
RunCommand(playerid, command[], params[]) //temporary
{
	StaryCzas[playerid] = GetTickCount()-101;
	return Command_ReProcess(playerid, sprintf("%s %s", command, params), false);
}

//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end