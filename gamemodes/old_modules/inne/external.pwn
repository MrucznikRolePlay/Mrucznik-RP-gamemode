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

//CALLBACKS
//GET
public MRP_GetPlayerMoney(playerid) return kaska[playerid];
public MRP_GetPlayerMC(playerid) return PlayerMC[playerid];
public MRP_GetPlayerCarSlots(playerid) return PlayerInfo[playerid][pCarSlots];
public MRP_GetPlayerPhone(playerid) return PlayerInfo[playerid][pPnumber];
public MRP_GetPlayerNickChanges(playerid) return PlayerInfo[playerid][pZmienilNick];
public MRP_GetPlayerAge(playerid) return PlayerInfo[playerid][pAge];
public MRP_GetPlayerUID(playerid) return PlayerInfo[playerid][UID];
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
    MruMySQL_SetAccInt("PhoneNr", GetNickEx(playerid), val);
}
public MRP_SetPlayerNickChanges(playerid, val)  PlayerInfo[playerid][pZmienilNick] = val;
public MRP_SetPlayerAge(playerid, val)  PlayerInfo[playerid][pAge] = val;

forward MRPWeryfikacja(index, response_code, data[]);
public MRPWeryfikacja(index, response_code, data[])
{
    print("Kubi aka Smigol: Moj skarb!! Nie oddam mojego skarbu!");
	return 1;
}



//END
