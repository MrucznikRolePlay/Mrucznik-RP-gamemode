//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ przedmioty ]----------------------------------------------//
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
	Zal¹¿ek systemu przedmiotów, na razie w formie systemu broni
*/

YCMD:przedmioty(playerid, params[], help)
{
    if(gPlayerLogged[playerid] == 1 && IsPlayerConnected(playerid))
    {
		new option[128], itemexist;
		if(!sscanf(params, "s[128]", option)) { //jesli wpisal string (/p [BRON])
			itemexist = 0;
			for (new i = 0; i <= 12; i++)
			{
				GetPlayerWeaponData(playerid, i, weapon, ammo);
				if(ammo > 0)
				{
					if(strcmp(weapon, option, true) == 0)
					{
						itemexist = weapon;
						//wyciagniecie broni
					}
				}
			}
			return (itemexist == 0) ? PokazDialogPrzedmioty(playerid) : PrzedmiotyZmienBron(playerid, itemexist);
		}
		else //domyœlne gui
		{
			return PokazDialogPrzedmioty(playerid);
		}
	}
	return 1;
}
