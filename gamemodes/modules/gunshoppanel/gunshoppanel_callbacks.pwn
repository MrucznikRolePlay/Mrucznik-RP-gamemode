//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                gunshoppanel                                               //
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
// Autor: wiger
// Data utworzenia: 18.02.2024
//Opis:
/*
	Panel zarzadzania sklepem z bronia
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
gunshoppanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	#pragma unused inputtext
	if(dialogid==D_GSPANEL) {
		if(response) {
			switch(listitem) {
				case 0:
					dgspanel_bronie(playerid);
				case 1:
					sendTipMessage(playerid, "Ceny mats");
			}
		}
		return 1;
	}
	else if(dialogid == D_GSPANEL_BRONIE) {
		if (response) {
			new gsid = GetPlayerOrg(playerid)-21;
			new gunid = DynamicGui_GetValue(playerid, listitem);
			new gunName[32], caption[128], string[256];
			GetWeaponName(gunid, gunName, 32);
			format(caption, sizeof(caption), "Panel gunshopu > Ceny broni > %s", gunName);
			format(string, sizeof(string), "Podaj koszt jaki chcesz ¿eby zabiera³o sprzedawcy za sprzeda¿ broni: %s\nTa kwota trafi do twojego sejfu za ka¿dy sprzedany egzemplarz.\nObecna cena: %d$", gunName, GS_BronCena[gsid][gunid]);
			ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE_SET, DIALOG_STYLE_INPUT, caption, string, "Akceptuj", "Wróæ");
			SetPVarInt(playerid, "gspanel_gunid", gunid);
		} else {
			dgspanel(playerid);
		}
		return 1;
	}
	else if(dialogid == D_GSPANEL_BRONIE_SET) {
		if(response) {
			new gsid = GetPlayerOrg(playerid)-21;
			new gunid = GetPVarInt(playerid, "gspanel_gunid");
			new cena = FunkcjaK(inputtext);
			if(cena > 0) {
				new gunName[32];
				GetWeaponName(gunid, gunName, 32);
				GS_BronCena[gsid][gunid] = cena;
				SaveGsPanelPrice(gsid, gunid);
				new str[128];
				format(str, 128, "Ustawiono koszt sprzedazy %s na $%i", gunName, cena);
				sendTipMessage(playerid, str);
			} else
				sendErrorMessage(playerid, "Niepoprawna cena!");
		}
		dgspanel_bronie(playerid);
		DeletePVar(playerid, "gspanel_gunid");
		return 1;
	}
	return 0;
}

//end