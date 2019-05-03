//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kup ]--------------------------------------------------//
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

YCMD:kup(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
		{
			if(GUIExit[playerid] == 0)
			{
				ShowPlayerDialogEx(playerid,12,DIALOG_STYLE_LIST,"Sklep 24/7","Telefon\t\t\t\t500$\nZdrapka\t\t\t7500$\nKsi¹¿ka telefoniczna\t\t5000$\nKostka\t\t\t\t500$\nAparat Fotograficzny\t\t5000$\nZamek\t\t\t\t10000$\nPrêdkoœciomierz\t\t5000$\nKondom\t\t\t50$\nOdtwarzacz MP3\t\t2500$\nPiwo Mruczny Gul\t\t20$\nWino Komandaos\t\t25$\nSprunk\t\t\t\t15$\nCB-Radio\t\t\t2500$\nCygara\t\t\t\t200$","KUP","WYJD");
			}
		}
		else if(PlayerToPoint(4.0, playerid, 815.6807,-1382.8877,23.6475))
		{
				if(kasjerkaWolna == 666)
				{
					kasjerkaWolna = playerid; 
					format(string, sizeof(string), "Bilet zwyk³y\t %d$\nBilet VIP\t %d$", cenaNorm, cenaVIP);
					ShowPlayerDialogEx(playerid, 6997,DIALOG_STYLE_LIST,  "Vinyl-Club", string, "Akceptuj", "Odrzuæ"); 
				}
				else
				{
					format(string, sizeof(string), "Aktualnie kasjerka obs³uguje %s - odczekaj chwile!", GetNick(kasjerkaWolna, true));
					sendTipMessage(playerid, string);
				}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 814.2560,-1371.4149,23.6475) 
		|| IsPlayerInRangeOfPoint(playerid, 2.0, 811.1123,-1351.7429,27.8413))
		{
			if(PlayerInfo[playerid][pAge] >= 18)
			{
				ShowPlayerDialogEx(playerid, 6996, DIALOG_STYLE_LIST, "Vinyl-Club", "Cytrynowy-sza³\t10.000$\nW³adca procêtów\t15.000$\nNapój mistrza Cotty\t20.000$\nTwoja Stara\t 30.000$", "Pij", "Odrzuæ");
			}
			else
			{
				SendClientMessage(playerid, -1, "Barman_Jaros³aw mówi: Nieletnim nie sprzedajemy alkoholu!");
				return 1;
			}
		}
		else 
		{
			sendErrorMessage(playerid, "Nie jesteœ w miejscu, w którym mo¿na u¿yæ tej komendy.");
			return 1;
		}
	}
	return 1;
}
