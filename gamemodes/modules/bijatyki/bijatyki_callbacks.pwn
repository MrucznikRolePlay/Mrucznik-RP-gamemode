//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  bijatyki                                                 //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024
//Opis:
/*
	Uporz¹dkowany system /pobij.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == BATTLE_FIGHT_DIALOG)
	{
		if(battleIsTooLate[playerid])
		{
			return Y_HOOKS_CONTINUE_RETURN_0;
		}

		new battleTimer = GetPVarInt(playerid, "battleTimer");
		KillTimer(battleTimer);

		new opponentid = fightingOpponentOf[playerid];
		if(response)
		{
			if(strcmp(battleCodeToRetype[opponentid], inputtext, true ) == 0 && strlen(inputtext) == 8)
			{
				SendClientMessage(playerid, COLOR_WHITE, "CIOS ODBITY!");
				BattlePhaseStart(playerid, opponentid, BATTLE_LEN_NEXT_SEC);
			}
			else
			{
				LoseBattle(playerid, opponentid);
			}
		}
		else
		{
			LoseBattle(playerid, opponentid);
		}
	}

	return Y_HOOKS_CONTINUE_RETURN_0;
}

//end