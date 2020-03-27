//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                                  groups                                                   //
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
// Data utworzenia: 22.03.2020
//Opis:
/*
	System grup.
*/

//


//------------------<[ MySQL: ]>--------------------
forward MruMySQL_LoadGroups();
public MruMySQL_LoadGroups()
{
	new result[450], query[32], i = 0;
    format(query, sizeof(query), "SELECT * FROM `mru_groups`");
	mysql_query(query);

    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new uid;
    	sscanf(result, "p<|>d", uid);
		sscanf(result,  "p<|>dds[32]s[6]ffffddd", 
			GroupInfo[uid][UID],
			GroupInfo[uid][Type],
			GroupInfo[uid][Name],
			GroupInfo[uid][Color],
			GroupInfo[uid][SpawnX],
			GroupInfo[uid][SpawnY],
			GroupInfo[uid][SpawnZ],
			GroupInfo[uid][SpawnA],
			GroupInfo[uid][SpawnVW],
			GroupInfo[uid][SpawnINT],
			GroupInfo[uid][Balance]
		);
		MruMySQL_LoadRanks(uid);
		i++;
	}
	mysql_free_result();
	printf("Grupy - %d", i);
}

forward MruMySQL_LoadRanks(gid);
public MruMySQL_LoadRanks(gid)
{
	new result[450], query[32], i = 0;
    format(query, sizeof(query), "SELECT * FROM `mru_groups_rank` WHERE `group_id` = '%d'", gid);
	mysql_query(query);

    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
		new recordid, group_id, level, name;
		sscanf(result,  "p<|>dds[32]", 
			recordid,
			group_id,
			level,
			name
		);

		RankInfo[gid][level][Name] = name;
		RankInfo[gid][level][Level] = level;
		i++;
	}
	mysql_free_result();
	printf("Za³adowano rangi dla grupy [%d] - %d", gid, i);
	MruMySQL_LoadRanksPerms(gid);
}

forward MruMySQL_LoadRanksPerms(gid);
public MruMySQL_LoadRanksPerms(gid)
{
	new result[450], query[32], i = 0;
    format(query, sizeof(query), "SELECT * FROM `mru_groups_perm` WHERE `group_id` = '%d'", gid);
	mysql_query(query);

    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
		new recordid, group_id, level;
		new permissions[2] = {0,0};
		sscanf(result,  "p<|>dds[32]", 
			recordid,
			group_id,
			level,
			name,
			permissions[0],
			permissions[1]
		);

		PermsInfo[group_id][level][GROUP_PERM_TEST] = permissions[GROUP_PERM_TEST];
		PermsInfo[group_id][level][GROUP_PERM_ARREST] = permissions[GROUP_PERM_ARREST];
		i++;
	}
	mysql_free_result();
	printf("Za³adowano uprawnienia rang dla grupy [%d] - %d", gid, i);
}

//end