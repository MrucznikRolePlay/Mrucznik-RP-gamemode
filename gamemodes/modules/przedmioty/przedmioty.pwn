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
stock GetWeaponChangeDelay(currentWeapon, changedWeapon)
{
	return WeaponsDelay[currentWeapon]/4 + WeaponsDelay[changedWeapon];
}

public PlayerChangeWeapon(playerid, newweaponid)
{
	starabron[playerid] = newweaponid;
	SetPlayerArmedWeapon(playerid, starabron[playerid]);
	AntySpam[playerid] = 0;
	return 1;
}
PrzedmiotyZmienBron(playerid, weaponid, weapondata = 0)
{
	if(AntySpam[playerid] == 1)
	{
		return sendTipMessageEx(playerid, COLOR_GRAD3, "Wyci¹gasz ju¿ broñ...");
	}

	new string[144], specNAME[144], i, gname[54];
	i = playerid;
	GetPlayerName(playerid, specNAME, sizeof(specNAME));
	
	if(weaponid > 1)
	{
		if(starabron[playerid] == 24 && GetPVarInt(playerid, "tazer") == 1)
		{
			format(gname, sizeof(gname), "Paralizator");
			SetPVarInt(playerid, "tazer", 0);
		}
		else
		{
			format(gname, sizeof(gname), "%s", GunNames[starabron[playerid]]);
		}
		if(starabron[playerid] > 1) format(specNAME, sizeof(specNAME), "%s chowa %s i", specNAME, gname);
	}

	switch(weaponid)
	{
		case 0:
		{
			format(string, sizeof(string), "* %s chowa Broñ.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 1:
		{
			format(string, sizeof(string), "* %s chowa Broñ.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 2:
		{
			format(string, sizeof(string), "* %s wyci¹ga Kij Golfowy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 3:
		{
			format(string, sizeof(string), "* %s wyci¹ga Pa³kê Policyjn¹.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 4:
		{
			format(string, sizeof(string), "* %s wyci¹ga Nó¿.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 5:
		{
			format(string, sizeof(string), "* %s wyci¹ga Bejzbol.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 6:
		{
			format(string, sizeof(string), "* %s wyci¹ga £opatê.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 7:
		{
			format(string, sizeof(string), "* %s wyci¹ga Kij Bilardowy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 8:
		{
			format(string, sizeof(string), "* %s wyci¹ga Katane.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 9:
		{
			format(string, sizeof(string), "* %s wyci¹ga Pi³ê Mechaniczn¹.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 14:
		{
			format(string, sizeof(string), "* %s wyci¹ga Kwiaty.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 15:
		{
			format(string, sizeof(string), "* %s wyci¹ga Dêbow¹ Laskê.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 16:
		{
			format(string, sizeof(string), "* %s wyci¹ga Granat.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 17:
		{
			format(string, sizeof(string), "* %s wyci¹ga Gaz £zawi¹cy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 18:
		{
			format(string, sizeof(string), "* %s wyci¹ga Koktajl Mo³otova.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		//bron 19 20 i 21 nie istnieje

		case 22:
		{
			format(string, sizeof(string), "* %s wyci¹ga z kieszeni Pistolety 9mm.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 23:
		{
			format(string, sizeof(string), "* %s wyci¹ga Pistolet z T³umikiem.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 24:
		{
			if(weapondata == 1)
			{
				MaTazer[playerid] = 1;
				//SetPVarInt(playerid, "tazer", 1);
				format(string, sizeof(string), "* %s wyci¹ga Paralizator.", specNAME);
				SetPlayerAmmo(playerid, 24, 10);
			}
			else
			{
				format(string, sizeof(string), "* %s wyci¹ga Pistolet Deagle.", specNAME);
			}
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 25:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli Shotgun'a.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 26:
		{
			format(string, sizeof(string), "* %s wyci¹ga z rzeŸni Obrzyny.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 27:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli Spas-12.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 28:
		{
			format(string, sizeof(string), "* %s wyci¹ga z kabury UZI.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 29:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli MP5.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 30:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli AK47.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 31:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli M4.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 32:
		{
			format(string, sizeof(string), "* %s wyci¹ga z kabury TEC-9.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 33:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli Strzelbê.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 34:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza koszuli Snajperkê.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 35:
		{
			format(string, sizeof(string), "* %s wyci¹ga zza ucha RPG.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 36:
		{
			format(string, sizeof(string), "* %s wyczarowuje Rakietnice.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 37:
		{
			format(string, sizeof(string), "* %s wyci¹ga z ognia Miotacz Ognia.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 38:
		{
			format(string, sizeof(string), "* %s wysrywa miniguna.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 39:
		{
			format(string, sizeof(string), "* %s wyci¹ga z torby C4.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 40:
		{
			format(string, sizeof(string), "* %s wyci¹ga detonator.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 41:
		{
			format(string, sizeof(string), "* %s wyci¹ga Gaz Pieprzowy / Spray.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 42:
		{
			format(string, sizeof(string), "* %s wyci¹ga Gaœnicê.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 43:
		{
			format(string, sizeof(string), "* %s wyci¹ga Aparat Fotograficzny.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}

		case 44:
		{
			format(string, sizeof(string), "* %s wyci¹ga noktowizor", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			ResetPlayerWeapons(i);
		}

		case 45:
		{
			format(string, sizeof(string), "* %s wyci¹ga termowizor.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			ResetPlayerWeapons(i);
		}

		case 46:
		{
			format(string, sizeof(string), "* %s zak³ada Spadochron na plecy.", specNAME);
			ProxDetector(10.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}

	AntySpam[playerid] = 1;
	SetTimerEx("PlayerChangeWeapon", GetWeaponChangeDelay(starabron[playerid], weaponid), false, "dd", playerid, weaponid);
	//starabron[playerid] = weaponid;
	//SetPlayerArmedWeapon(playerid, starabron[playerid]);
	return 1;
}
PokazDialogBronie(playerid)
{
	if(GUIExit[playerid] != 0)
	{
		return SetPlayerArmedWeapon(playerid, starabron[playerid]);
	}
	GUIExit[playerid] = 1;
	DynamicGui_Init(playerid);
	SetPlayerArmedWeapon(playerid, starabron[playerid]);
	new dialogstring[2048], weaponexist = 0, active[144];
	DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun0], PlayerInfo[playerid][pGun0]);
	if(PlayerInfo[playerid][pGun0] == starabron[playerid])
	{
		format(active, sizeof(active), "{FAD82D}» {FAD82D}");
	}
	else
	{
		format(active, sizeof(active), "{FFFFFF}");
	}
	format(dialogstring, sizeof(dialogstring), "%s%s", active, GunNames[PlayerInfo[playerid][pGun0]]);
	if(PlayerInfo[playerid][pGun1] >= 2)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pGun1]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun1] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun1]]);
	}
	if(PlayerInfo[playerid][pGun2] >= 2 && PlayerInfo[playerid][pAmmo2] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pGun2]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun2] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun2]]);
	}
	if(PlayerInfo[playerid][pGun3] >= 2 && PlayerInfo[playerid][pAmmo3] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pGun3]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun3] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun3]]);
	}
	if(PlayerInfo[playerid][pGun4] >= 2 && PlayerInfo[playerid][pAmmo4] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pGun4]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun4] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun4]]);
	}
	if(PlayerInfo[playerid][pGun5] >= 2 && PlayerInfo[playerid][pAmmo5] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun5], PlayerInfo[playerid][pGun5]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun5] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun5]]);
	}
	if(PlayerInfo[playerid][pGun6] >= 2 && PlayerInfo[playerid][pAmmo6] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun6], PlayerInfo[playerid][pGun6]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun6] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun6]]);
	}
	if(PlayerInfo[playerid][pGun7] >= 2 && PlayerInfo[playerid][pAmmo7] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun7], PlayerInfo[playerid][pGun7]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun7] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun7]]);
	}
	if(PlayerInfo[playerid][pGun8] >= 2 && PlayerInfo[playerid][pAmmo8] >= 1)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun8], PlayerInfo[playerid][pGun8]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun8] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun8]]);
	}
	if(PlayerInfo[playerid][pGun9] >= 2  && PlayerInfo[playerid][pAmmo9] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun9], PlayerInfo[playerid][pGun9]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun9] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun9]]);
	}
	if(PlayerInfo[playerid][pGun10] >= 2)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun10], PlayerInfo[playerid][pGun10]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun10] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun10]]);
	}
	if(PlayerInfo[playerid][pGun11] >= 2  && PlayerInfo[playerid][pAmmo11] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun11], PlayerInfo[playerid][pGun11]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun11] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun11]]);
	}
	if(PlayerInfo[playerid][pGun12] >= 2  && PlayerInfo[playerid][pAmmo12] >= 10)
	{
		DynamicGui_AddRow(playerid, PlayerInfo[playerid][pGun12], PlayerInfo[playerid][pGun12]);
		weaponexist = 1;
		if(PlayerInfo[playerid][pGun12] == starabron[playerid])
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, GunNames[PlayerInfo[playerid][pGun12]]);
	}
	if((IsACop(playerid) || IsABOR(playerid)) && (OnDuty[playerid] == 1 || OnDutyCD[playerid] == 1))
	{
		DynamicGui_AddRow(playerid, 1, 24); //paralizator
		weaponexist = 1;
		if(24 == starabron[playerid] && GetPVarInt(playerid, "tazer") == 1)
		{
			format(active, sizeof(active), "{FAD82D}» {FAD82D}");
		}
		else
		{
			format(active, sizeof(active), "{FFFFFF}");
		}
		format(dialogstring, sizeof(dialogstring), "%s\n%s%s", dialogstring, active, "Paralizator");
	}

	if(!weaponexist) return sendErrorMessage(playerid, "Nie posiadasz przy sobie ¿adnej broni.");
	return ShowPlayerDialogEx(playerid, D_PRZEDMIOTY_BRONIE, DIALOG_STYLE_LIST, "{FFFFFF}Wyci¹gnij broñ (/togscroll) (/p [nazwa])", dialogstring, "Wyci¹gnij", "WyjdŸ");
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end