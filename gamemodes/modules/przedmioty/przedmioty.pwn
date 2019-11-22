//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 przedmioty                                                //
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
//Opis:
/*

*/
// Autor: Creative
// Data utworzenia: 22.11.2019

//

//-----------------<[ Callbacki: ]>-------------------
//-----------------<[ Funkcje: ]>-------------------
/*PlayerChangeWeapon(playerid)
{
	//SendClientMessageToAll(COLOR_GRAD2, "#5: PlayerChangeWeaponOnInjury");
	//SetPlayerArmedWeapon(playerid, starabron[playerid]);
	PokazDialogPrzedmioty(playerid);
	return 1;
}
*/
PrzedmiotyZmienBron(playerid, weaponid)
{
	starabron[playerid] = weaponid;
	SetPlayerArmedWeapon(playerid, starabron[playerid]);
	return 1;
}
PokazDialogBronie(playerid)
{
	new dialogstring[2048];
	new weapon, ammo;
	for (new i = 0; i <= 12; i++)
	{
		GetPlayerWeaponData(playerid, i, weapon, ammo);
		if(ammo > 0)
		{
			if(isnull(dialogstring)) format(dialogstring, sizeof(dialogstring), "%s\n", dialogstring);
			format(dialogstring, sizeof(dialogstring), "%s%s [%s]", dialogstring, GunNames[weapon]);
		}
	}
	if(isnull(dialogstring)) return sendErrorMessage(playerid, "Nie posiadasz przy sobie ¿adnej broni.");
	return ShowPlayerDialogEx(playerid, D_PRZEDMIOTY_BRONIE, DIALOG_STYLE_LIST, "{4876FF}Mrucznik Role Play » {FFFFFF}Wyci¹gnij broñ", dialogstring, "Wyci¹gnij", "WyjdŸ");
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end