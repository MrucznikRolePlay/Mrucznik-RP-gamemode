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
command_kup_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		new string[256];
		if (IsAt247(playerid))//centerpoint 24-7
		{
			if(GUIExit[playerid] == 0)
			{
				ShowShopDialog(playerid);
			}
		}
		else if(PlayerToPoint(5.0, playerid, 809.4175,-1420.2585,-22.6193))
		{
			format(string, sizeof(string), "Bilet zwyk≥y\t %d$\nBilet VIP\t %d$", vinylCenaNorm, vinylCenaVIP);
			ShowPlayerDialogEx(playerid, 6997,DIALOG_STYLE_LIST,  "Vinyl-Club", string, "Akceptuj", "OdrzuÊ"); 
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
				vinylDrinkNames[0], vinylDrinkCosts[0], 
				vinylDrinkNames[1], vinylDrinkCosts[1], 
				vinylDrinkNames[2], vinylDrinkCosts[2], 
				vinylDrinkNames[3], vinylDrinkCosts[3]); 
				ShowPlayerDialogEx(playerid, 6996, DIALOG_STYLE_TABLIST_HEADERS, "Vinyl-Club", stringBig, "Pij", "OdrzuÊ", true);
			}
			else
			{
				SendClientMessage(playerid, -1, "Barman_Jaros≥aw mÛwi: Nieletnim nie sprzedajemy alkoholu!");
				return 1;
			}
		}
		else 
		{
			sendErrorMessage(playerid, "Nie jesteú w miejscu, w ktÛrym moøna uøyÊ tej komendy.");
			return 1;
		}
	}
	return 1;
}

ShowShopDialog(playerid)
{
	ShowPlayerDialogEx(playerid,12,DIALOG_STYLE_LIST,"Sklep 24/7","Zdrapka\t\t\t56500$\nTelefon\t\t\t\t500$\nKsiπøka telefoniczna\t\t5000$\nKostka\t\t\t\t500$\nAparat Fotograficzny\t\t5000$\nZamek\t\t\t\t10000$\nPrÍdkoúciomierz\t\t5000$\nKondom\t\t\t50$\nOdtwarzacz MP3\t\t2500$\nPiwo Mruczny Gul\t\t20$\nWino Komandaos\t\t25$\nSprunk\t\t\t\t15$\nCB-Radio\t\t\t2500$\nCygara\t\t\t\t200$\nKij Baseballowy\t\t\t15000$\nTempomat\t\t\t35000$\nMroøony kurczak\t\t15$\nMroøona pizza\t\t\t30$\nMroøony hamburger\t\t25$\nMaseczka ochronna\t\t15000$","KUP","WYJDè");	
}

//end
