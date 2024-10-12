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
gunshoppanel_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	#pragma unused inputtext
	if(dialogid==D_GSPANEL) 
	{
		if(response) 
		{
			switch(listitem) 
			{
				case 0:
				{
					GunShopPanel_Bronie(playerid);
				}
				case 1: 
				{
					new gsid = GetPVarInt(playerid, "gspanel_gsid");

					ShowPlayerDialogEx(playerid, D_GSPANEL_MATS, DIALOG_STYLE_INPUT, "Panel gunshopu > Cena mats", 
						sprintf("Podaj cenê jednej jednostki materia³ów. 0=wy³¹cz bota.\nObecna cena: $%d", GS_MatsCena[gsid]), 
						"Akceptuj", "Wróæ");
				}
			}
		}
		return 1;
	}
	else if(dialogid == D_GSPANEL_BRONIE) 
	{
		if (response) 
		{
			new gsid = GetPVarInt(playerid, "gspanel_gsid");
			new gunid = DynamicGui_GetValue(playerid, listitem);
			new gunName[32], caption[128], string[256];
			GetWeaponName(gunid, gunName, 32);
			format(caption, sizeof(caption), "Panel gunshopu > Ceny broni > %s", gunName);
			format(string, sizeof(string), "Podaj now¹ cenê broni: %s\nTa kwota trafi do twojego sejfu za ka¿dy sprzedany egzemplarz.\nObecna cena: %d$, koszt wytworzenia broni: %d materia³ów", 
				gunName, GS_BronCena[gsid][gunid], floatround(GunInfo[gunid][GunMaterialsCost] * 1.5));
			ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE_SET, DIALOG_STYLE_INPUT, caption, string, "Akceptuj", "Wróæ");
			SetPVarInt(playerid, "gspanel_gunid", gunid);
		} 
		else 
		{
			GunShopPanel(playerid);
		}
		return 1;
	}
	else if(dialogid == D_GSPANEL_BRONIE_SET) 
	{
		if(response) 
		{
			new gsid = GetPVarInt(playerid, "gspanel_gsid");
			new gunid = GetPVarInt(playerid, "gspanel_gunid");
			new cena = FunkcjaK(inputtext);
			if(cena > 0 && cena <= 20000000)
			{
				new gunName[32];
				GetWeaponName(gunid, gunName, 32);
				GS_BronCena[gsid][gunid] = cena;
				SaveGsPanelPrice(gsid, gunid);
				new str[128];
				format(str, 128, "Ustawiono koszt sprzeda¿y %s na $%i", gunName, cena);
				sendTipMessage(playerid, str);
			} 
			else
			{
				sendErrorMessage(playerid, "Niepoprawna cena!");
			}
		}
		GunShopPanel_Bronie(playerid);
		DeletePVar(playerid, "gspanel_gunid");
		return 1;
	}
	else if(dialogid == D_GSPANEL_MATS) 
	{
		if(response) 
		{
			new gsid = GetPVarInt(playerid, "gspanel_gsid");
			new cena = FunkcjaK(inputtext);
			if(cena >= 0 && cena <= 20000) 
			{
				GS_MatsCena[gsid] = cena;
				SaveGsPanelPrice(gsid, 0);
				new str[128];
				if(cena)
				{
					format(str, 128, "Od teraz bot skupuje 1 mats za $%d. 5k mats = $%d", cena, cena*5000);
				}
				else
				{
					format(str, 128, "Wy³¹czono sprzeda¿ materia³ów u bota!");
				}
				sendTipMessage(playerid, str);
				UpdateMats3DText(gsid);
			} 
			else
			{
				sendErrorMessage(playerid, "Niepoprawna cena!");
			}
		}
		GunShopPanel(playerid);
		return 1;
	}
	return 0;
}

//end