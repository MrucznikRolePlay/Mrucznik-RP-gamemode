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
command_setmats_Impl(playerid, params[256])
{
    if (IsAHeadAdmin(playerid))
	{
		new gracz, wartosc;
		if(sscanf(params, "k<fix>d", gracz, wartosc))
		{
			sendTipMessage(playerid, "U¿yj /setmats [playerid/CzêœæNicku] [iloœæ matsów]");
			return 1;
		}

		if(IsPlayerConnected(gracz))
		{
			PlayerInfo[gracz][pMats] = wartosc;
			Log(adminLog, INFO, "Admin %s ustawi³ %s materia³y na %d", GetPlayerLogName(playerid), GetPlayerLogName(gracz), wartosc);

            _MruAdmin(playerid, sprintf("Da³eœ %d materia³ów graczowi %s [ID: %d]", wartosc, GetNick(gracz), gracz));
            if(gracz != playerid) _MruAdmin(gracz, sprintf("Dosta³eœ %d materia³ów od admina %s [ID: %d]", wartosc, GetNickEx(playerid), playerid));


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

//end
