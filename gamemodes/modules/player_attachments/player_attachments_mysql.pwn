//-----------------------------------------------<< MySQL >>-------------------------------------------------//
//                                             player_attachments                                            //
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
// Autor: Mrucznik
// Data utworzenia: 10.08.2019
//Opis:
/*
	Modu³ odpowiedzialny za zarz¹dzanie obiektami przyczepialnymi do gracza.
*/

//

//------------------<[ MySQL: ]>--------------------
PlayerAttachments_Create(playerid, model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz)
{
    new str[512];
    format(str, sizeof(str), "INSERT INTO `mru_playeritems` (`UID`, `model`, `bone`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `sx`, `sy`, `sz`)"\
					 " VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f')", 
		PlayerInfo[playerid][pUID],
		model, 
        bone,
        x, y, z,
        rx, ry, rz,
        sx, sy, sz
	);
    mysql_query(mruMySQL_Connection, str);
    new id = cache_insert_id();

	VECTOR_push_back_val(VAttachedItems[playerid], model);
    return id;
}

//TODO: use
stock PlayerAttachments_Remove(playerid, model)
{
    mysql_query(mruMySQL_Connection, 
        sprintf("DELETE FROM mru_playeritems WHERE `uid`=%d AND `model`='%d'", 
        PlayerInfo[playerid][pUID], model)
    );
	VECTOR_remove_val(VAttachedItems[playerid], model);
}

PlayerAttachments_LoadItems(playerid)
{
	new str[256], model, bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, bool:active;
    format(str, sizeof(str), "SELECT `model`, `x`, `y`, `z`, `rx`, `ry`, `rz`, `sx`, `sy`, `sz`, `active`,`bone` FROM `mru_playeritems` WHERE `UID`='%d'", PlayerInfo[playerid][pUID]);
    new Cache:result = mysql_query(mruMySQL_Connection, str, true);
    if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
		{
		    cache_get_value_index_int(i, 0, model);
            cache_get_value_index_float(i, 1, x);
            cache_get_value_index_float(i, 2, y);
            cache_get_value_index_float(i, 3, z);
            cache_get_value_index_float(i, 4, rx);
            cache_get_value_index_float(i, 5, ry);
            cache_get_value_index_float(i, 6, rz);
            cache_get_value_index_float(i, 7, sx);
            cache_get_value_index_float(i, 8, sy);
            cache_get_value_index_float(i, 9, sz);
            cache_get_value_index_int(i, 10, active);
            cache_get_value_index_int(i, 11, bone);

            VECTOR_push_back_val(VAttachedItems[playerid], model);
            if(active)
            {
                AttachPlayerItem(playerid, model, bone, x, y, z, rx, ry, rz, sx, sy, sz);
            }
        }
		cache_delete(result);
    }
}

PlayerAttachments_LoadItem(playerid, model)
{
	new str[256], bone, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, Float:sx, Float:sy, Float:sz, bool:active;
    new index = INVALID_ATTACHED_OBJECT_INDEX;
	format(str, sizeof(str), "SELECT `x`, `y`, `z`, `rx`, `ry`, `rz`, `sx`, `sy`, `sz`, `active`,`bone` FROM `mru_playeritems` WHERE `UID`='%d' AND `model`='%d'", 
		PlayerInfo[playerid][pUID],
		model
	);
    new Cache:result = mysql_query(mruMySQL_Connection, str, true);
    if(cache_is_valid(result))
	{
        sscanf(str, "p<|>fffffffffdd", x, y, z, rx, ry, rz, sx, sy, sz, active, bone);
        cache_get_value_index_float(0, 0, x);
        cache_get_value_index_float(0, 1, y);
        cache_get_value_index_float(0, 2, z);
        cache_get_value_index_float(0, 3, rx);
        cache_get_value_index_float(0, 4, ry);
        cache_get_value_index_float(0, 5, rz);
        cache_get_value_index_float(0, 6, sx);
        cache_get_value_index_float(0, 7, sy);
        cache_get_value_index_float(0, 8, sz);
        cache_get_value_index_int(0, 9, active);
        cache_get_value_index_int(0, 10, bone);
        index = AttachPlayerItem(playerid, model, bone, x, y, z, rx, ry, rz, sx, sy, sz);
		cache_delete(result);
    }
    return index;

}

PlayerAttachments_UpdateItem(playerid, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone, active) {
    new str[256];
    format(str, sizeof(str), "UPDATE mru_playeritems SET `bone`='%d', `x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f', `active`='%d' WHERE `uid`='%d' AND model='%d'", 
		bone, x,y,z,rx,ry,rz, active, PlayerInfo[playerid][pUID], model);
    mysql_query(mruMySQL_Connection, str);
    return 1;
}

PlayerAttachments_SetActive(playerid, model, active) {
    new str[256];
    format(str, sizeof(str), "UPDATE mru_playeritems SET `active`='%d' WHERE `uid`='%d' AND model='%d'", 
		active, PlayerInfo[playerid][pUID], model);
    mysql_query(mruMySQL_Connection, str);
    return 1;
}

//end