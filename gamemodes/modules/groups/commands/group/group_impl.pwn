//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   group                                                   //
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
// Autor: Creative
// Data utworzenia: 28.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_group_Impl(playerid, sub[32], rest[126])
{
    if(strcmp(sub, "info", true) == 0)
	{
 		new str[256];
        format(str, sizeof(str), "{FFFFFF}UID:\t%d\nNazwa:\t%s\nKolor:\t{%s}#%s{FFFFFF}\nKonto bankowe:\t$%d", GroupInfo[PlayerInfo[playerid][pGroup]][gUID], GroupInfo[PlayerInfo[playerid][pGroup]][gName], GroupInfo[PlayerInfo[playerid][pGroup]][gColor], GroupInfo[PlayerInfo[playerid][pGroup]][gColor], GroupInfo[PlayerInfo[playerid][pGroup]][gBalance]);
		ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", str); 
	}
	else if(strcmp(sub, "online", true) == 0)
	{
		ShowOnlineGroupPlayers(playerid);
	}
	else if(strcmp(sub, "zapros", true) == 0)
	{
		//uprawnienia lidera?
 		new giveid;
 		if(sscanf(rest, "k<fix>", giveid)) return sendTipMessage(playerid, "TIP: /g zapros [id/po³owa nicku]");
		if(giveid != INVALID_PLAYER_ID)
		{
			if(GetDistanceBetweenPlayers(playerid, giveid) < 5)
			{
				InvitePlayerToGroup(playerid, giveid);
			}
			else
			{
				return sendTipMessage(playerid, "Gracz musi byæ przy Tobie!", COLOR_LIGHTBLUE);				            
			}
		}
	}
	/*else if(strcmp(sub, "lider", true) == 0)
	{
	 	new giveid;
 		if(sscanf(rest, "k<fix>", giveid)) return SendClientMessage(playerid, CLR_GRAY, "TIP: /g lider [id/po³owa nicku]");
		//SetLeaderGroup(playerid, giveid);
		//tu save vlidera
	}*/
	else if(strcmp(sub, "gps", true) == 0)
	{
        if(!PermsInfo[PlayerInfo[playerid][pGroup]][PlayerInfo[playerid][pRank]][GROUP_PERM_GPS]) return 1;
		if(!IsPlayerInAnyVehicle(playerid)) return sendTipMessage(playerid, "Musisz byæ w pojeŸdzie grupy.");
		//+ sprawdzanie czy pojazd nalezy do grupy
        if(PlayerInfo[playerid][pGPS] == 0)
        {
            PlayerInfo[playerid][pGPS] = 1;
            PlayerInfo[playerid][pGPSIcon] = 0;
            new Float:PlayerPosX[MAX_PLAYERS], Float:PlayerPosY[MAX_PLAYERS], Float:PlayerPosZ[MAX_PLAYERS];
            foreach(new i : Player)
            {
                if(PlayerInfo[i][pGroup] == PlayerInfo[playerid][pGroup] && PlayerInfo[i][pGroupDuty])
                {
                    GetPlayerPos(i, PlayerPosX[i], PlayerPosY[i], PlayerPosZ[i]);
                    SetPlayerMapIcon(playerid, i, PlayerPosX[i], PlayerPosY[i], PlayerPosZ[i], 30, 0xFFFFFFFF, MAPICON_GLOBAL);
                    PlayerInfo[playerid][pGPSIcon]++;
                }
            }
			ProxDetector(60.0, playerid, sprintf("* %s aktywowa³ namierzanie GPS.", GetNick(playerid)), COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            Groups_GPS[playerid] = SetTimerEx("gGPS", 4000, 1, "d", playerid);
        }
        else
        {
            new max_icons = PlayerInfo[playerid][pGPSIcon];
            for(new i; i < max_icons; i++)
            {
                RemovePlayerMapIcon(playerid, i);
            }
            KillTimer(Groups_GPS[playerid]);
            PlayerInfo[playerid][pGPS] = 0;
        }
	}
	/*
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
	*/
	else if(strcmp(sub, "wplac", true) == 0)
	{
		new kwota;
		if(sscanf(rest, "d", kwota)) return sendTipMessage(playerid, "U¿yj: /g wplac [kwota]");
		if(kaska[playerid] < kwota) return sendErrorMessage(playerid, "Nie masz tyle kasy!");
		ZabierzKase(playerid, kwota);
		GroupInfo[PlayerInfo[playerid][pGroup]][gBalance] += kwota;
		ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Pomyœlnie wp³aci³eœ podan¹ kwotê na konto grupy."); 
		MruMySQL_SaveGroup(PlayerInfo[playerid][pGroup]);
	}
	else if(strcmp(sub, "wyplac", true) == 0)
	{
		new kwota;
		if(sscanf(rest, "d", kwota)) return sendTipMessage(playerid, "U¿yj: /g wyplac [kwota]");
		if(PermsInfo[PlayerInfo[playerid][pGroup]][PlayerInfo[playerid][pRank]][GROUP_PERM_WYPLAC]) return sendErrorMessage(playerid, "Na tej randze masz zablokowan¹ mo¿liwoœæ wyp³aty pieniêdzy z grupy.");
		if(kwota > GroupInfo[PlayerInfo[playerid][pGroup]][gBalance]) return sendErrorMessage(playerid, "Na koncie grupy nie ma tyle kasy!");
		DajKase(playerid, kwota);
		GroupInfo[PlayerInfo[playerid][pGroup]][gBalance] -= kwota;
		ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", "Pomyœlnie wyp³aci³eœ podan¹ kwotê z konta grupy."); 
		MruMySQL_SaveGroup(PlayerInfo[playerid][pGroup]);
	}
	/*
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

    
    return 1;
}

//end