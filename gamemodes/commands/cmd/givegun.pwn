//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ givegun ]------------------------------------------------//
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

YCMD:givegun(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new playa, gun, ammo;
		new string[128];
		if( sscanf(params, "k<fix>dd", playa, gun, ammo))
		{
			sendTipMessage(playerid, "U¿yj /givegun [ID gracza] [Broñ] [Amunicja]");
			SendClientMessage(playerid, COLOR_GRAD4, "3(Club) 4(knife) 5(bat) 6(Shovel) 7(Cue) 8(Katana) 10-13(Dildo) 14(Flowers) 15(Grenades) 16(Tear) 17(Molotovs) 22(Pistol) 23(SPistol)");
			SendClientMessage(playerid, COLOR_GRAD3, "24(Eagle) 25(shotgun) 29(MP5) 30(AK47) 31(M4) 33(Rifle) 34(Sniper) 37(Flamethrower) 41(spray) 42(exting) 43(Camera) 46(Parachute)");
			return 1;
		}

		if(gun < 1||gun > 46)
		{ sendTipMessageEx(playerid, COLOR_GRAD1, "B³êdne ID broni!"); return 1; }

		if(ammo <1||ammo > 99999)
		{ sendTipMessageEx(playerid, COLOR_GRAD1, "Amunicja mo¿e byæ od 1 do 99999 !"); return 1; }
		if(PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
		            if(gun == 1)
		            {
		            	PlayerInfo[playa][pGun0] = gun;
		            	PlayerInfo[playa][pAmmo0] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
		            if(gun >= 2 && gun <= 9)
		            {
		            	PlayerInfo[playa][pGun1] = gun;
		            	PlayerInfo[playa][pAmmo1] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun >= 10 && gun <= 15)
					{
					    PlayerInfo[playa][pGun10] = gun;
		            	PlayerInfo[playa][pAmmo10] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun >= 16 && gun <= 18)
					{
					    PlayerInfo[playa][pGun8] = gun;
		            	PlayerInfo[playa][pAmmo8] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun >= 19 && gun <= 21)
					{
      					SendClientMessage(playerid, COLOR_GREY, "Na tym slocie nie ma broni !");
						return 1;
					}
					else if(gun >= 22 && gun <= 24)
					{
					    PlayerInfo[playa][pGun2] = gun;
		            	PlayerInfo[playa][pAmmo2] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun >= 25 && gun <= 27)
					{
					    PlayerInfo[playa][pGun3] = gun;
		            	PlayerInfo[playa][pAmmo3] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun == 28 || gun == 29 || gun == 32)
					{
					    PlayerInfo[playa][pGun4] = gun;
		            	PlayerInfo[playa][pAmmo4] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun == 30 || gun == 31)
					{
					    PlayerInfo[playa][pGun5] = gun;
		            	PlayerInfo[playa][pAmmo5] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if(gun == 33 || gun == 34)
					{
					    PlayerInfo[playa][pGun6] = gun;
		            	PlayerInfo[playa][pAmmo6] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if( gun == 39)
					{
					    PlayerInfo[playa][pGun8] = gun;
		            	PlayerInfo[playa][pAmmo8] = ammo;
		            	PlayerInfo[playa][pGun12] = 40;
		            	PlayerInfo[playa][pAmmo12] = 1;
						GivePlayerWeapon(playa, gun, ammo);
						GivePlayerWeapon(playa, 40, 1);
					}
					else if( gun >= 35 || gun <= 38)
					{
					    PlayerInfo[playa][pGun7] = gun;
		            	PlayerInfo[playa][pAmmo7] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if( gun >= 41 || gun <= 43)
					{
					    PlayerInfo[playa][pGun9] = gun;
		            	PlayerInfo[playa][pAmmo9] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else if( gun == 46)
					{
					    PlayerInfo[playa][pGun11] = gun;
		            	PlayerInfo[playa][pAmmo11] = ammo;
						GivePlayerWeapon(playa, gun, ammo);
					}
					else
					{
					    SendClientMessage(playerid, COLOR_GREY, "Broñ zablokowana lub nie istnieje !");
					    return 1;
					}
					
					//logi broñ
					format(string, sizeof(string), "Admin %s dal bron (ID:[%d], AMMO:[%d]) graczowi %s.", GetNickEx(playerid), gun, ammo, GetNick(playa));
					SendCommandLogMessage(string);
					Log(adminLog, INFO, "Admin %s da³ graczowi %s broñ %s", GetPlayerLogName(playerid), GetPlayerLogName(playa), GetWeaponLogName(gun, ammo));
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
