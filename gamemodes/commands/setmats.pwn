//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setmats ]------------------------------------------------//
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

CMD:setmats(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] == 5000)
	{
		new gracz, wartosc;
		if(sscanf(params, "k<fix>d", gracz, wartosc))
		{
			sendTipMessage(playerid, "U¿yj /setmats [playerid/CzêœæNicku] [iloœæ matsów]");
			return 1;
		}

		if(IsPlayerConnected(gracz))
		{
			new sendername[MAX_PLAYER_NAME], giveplayer[MAX_PLAYER_NAME], string[128];
			GetPlayerName(gracz, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[gracz][pMats] = wartosc;
			format(string, sizeof(string),"AdmCmd: %s dal %d matsow graczowi %s.", sendername, wartosc, giveplayer);
            StatsLog(string);

            _MruAdmin(playerid, sprintf("Da³eœ %d materia³ów graczowi %s [ID: %d]", wartosc, GetNick(gracz, true), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Dosta³eœ %d materia³ów od admina %s [ID: %d]", wartosc, GetNick(playerid, true), playerid));


		}
		else
		{
			sendErrorMessage(playerid, "Ten gracz jest offline!");
		}

	}
	else
	{
		noAccessMessage(playerid);
	}
	return 1;
}

