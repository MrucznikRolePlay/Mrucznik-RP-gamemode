//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                 setgroup                                                  //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------

//-------<[ initialize ]>-------
command_setgroup()
{
    new command = Command_GetID("setgroup");

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:setgroup(playerid, params[], help)
{
	new sub[32], rest[126];
	if(sscanf(params, "s[32]S()[126]", sub, rest))
	{
		ShowGroupsForPlayer(playerid);
		SendClientMessage(playerid, COLOR_GREY, "TIP: /g [info/online/v/zapros/zadania/wypros/kolor/wplac/wyplac]");
		return 1;
	}
    if(PlayerInfo[playerid][Group] == 0) return SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ w ¿adnej grupie.");
	if(strcmp(sub, "info", true) == 0)
	{
 		new str[256];
        format(str, sizeof(str), "UID:\t%d\nNazwa:\t%s\nKonto bankowe:\t$%d", GroupInfo[PlayerInfo[playerid][Group]][UID], GroupInfo[PlayerInfo[playerid][Group]][Name], GroupInfo[PlayerInfo[playerid][Group]][Balance]);
		ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", str); 
	}
	/*else if(strcmp(sub, "online", true) == 0)
	{
		ShowOnlineGroupPlayers(playerid);
	}
	else if(strcmp(sub, "zapros", true) == 0)
	{
 		new giveid;
 		if(sscanf(rest, "u", giveid)) return SendClientMessage(playerid, CLR_GRAY, "TIP: /g zapros [id/po³owa nicku]");
		InvitePlayerToGroup(playerid, giveid);
	}
	else if(strcmp(sub, "lider", true) == 0)
	{
	 	new giveid;
 		if(sscanf(rest, "u", giveid)) return SendClientMessage(playerid, CLR_GRAY, "TIP: /g lider [id/po³owa nicku]");
		SetLeaderGroup(playerid, giveid);
	}
	else if(strcmp(sub, "gps", true) == 0)
	{
 		new str[256];
        if(GroupInfo[PlayerInfo[playerid][Group1]][gPerm] & GLOBAL_GROUP_GPS) return 1;
        if(PlayerInfo[playerid][GPS] == 0)
        {
            PlayerInfo[playerid][GPS] = 1;
            PlayerInfo[playerid][gpsIcon] = 0;
            new Float:PlayerPosX[MAX_PLAYERS], Float:PlayerPosY[MAX_PLAYERS], Float:PlayerPosZ[MAX_PLAYERS];
            foreach(Player, i)
            {
                if(PlayerInfo[i][Group1] == PlayerInfo[playerid][Group1] || PlayerInfo[i][Group2] == PlayerInfo[playerid][Group1] || PlayerInfo[i][Group3] == PlayerInfo[playerid][Group1])
                {
                    GetPlayerPos(i, PlayerPosX[i], PlayerPosY[i], PlayerPosZ[i]);
                    SetPlayerMapIcon(playerid, i, PlayerPosX[i], PlayerPosY[i], PlayerPosZ[i], 30, 0xFFFFFFFF, MAPICON_GLOBAL);
                    PlayerInfo[playerid][gpsIcon]++;
                }
            }
            GPSon[playerid] = SetTimerEx("gGPS", 4000, 1, "dd", group, playerid);
        }
        else
        {
            new max_icons = PlayerInfo[playerid][gpsIcon];
            for(new i; i < max_icons; i++)
            {
                RemovePlayerMapIcon(playerid, i);
            }
            KillTimer(GPSon[playerid]);
            PlayerInfo[playerid][GPS] = 0;
        }
	}
	else if(strcmp(sub, "zadania", true) == 0)
	{
		if(group == 1)
		{
			new query2[126], result2[126], uid, player[MAX_PLAYER_NAME], playeruid, groupid, Float:x, Float:y, Float:z, count = 0, str[256];
			format(query2, sizeof(query2), "SELECT * FROM `tasks` WHERE `groupid` = '%d'", PlayerInfo[playerid][Group1]);
			mysql_query(query2);
			mysql_store_result();
			if(mysql_num_rows())
			{
				while(mysql_fetch_row_format(result2, "|") == 1)
				{
					sscanf(result2,  "p<|>ds[32]ddfff", uid, player, playeruid, groupid, x, y, z);
					format(str, sizeof(str), "%s%d\t\t%s (%d)\n", str, playeruid, player);
					count++;
				}
			}
			mysql_free_result();
			if(count != 0)
			{
				ShowPlayerDialog(playerid, DIALOG_SELECT_TASK, DIALOG_STYLE_LIST, ""NAME" » Grupy", str, "Wybierz", "Anuluj");	
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Aktualnie ta grupa nie posiada ¿adnych ¿¹dañ.", "OK", "");
			}
		}
		else if(group == 2)
		{
			new query2[126], result2[126], uid, player[MAX_PLAYER_NAME], playeruid, groupid, Float:x, Float:y, Float:z, count = 0, str[256];
			format(query2, sizeof(query2), "SELECT * FROM `tasks` WHERE `groupid` = '%d'", PlayerInfo[playerid][Group2]);
			mysql_query(query2);
			mysql_store_result();
			if(mysql_num_rows())
			{
				while(mysql_fetch_row_format(result2, "|") == 1)
				{
					sscanf(result2,  "p<|>ds[32]ddfff", uid, player, playeruid, groupid, x, y, z);
					format(str, sizeof(str), "%s%d\t\t%s (%d)\n", str, playeruid, player);
					count++;
				}
			}
			mysql_free_result();
			if(count != 0)
			{
				ShowPlayerDialog(playerid, DIALOG_SELECT_TASK, DIALOG_STYLE_LIST, ""NAME" » Grupy", str, "Wybierz", "Anuluj");	
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Aktualnie ta grupa nie posiada ¿adnych ¿¹dañ.", "OK", "");
			}
		}		
		else if(group == 3)
		{
			new query2[126], result2[126], uid, player[MAX_PLAYER_NAME], playeruid, groupid, Float:x, Float:y, Float:z, count = 0, str[256];
			format(query2, sizeof(query2), "SELECT * FROM `tasks` WHERE `groupid` = '%d'", PlayerInfo[playerid][Group3]);
			mysql_query(query2);
			mysql_store_result();
			if(mysql_num_rows())
			{
				while(mysql_fetch_row_format(result2, "|") == 1)
				{
					sscanf(result2,  "p<|>ds[32]ddfff", uid, player, playeruid, groupid, x, y, z);
					format(str, sizeof(str), "%s%d\t\t%s (%d)\n", str, playeruid, player);
					count++;
				}
			}
			mysql_free_result();
			if(count != 0)
			{
				ShowPlayerDialog(playerid, DIALOG_SELECT_TASK, DIALOG_STYLE_LIST, ""NAME" » Grupy", str, "Wybierz", "Anuluj");	
			}
			else
			{
				ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Aktualnie ta grupa nie posiada ¿adnych ¿¹dañ.", "OK", "");
			}
		}		
	}
	else if(strcmp(sub, "wplac", true) == 0)
	{
		new kwota;
		if(sscanf(rest, "d", kwota)) return SendClientMessage(playerid, CLR_GRAY, "TIP: /g [slot] wplac [kwota]");
 		new str[256];
		if(group == 1)
		{
			if(PlayerInfo[playerid][Group1] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(kwota > PlayerInfo[playerid][Cash]) return 1;
			PlayerInfo[playerid][Cash] -= kwota;
			GivePlayerMoney(playerid, -kwota);
			GroupInfo[PlayerInfo[playerid][Group1]][gCash] += kwota;
  			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie wp³aci³eœ podan¹ kwotê na konto grupy.", "OK", "");
		    SavePlayer(playerid, SAVE_CASH);
			SaveGroup(PlayerInfo[playerid][Group1]);
		}
		else if(group == 2)
		{
			if(PlayerInfo[playerid][Group2] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(kwota > PlayerInfo[playerid][Cash]) return 1;
			PlayerInfo[playerid][Cash] -= kwota;
			GivePlayerMoney(playerid, -kwota);
			GroupInfo[PlayerInfo[playerid][Group2]][gCash] += kwota;
  			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie wp³aci³eœ podan¹ kwotê na konto grupy.", "OK", "");
		    SavePlayer(playerid, SAVE_CASH);
			SaveGroup(PlayerInfo[playerid][Group2]);
		}
		else if(group == 3)
		{
			if(PlayerInfo[playerid][Group3] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(kwota > PlayerInfo[playerid][Cash]) return 1;
			PlayerInfo[playerid][Cash] -= kwota;
			GivePlayerMoney(playerid, -kwota);
			GroupInfo[PlayerInfo[playerid][Group3]][gCash] += kwota;
  			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie wp³aci³eœ podan¹ kwotê na konto grupy.", "OK", "");
		    SavePlayer(playerid, SAVE_CASH);
			SaveGroup(PlayerInfo[playerid][Group3]);
		}
	}
	else if(strcmp(sub, "wyplac", true) == 0)
	{
		new kwota;
		if(sscanf(rest, "d", kwota)) return SendClientMessage(playerid, CLR_GRAY, "TIP: /g [slot] wyplac [kwota]");
 		new str[256];
		if(group == 1)
		{
			if(PlayerInfo[playerid][Group1] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(GroupInfo[PlayerInfo[playerid][Group1]][gPerm] & GLOBAL_GROUP_WYPLAC) return SendClientMessage(playerid, CLR_GRAY, "Ta grupa ma zablokowan¹ mo¿liwoœæ wyp³aty pieniêdzy.");
			if(kwota > GroupInfo[PlayerInfo[playerid][Group1]][gCash]) return 1;
			PlayerInfo[playerid][Cash] += kwota;
			GivePlayerMoney(playerid, kwota);
			GroupInfo[PlayerInfo[playerid][Group1]][gCash] -= kwota;
  			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie wyp³aci³eœ podan¹ kwotê z konta grupy.", "OK", "");
		    SavePlayer(playerid, SAVE_CASH);
			SaveGroup(PlayerInfo[playerid][Group1]);
		}
		else if(group == 2)
		{
			if(PlayerInfo[playerid][Group2] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(GroupInfo[PlayerInfo[playerid][Group2]][gPerm] & GLOBAL_GROUP_WYPLAC) return SendClientMessage(playerid, CLR_GRAY, "Ta grupa ma zablokowan¹ mo¿liwoœæ wyp³aty pieniêdzy.");
			if(kwota > GroupInfo[PlayerInfo[playerid][Group2]][gCash]) return 1;
			PlayerInfo[playerid][Cash] += kwota;
			GivePlayerMoney(playerid, kwota);
			GroupInfo[PlayerInfo[playerid][Group2]][gCash] -= kwota;
  			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie wyp³aci³eœ podan¹ kwotê z konta grupy.", "OK", "");
		    SavePlayer(playerid, SAVE_CASH);
			SaveGroup(PlayerInfo[playerid][Group2]);
		}
		else if(group == 3)
		{
			if(PlayerInfo[playerid][Group3] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(GroupInfo[PlayerInfo[playerid][Group3]][gPerm] & GLOBAL_GROUP_WYPLAC) return SendClientMessage(playerid, CLR_GRAY, "Ta grupa ma zablokowan¹ mo¿liwoœæ wyp³aty pieniêdzy.");
			if(kwota > GroupInfo[PlayerInfo[playerid][Group3]][gCash]) return 1;
			PlayerInfo[playerid][Cash] += kwota;
			GivePlayerMoney(playerid, kwota);
			GroupInfo[PlayerInfo[playerid][Group3]][gCash] -= kwota;
  			ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie wyp³aci³eœ podan¹ kwotê z konta grupy.", "OK", "");
		    SavePlayer(playerid, SAVE_CASH);
			SaveGroup(PlayerInfo[playerid][Group3]);
		}
	}
	else if(strcmp(sub, "v", true) == 0)
	{
 		new str[256];
		if(group == 1)
		{
			if(PlayerInfo[playerid][Group1] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
	        new	list[512], count = 0;
		   	petla(i, MAX_VEH)
			{
			    new vehicleid = GetVehicleID(sVehicles[i][vUID]);
			    if(sVehicles[i][vOwner] == GroupInfo[PlayerInfo[playerid][Group1]][gUID] && i != 0 && sVehicles[i][vOwnerType] == OWNER_GROUP)
			    {
			        if(servVehicle[vehicleid][vehUID] != 0)
					{
						format(list, sizeof(list), "%s\n%d\t%s - Zespawnowany", list, sVehicles[i][vUID], GetVehicleModelName(sVehicles[i][vModel]));
					}
			        else format(list, sizeof(list), "%s\n%d\t%s - Odspawnowany", list, sVehicles[i][vUID], GetVehicleModelName(sVehicles[i][vModel]));
			        count++;
			    }
			}
			if(count > 0) ShowPlayerDialog(playerid, DIALOG_VEHICLE_LIST, DIALOG_STYLE_LIST, ""NAME" » Pojazdy", list, "Od/spawnuj", "Anuluj");
			else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Pojazdy", "Nie posiadasz ¿adnych pojazdów.", "OK", "");
		}
		else if(group == 2)
		{
			if(PlayerInfo[playerid][Group2] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
	        new	list[512], count = 0;
		   	petla(i, MAX_VEH)
			{
			    new vehicleid = GetVehicleID(sVehicles[i][vUID]);
			    if(sVehicles[i][vOwner] == GroupInfo[PlayerInfo[playerid][Group2]][gUID] && i != 0 && sVehicles[i][vOwnerType] == OWNER_GROUP)
			    {
			        if(servVehicle[vehicleid][vehUID] != 0)
					{
						format(list, sizeof(list), "%s\n%d\t%s - Zespawnowany", list, sVehicles[i][vUID], GetVehicleModelName(sVehicles[i][vModel]));
					}
			        else format(list, sizeof(list), "%s\n%d\t%s - Odspawnowany", list, sVehicles[i][vUID], GetVehicleModelName(sVehicles[i][vModel]));
			        count++;
			    }
			}
			if(count > 0) ShowPlayerDialog(playerid, DIALOG_VEHICLE_LIST, DIALOG_STYLE_LIST, ""NAME" » Pojazdy", list, "Od/spawnuj", "Anuluj");
			else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Pojazdy", "Nie posiadasz ¿adnych pojazdów.", "OK", "");
		}
		else if(group == 3)
		{
			if(PlayerInfo[playerid][Group3] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
	        new	list[512], count = 0;
		   	petla(i, MAX_VEH)
			{
			    new vehicleid = GetVehicleID(sVehicles[i][vUID]);
			    if(sVehicles[i][vOwner] == GroupInfo[PlayerInfo[playerid][Group3]][gUID] && i != 0 && sVehicles[i][vOwnerType] == OWNER_GROUP)
			    {
			        if(servVehicle[vehicleid][vehUID] != 0)
					{
						format(list, sizeof(list), "%s\n%d\t%s*", list, sVehicles[i][vUID], GetVehicleModelName(sVehicles[i][vModel]));
					}
			        else format(list, sizeof(list), "%s\n%d\t%s", list, sVehicles[i][vUID], GetVehicleModelName(sVehicles[i][vModel]));
			        count++;
			    }
			}
			if(count > 0) ShowPlayerDialog(playerid, DIALOG_VEHICLE_LIST, DIALOG_STYLE_LIST, ""NAME" » Pojazdy", list, "Od/spawnuj", "Anuluj");
			else ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Pojazdy", "Nie posiadasz ¿adnych pojazdów.", "OK", "");
		}
	}
	else if(strcmp(sub, "kolor", true) == 0)
	{
	    new kolor[11];
		if(sscanf(rest, "s[11]", kolor)) return SendClientMessage(playerid, CLR_GRAY, "TIP: /g [slot] kolor [kolor heksadecymalny]");
 		new str[256];
		if(group == 1)
		{
			if(PlayerInfo[playerid][Group1] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(PlayerInfo[playerid][Group1Upr] & GROUP_PERM_LEADER)
			{
                GroupInfo[PlayerInfo[playerid][Group1]][gColor] = kolor;
                ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie zmieni³eœ kolor swojej grupy.", "OK", "");
				SaveGroup(PlayerInfo[playerid][Group1]);
			}
			else
			{
				SendClientMessage(playerid, CLR_GRAY, "Nie posiadasz uprawnieñ do u¿ycia tej komendy.");
			}
		}
		else if(group == 2)
		{
			if(PlayerInfo[playerid][Group2] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(PlayerInfo[playerid][Group2Upr] & GROUP_PERM_LEADER)
			{
                GroupInfo[PlayerInfo[playerid][Group2]][gColor] = kolor;
                ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie zmieni³eœ kolor swojej grupy.", "OK", "");
				SaveGroup(PlayerInfo[playerid][Group2]);
			}
			else
			{
				SendClientMessage(playerid, CLR_GRAY, "Nie posiadasz uprawnieñ do u¿ycia tej komendy.");
			}
		}
		else if(group == 3)
		{
			if(PlayerInfo[playerid][Group3] == 0) return SendClientMessage(playerid, CLR_GRAY, "Na tym slocie nie posiadasz ¿adnej grupy.");
			if(PlayerInfo[playerid][Group3Upr] & GROUP_PERM_LEADER)
			{
                GroupInfo[PlayerInfo[playerid][Group3]][gColor] = kolor;
                ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, ""NAME" » Grupy", "Pomyœlnie zmieni³eœ kolor swojej grupy.", "OK", "");
				SaveGroup(PlayerInfo[playerid][Group3]);
			}
			else
			{
				SendClientMessage(playerid, CLR_GRAY, "Nie posiadasz uprawnieñ do u¿ycia tej komendy.");
			}
		}
	}
    */
    SendClientMessage(playerid, -1, sprintf("Aresztowanie NA RANGE [%d]: %d", PlayerInfo[playerid][Rank], PermsInfo[PlayerInfo[playerid][Group]][PlayerInfo[playerid][Rank]][GROUP_PERM_ARREST]));
	return 1;
}

YCMD:test2(playerid, params[], help)
{
    PlayerInfo[playerid][Group] = 2;
    new groupid = PlayerInfo[playerid][Group];
    new rankid = PlayerInfo[playerid][Rank];
    PermsInfo[groupid][rankid][GROUP_PERM_ARREST] = 1;
    SendClientMessage(playerid, -1, sprintf("Aresztowanie: %d, Cos tam: %d", PermsInfo[groupid][rankid][GROUP_PERM_ARREST], PermsInfo[groupid][rankid][GROUP_PERM_TEST]));
    return 1;
}