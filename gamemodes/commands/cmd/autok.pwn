//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ autok ]-------------------------------------------------//
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

CMD:autoklucze(playerid) return cmd_autok(playerid);
CMD:pojazdklucze(playerid) return cmd_autok(playerid);
CMD:samochodklucze(playerid) return cmd_autok(playerid);
CMD:carklucze(playerid) return cmd_autok(playerid);
CMD:autok(playerid)
{
	if(PlayerInfo[playerid][pKluczeAuta] > 0)
	{
	    if(GUIExit[playerid] == 0)
	    {
		    SendClientMessage(playerid, COLOR_GRAD2, "Skrót komendy: /autok");
		    ShowPlayerDialogEx(playerid, 443, DIALOG_STYLE_LIST, "Co chcesz zrobiæ z wozem?", "Spawnuj\nZnajdŸ\nPoka¿ parking", "Wybierz", "Wyjdz");
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie posiadasz klucz do pojazdu");
	}
	return 1;
}

