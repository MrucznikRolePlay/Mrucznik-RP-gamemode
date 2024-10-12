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
command_kontakty_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pPnumber] == 0)
	{
		sendErrorMessage(playerid, "Nie masz telefonu, nie mo¿esz wpisaæ tam swoich kontaktów.");
		return 1;
	}

	new opcja[32];
	if(sscanf(params, "s[32] ", opcja))
	{
		sendTipMessage(playerid, "U¿yj /kontakty [dzwoñ/sms/dodaj/edytuj/usuñ/lista]");
		return 1;
	}
	
	if(strcmp(opcja, "dodaj", true) == 0)
	{
		if(!CzyMaWolnySlotNaKontakt(playerid))
		{
			sendErrorMessage(playerid, "Osi¹gn¹³eœ maksymaln¹ liczbê kontaktów.");
			return 1;
		}
	
		new nazwa[MAX_KONTAKT_NAME_1], numer;
		if(sscanf(params, "s[32]ds["#MAX_KONTAKT_NAME_1"]", opcja, numer, nazwa))
		{
			sendTipMessage(playerid, "U¿yj /kontakty dodaj [numer] [nazwa - max 32znaki]");
			return 1;
		}
		
		
		if(strlen(nazwa) > MAX_KONTAKT_NAME)
		{
			sendErrorMessage(playerid, "Nazwa kontaktu mo¿e mieæ maksymalnie "#MAX_KONTAKT_NAME" znaki!");
			return 1;
		}
		
		DodajKontakt(playerid, nazwa, numer);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, "Kontakt dodany.");
	}
	else
	{
		if(!CzyGraczMaKontakty(playerid))
		{
			sendErrorMessage(playerid, "Nie posiadasz jeszcze ¿adnego kontaktu, wpisz /kontakty dodaj aby dodaæ kontakt.");
			return 1;
		}
	
		if(strcmp(opcja, "dzwon", true) == 0 || strcmp(opcja, "dzwoñ", true) == 0)
		{
			ShowPlayerDialogEx(playerid, D_KONTAKTY_DZWON, DIALOG_STYLE_LIST, "Kontakty - dzwoñ", ListaKontaktowGracza(playerid), "Dzwoñ", "Zamknij");
		}
		else if(strcmp(opcja, "sms", true) == 0)
		{
			ShowPlayerDialogEx(playerid, D_KONTAKTY_SMS, DIALOG_STYLE_LIST, "Kontakty - SMS", ListaKontaktowGracza(playerid), "Wyœlj SMS", "Zamknij");
		}
		else if(strcmp(opcja, "edytuj", true) == 0)
		{
			ShowPlayerDialogEx(playerid, D_KONTAKTY_EDYTUJ, DIALOG_STYLE_LIST, "Kontakty - edytuj", ListaKontaktowGracza(playerid), "Edytuj", "Zamknij");
		}
		else if(strcmp(opcja, "usun", true) == 0 || strcmp(opcja, "usuñ", true) == 0)
		{
			ShowPlayerDialogEx(playerid, D_KONTAKTY_USUN, DIALOG_STYLE_LIST, "Kontakty - usuñ", ListaKontaktowGracza(playerid), "Usuñ", "Zamknij");
		}
		else if(strcmp(opcja, "lista", true) == 0)
		{
			ShowPlayerDialogEx(playerid, D_KONTAKTY_LISTA, DIALOG_STYLE_LIST, "Kontakty - lista", ListaKontaktowGracza(playerid), "Wyœwietl", "WyjdŸ");
		}
	}
	return 1;
}

//end
