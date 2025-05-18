//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   pobij                                                   //
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


//

//------------------<[ Implementacja: ]>-------------------
command_pobij_Impl(playerid, opponentid)
{
    if(IsPobijInvalid(playerid, opponentid))
    {
        return 1;
    }

    new message_s[128];

	new opponentName[MAX_PLAYER_NAME];
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(opponentid, opponentName, sizeof(opponentName));
	GetPlayerName(playerid, playerName, sizeof(playerName));

	format(message_s, sizeof(message_s), "* %s próbuje uderzyæ %s.", playerName, opponentName);
	ProxDetector(30.0, playerid, message_s, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	NadajWL(playerid, 1, "Pobicie cz³owieka");

	new randomRoll = random(15);
	if(randomRoll == 14) // krytyczna pora¿ka - atakuj¹cy automatycznie przegrywa
	{
		LoseBattle(playerid, opponentid);
	}
	else
	{
		PlayerPlaySound(playerid, 1097, 0.0, 0.0, 0.0);
		PlayerPlaySound(opponentid, 1097, 0.0, 0.0, 0.0);
		TogglePlayerControllable(playerid, 0);
		TogglePlayerControllable(opponentid, 0);

		fightingOpponentOf[playerid] = opponentid;
		fightingOpponentOf[opponentid] = playerid;
		wasRecentlyFighting[playerid] = true;
		wasRecentlyFighting[opponentid] = true;

        BattlePhaseStart(playerid, opponentid, BATTLE_LEN_FIRST_SEC);
	}

	return 1;
}

//end