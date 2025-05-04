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
command_checkbw_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
	{
		new id, string[144], typeint, type[144];
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U�yj /checkbw [ID]");
		if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		if(PlayerInfo[id][pBW] <= 0 && PlayerInfo[id][pInjury] <= 0)
		{
			return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma BW.");
		} 
		else
		{
			if(PlayerInfo[id][pBW] > 0)
			{
				typeint = PlayerInfo[id][pBW];
				format(type, sizeof(type), "(nieprzytomny)");
			}
			else
			{
				typeint = PlayerInfo[id][pInjury];
				format(type, sizeof(type), "(ranny)");
			}
			format(string, sizeof(string), "Graczowi %s zosta�o do ko�ca BW: %d sekund %s", GetNick(id), typeint, type); 
			SendClientMessage(playerid, COLOR_GRAD2, string);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie masz uprawnie�.");
	}
    return 1;
}

//end
