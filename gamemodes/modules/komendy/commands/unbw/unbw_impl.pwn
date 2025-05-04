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
command_unbw_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid) || IsAZaufanyGracz(playerid))
	{
		new id;
		if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U�yj /unbw [ID]");
		if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Nie ma takiego gracza.");
		if(PlayerInfo[id][pBW] <= 0 && PlayerInfo[id][pInjury] <= 0) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie jest ranny.");
		ZdejmijBW(id, 2000);
		SetPlayerChatBubble(id, " ", 0xFF0000FF, 100.0, 1000);
		SendClientMessage(playerid, COLOR_GRAD2, "Zdj�to BW.");
	}
    return 1;
}

//end
