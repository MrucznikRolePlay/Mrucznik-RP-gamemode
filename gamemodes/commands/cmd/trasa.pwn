//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ trasa ]-------------------------------------------------//
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

YCMD:trasa(playerid, params[], help)
{
	new Veh = GetPlayerVehicleID(playerid);
	if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10 || PlayerInfo[playerid][pJob] == 10)
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pRank] >= 0 || PlayerInfo[playerid][pJob] == 10)
			{
				if(IS_KomunikacjaMiejsca(Veh))
				{
					ShowPlayerDialogEx(playerid, 8155, DIALOG_STYLE_LIST, "Wybierz swój kurs:", "Linia 55 - niebieska(230$/p , 9min, 21p, +2)\nLinia 72 - pomarañczowa (200$/p, 6min, 15p, +1)\nLinia 96 - zielona 4s (310$/p, 8min, 24p, +1)\nLinia 82 ¿ó³ta 5s (510$/p , 11min, 18p, +3)\nLinia 85 3s (270$/p , ? min, 24p, +2)\nWycieczka 5s\nPowrót do bazy\nPomoc", "Wybierz", "Wyjdz");
				}
				else
				{
					sendTipMessage(playerid, "Nie jesteœ w autobusie!");
				}
			}
			else
			{
				sendTipMessage(playerid, "Nie posiadasz 2 rangi!");
			}
			return 1;
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ z Korporacji Transportowej!");
	}
	return 1;
}
