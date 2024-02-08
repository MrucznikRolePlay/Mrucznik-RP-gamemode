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

ShowShopDialog(playerid)
{
	ShowPlayerDialogEx(playerid,12,DIALOG_STYLE_LIST,"Sklep 24/7","Zdrapka\t\t\t56500$\nTelefon\t\t\t\t500$\nKsi¹¿ka telefoniczna\t\t5000$\nKostka\t\t\t\t500$\nAparat Fotograficzny\t\t5000$\nZamek\t\t\t\t10000$\nPrêdkoœciomierz\t\t5000$\nKondom\t\t\t50$\nOdtwarzacz MP3\t\t2500$\nPiwo Mruczny Gul\t\t20$\nWino Komandaos\t\t25$\nSprunk\t\t\t\t15$\nCB-Radio\t\t\t2500$\nCygara\t\t\t\t200$\nKij Baseballowy\t\t\t15000$\nTempomat\t\t\t35000$\nMro¿ony kurczak\t\t15$\nMro¿ona pizza\t\t\t30$\nMro¿ony hamburger\t\t25$\nMaseczka ochronna\t\t15000$","KUP","WYJD");	
}

YCMD:kup(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
		{
			if(GUIExit[playerid] == 0)
			{
				ShowShopDialog(playerid);
			}
		}
		else if(PlayerToPoint(5.0, playerid, 809.4175,-1420.2585,-22.6193))
		{
				if(kasjerkaWolna == 666)
				{
					kasjerkaWolna = playerid; 
					format(string, sizeof(string), "Bilet zwyk³y\t %d$\nBilet VIP\t %d$", cenaNorm, cenaVIP);
					ShowPlayerDialogEx(playerid, 6997,DIALOG_STYLE_LIST,  "Vinyl-Club", string, "Akceptuj", "Odrzuæ"); 
				}
				else
				{
					format(string, sizeof(string), "Aktualnie kasjerka obs³uguje %s - odczekaj chwile!", GetNick(kasjerkaWolna));
					sendTipMessage(playerid, string);
				}
		}
		else if(IsPlayerInRangeOfPoint(playerid, 2.0, 800.8901,-1410.6635,-22.6093) 
		|| IsPlayerInRangeOfPoint(playerid, 2.0, 833.8511,-1391.2689,-17.6433))
		{
			if(PlayerInfo[playerid][pAge] >= 18)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2.0, 833.8511,-1391.2689,-17.6433))
				{
					SetPVarInt(playerid, "jestPrzyBarzeVIP", 1);
				}
				new stringBig[256]; 
				format(stringBig, sizeof(stringBig), 
				"Nazwa\tKoszt\tMoc (vol)\n\
				{FF0000}%s\t{80FF00}$%d\t15\n\
				{FF0000}%s\t{80FF00}$%d\t30\n\
				{FF0000}%s\t{80FF00}$%d\t40\n\
				{FF0000}%s\t{80FF00}$%d\t60", 
				drinkName1, drinkCost1, 
				drinkName2, drinkCost2,
				drinkName3, drinkCost3,
				drinkName4, drinkCost4); 
				ShowPlayerDialogEx(playerid, 6996, DIALOG_STYLE_TABLIST_HEADERS, "Vinyl-Club", stringBig, "Pij", "Odrzuæ", true);
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
