//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ glosowanie ]----------------------------------------------//
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

CMD:glosowanie(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		new timeValue;
		new result[128];
		new string[256];
		if(sscanf(params, "ds[128]", timeValue, result))
		{
			sendTipMessage(playerid, "U¿yj /glosowanie [czas_trwania_w_minutach] [temat]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] >= 200 || IsAScripter(playerid))
		{
			if(strlen(result) > 120)
			{
				sendErrorMessage(playerid, "Za d³ugi temat"); 
				return 1;
			}
			if(glosowanie_admina_status == 1)
			{
				sendTipMessage(playerid, "Aktualnie trwa g³osowanie"); 
				return 1;
			}	
			//_____WYKONUJEMY KOD____
			
			if(GetPlayerAdminDutyStatus(playerid) == 1)
			{
				iloscInne[playerid]++; 
			}
			format(string, sizeof(string), "Admin %s rozpocz¹³ ankietê na temat:{C0C0C0}%s", GetNick(playerid), result);
			SendClientMessageToAll(COLOR_RED, string);
			SendClientMessageToAll(COLOR_WHITE,  "Aby zag³osowaæ wpisz /glosuja");
			format(string, sizeof(string), "G³osowanie potrwa %d minut", timeValue); 
			SendClientMessageToAll(COLOR_WHITE, string);
			glosowanie_admina_status = 1;
			glosowanie_admina_tak = 0;
			glosowanie_admina_nie = 0;
			format(string, sizeof(string), "Zmienna po przeliczeniu to %d", (timeValue*60000));
			sendTipMessage(playerid, string); 
			SetTimer("glosuj_admin_ankieta", (timeValue*60000), false);
			foreach(new i : Player)
			{
				SetPVarInt(i, "glosowal_w_ankiecie", 0);
			}
		}
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
	}
	return 1;
}

