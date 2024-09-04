//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ trasy ]-------------------------------------------------//
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

YCMD:trasy(playerid, params[], help)
{
	if(GUIExit[playerid] == 0)
	{
		if(IsAMechazordWarsztatowy(playerid))
		{
			if(PlayerInfo[playerid][pRank] >= 4)
			{
				ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wyœcigów: Wybierz opcjê", "Poka¿ trasy\nZorganizuj wyœcig\nEdytuj trasê\nUsuñ trasê", "Wybierz", "Anuluj");
			}
			else if(PlayerInfo[playerid][pRank] >= 2)
			{
				ShowPlayerDialogEx(playerid, 1410, DIALOG_STYLE_LIST, "Panel wyœcigów: Wybierz opcjê", "Poka¿ trasy\nZorganizuj wyœcig", "Wybierz", "Anuluj");
			}
			else
			{
				ShowPlayerDialogEx(playerid, 1411, DIALOG_STYLE_LIST, "Wszystkie trasy:", ListaWyscigow(), "Wiêcej", "WyjdŸ");
			}
			return 1;
		}
		else
		{
			ShowPlayerDialogEx(playerid, 1411, DIALOG_STYLE_LIST, "Wszystkie trasy:", ListaWyscigow(), "Wiêcej", "WyjdŸ");
		}
	}
	return 1;
}
