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
forward UnloadPlayerItems(playerid);
public UnloadPlayerItems(playerid)
{
	new find = 0;
	for(new i = 0, i < MAX_ITEMS; i++)
	{
	    if(ItemCache[i][iOwner] == PlayerInfo[playerid][pUID] && ItemCache[i][iUse] != 0 && ItemCache[i][iOwnertype] == OWNER_PLAYER)
	    {
	        ItemCache[i][iUID] = 0;
			ItemCache[i][iOwner] = 0;
			ItemCache[i][iType] = 0;
			ItemCache[i][iValue1] = 0;
			ItemCache[i][iValue2] = 0;
			format(ItemCache[i][iName], 32, "%s", 0);
			ItemCache[i][iOwnertype] = 0;
			ItemCache[i][iX] = 0;
			ItemCache[i][iY] = 0;
			ItemCache[i][iZ] = 0;
			ItemCache[i][iDoor] = 0;
			ItemCache[i][iUse] = 0;
			ItemCache[i][iUrl] = 0;
			find++;
		}
	}
	printf("[Przedmioty] Wyzerowano %d przedmiotów gracza (%s:%d).", find, GetNickEx(playerid), PlayerInfo[playerid][pUID]);
}

forward LoadPlayerItems(playerid);
public LoadPlayerItems(playerid)
{
	UnloadPlayerItems(playerid);
	new result[256], query[150], i = 0;
	mysql_free_result();
    format(query, sizeof(query), "SELECT * FROM `mru_items` WHERE `owner` = '%d' AND `owner_type` = %d", PlayerInfo[playerid][pUID], OWNER_PLAYER);

	mysql_query(query);

    mysql_store_result();

    while(mysql_fetch_row_format(result, "|") == 1)
	{
	    new index = SearchFreeItemIndex();
		sscanf(result,  "p<|>ddddds[32]dfffddd",    ItemCache[index][iUID],
													ItemCache[index][iOwner],
													ItemCache[index][iType],
													ItemCache[index][iValue1],
													ItemCache[index][iValue2],
													ItemCache[index][iName],
													ItemCache[index][iOwnertype],
													ItemCache[index][iX],
													ItemCache[index][iY],
													ItemCache[index][iZ],
													ItemCache[index][iDoor],
													ItemCache[index][iCreate],
													ItemCache[index][iTermin]);
		ItemTermin(index);
		if(ItemCache[index][iOwner] == PlayerInfo[playerid][pUID])
		{
			i++;
		}
	}
	mysql_free_result();
	printf("[LOAD] Loaded %d things player (%s:%d).", i, NickName(playerid), PlayerInfo[playerid][pUID]);
}

stock ItemTermin(index)
{
	if(ItemCache[index][iTermin] < timestamp() && ItemCache[index][iTermin] != 0)
	{
		DeleteItem(ItemCache[index][iUID]);
	}
}

forward DeleteItem(uid);
public DeleteItem(uid)
{
	new query[100];
	format(query, sizeof(query), "DELETE FROM `mru_items` WHERE `uid` = '%d'", uid);
	mysql_query(query);
	new index = GetItemIndex(uid);
	Update3DTextLabelText(ItemCache[index][i3DText], 0xFFFFFFFF, " ");
    ItemCache[index][iUID] = 0;
	ItemCache[index][iOwner] = 0;
	ItemCache[index][iType] = 0;
	ItemCache[index][iValue1] = 0;
	ItemCache[index][iValue2] = 0;
	format(ItemCache[index][iName], 32, "%s", 0);
	ItemCache[index][iOwnertype] = 0;
	ItemCache[index][iX] = 0;
	ItemCache[index][iY] = 0;
	ItemCache[index][iZ] = 0;
	ItemCache[index][iDoor] = 0;
	ItemCache[index][iCreate] = 0;
	ItemCache[index][iUrl] = 0;
	mysql_free_result();
}

forward GetItemIndex(itemuid);
public GetItemIndex(itemuid)
{
	for(new i = 0, i < MAX_ITEMS; i++)
	{
		if(ItemCache[index][iUID] == itemuid) return index;
	}
	return -1;
}

forward SearchFreeItemIndex();
public SearchFreeItemIndex()
{
	new find = 0;
	for(new i = 0, i < MAX_ITEMS; i++)
	{
	    if(i != 0)
	    {
			if(ItemCache[i][iUID] < 1)
			{
			    find = i;
			}
			if(find != 0)
			{
				return find;
			}
		}
	}
	return find;
}
hook OnPlayerDisconnect(playerid, reason)
{
	if(PlayerInfo[playerid][pUID] == 0) return 1;
	if(reason == 0)
	{
		for(new i = 0, i < MAX_ITEMS; i++)
		{
		    if(ItemCache[i][iOwner] == PlayerInfo[playerid][pUID] && ItemCache[i][iType] == ITEM_WEAPON && ItemCache[i][iUse] == 1)
 			{
   				ItemCache[i][iUse] = 0;
   			}
		}
	}
	ItemCache[PlayerInfo[playerid][WeaponItem]][iUse] = 0;
	RemovePlayerWeapon(playerid, PlayerInfo[playerid][Weapon]);
	PlayerInfo[playerid][WeaponItem] = 0;
	PlayerInfo[playerid][Weapon] = 0;
	SavePlayerItems(playerid);
	UnloadPlayerItems(playerid);
}

forward SavePlayerItems(playerid);
public SavePlayerItems(playerid)
{
	new find = 0;
	for(new i = 0, i < MAX_ITEMS; i++)
	{
	    if(ItemCache[i][iOwner] == PlayerInfo[playerid][pUID] && ItemCache[i][iOwnertype] == OWNER_PLAYER && ItemCache[i][iType] == ITEM_WEAPON)
	    {
	        SaveItem(ItemCache[i][iUID]);
			find++;
		}
	}
	printf("[Przedmioty] Zapisano %d przedmiotów gracza (%s:%d).", find, GetNickEx(playerid), PlayerInfo[playerid][pUID]);
}

forward SaveItem(uid);
public SaveItem(uid)
{
	new query[564];
	new index = GetItemIndex(uid);
	format(query, sizeof(query), "UPDATE `mru_items` SET `used` = '%d', `owner` = '%d', `type` = '%d', `value1` = '%d', `value2` = '%d', `name` = '%s', `owner_type` = '%d', `iX` = '%f', `iY` = '%f', `iZ` = '%f', `iVW` = '%d', `by` = '%d', `termin` = '%d', `url` = '%s' WHERE `uid` = '%d'",
	ItemCache[index][iUse],
	ItemCache[index][iOwner],
	ItemCache[index][iType],
	ItemCache[index][iValue1],
	ItemCache[index][iValue2],
	ItemCache[index][iName],
	ItemCache[index][iOwnertype],
	ItemCache[index][iX],
	ItemCache[index][iY],
	ItemCache[index][iZ],
	ItemCache[index][iDoor],
	ItemCache[index][iCreate],
	ItemCache[index][iTermin],
	ItemCache[index][iUrl],
	uid);
	mysql_query(query);
	mysql_free_result();
	return 1;
}
//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------

//end