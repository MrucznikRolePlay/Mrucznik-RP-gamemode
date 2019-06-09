//EXTERNAL
//GET
forward MRP_GetPlayerMoney(playerid);
forward MRP_GetPlayerMC(playerid);
forward MRP_GetPlayerCarSlots(playerid);
forward MRP_GetPlayerPhone(playerid);
forward MRP_GetPlayerNickChanges(playerid);
forward MRP_GetPlayerAge(playerid);
forward MRP_GetPlayerUID(playerid);
forward MRP_IsInPolice(playerid);
forward MRP_IsInGang(playerid);

//SET
forward MRP_SetPlayerMoney(playerid, val);
forward MRP_SetPlayerCarSlots(playerid, val);
forward MRP_SetPlayerPhone(playerid, val);
forward MRP_SetPlayerNickChanges(playerid, val);
forward MRP_SetPlayerAge(playerid, val);
forward MRP_ShopPurchaseCar(playerid, model, cena);
forward MRP_ForceDialog(playerid, dialogid);
forward MRP_CreatePlayerAttachedItem(playerid, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone);

//OTHERS
forward MRP_IsPhoneNumberAvailable(number);
forward MRP_UpdateAttachedItem(playerid, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone, active, id);
forward MRP_RemoveAttachedItem(id);

//CALLBACKS
//GET
public MRP_GetPlayerMoney(playerid) return kaska[playerid];
public MRP_GetPlayerMC(playerid) return PlayerMC[playerid];
public MRP_GetPlayerCarSlots(playerid) return PlayerInfo[playerid][pCarSlots];
public MRP_GetPlayerPhone(playerid) return PlayerInfo[playerid][pPnumber];
public MRP_GetPlayerNickChanges(playerid) return PlayerInfo[playerid][pZmienilNick];
public MRP_GetPlayerAge(playerid) return PlayerInfo[playerid][pAge];
public MRP_GetPlayerUID(playerid) return PlayerInfo[playerid][pUID];
public MRP_IsInPolice(playerid)
{
    if(GetPlayerFraction(playerid) == FRAC_LSPD || GetPlayerFraction(playerid) == FRAC_FBI || GetPlayerFraction(playerid) == FRAC_NG) return 1;
    return 0;
}
public MRP_IsInGang(playerid)
{
    if(GetPlayerOrgType(playerid) == ORG_TYPE_GANG) return 1;
    return 0;
}

//SET
public MRP_SetPlayerMoney(playerid, val)  kaska[playerid] = val;
public MRP_SetPlayerCarSlots(playerid, val)  PlayerInfo[playerid][pCarSlots] = val;
public MRP_SetPlayerPhone(playerid, val)  {
    PlayerInfo[playerid][pPnumber] = val;
    MruMySQL_SetAccInt("PhoneNr", GetNick(playerid), val);
}
public MRP_SetPlayerNickChanges(playerid, val)  PlayerInfo[playerid][pZmienilNick] = val;
public MRP_SetPlayerAge(playerid, val)  PlayerInfo[playerid][pAge] = val;

public MRP_CreatePlayerAttachedItem(playerid, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone)
//playerid, model, uid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone
{
    new str[256];
    format(str, 256, "INSERT INTO `mru_playeritems` (`model`, `UID`, `bone`, `x`, `y`, `z`, `rx`, `ry`, `rz`) VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f')", model, PlayerInfo[playerid][pUID], bone, x,y,z,rx,ry,rz);
    mysql_query(str);
    new id = mysql_insert_id();
    return id;
}
public MRP_RemoveAttachedItem(id) {
    new str[128];
    format(str, 128, "DELETE FROM mru_playeritems WHERE id=%d", id);
    mysql_query(str);
}
forward MRPWeryfikacja(index, response_code, data[]);
public MRPWeryfikacja(index, response_code, data[])
{
    print("Kubi aka Smigol: Moj skarb!! Nie oddam mojego skarbu!");
	return 1;
}

// OTHERS
public MRP_IsPhoneNumberAvailable(number) {
    
    if(100 >= number <= 150) return false;
    if(number == 555) return false;
    new string[70];
    format(string, sizeof(string), "SELECT `UID` FROM `mru_konta` WHERE `PhoneNr` = %d", number);
    mysql_query(string);
    mysql_store_result();
    if(mysql_num_rows() > 0)
    {
        mysql_free_result();
        return true;
    }
    mysql_free_result();
    return false;
}

public MRP_UpdateAttachedItem(playerid, model, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, bone, active, id) {
    new str[256];
    //format(str, 256, "INSERT INTO `mru_playeritems` (`model`, `UID`, `bone`, `x`, `y`, `z`, `rx`, `ry`, `rz`) VALUES ('%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f')", model, PlayerInfo[playerid][pUID], bone, x,y,z,rx,ry,rz);
    format(str, 256, "UPDATE mru_playeritems SET `model`='%d', `bone`='%d', `x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f', `active`='%d' WHERE `id`=%d", model, bone, x,y,z,rx,ry,rz, active, id);
    printf(str);
    mysql_query(str);
}

//END
