//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ okienko ]------------------------------------------------//
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

YCMD:okienko(playerid, params[], help)
{
	if (IsAUrzednik(playerid))
	{
		if(IsPlayerConnected(playerid))
		{
			new okienkoid;
			if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0215,-1792.1661,77.9453))
			{
				okienkoid = 0;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0216,-1795.3773,77.9453))
			{
				okienkoid = 1;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0219,-1798.5234,77.9453))
			{
				okienkoid = 2;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1454.0416,-1801.7599,77.9453))
			{
				okienkoid = 3;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9628,-1791.4224,77.9453))
			{
				okienkoid = 4;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9757,-1794.6508,77.9453))
			{
				okienkoid = 5;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9752,-1797.7997,77.9453))
			{
				okienkoid = 6;
			}
			else if(IsPlayerInRangeOfPoint(playerid,OKIENKO_DMV_RANGE, 1446.9729,-1800.9788,77.9453))
			{
				okienkoid = 7;
			}
			else
			{
				sendErrorMessage(playerid, "Nie jesteœ przy ¿adnym z okienek!");
				return 1;
			}
			
			new string[32];
			format(string, sizeof(string), "Edytujesz okienko nr: %d", okienkoid+1);
			SendClientMessage(playerid, COLOR_WHITE, string);
			SetPVarInt(playerid, "okienko-edit", okienkoid);
			ShowPlayerDialogEx(playerid,99,DIALOG_STYLE_LIST,"Któr¹ tablicê wywieszasz:","Dopasuj do rangi\nEgzaminy Praktyczne\nEgzaminy Teoretyczne\nKurs na prawo jazdy\nRejestracja\nZ/W\nZamkniête","Wywieœ","Zamknij");
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ urzêdnikiem!");
	}
	return 1;
}
