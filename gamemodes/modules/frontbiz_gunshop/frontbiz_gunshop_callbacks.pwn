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
GunShop_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
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
						sprintf("Podaj cen� jednej jednostki materia��w. 0=wy��cz bota.\nObecna cena: $%d", GS_MatsCena[gsid]), 
						"Akceptuj", "Wr��");
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
			new gunIdx = GetGunIndex(gunid);
			new gunName[32], caption[128], string[256];
			GetWeaponName(gunid, gunName, 32);
			format(caption, sizeof(caption), "Panel gunshopu > Ceny broni > %s", gunName);
			format(string, sizeof(string), "Podaj now� cen� broni: %s\nTa kwota trafi do twojego sejfu za ka�dy sprzedany egzemplarz.\nObecna cena: %d$, koszt wytworzenia broni: %d materia��w", 
				gunName, GS_BronCena[gsid][gunid], GunInfo[gunIdx][GunMaterialsCost]);
			ShowPlayerDialogEx(playerid, D_GSPANEL_BRONIE_SET, DIALOG_STYLE_INPUT, caption, string, "Akceptuj", "Wr��");
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
				format(str, 128, "Ustawiono koszt sprzeda�y %s na $%i", gunName, cena);
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
					format(str, 128, "Wy��czono sprzeda� materia��w u bota!");
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
    else if(dialogid == D_GSPANEL_KUPBRON)
    {
        if(response)
        {
			new bizId = GetPVarInt(playerid, "gunshop_bizId");
			new gsid = GetPVarInt(playerid, "gunshop_gsid");
			new gunid = GS_Guns[listitem];
			new gunPrice = GS_BronCena[gsid][gunid];
			new gunIdx = GetGunIndex(gunid);
			new matsPrice = GunInfo[gunIdx][GunMaterialsCost];
			new contrabandPrice = GunInfo[gunIdx][GunContrabandCost];
			new org = FrontBusiness[bizId][Owner];
			new weaponName[32];
			GetWeaponName(gunid, weaponName);

			if(gunPrice <= 0)
			{
				MruMessageFail(playerid, "Nie sprzedajemy tej broni!");
				ShowBuyGunDialog(playerid);
				return 1;
			}

			if(kaska[playerid] < gunPrice)
			{
				MruMessageFail(playerid, "Nie sta� ci� na t� bro�!");
				ShowBuyGunDialog(playerid);
				return 1;
			}

			if(Rodzina_Mats[org] < matsPrice)
			{
				MruMessageFail(playerid, "Gun Shop nie ma tyle materia��w, by sprzeda� Ci t� bro�.");
				ShowBuyGunDialog(playerid);
				return 1;
			}

			if(Rodzina_Contraband[org] < contrabandPrice)
			{
				MruMessageFail(playerid, "Gun Shop nie ma tyle kontrabandy, by sprzeda� Ci t� bro�.");
				ShowBuyGunDialog(playerid);
				return 1;
			}

			GivePlayerWeaponEx(playerid, gunid, GunInfo[gunIdx][GunAmmo], true);

			ZabierzKase(playerid, gunPrice);
			SejfR_Add(org, gunPrice);
			SejfR_AddMats(org, -matsPrice);
			SejfR_AddContraband(org, -contrabandPrice);

			MruMessageGoodInfo(playerid, sprintf("Kupi�e� bro� %s za %d$.", weaponName, gunPrice));
			SendOrgMessage(org, TEAM_AZTECAS_COLOR, sprintf("%s: %s kupi� %s za %d$, koszt stworzenia: %dm + %dc, stan materia��w: %d", 
				FrontBusiness[bizId][Name], GetNick(playerid), weaponName, gunPrice, matsPrice, contrabandPrice, Rodzina_Mats[org], Rodzina_Contraband[org]));
			Log(payLog, INFO, "Gracz %s kupi� %s za %d$ od organizacji %d biznes %d koszt: %dm + %dc, stan: %dm + %dc", 
				GetPlayerLogName(playerid), weaponName, gunPrice, org, bizId, matsPrice, contrabandPrice, Rodzina_Mats[org], Rodzina_Contraband[org]);
        }
        return 1;
    }
	return 0;
}

//end