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
command_przedmiotycmd_Impl(playerid, params[256])
{
    if(gPlayerLogged[playerid] == 1 && IsPlayerConnected(playerid))
    {
		if(PlayerInfo[playerid][pInjury] > 0 || PlayerInfo[playerid][pBW] > 0) return 1;
		new playerState = GetPlayerState(playerid);
		if(playerState == 1)
		{
			new option[128];
			if(!sscanf(params, "s[128]", option)) { //jesli wpisal string (/p [BRON])
				new itemexist = 0, weaponid = 0, ammo, weapondata;
				for (new i = 0; i <= 12; i++)
				{
					GetPlayerWeaponData(playerid, i, weaponid, ammo);
					if(ammo > 0)
					{
						if(weaponid == 24 && (strfind("Paralizator", option, true) != -1 || strfind("Tazer", option, true) != -1) && (IsAPolicja(playerid) || IsABOR(playerid)) && (OnDuty[playerid] == 1 || OnDutyCD[playerid] == 1))
						{
							itemexist = 24;
							weapondata = 1;
						}
						else if(strfind(GunNames[weaponid], option, true) != -1) 
						{
							itemexist = weaponid;
							//wyciagniecie broni
						}
					}
				}
				return (itemexist == 0) ? PokazDialogBronie(playerid) : PrzedmiotyZmienBron(playerid, itemexist, weapondata);
			}
			else //domyœlne gui
			{
				return PokazDialogBronie(playerid);
			}
		}
	}
	return 1;
}

//end
