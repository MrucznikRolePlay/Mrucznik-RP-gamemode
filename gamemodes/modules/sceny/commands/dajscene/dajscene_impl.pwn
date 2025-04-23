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
command_dajscene_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, value; 
		if(sscanf(params, "k<fix>d", giveplayerid, value))
		{
			sendTipMessage(playerid, "U¿yj /dajscene [ID] [0 - Zabierz || 1 - daj ]");
			return 1;
		}
		if(IsPlayerConnected(giveplayerid))
		{
			if(PlayerInfo[playerid][pLider] == FRAC_SN && PlayerInfo[playerid][pLiderValue] != 3)
			{
				if (value == 0) {
					sendTipMessage(playerid, sprintf("Da³eœ pozwolenie na scene graczowi %s", GetNick(giveplayerid)));
					sendTipMessage(giveplayerid, "Dosta³eœ pozwolenie na zarz¹dzenie scen¹");
				} else if (value == 1) {
					sendTipMessage(playerid, sprintf("Odebra³eœ pozwolenie na scene graczowi %s", GetNick(giveplayerid)));
					sendTipMessage(giveplayerid, "Odebrano ci pozwolenie na zarz¹dzenie scen¹");
				} else {
					sendErrorMessage(playerid, "Niepoprawna opcja");
					return 1;
				}
				SN_ACCESS[giveplayerid] = value;
			}
			else
			{
				sendErrorMessage(playerid, "Brak uprawnieñ do zarz¹dzania przydzia³em!"); 
			}
		}
	}
	return 1;
}

//end
