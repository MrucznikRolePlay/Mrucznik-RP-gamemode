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
				SN_ACCESS[giveplayerid] = value;
				sendTipMessage(playerid, "Zmieni³eœ wartoœæ pozwolenia sceny"); 
				sendTipMessage(giveplayerid, "Zosta³a zmieniona Ci wartoœæ pozwolenia zarz¹dzania scen¹"); 
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
