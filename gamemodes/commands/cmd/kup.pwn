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
	new string[800]; 
	new nameBusiness[64];
	format(string, sizeof(string), "Przedmiot\tCena\tIloœæ\n\
	Telefon\t{80FF00}{80FF00}%d$\t1\n\
	Zdrapka\t{80FF00}%d$\t1\n\
	Ksi¹¿ka Telefoniczna\t{80FF00}%d$\t1\n\
	Kostka\t{80FF00}%d$\t2\n\
	Aparat\t{80FF00}%d$\t500x\n\
	Zamek\t{80FF00}%d$\t1\n\
	Prêdkoœciomierz\t{80FF00}%d$\t1\n\
	Kondom\t{80FF00}%d$\t4x\n\
	Odtwarzacz MP3\t{80FF00}%d$\t1\n\
	Piwo Mruczny Gul\t{80FF00}%d$\t500ml\n\
	Wino Komandos\t{80FF00}%d$\t500ml\n\
	Sprunk\t{80FF00}%d$\t250ml\n\
	CB-RADIO\t{80FF00}%d$\t1\n\
	Cygara\t{80FF00}%d$\t1\n\
	Kij Baseballowy\t{80FF00}%d$\t1\n\
	Nawigacja GPS\t{80FF00}%d$\t1",
	S_CENA_TELEFON,
	S_CENA_ZDRAPKA,
	S_CENA_KSIAZKA, 
	S_CENA_KOSTKA,
 	S_CENA_APARAT,
 	S_CENA_ZAMEK,
 	S_CENA_PREDKOSCIOMIERZ,
 	S_CENA_KONDOM,
 	S_CENA_ODTWARZACZ,
 	S_CENA_PIWO,
 	S_CENA_WINO,
 	S_CENA_SPRUNK,
 	S_CENA_CBRADIO,
 	S_CENA_CYGARO,
 	S_CENA_KIJ,
	S_CENA_NAWIGACJA);
	new bIDE = GetNearBusinessID(playerid); 
	format(nameBusiness, 64, "%s", mBiz[bIDE][b_Name]);
	ShowPlayerDialogEx(playerid,12,DIALOG_STYLE_TABLIST_HEADERS, nameBusiness, string,"KUP","WYJD");		
}

YCMD:kup(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new string[256];
		/*if (PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53))//centerpoint 24-7
		{
			if(GUIExit[playerid] == 0)
			{
				ShowShopDialog(playerid);
			}
		}*/
		if(PlayerNearBusinessType(playerid, BTYPE_SERVICES, BTYPE2_SHOP))
		{ 
			ShowShopDialog(playerid); 
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
					format(string, sizeof(string), "Aktualnie kasjerka obs³uguje %s - odczekaj chwile!", GetNick(kasjerkaWolna, true));
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
