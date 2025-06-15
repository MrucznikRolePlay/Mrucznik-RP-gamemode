//funkcje.pwn
//FUNKCJE DLA CA�EGO SERWERA

stock Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2)
{
    return VectorSize(x1-x2, y1-y2, z1-z2);
}

stock GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	// Created by Y_Less

	new Float:a;

	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);

	if (GetPlayerVehicleID(playerid)) {
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}

	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}


/* SSCANF FIX */
SSCANF:fix(string[])
{
	new ret = INVALID_PLAYER_ID;
	
	if(IsNumeric(string))
	{
		new p = strval(string);
		if(IsPlayerConnected(p))
			ret = p;
	}
	else 
	{
		foreach(new p : Player)
		{
			if(strfind(GetNick(p), string, true) != -1)
			{
				ret = p;
				break;
			}
		}
	}
	
	return ret;
}

stock strToUpper(str[])
{
	for(new i = 0, n = strlen(str); i <n; i ++)
    {
        str[i] = toupper(str[i]);
    }
    return 1;
} 

stock GenString( string[ ] , size = sizeof string )
{
    static const Data[ ] = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";//add more characters if they want to include in string
    new i;
    for(i = 0 ; i < size; ++i)
        string[ i ] = Data[ random( sizeof Data ) ];
}

stock randomString(strDest[], strLen) // credits go to: RyDeR`
{
	strDest[--strLen] = '\0';
    while(strLen--)
        strDest[strLen] = random(2) ? (random(26) + (random(2) ? 'a' : 'A')) : (random(10) + '0');
}

timer DeferedDestroyObject[2000](objectid) 
{
	DestroyDynamicObject(objectid);
	return 1;
}

GetTickDiff(newtick, oldtick)
{
	if (oldtick < 0 && newtick >= 0) {
		return newtick - oldtick;
	} else if (oldtick >= 0 && newtick < 0 || oldtick > newtick) {
		return (cellmax - oldtick + 1) - (cellmin - newtick);
	}
	return newtick - oldtick;
}

PutPlayerInVehicleEx(playerid,vehicleid,seatid)
{
    PutPlayerInVehicle(playerid,vehicleid,seatid);
}

RemovePlayerFromVehicleEx(playerid)
{
    new veh = GetPlayerVehicleID(playerid);
    new model = GetVehicleModel(veh);
    if(model == 538 || model == 537 || model == 449)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        SetPlayerPos(playerid, x, y, z+0.7);
    }
    RemovePlayerFromVehicle(playerid);
}

IsAtGym(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 20.0, 765.9343,0.2761,1000.7173))
	{ // Los Santos gym
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 25.0, 766.6314,-68.7979,1001.5692))
	{ // Vice City gym
		return 1;
	}
	return 0;
}

SetPlayerBoxingPos(playerid, giveplayerid)
{
	if(PlayerToPoint(25.0, playerid, 766.6314,-68.7979,1001.5692))
	{  // Gym Vice City
		SetPlayerInterior(playerid, 7); SetPlayerInterior(giveplayerid, 7);
		SetPlayerPos(playerid, 768.8528,-70.9904,1001.5692); SetPlayerFacingAngle(playerid, 47.6238);
		SetPlayerPos(giveplayerid, 764.4429,-66.4150,1001.5692); SetPlayerFacingAngle(giveplayerid, 228.1055);
	}
	else
	{ // Gym LS
		SetPlayerInterior(playerid, 5); SetPlayerInterior(giveplayerid, 5);
		SetPlayerPos(playerid, 762.9852,2.4439,1001.5942); SetPlayerFacingAngle(playerid, 131.8632);
		SetPlayerPos(giveplayerid, 758.7064,-1.8038,1001.5942); SetPlayerFacingAngle(giveplayerid, 313.1165);
	}
}


saveLegale(playerid) {
	//LEGAL
	new lStr[256];
	format(lStr, sizeof lStr, "UPDATE mru_legal SET weapon1=%d, weapon2=%d, weapon3=%d, weapon4=%d, weapon5=%d, weapon6=%d, weapon7=%d, weapon8=%d, weapon9=%d, weapon10=%d, weapon11=%d,weapon12=%d,weapon13=%d WHERE pID = %d", playerWeapons[playerid][weaponLegal1],playerWeapons[playerid][weaponLegal2],playerWeapons[playerid][weaponLegal3],playerWeapons[playerid][weaponLegal4],playerWeapons[playerid][weaponLegal5],playerWeapons[playerid][weaponLegal6],playerWeapons[playerid][weaponLegal7],playerWeapons[playerid][weaponLegal8],playerWeapons[playerid][weaponLegal9],playerWeapons[playerid][weaponLegal10],playerWeapons[playerid][weaponLegal11],playerWeapons[playerid][weaponLegal12],playerWeapons[playerid][weaponLegal13], PlayerInfo[playerid][pUID]);
	db_free_result(db_query(db_handle, lStr));
}


loadKamiPos(playerid)
{
	new lStr[256];
	format(lStr, sizeof lStr, "SELECT * FROM `mru_kevlar` WHERE `pID`=%d", PlayerInfo[playerid][pUID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, lStr);

	if(db_num_rows(db_result)) {
		//RemovePlayerAttachedObject(playerid, 7);
		//SetPlayerAttachedObject(playerid, 7, 19142, 1, db_get_field_assoc_float(db_result, "offsetX"), db_get_field_assoc_float(db_result, "offsetY"), db_get_field_assoc_float(db_result, "offsetZ"), db_get_field_assoc_float(db_result, "rotX"), db_get_field_assoc_float(db_result, "rotY"), db_get_field_assoc_float(db_result, "rotZ"), db_get_field_assoc_float(db_result, "scaleX"), db_get_field_assoc_float(db_result, "scaleY"), db_get_field_assoc_float(db_result, "scaleY"));

		SetPVarFloat(playerid, "k_offsetX", db_get_field_assoc_float(db_result, "offsetX"));
		SetPVarFloat(playerid, "k_offsetY", db_get_field_assoc_float(db_result, "offsetY"));
		SetPVarFloat(playerid, "k_offsetZ", db_get_field_assoc_float(db_result, "offsetZ"));
		SetPVarFloat(playerid, "k_rotX", db_get_field_assoc_float(db_result, "rotX"));
		SetPVarFloat(playerid, "k_rotY", db_get_field_assoc_float(db_result, "rotY"));
		SetPVarFloat(playerid, "k_rotZ", db_get_field_assoc_float(db_result, "rotZ"));
		SetPVarFloat(playerid, "k_scaleX", db_get_field_assoc_float(db_result, "scaleX"));
		SetPVarFloat(playerid, "k_scaleY", db_get_field_assoc_float(db_result, "scaleY"));
		SetPVarFloat(playerid, "k_scaleZ", db_get_field_assoc_float(db_result, "scaleZ"));

		db_free_result(db_result);
	}
	else
	{
		SetPVarFloat(playerid, "k_offsetX", 0.1);
		SetPVarFloat(playerid, "k_offsetY", 0.05);
		SetPVarFloat(playerid, "k_offsetZ", 0.0);
		SetPVarFloat(playerid, "k_rotX", 0.0);
		SetPVarFloat(playerid, "k_rotY", 0.0);
		SetPVarFloat(playerid, "k_rotZ", 0.0);
		SetPVarFloat(playerid, "k_scaleX", 1.0);
		SetPVarFloat(playerid, "k_scaleY", 1.2);
		SetPVarFloat(playerid, "k_scaleZ", 1.0);
	}
}


saveKevlarPos(playerid, recurention=1)
{
	new lStr[256];
	format(lStr, sizeof lStr, "SELECT * FROM `mru_kevlar` WHERE `pID`=%d", PlayerInfo[playerid][pUID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, lStr);

	if(!db_num_rows(db_result)) 
	{
		format(lStr, sizeof lStr, "INSERT INTO `mru_kevlar` (`pID`,`offsetX`, `offsetY`, `offsetZ`, `rotX`, `rotY`, `rotZ`, `scaleX`, `scaleY`, `scaleZ`) VALUES (%d, 0.1,0.05,0.0,0.0,0.0,0.0,1.0,1.2,1.0)", PlayerInfo[playerid][pUID]);

		db_free_result(db_query(db_handle, lStr));

		if(recurention)
			saveKevlarPos(playerid, 0);
	}
	else
	{
		format(lStr, sizeof lStr, "UPDATE mru_kevlar SET offsetX=%f, offsetY=%f, offsetZ=%f, rotX=%f, rotY=%f, rotZ=%f, scaleX=%f, scaleY=%f, scaleZ=%f WHERE pID = %d", GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"), PlayerInfo[playerid][pUID]);

		db_free_result(db_query(db_handle, lStr));
	}
}

pusteZgloszenia() {
	for(new i = 0, j=OSTATNIE_ZGLOSZENIA; i<j; i++) {
		new Hour, Minute;
		gettime(Hour, Minute);
		new string[36];
		format(string, sizeof(string), "%02d:%02d",  Hour, Minute);
		strmid(Zgloszenie[i][zgloszenie_kiedy], string, 0, sizeof(string), 36);
		strmid(Zgloszenie[i][zgloszenie_nadal], "Brak", 0, 4, MAX_PLAYER_NAME+1);
		strmid(Zgloszenie[i][zgloszenie_tresc], "Brak", 0, 4, 70);
	}
	for(new i = 0, j=OSTATNIE_ZGLOSZENIASASP; i<j; i++) {
		new Hour, Minute;
		gettime(Hour, Minute);
		new string[36];
		format(string, sizeof(string), "%02d:%02d",  Hour, Minute);
		strmid(ZgloszenieSasp[i][zgloszenie_kiedy], string, 0, sizeof(string), 36);
		strmid(ZgloszenieSasp[i][zgloszenie_nadal], "Brak", 0, 4, MAX_PLAYER_NAME+1);
		strmid(ZgloszenieSasp[i][zgloszenie_tresc], "Brak", 0, 4, 70);
	}
}
getWolneZgloszenie() {
	if(ilosczgloszen == OSTATNIE_ZGLOSZENIA) {
		ilosczgloszen = 0;
	}
	return ilosczgloszen++;
}
getWolneZgloszenieSasp() {
	if(ilosczgloszenSasp == OSTATNIE_ZGLOSZENIASASP) {
		ilosczgloszenSasp = 0;
	}
	return ilosczgloszenSasp++;
}
sendNotification(id, title[], text[], time) {
	CallRemoteFunction("notify", "dssd", id, title, text, time);
}
new _str[144];
_MruAdmin(id, string:msg[])
{
	format(_str, 144, "�� %s", msg);
	return SendClientMessage(id, 0xACD32FFF, _str);
}


_MruGracz(id, string:msg[], bool:noArrows=false)
{
	format(_str, 144, "%s%s", (!noArrows) ? ("�� ") : (""), msg);
	return SendClientMessage(id, COLOR_GOLD, _str);
}

noAccessMessage(id) {
    return SendClientMessage(id,COLOR_FADE2,"�� Nie posiadasz dost�pu do tej komendy");
}
sendTipMessage(id, string:msg[], color = COLOR_GRAD3) {
	format(_str,128,"�� %s", msg);
	return SendClientMessage(id, color, _str);
}

sendTipMessageEx(id, color = COLOR_GRAD3, string:msg[]) { //CM do sendclientmessage (:
	return sendTipMessage(id, msg, color);
}
sendErrorMessage(id, string:msg[]) {
	format(_str,128,"�� %s", msg);
	return SendClientMessage(id, COLOR_LIGHTRED, _str);
}

ToggleInwigilacja(playerid, adminid)
{
	if(PlayerInfo[playerid][pPodPW] == 0)
	{
		PlayerInfo[playerid][pPodPW] = 1;
		SendCommandLogMessage(sprintf("Admin %s [%d] w��czy� inwigilacje dla %s [%d]", GetNickEx(adminid), adminid, GetNick(playerid), playerid));
		Log(adminLog, INFO, "Admin %s w��czy� inwigilacje /w dla gracza %s", GetPlayerLogName(adminid), GetPlayerLogName(playerid));
	}
	else if(PlayerInfo[playerid][pPodPW] == 1)
	{
		PlayerInfo[playerid][pPodPW] = 0;
		SendCommandLogMessage(sprintf("Admin %s [%d] wy��czy� inwigilacje dla %s [%d]", GetNickEx(adminid), adminid, GetNick(playerid), playerid));
		Log(adminLog, INFO, "Admin %s wy��czy� inwigilacje /w dla gracza %s", GetPlayerLogName(adminid), GetPlayerLogName(playerid));
	}
	return 1;
}


//WRZUCANIE DO DEMORGAN
JailDeMorgan(playerid)
{
	SetPlayerStateArrestPos(playerid);
	SetCameraBehindPlayer(playerid);
	Wchodzenie(playerid);
	PlayerInfo[playerid][pJailed] = 2;
	GameTextForPlayer(playerid, "~w~Witamy ~r~w sztumie!", 5000, 1);
	return 1;
}

// WYPUSZCZANIE z DEMORGAN
UnJailDeMorgan(playerid)
{
	if(PlayerInfo[playerid][pSpawn] == 3)
	{
		// Vice City
		SetPlayerInterior(playerid, 0);
		SetPlayerInterior(playerid, 3);
		SetPlayerVirtualWorld(playerid, 7110);
		SetPlayerPos(playerid, StateArrestFreePositionVC[0], StateArrestFreePositionVC[1], StateArrestFreePositionVC[2]);
		SetPlayerFacingAngle(playerid, StateArrestFreePositionVC[3]);
	}
	else
	{
		SetPlayerVirtualWorld(playerid, 1);
		SetPlayerPos(playerid, StateArrestFreePosition[0], StateArrestFreePosition[1], StateArrestFreePosition[2]);
		SetPlayerFacingAngle(playerid, StateArrestFreePosition[3]);
	}
	Wchodzenie(playerid);
	GameTextForPlayer(playerid, "~w~Dostales szanse na bycie ~n~~r~lepszym obywatelem", 5000, 3);
	PoziomPoszukiwania[playerid] = 0;
	PlayerInfo[playerid][pJailed] = 0;
	PlayerInfo[playerid][pJailTime] = 0;
}

DialogListaFrakcji()
{
	new frakcje[512];
	for(new i=1; i<18; i++)
	{
		strcat(frakcje, FractionNames[i], sizeof(frakcje));
		if(i!=18) strcat(frakcje, "\n", sizeof(frakcje));
	}
	safe_return frakcje;
}

stock PreloadAnimLibs(playerid) {
  for(new i = 0; i < sizeof(AnimLibs); i++) {
      ApplyAnimation(playerid, AnimLibs[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
  }
  return 1;
}

DialogListaSkinow(frakcja)
{
	new skiny[1024];
	for(new i=0;i<MAX_SKIN_SELECT;i++)
	{
		if(FRAC_SKINS[frakcja][i] == 0) break;
		format(skiny, sizeof(skiny), "%s%d\n", skiny, FRAC_SKINS[frakcja][i], i);
	}
	strdel(skiny, strlen(skiny)-1, strlen(skiny));
	safe_return skiny;
}

DialogListaSkinowFamily(family)
{
	new skiny[1024];
	for(new i=0;i<MAX_SKIN_SELECT;i++)
	{
		if(OrgSkins[family][i] == 0) break;
		format(skiny, sizeof(skiny), "%s%d\n", skiny, OrgSkins[family][i], i);
	}
	strdel(skiny, strlen(skiny)-1, strlen(skiny));
	safe_return skiny;
}

PDTuneSultan(vehicleid)
{
	new o[5];
	o[0] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[1] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[2] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[3] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	o[4] = CreateDynamicObject(19797, 0, 0, 0, 0, 0, 0);
	AttachDynamicObjectToVehicle(o[0], vehicleid, 0.234999, 2.598513, -0.222499, 0.000000, -0.000001, 178.890090); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[1], vehicleid, -0.234999, 2.598513, -0.217499, 0.000000, 179.895095, 182.910110); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[2], vehicleid, 0.000000, -2.374014, 0.159999, 0.000000, 0.000000, 0.000000); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[3], vehicleid, -0.674999, -2.362517, 0.110000, 0.000000, 0.000000, 0.000000); //Object Model: 19797 |
	AttachDynamicObjectToVehicle(o[4], vehicleid, 0.676498, -2.344018, 0.110000, 0.000000, 179.895095, -0.000001); //Object Model: 19797 |
}

PDTuneInfernus(vehicleid)
{
    new alspdo = CreateDynamicObject(2286,-0.0972000,-1.9730999,0.2444000,275.5001526,0.0000000,0.0000000);
    SetDynamicObjectMaterial(alspdo, 1, 0, "none", "none");
    new lspdo1 = CreateDynamicObject(19280, -0.5947266,2.6767578,-0.4871000,341.4990234,0.0000000,12.7496338);
    new lspdo3 = CreateDynamicObject(19280, -0.7447000,2.6440001,-0.4871000,341.4990234,0.0000000,12.7496338);
    new lspdo4 = CreateDynamicObject(19280, 0.6053000,2.6768000,-0.4871000,341.4990234,0.0000000,346.7496338);
    new lspdo5 = CreateDynamicObject(19280, 0.7545000,2.6418002,-0.4871000,341.4990234,0.0000000,346.7449951);
    SetDynamicObjectMaterial(lspdo1, 1, 18646, "matcolours", "red");
    SetDynamicObjectMaterial(lspdo3, 1, 18646, "matcolours", "red");
    SetDynamicObjectMaterial(lspdo4, 1, 18646, "matcolours", "blue");
    SetDynamicObjectMaterial(lspdo5, 1, 18646, "matcolours", "blue");
    SetDynamicObjectMaterialText(alspdo, 0, " POLICE", OBJECT_MATERIAL_SIZE_256x128, "Arial", 75, 1, 0xFFFFFFFF, 0, 1);
    AttachDynamicObjectToVehicle(alspdo, vehicleid, -0.0972000,-1.9730999,0.2444000,275.5001526,0.0000000,0.0000000);
    AttachDynamicObjectToVehicle(lspdo1, vehicleid, -0.5947266,2.6767578,-0.4871000,341.4990234,0.0000000,12.7496338);
    AttachDynamicObjectToVehicle(lspdo3, vehicleid, -0.7447000,2.6440001,-0.4871000,341.4990234,0.0000000,12.7496338);
    AttachDynamicObjectToVehicle(lspdo4, vehicleid, 0.6053000,2.6768000,-0.4871000,341.4990234,0.0000000,346.7496338);
    AttachDynamicObjectToVehicle(lspdo5, vehicleid, 0.7545000,2.6418002,-0.4871000,341.4990234,0.0000000,346.7449951);
    new hsiu_text = CreateDynamicObject(2659,-1.1012001,0.0907000,-0.1102000,0.0000000,0.0000000,271.5000000);
    new hsiu_text2 = CreateDynamicObject(2659,1.1012998,0.0907000,-0.1102000,0.0000000,0.0000000,88.7496338);
    SetDynamicObjectMaterialText(hsiu_text, 0, " SAPD", OBJECT_MATERIAL_SIZE_256x128, "Arial", 74, 1, 0xFFFFFFFF, 0, 1);
    SetDynamicObjectMaterialText(hsiu_text2, 0, " SAPD", OBJECT_MATERIAL_SIZE_256x128, "Arial", 74, 1, 0xFFFFFFFF, 0, 1);
    AttachDynamicObjectToVehicle(hsiu_text, vehicleid, -1.1012001,0.0907000,-0.150000,0.0000000,0.0000000,271.5000000);
    AttachDynamicObjectToVehicle(hsiu_text2, vehicleid, 1.1013298,0.0907000,-0.150000,0.0000000,0.0000000,88.7496338);
}

GetFreeVehicleSeat(vehicleid)
{
	new bool:Seat[4];
	foreach(new i : Player)
	{
		if(IsPlayerInVehicle(i,vehicleid))
		{
			if(GetPlayerVehicleSeat(i) == 3) Seat[3] = true;
			else if(GetPlayerVehicleSeat(i) == 2) Seat[2] = true;
			else if(GetPlayerVehicleSeat(i) == 1) Seat[1] = true;
			else if(GetPlayerVehicleSeat(i) == 0) Seat[0] = true;
		}
	}
	if(Seat[3] == false) return 3;
	else if(Seat[2] == false) return 2;
	else if(Seat[1] == false) return 1;
	else if(Seat[0] == false) return 0;
	else return -1;
}

GetCarSpeed(vehicleid)
{
    new Float:pAC_Pos[3],Float:VS ;
    GetVehicleVelocity(vehicleid, pAC_Pos[0], pAC_Pos[1], pAC_Pos[2]);
    VS = VectorSize(pAC_Pos[0], pAC_Pos[1], pAC_Pos[2])*136.6666;
    return floatround(VS,floatround_round);
}

Odpolszcz(text[])
{
    new string[256], i_pos;
    format(string, sizeof(string), text);
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'A';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'a';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'C';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'c';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'E';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'e';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'L';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'l';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'N';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'n';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'S';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 's';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'O';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'o';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'Z';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'z';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'Z';
	while ((i_pos = strfind(string, "�", false, i_pos)) != -1) string[i_pos] = 'z';
	return string;
}

Uprawnienia(playerid, flags, bool:part=false)
{
    if(flags & ACCESS[playerid] != 0)
    {
        if(part) return 1;
        else
        {
            if(flags & ACCESS[playerid] == flags) return 1;
            else return 0;
        }
    }
    else return 0;
}

stock Have_Worek(playerid)
{
    TextDrawShowForPlayer(playerid, TXD_Worek);
    GangZoneShowForPlayer(playerid, blackmap, 255);
}

stock UnHave_Worek(playerid)
{
    TextDrawHideForPlayer(playerid, TXD_Worek);
    GangZoneHideForPlayer(playerid, blackmap);
}

GetPlayerFraction(playerid)
{
    if(PlayerInfo[playerid][pMember] == 0) return PlayerInfo[playerid][pLider];
    else return PlayerInfo[playerid][pMember];
}

FracGetsUniformOnDuty(fracid) {
    switch(fracid) {
        case 1, 2, 3, 4, 7, 9, 10, 11:
            return 1;
    }
    return 0;
}

SetDefaultUniform(playerid) {
	new frac = GetPlayerFraction(playerid);
	if (PlayerInfo[playerid][pLider]) {
		if(frac == 0) { PlayerInfo[playerid][pUniform] = 0; }
		else if(frac == 1) { PlayerInfo[playerid][pUniform] = 288; }
		else if(frac == 2) { PlayerInfo[playerid][pUniform] = 295; }
		else if(frac == 3) { PlayerInfo[playerid][pUniform] = 287; }
		else if(frac == 4) { PlayerInfo[playerid][pUniform] = 228; }
		else if(frac == 5) { PlayerInfo[playerid][pUniform] = 113; }
		else if(frac == 6) { PlayerInfo[playerid][pUniform] = 208; }
		else if(frac == 7) { PlayerInfo[playerid][pUniform] = 57; }
		else if(frac == 8) { PlayerInfo[playerid][pUniform] = 294; }
		else if(frac == 9) { PlayerInfo[playerid][pUniform] = 227; }
		else if(frac == 10) { PlayerInfo[playerid][pUniform] = 61; }
		else if(frac == 11) { PlayerInfo[playerid][pUniform] = 147; }
		else if(frac == 12) { PlayerInfo[playerid][pUniform] = 270; }
		else if(frac == 13) { PlayerInfo[playerid][pUniform] = 103; }
		else if(frac == 14) { PlayerInfo[playerid][pUniform] = 109; }
		else if(frac == 15) { PlayerInfo[playerid][pUniform] = 60; }
		else if(frac == 16) { PlayerInfo[playerid][pUniform] = 112; }
		else if(frac == 17) { PlayerInfo[playerid][pUniform] = 279; }
	} else {
		if(frac == 0) { PlayerInfo[playerid][pUniform] = 0; }
		else if(frac == 1) { PlayerInfo[playerid][pUniform] = 280; }
		else if(frac == 2) { PlayerInfo[playerid][pUniform] = 286; }
		else if(frac == 3) { PlayerInfo[playerid][pUniform] = 71; }
		else if(frac == 4) { PlayerInfo[playerid][pUniform] = 70; }
		else if(frac == 5) { PlayerInfo[playerid][pUniform] = 258; }
		else if(frac == 6) { PlayerInfo[playerid][pUniform] = 117; }
		else if(frac == 7) { PlayerInfo[playerid][pUniform] = 59; }
		else if(frac == 8) { PlayerInfo[playerid][pUniform] = 127; }
		else if(frac == 9) { PlayerInfo[playerid][pUniform] = 148; }
		else if(frac == 10) { PlayerInfo[playerid][pUniform] = 253; }
		else if(frac == 11) { PlayerInfo[playerid][pUniform] = 60; }
		else if(frac == 12) { PlayerInfo[playerid][pUniform] = 270; }
		else if(frac == 13) { PlayerInfo[playerid][pUniform] = 103; }
		else if(frac == 14) { PlayerInfo[playerid][pUniform] = 108; }
		else if(frac == 15) { PlayerInfo[playerid][pUniform] = 8; }
		else if(frac == 16) { PlayerInfo[playerid][pUniform] = 206; }
		else if(frac == 17) { PlayerInfo[playerid][pUniform] = 278;}
	}
}


CarOpis_Usun(playerid, vehicleid, message=false)
{
    if(vehicleid >= MAX_VEHICLES) return 0;
    if(Car3dTextDesc[vehicleid] != Text3D:INVALID_3DTEXT_ID)
    {
        DestroyDynamic3DTextLabel(Text3D:Car3dTextDesc[vehicleid]);
        Car3dTextDesc[vehicleid] = Text3D:INVALID_3DTEXT_ID;
		
		if(CarData[VehicleUID[vehicleid][vUID]][c_UID] > 0)
		{
			MruMySQL_DeleteOpis(CarData[VehicleUID[vehicleid][vUID]][c_UID], 2);
		}
        if(message)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Opis: Usuni�to.");
        }
        return 1;
    }
    return 0;
}

public Dopalaj(playerid)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new Float:Velocity[4], veh;
		veh = GetPlayerVehicleID(playerid);
		GetVehicleVelocity(veh, Velocity[0], Velocity[1], Velocity[2]);
		Velocity[3] = VectorSize(Velocity[0], Velocity[1], 0.0);
		if(Velocity[3] > 0.9)
		{
			if(Velocity[3] > 1.5)
			{
				SetTimerEx("Dopalaj",1000,0,"d",playerid);
			}
			else
			{
				SetVehicleVelocity(veh, Velocity[0]*1.15, Velocity[1]*1.15, Velocity[2]-0.01);
				SetTimerEx("Dopalaj",1000,0,"d",playerid);
				return 1;
			}
		}
		else
		{
			SendClientMessage(playerid, TEAM_CYAN_COLOR, "Dopalacz deaktywowany - zbyt ma�a pr�dko��");
			return 1;
		}
	}
	else
	{
		SendClientMessage(playerid, TEAM_CYAN_COLOR, "Dopalacz deaktywowany - wysiad�e� z wozu");
		return 1;
	}
	return 1;
}

ClearChat(playerid)
{
	for(new i; i<100; i++)
	{
		SendClientMessage(playerid, COLOR_GREY," ");
	}
	return 1;
}

AntyReklama(result[])
{
	if ( strfind(result , "mrucznik-rp.pl" , true)>=0)
		return 0;
	if ( strfind(result , "lsrp" , true)>=0 ||  strfind(result , "ls-rp" , true)>=0 || strfind(result , "n4g" , true)>=0 || strfind(result , "net4game" , true)>=0)//nazwy serwer�while
		return 1;
	if ( strfind(result , "www." , true)>=0 || strfind(result , ".pl" , true)>=0 || strfind(result , ".net" , true)>=0 || strfind(result , ".com" , true)>=0)//strony internetowe
		return 2;

	new dwukrop = strfind(result , ":" , true);
	if ( dwukrop>=0)//adersy ip
	{
		if(result[dwukrop+1] != '\0')
		{
			if(result[dwukrop+1] >= '1' && result[dwukrop+1] <= '9')
				return 3;
		}
		else if(result[dwukrop+2] != '\0')
		{
			if(result[dwukrop+2] >= '1' && result[dwukrop+2] <= '9')
				return 3;
		}
	}
	return 0;
}

AntyCzitText(result[])
{
	if(strfind(result , "cheat" , true)>=0 || strfind(result , "czit" , true)>=0 || strfind(result , "cleo" , true)>=0 || strfind(result , "sobeit" , true)>=0
	|| strfind(result , "hack" , true)>=0 || strfind(result , "hax" , true)>=0 || strfind(result , "s0b" , true)>=0 || strfind(result , "s0beit" , true)>=0)
		return 1;
	else
		return 0;
}


CreateShopPickups()
{
	for(new i; i<sizeof(ShopPickupsPos); i++)
	{
		ShopPickups[i] = CreateDynamicPickup(1275, 1, ShopPickupsPos[i][0], ShopPickupsPos[i][1], ShopPickupsPos[i][2]);
	}
}

//--------------------------------------------------------
//---------------------[Mini Timery:]---------------------
//--------------------------------------------------------
PlayerPlayMusic(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		SetTimer("StopMusic", 5000, 0);
		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
	}
}

public StopMusic()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
		}
	}
}

public PlayerFixRadio(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    SetTimer("PlayerFixRadio2", 500, 0);
		PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
		Fixr[playerid] = 1;
	}
}

MruDialog(playerid, title[], text[])
{
	return ShowPlayerDialogEx(playerid, 0, DIALOG_STYLE_MSGBOX, MruTitle(title), text, "Ok", "");
}
MruTitle(text[])
{
	new title_str[128];
	format(title_str, 128, "Mrucznik-RP � {00b33c}%s", text);
	return title_str;
}

public PlayerFixRadio2()
{
	foreach(new i : Player)
	{
		if(Fixr[i])
		{
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
			Fixr[i] = 0;
		}
	}
}

forward func_SetPVarInt(playerid, key[], value);
public func_SetPVarInt(playerid, key[], value)
{
	SetPVarInt(playerid, key, value);
	return 1;
}

public CountDownVehsRespawn()
{
	if (Count > 0)
	{
		new text[56];
		format(text, sizeof text, "respawn za ~g~%d", Count-1);
		GameTextForAll(text, 2500, 1);
		if(Count % 5 == 0) SoundForAll(1056);
		Count--;
		SetTimer("CountDownVehsRespawn", 1000, 0);
	}
	else
	{	
		SoundForAll(1057);
		GameTextForAll("~g~Respawn", 2500, 1);
		SendClientMessageToAll(COLOR_PANICRED, "|___Nast�pi� respawn nieu�ywanych pojazd�w___|");
		Count = 20;
		new bool:used[CAR_AMOUNT] = {false, ... };
		foreach(new p : Player)
		{
			if(IsPlayerInAnyVehicle(p))
			{
				new veh = GetPlayerVehicleID(p);
				used[veh] = true;
			}
		}
		for(new v = 1; v < MAX_VEHICLES; v++)
		{
			if(!used[v])
			{
				if(v <= CAR_End)
				{
					ReloadCarForStealing(v);
				}
				else
				{
			    	RespawnVehicleEx(v);
				}

			    if(Car_GetOwnerType(v) == CAR_OWNER_PLAYER)
			    {
                    Car_Unspawn(v);
	            }
			}
		}

		ReloadDeluxeCarsForStealing();
	}
}

public Odmroz(playerid)
{
    TogglePlayerControllable(playerid, 1);
    return 1;
}

public Wchodzenie(playerid) //Zmiana na inteligentny system odmra�ania
{
    if(GetPVarInt(playerid, "enter-check") == 0)
    {
        TogglePlayerControllable(playerid, 0);
        SetPVarInt(playerid, "enter-check", 1);
        SetPVarInt(playerid, "enter-nowobj", 0);
        SetPVarInt(playerid, "enter-stuffobj", 0);
        SetPVarInt(playerid, "enter-stuff", 0);
        SetPVarInt(playerid, "enter-oldvw", GetPVarInt(playerid, "enter-vw"));
        SetPVarInt(playerid, "enter-vw", GetPlayerVirtualWorld(playerid));
        SetPVarInt(playerid, "enter-time", gettime());
    }
    else
    {
        new count = Streamer_CountVisibleItems(playerid, STREAMER_TYPE_OBJECT);
        if( ((count >= GetPVarInt(playerid, "enter-nowobj")) && GetPVarInt(playerid, "enter-nowobj") != 0) || (count > 0 && GetPVarInt(playerid, "enter-oldvw") == GetPVarInt(playerid, "enter-vw")) || (GetPVarInt(playerid, "enter-nowobj") >= count)) //obj wczytane
        {
            //printf("(OBJ LOADER Inteligencja) TIME [%d sek.] DLA [%d]", gettime()-GetPVarInt(playerid, "enter-time"), playerid);
            TogglePlayerControllable(playerid, 1);
            SetPVarInt(playerid, "enter-check", 0);
            if(GetPVarInt(playerid, "enter-stuff") != 0) DestroyDynamicObject(GetPVarInt(playerid, "enter-stuffobj"));
            return 1;
        }
        else if(GetPVarInt(playerid, "enter-nowobj") == 0) //check lag
        {
            if(GetPVarInt(playerid, "enter-stuff") == 0)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                SetPVarInt(playerid, "enter-stuffobj", CreateDynamicObject(19300, x, y, z, 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid));
                SetPVarInt(playerid, "enter-stuff", 1);
                Streamer_Update(playerid);
            }
        }
        else
        {
            TogglePlayerControllable(playerid, 1);
            SetPVarInt(playerid, "enter-check", 0);
            new str[128];
            SendClientMessage(playerid, -1, "(OBJ LOADER Inteligencja) - B��d z wczytaniem obiekt�w, nie mo�na doda� nowych - zg�os to z debugiem:");
            format(str, 128, "CHK |%d| NowOBJ |%d| Stuff |%d:%d| VW.o |%d| VW.n |%d| T |%d| T.n |%d| T.s |%d| Count |%d|", GetPVarInt(playerid, "enter-check"),GetPVarInt(playerid, "enter-nowobj"),GetPVarInt(playerid, "enter-stuffobj"),GetPVarInt(playerid, "enter-stuff"),GetPVarInt(playerid, "enter-oldvw"),GetPVarInt(playerid, "enter-vw"),GetPVarInt(playerid, "enter-time"), gettime(), gettime()-GetPVarInt(playerid, "enter-time"),count);
            SendClientMessage(playerid, -1, str);
            printf("(OBJ LOADER Inteligencja) FAIL [%d]! CHK |%d| NowOBJ |%d| Stuff |%d:%d| VW.o |%d| VW.n |%d| T |%d| T.n |%d| T.s |%d| Count |%d|", playerid, GetPVarInt(playerid, "enter-check"),GetPVarInt(playerid, "enter-nowobj"),GetPVarInt(playerid, "enter-stuffobj"),GetPVarInt(playerid, "enter-stuff"),GetPVarInt(playerid, "enter-oldvw"),GetPVarInt(playerid, "enter-vw"),GetPVarInt(playerid, "enter-time"), gettime(), gettime()-GetPVarInt(playerid, "enter-time"),count);
            if(GetPVarInt(playerid, "enter-stuff") != 0) DestroyDynamicObject(GetPVarInt(playerid, "enter-stuffobj"));
        }
        SetPVarInt(playerid, "enter-nowobj", count);
    }
    SetTimerEx("Wchodzenie", 1800, 0, "i", playerid);
    return 1;
}
public freezuj(playerid){
TogglePlayerControllable(playerid, 0);
return 1;
}

public AntySB(playerid)
{
	AntySpawnBroni[playerid] = 0;
	//SendClientMessage(playerid,COLOR_P@,"|_________________________ Nowe premium _________________________|");
	//SendClientMessage(playerid,COLOR_WHITE,"INFO INFO INFO INFO");
	//SendClientMessage(playerid,COLOR_P@,"|____________________________>>> Mi�ej gry<<<____________________________|");
	return 1;
}

public TiNzPJwGUI(playerid)
{
	new playername[MAX_PLAYER_NAME];
	new string [256];
	PlayerInfo[playerid][pPrawojazdydobreodp] = 0;
	PlayerInfo[playerid][pPrawojazdypytania] = 0;
	PlayerInfo[playerid][pWtrakcietestprawa] = 0;
	PlayerInfo[playerid][pMinalczasnazdpr] = 1;
	PlayerInfo[playerid][pSprawdzczyzdalprawko] = 0;
	GetPlayerName(playerid, playername, sizeof(playername));
	format(string, sizeof(string), "* S�ycha� d�wi�k ko�ca czasu na rozwi�znie testu ((%s))", playername);
	ProxDetector(40.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	ShowPlayerDialogEx(playerid, 13, DIALOG_STYLE_MSGBOX, "Czas min��!", "Przykro nam!\nUp�yn� czas na udzielenie poprawnej odpowiedzi.\nOblewasz egzamin i mo�esz go zda� ponownie za 2h.", "Wyjdz", "");
	return 1;
}
public Naprawianie(playerid){
naprawiony[playerid] = 0;
return 1;
}

stock KickEx(playerid, reason[])
{
	SendClientMessage(playerid, COLOR_PANICRED, sprintf("Zosta�e� wyrzucony z serwera, pow�d: %s", reason));
	format(kickReason[playerid], 128, "%s", reason);

	kicking[playerid] = 1;
	defer KickPlayer(playerid);
	return 1;
}

timer KickPlayer[250](playerid)
{
	if(kicking[playerid] == 1)
	{
		printf("Gracz %s zostal zkickowany za: %s", GetNick(playerid), kickReason[playerid]);
		Kick(playerid);
	}
}

public Banicja(playerid)
{
	SetTimerEx("BanExTimer",250,0,"d",playerid);
	return 1;
}

public BanExTimer(playerid)
{
	if(IsPlayerConnected(playerid)) Ban(playerid);
	return 1;
}

public Matsowanie(playerid){
MatsGood[playerid] = 0;
return 1;
}

public togczastimer(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    new mtext[20], string[256];
		new year, month,day;
		getdate(year, month, day);
		if(month == 1) { mtext = "Styczen"; }
		else if(month == 2) { mtext = "Luty"; }
		else if(month == 3) { mtext = "Marzec"; }
		else if(month == 4) { mtext = "Kwiecien"; }
		else if(month == 5) { mtext = "Maj"; }
		else if(month == 6) { mtext = "Czerwiec"; }
		else if(month == 7) { mtext = "Lipiec"; }
		else if(month == 8) { mtext = "Sierpien"; }
		else if(month == 9) { mtext = "Wrzesien"; }
		else if(month == 10) { mtext = "Pazdziernik"; }
		else if(month == 11) { mtext = "Listopad"; }
		else if(month == 12) { mtext = "Grudzien"; }
	    new hour,minuite,second;
		gettime(hour,minuite,second);
		FixHour(hour);
		hour = shifthour;
		if (minuite < 10)
		{
			if (PlayerInfo[playerid][pJailed] > 0 && PlayerInfo[playerid][pJailTime] > 0)
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:0%d~g~|~n~~w~Czas Aresztu: %d sek", day, mtext, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
			}
			else
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:0%d~g~|", day, mtext, hour, minuite);
			}
		}
		else
		{
			if (PlayerInfo[playerid][pJailed] > 0 && PlayerInfo[playerid][pJailTime] > 0)
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d~g~|~n~~w~Czas Aresztu: %d sec", day, mtext, hour, minuite, PlayerInfo[playerid][pJailTime]-10);
			}
			else
			{
				format(string, sizeof(string), "~y~%d %s~n~~g~|~w~%d:%d~g~|", day, mtext, hour, minuite);
			}
		}
		GameTextForPlayer(playerid, string, 5000, 1);
	}
	return 1;
}

public spamujewl(playerid){
spamwl[playerid] = 0;
return 1;
}


public AntySpamMechanik(playerid){
SpamujeMechanik[playerid] = 0;
return 1;
}

public PoscigTimer(playerid){
poscig[playerid] = 0;
SendClientMessage(playerid,COLOR_PANICRED,"|_________________Tryb Po�cigu ZAKO�CZONY_________________|");
SendClientMessage(playerid,COLOR_WHITE,"Czas na z�apanie ci� dobieg� ko�ca.");
SendClientMessage(playerid,COLOR_WHITE,"Je�eli nie przeprowadzasz ju� �adnej akcji RP, mo�esz bezpiecznie wyj�� z gry");
SendClientMessage(playerid,COLOR_PANICRED,"|______________________________________________|");
return 1;
}

public AntySpamTimer(playerid){
AntySpam[playerid] = 0;
return 1;
}

public odpalanie(playerid)
{
	new engine, lights, alarm, doors, bonnet, boot, objective, Float:health, sendername[MAX_PLAYER_NAME], string[256];
	new carid = GetPlayerVehicleID(playerid);
	GetPlayerName(playerid, sendername, sizeof(sendername));
	GetVehicleHealth(carid, health);
 	GetVehicleParamsEx(carid,engine, lights ,alarm, doors, bonnet, boot, objective);
 	OdpalanieSpam[playerid] = 0;
	if(Gas[carid] > 3)
	{
		new rand = random(1000);
		if(rand <= health)
		{
			format(string, sizeof(string), "* silnik odpali� (( %s ))", sendername);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
      		SetVehicleParamsEx(carid , 1, lights, alarm, doors, bonnet, boot, objective);
			if(PlayerInfo[playerid][pTurnedOnCarWithoutCarLic] != carid && PlayerInfo[playerid][pCarLic] == 0)
			{
				PlayerInfo[playerid][pTurnedOnCarWithoutCarLic] = carid;

				NadajWL(playerid, 1, "Jazda bez prawa jazdy");
			}
		}
		else
		{
		    format(string, sizeof(string), "* silnik nie odpali� (( %s ))", sendername);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		}
	}
	else
	{
	 	format(string, sizeof(string), "* na desce rozdzielczej pojawia si� informacja o braku paliwa (( %s ))", sendername);
		ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	return 1;
}
//SYSTEM KRADZIEZY AUT!

//uda�o si�

public udalo1(playerid){
//��czenie kabelk�w
if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
{
	new komunikat[128];
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(komunikat, sizeof(komunikat),"* %s ��czy kabelki i wyjmuje �rubokr�t i odkr�ca nast�pn� os�onk�.", nick);
	ProxDetector(20.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	SetTimerEx("udalo2",6000,0,"d",playerid);
}
else
{
    NieSpamujKradnij[playerid] = 0;
}
return 1;
}

public udalo2(playerid){
//odpalanie silnika
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
    	new komunikat[128];
    	new nick[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, nick, sizeof(nick));
    	format(komunikat, sizeof(komunikat),"* %s wyjmuje 4 kolorowe kabelki.", nick);
    	ProxDetector(20.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	SetTimerEx("udalo3",6000,0,"d",playerid);
    }
    else
    {
        NieSpamujKradnij[playerid] = 0;
    }
    return 1;
}

public udalo3(playerid){
//odpali�
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
    	new komunikat[128];
    	new nick[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, nick, sizeof(nick));
    	format(komunikat, sizeof(komunikat),"* %s ��czy odpowiednie kabelki i wy��czy� alarm.", nick);
    	ProxDetector(20.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	TogglePlayerControllable(playerid, 1);
		new carid = GetPlayerVehicleID(playerid); 
		if(Gas[carid] <= 10) Gas[carid] += 15;
    	NieSpamujKradnij[playerid] = 0;
    	SendClientMessage(playerid, COLOR_GRAD2, "Skill z�odzieja aut +1");
    	PlayerInfo[playerid][pJackSkill] ++;
        KradniecieWozu[playerid] = GetPlayerVehicleID(playerid);
    	if(PlayerInfo[playerid][pJackSkill] == 50)
    	{ SendClientMessage(playerid, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 2, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
    	else if(PlayerInfo[playerid][pJackSkill] == 100)
    	{ SendClientMessage(playerid, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 3, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
    	else if(PlayerInfo[playerid][pJackSkill] == 200)
    	{ SendClientMessage(playerid, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 4, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
    	else if(PlayerInfo[playerid][pJackSkill] == 400)
    	{ SendClientMessage(playerid, COLOR_YELLOW, "* Tw�j skill z�odzieja samochod�w wynosi teraz 5, masz teraz wi�ksze szanse �e uda ci si� ukra�� w�z."); }
    }
    else
    {
        NieSpamujKradnij[playerid] = 0;
    }
    return 1;
}

//nie uda�o si�

public nieudalo1(playerid){
    //��czenie kabelk�w
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
    	new komunikat[128];
    	new nick[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, nick, sizeof(nick));
    	format(komunikat, sizeof(komunikat),"* %s ��czy kabelki i wyjmuje �rubokr�t i odkr�ca nast�pn� os�onk�.", nick);
    	ProxDetector(20.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	SetTimerEx("nieudalo2",6000,0,"d",playerid);
    }
    else
    {
        NieSpamujKradnij[playerid] = 0;
    }
    return 1;
}

public nieudalo2(playerid){
//odpalanie silnika
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
    	new komunikat[128];
    	new nick[MAX_PLAYER_NAME];
    	GetPlayerName(playerid, nick, sizeof(nick));
    	format(komunikat, sizeof(komunikat),"* %s wyjmuje 4 kolorowe kabelki.", nick);
    	ProxDetector(20.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    	SetTimerEx("nieudalo3",6000,0,"d",playerid);
    }
    else
    {
        NieSpamujKradnij[playerid] = 0;
    }
    return 1;
}

public nieudalo3(playerid){
//alarm si� w��cza
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
    	new komunikat[128];
    	new nick[MAX_PLAYER_NAME];
    	new vehi = GetPlayerVehicleID(playerid);
    	new engine, lights, alarm, doors, bonnet, boot, objective;
    	GetPlayerName(playerid, nick, sizeof(nick));
    	format(komunikat, sizeof(komunikat),"* %s �le ��czy kabelki po czym w��cza si� alarm.", nick);
    	ProxDetector(20.0, playerid, komunikat, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        GetVehicleParamsEx(vehi, engine, lights, alarm, doors, bonnet, boot, objective);
        SetVehicleParamsEx(vehi, engine, lights, true, doors, bonnet, boot, objective);
    	SetTimerEx("WylaczAlarm", 90000, false, "d", vehi);
    	SendClientMessage(playerid, COLOR_PANICRED, "Uciekaj! Zaraz tu b�d� gliny!");
    	TogglePlayerControllable(playerid, 1);
    	RemovePlayerFromVehicleEx(playerid);
    	KradniecieWozu[playerid] = 0;
    	NieSpamujKradnij[playerid] = 0;
		new pZone[MAX_ZONE_NAME];
		GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
		format(komunikat, sizeof(komunikat), "HQ: Zg�oszono pr�b� kradzie�y %s na %s.", VehicleNames[GetVehicleModel(vehi)-400], pZone);
		SendFamilyMessage(FRAC_LSPD, COLOR_LIGHTRED, komunikat, true);
    }
    else
    {
        NieSpamujKradnij[playerid] = 0;
    }
    return 1;
}

public WylaczAlarm(vehi)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehi, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehi, engine, lights, false, doors, bonnet, boot, objective);
}

//KONIEC SYSTEMU KRADZIEZY WAUT

public UsuwanieBroniReset(playerid){
PrzywrocBron(playerid);
return 1;
}

public Odlicz(wyscig){
if(Wodliczanie == 3)
{
    foreach(new i : Player)
   	{
    	if(ScigaSie[i] == wyscig)
	    {
	        SetPlayerRaceCheckpoint(i,Wyscig[wyscig][wTypCH],wCheckpoint[wyscig][1][0], wCheckpoint[wyscig][1][1], wCheckpoint[wyscig][1][2],wCheckpoint[wyscig][2][0], wCheckpoint[wyscig][2][1], wCheckpoint[wyscig][2][2], 10);
			TogglePlayerControllable(i, 1);
			GameTextForPlayer(i, "~r~GO!", 2500, 4);
			Wodliczanie = 0;
			IloscCH[i] = 1;
			PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
		}
	}
}
else
{
    new string[12];
    foreach(new i : Player)
   	{
    	if(ScigaSie[i] == wyscig)
	    {
		    format(string, sizeof(string), "~g~%d", (3-Wodliczanie));
		    GameTextForPlayer(i, string, 1000, 4);
		    PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
        }
	}
	Wodliczanie++;
 	SetTimerEx("Odlicz",1000,0,"d",wyscig);
}
return 1;
}


KoniecWyscigu(playerid)
{
	new string[256];
	if(playerid == -1)
		format(string, sizeof(string), "Komunikat wy�cigowy: {FFFFFF}Wyscig %s zako�czony przez system.", Wyscig[Scigamy][wNazwa]);
	else if(playerid == -2)
		format(string, sizeof(string), "Komunikat wy�cigowy: {FFFFFF}Wyscig %s zako�czony - wszyscy dojechali do mety!", Wyscig[Scigamy][wNazwa]);
	else
		format(string, sizeof(string), "Komunikat wy�cigowy: {FFFFFF}Wyscig %s zako�czony przez %s.", Wyscig[Scigamy][wNazwa], GetNickEx(playerid));

	WyscigMessage(COLOR_YELLOW, string);

	foreach(new i : Player)
	{
		if(ScigaSie[i] != 666)
		{
		    DisablePlayerRaceCheckpoint(i);
		    SendClientMessage(i, COLOR_YELLOW, "Koniec wyscigu");
		    ScigaSie[i] = 666;
		    IloscCH[i] = 0;
		}
	}
	IloscZawodnikow = 0;
	Ukonczyl = 1;
	Scigamy = 666;
	return 1;
}

strreplace2(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

public CleanPlayaPointsPJ(playerid)
{
PlayerInfo[playerid][pPrawojazdypytania] = 0;
PlayerInfo[playerid][pPrawojazdydobreodp] = 0;
return 1;
}

PrawoJazdyRandomGUITest(playerid, questions_available[], questions_count)
{
    new questions_ids[] = {3, 4, 5, 6, 7, 8, 9, 10, 21};
    new questions_content[][] =
    {
        "Jaki jest poprawny numer alarmowy?\n\nPodaj w cyfrach",
        "Czy nitro jest dozwolone?\n\nTak/Nie",
        "Ile wynosi dopuszczalna pr�dko��\nprzy holowaniu w terenie zabudowanym?\n\nPodaj w cyfrach",
        "Kt�r� stron� jezdni nale�y jecha�?\n\nPodaj jeden wyraz",
        "Co nale�y rozstawi� po wypadku?\n\nPodaj jeden wyraz",
        "Dozwolona pr�dko�� na autostradzie?\n\nPodaj w cyfrach",
        "Dozwolona pr�dko�� na mie�cie?\n\nPodaj w cyfrach",
        "Jaka jest maksymalna, dozwolona\npr�dko�� na drodze szybkiego ruchu?\n\nPodaj w cyfrach",
        "Co trzeba wyci�gn�� po wypadku\nby ostrzec o nim?\n\nPodaj jeden wyraz"
    };

    new random_question = random(questions_count);
    new random_question_id = questions_available[random_question];

    for(new i = random_question; i < questions_count - 1; i++)
    {
        questions_available[i] = questions_available[i+1];
    }

    ShowPlayerDialogEx(playerid, questions_ids[random_question_id], DIALOG_STYLE_INPUT, "Prawo Jazdy", questions_content[random_question_id], "Dalej", "");
    TiPJTGBKubi[playerid] = SetTimerEx("TiNzPJwGUI", 30000, 0, "i", playerid);
    return 1;
}

public Wywalonyzdmv(playerid){
wywalzdmv[playerid] = 0;
GameTextForPlayer(playerid, "~r~Mozesz juz wchodzic do dmv", 5000, 1);
return 1;
}

public ZlyKodUn(playerid){
AntyWlamSejf[playerid] = 0;
return 1;
}

public OgladanieDOM(playerid){
	new deem = PlayerInfo[playerid][pDomWKJ];
	if(PlayerInfo[playerid][pDomWKJ] != 0)
	{
		SetPlayerPos(playerid, Dom[deem][hWej_X], Dom[deem][hWej_Y], Dom[deem][hWej_Z]);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		PlayerInfo[playerid][pDomWKJ] = 0;
		SetServerWeatherAndTime(playerid);
	}
	if(isNaked[playerid])
	{
		UndressPlayer(playerid, false); 
	}
	GameTextForPlayer(playerid, "~r~Koniec czasu, zakup ten dom!", 5000, 1);
	DomOgladany[playerid] = 1;

	SetTimerEx("CzasOgladaniaDOM", 180000,0,"d",playerid);
	return 1;
}

public CzasOgladaniaDOM(playerid){
	DomOgladany[playerid] = 0;
	GameTextForPlayer(playerid, "~g~Znow mozesz obejrzec dom", 5000, 1);
	return 1;
}

public RSPAWN(playerid){
SetCameraBehindPlayer(playerid);
return 1;
}

public SzukanieAuta(playerid){
DisablePlayerCheckpoint(playerid);
return 1;
}

//Osobno
public AutodbzesRH(playerid)
{
	PlayerInfo[playerid][pRockHotelPuAc]=0;
	return 0;
}
/*
IsPlayerInCube(playerid, Float:xmin, Float:ymin, Float:zmin, Float:xmax, Float:ymax, Float:zmax)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	if(x > xmin && y > ymin && z > zmin && x < xmax && y < ymax && z < zmax)return 1;
	return 0;
}*/ 

stock GetPlayer2DZone(playerid, zone[], len)
{
	if(PlayerInfo[playerid][pJailed] == 3) 
	{
		return format(zone, len, "Nieznane ((AJ))", 0);
	}
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
 	for(new i = 0; i != sizeof(gSAZones); i++ )
 	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
		    return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock IsPlayerAtZone(playerid, zone[])
{
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	if(strcmp(pZone, zone, true) == 0)
	{
		return 1;
	}
	return 0;
}
/*
IsPointInRangeOfPoint(Float:range, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
{
    x2 -= x;
    y2 -= y;
    z2 -= z;
    return ((x2 * x2) + (y2 * y2) + (z2 * z2)) < (range * range);
}
*/
stock UndressPlayer(playerid, bool:dressup, colorID=0)
{
	new string[124];
	if(dressup)
	{
		SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]); 
        isNaked[playerid] = 0;
        format(string, sizeof(string), "%s ubiera si�.", GetNick(playerid)); 
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	}
	else
	{
		if(PlayerInfo[playerid][pSex] == 2)
        {
            if(colorID == 1)
            {
                SetPlayerSkinEx(playerid, 20001);
            }
            else
            {
                SetPlayerSkinEx(playerid, 20002); 
            }
        }
        else
        {
            if(colorID == 1)
            {
                SetPlayerSkinEx(playerid, 252);
            }
            else
            {
                SetPlayerSkinEx(playerid, 18); 
            }
        }
        format(string, sizeof(string), "%s rozbiera si�.", GetNick(playerid)); 
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        sendTipMessage(playerid, "Aby ubra� si� spowrotem, ponownie u�yj komendy /rozbierz.");
        isNaked[playerid] = 1; 
	}
	return 1;
}
stock IsVehicleInRangeOfPoint(vehicleid,Float:range,Float:x,Float:y,Float:z)
{
    if(vehicleid == INVALID_VEHICLE_ID) return 0;
    
    new Float:DistantaCar = GetVehicleDistanceFromPoint(vehicleid, x, y, z);
    
    if(DistantaCar <= range) return 1;
    return 0;
} 

stock GetNickEx(playerid, withmask = false)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	if(withmask)
	{
		return nick;
	}
	else
	{
		new nick2[24];
		if(GetPVarString(playerid, "maska_nick", nick2, 24))
		{
			return nick2;
		}
	}
	return nick;
}
stock GetNick(playerid)
{
	new nick[MAX_PLAYER_NAME];
 	GetPlayerName(playerid, nick, sizeof(nick));
	return nick;
}
stock GetIp(playerid)
{
	new ip[16];
	GetPlayerIp(playerid, ip, sizeof(ip));
	return ip;
}
FindPlayerByNumber(number)
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pPnumber] == number)
			return i;
	}
	return INVALID_PLAYER_ID;
}

Kostka_Wygrana(playerid, loser, kasa, bool:quit=false)
{
    //Kilka sprawdze�
    if(!quit && !IsPlayerConnected(loser)) return 0;
    if(strlen(GetNick(loser)) < 4) return 0;
    if(strlen(GetNick(playerid)) < 4) return 0;

    new podatek = floatround(kasa*0.05); //tutaj do sejfu 5% podatku
    DajKase(playerid, kasa-podatek);
    if(quit)
    {
        SetPVarInt(playerid, "kostka",0);
        SetPVarInt(playerid, "kostka-throw", 0);
        SetPVarInt(playerid, "kostka-suma", 0);
        SetPVarInt(playerid, "kostka-cash", 0);
        SetPVarInt(playerid, "kostka-first", 0);
        SetPVarInt(playerid, "kostka-rzut", 0);
        SetPVarInt(playerid, "kostka-wait", 0);
        SetPVarInt(playerid, "kostka-player", 0);
    }

	// podatek do sejfu
	new bizId = IsAtFrontBusinessInteriorType(playerid, FRONT_BIZ_TYPE_CASINO);
	if(bizId != -1)
	{
		GenerateFrontBusinessIncome(bizId, podatek / 2);
	}

    Log(payLog, INFO, "%s wygra� rzuty kostk� z %s na kwot� %d$ %s", GetPlayerLogName(playerid), GetPlayerLogName(loser), kasa, quit ? "(quit)" : "");
    return 1;
}
//system barierek by Kubi
GetNumberOfPages()
{
	if((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
	{
		return (gTotalItems / SELECTION_ITEMS);
	}
	else return (gTotalItems / SELECTION_ITEMS) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
 	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
   	PlayerTextDrawBoxColor(playerid, txtInit, 0x00000066);
   	PlayerTextDrawBackgroundColor(playerid, txtInit, 0x00000066);
	PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 3.1);
	PlayerTextDrawFont(playerid, txtInit, 1);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
	new PlayerText:txtInit;
   	txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
   	PlayerTextDrawUseBox(playerid, txtInit, 0);
	PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
	PlayerTextDrawFont(playerid, txtInit, 0);
	PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}

//------------------------------------------------

PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
	new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos,
	"                                 ~n~");
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawAlignment(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x00215D77);
	PlayerTextDrawLetterSize(playerid, txtBackground, 0.0, Height/10);
	PlayerTextDrawFont(playerid, txtBackground, 1);
	PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground,-1);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, 0.0);
   	PlayerTextDrawBackgroundColor(playerid, txtBackground, 255);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}

//------------------------------------------------

PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, "");
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x00000066);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height);
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetPreviewRot(playerid,txtPlayerSprite, -16.0, 0.0, -55.0);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid,txtPlayerSprite);
    return txtPlayerSprite;
}

//------------------------------------------------

DestroyPlayerModelPreviews(playerid)
{
	new x=0;
	while(x != SELECTION_ITEMS) {
	    if(gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW) {
			PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
			gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
		}
		x++;
	}
}

//------------------------------------------------

ShowPlayerModelPreviews(playerid)
{
    new x=0;
	new Float:BaseX = DIALOG_BASE_X;
	new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33);
	new linetracker = 0;

	new itemat = GetPVarInt(playerid, "gatechose_page") * SELECTION_ITEMS;

	DestroyPlayerModelPreviews(playerid);

	while(x != SELECTION_ITEMS && itemat < gTotalItems) {
	    if(linetracker == 0) {
	        BaseX = DIALOG_BASE_X + 25.0;
	        BaseY += SPRITE_DIM_Y + 1.0;
		}
  		gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
  		gSelectionItemsTag[playerid][x] = gItemList[itemat];
		BaseX += SPRITE_DIM_X + 1.0;
		linetracker++;
		if(linetracker == ITEMS_PER_LINE) linetracker = 0;
		itemat++;
		x++;
	}
}

//------------------------------------------------

UpdatePageTextDraw(playerid)
{
	new PageText[64+1];
	format(PageText, 64, "%d/%d", GetPVarInt(playerid,"gatechose_page") + 1, GetNumberOfPages());
	PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}

//------------------------------------------------

CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 95.0, DIALOG_BASE_Y+(DIALOG_HEIGHT/3)+108.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH+1, DIALOG_BASE_Y+(DIALOG_HEIGHT/2), 25.0, 36.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_BASE_X-1, DIALOG_BASE_Y+(DIALOG_HEIGHT/2), 25.0, 36.0, PREV_TEXT);

    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}

//------------------------------------------------

DestroySelectionMenu(playerid)
{
	DestroyPlayerModelPreviews(playerid);

	PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
	PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);

	gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}

GetBarierID(frac)
{
    new id=-1;
    for(new i=0;i<10;i++)
    {
        if(!BarierState[frac][i])
        {
            id = i;
            break;
        }
    }
    return id;
}
HandlePlayerItemSelection(playerid, selecteditem)
{
    new frac = GetPlayerFraction(playerid);
    new id = GetBarierID(frac); //FRAKCJA!!

    if(id == -1) return SendClientMessage(playerid, -1, "Osi�gni�to limit barierek.");

    new Float:x, Float:y, Float:z, Float:a, vw;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    SetPlayerPos(playerid, x, y, z+0.2);
	vw = GetPlayerVirtualWorld(playerid);
    x+=2*floatsin(-a, degrees);
    y+=2*floatcos(-a, degrees);

    BARIERKA_Create(frac, id, gSelectionItemsTag[playerid][selecteditem], x, y, z-0.5, a, vw);

    SetPVarInt(playerid, "Barier-id", id+1);
    SetTimerEx("EditObj", 500, 0, "ii", playerid, Barier[frac][id]);
    return 1;
}

BARIERKA_Create(frac, id, model, Float:x, Float:y, Float:z, Float:a, vw = 0)
{
	DestroyDynamicObject(Barier[frac][id]);
	new oid = CreateDynamicObject(model, x, y, z, 0.0, 0.0, a, vw);
	if(Barier[frac][id] != oid) printf("Object ID moved from %d to %d", Barier[frac][id], oid), Barier[frac][id] = oid;
	BarierState[frac][id] = true;
    return 1;
}

BARIERKA_Remove(frakcja, id)
{
    SetDynamicObjectPos(Barier[frakcja][id], 0.0, 0.0, -100.0);
    DestroyDynamic3DTextLabel(BarText[frakcja][id]);
    BarierState[frakcja][id] = false;
    return 1;
}

BARIERKA_Init()
{
    for(new j=0;j<=4;j++) //organizacje, LSPD, FBI, NG LSMC
    {
        for(new i=0;i<10;i++)
        {
            Barier[j][i] = CreateDynamicObject(19300, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
            BarierState[j][i] = false;
        }
    }
    for(new i=0;i<10;i++) //LSFD
    {
        Barier[FRAC_ERS][i] = CreateDynamicObject(19300, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
        BarierState[FRAC_ERS][i] = false;
    }
    for(new i=0;i<10;i++) //USSS
    {
        Barier[FRAC_BOR][i] = CreateDynamicObject(19300, 0.0, 0.0, -50.0, 0.0, 0.0, 0.0);
        BarierState[FRAC_BOR][i] = false;
    }
    return 1;
}

public EditObj(playerid, obj)
{
    EditDynamicObject(playerid, obj);
}

SetPlayerWeatherEx(playerid, id)
{
    if(!(1 < id < 21)) return 1;
	SetPlayerWeather(playerid, id);
    SetPVarInt(playerid, "Weather", id);
    return 1;
}

SetWeatherEx(id)
{
    if(!(1 < id < 21) || id == 11 || id == 19) return 1;
	SetWeather(id);
	ServerWeather = id;
	return 1;
}


//koniec Mini Timery

//--------------------------------------------------------
//-----------------------[Funkcje:]-----------------------
//--------------------------------------------------------

split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}


Float:GetDistanceBetweenPlayers(p1,p2)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
	if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2))
	{
		return -1.00;
	}
	if(Spectate[p1] != INVALID_PLAYER_ID || Spectate[p2] != INVALID_PLAYER_ID)
	{
		return 50000; // admini na spec nie s� blisko
	}
	GetPlayerPos(p1,x1,y1,z1);
	GetPlayerPos(p2,x2,y2,z2);
	return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

IsPlayerNear(playerid, giveplayerid, distance=10)
{
	return (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(giveplayerid) && 
		GetDistanceBetweenPlayers(playerid, giveplayerid) < distance && 
		Spectate[giveplayerid] == INVALID_PLAYER_ID
	);
}

SearchingHit(playerid)
{
	new string[256];
	new giveplayer[MAX_PLAYER_NAME];
	new searchhit = 0;
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(searchhit == 0)
		    {
			    if(PlayerInfo[i][pHeadValue] > 0 && GotHit[i] == 0 && PlayerInfo[i][pMember] != 8)
			    {
			        GetPlayerName(i, giveplayer, sizeof(giveplayer));
			        searchhit = 1;
			        hitfound = 1;
			        hitmanid = i;
			        foreach(new k : Player)
					{
						if(IsPlayerConnected(k))
						{
				        	if(PlayerInfo[k][pMember] == 8 || PlayerInfo[k][pLider] == 8)
				        	{
	               				SendClientMessage(k, COLOR_WHITE, "|__________________ Hitman Agency News __________________|");
				                SendClientMessage(k, COLOR_DBLUE, "*** Wiadomo��: Nowe zlecenia s� ju� dost�pne. ***");
				                format(string, sizeof(string), "Osoba: %s   ID: %d   Kasa: $%d", giveplayer, i, PlayerInfo[i][pHeadValue]);
								SendClientMessage(k, COLOR_DBLUE, string);
								SendClientMessage(k, COLOR_YELLOW, "Wpisz Givehit [hitmanid], aby podpisa� kontrakt z hitmanem.");
								SendClientMessage(k, COLOR_WHITE, "|________________________________________________________|");
	      					}
					    }
					}
					return 0;
			    }
			}
		}
	}
	if(searchhit == 0)
	{
	    SendClientMessage(playerid, COLOR_GREY, "   Nie ma dost�pnych zlece� !");
	}
	return 0;
}

StartZuzling()
{
    foreach(new i : Player)
	{
	    if(IsPlayerConnected(i))
	    {
	        if(zawodnik[i] == 1)
	        {
	            SendClientMessage(i, COLOR_GREEN, "Zielone �wiat�o, go go go !");
	            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
	            SetPlayerCheckpoint(i,-1083.2609,-1006.3092,128.9274,5.0);
	            okrazenia[i] = 0;
	        }
	    }
	}
}

DollahScoreUpdate()
{
	new LevScore;
	foreach(new i : Player)
	{
		LevScore = PlayerInfo[i][pLevel];
		SetPlayerScore(i, LevScore);
	}
	return 1;
}

rightStr(source[], len)
{
	new retval[MAX_STRING2], srclen;
	srclen = strlen(source);
	strmid(retval, source, srclen - len, srclen, MAX_STRING2);
	return retval;
}

IsAProductionServer()
{
	return dini_Exists("production.info");
}


IsAWyscigOrganizowany()
{
	foreach(new i : Player)
	{
		if(owyscig[i] != 666)
		{
			return i;
		}
	}
	return -1;
}

IsAWyscigTworzony()
{
	foreach(new i : Player)
	{
		if(tworzenietrasy[i] != 666)
		{
			return i;
		}
	}
	return -1;
}

IsASpojler(vehid)
{
	new wozspojler = GetVehicleModel(vehid);
 	if(wozspojler == 401 || wozspojler == 404 || wozspojler == 405 || wozspojler == 410 || wozspojler == 415 || wozspojler == 418 || wozspojler == 420 || wozspojler == 421 || wozspojler == 426 || wozspojler == 436 || wozspojler == 439 || wozspojler == 458 || wozspojler == 489 || wozspojler == 490 || wozspojler == 491 || wozspojler == 492 || wozspojler == 496 || wozspojler == 505 || wozspojler == 516 || wozspojler == 517 || wozspojler == 518)
	{
	    return 1;
	}
	if(wozspojler == 527 || wozspojler == 529 || wozspojler == 540 || wozspojler == 542 || wozspojler == 546 || wozspojler == 547 || wozspojler == 549 || wozspojler == 550 || wozspojler == 551 || wozspojler == 558 || wozspojler == 559 || wozspojler == 560 || wozspojler == 561 || wozspojler == 562 || wozspojler == 565 || wozspojler == 579 || wozspojler == 580 || wozspojler == 586 || wozspojler == 587 || wozspojler == 589 || wozspojler == 599 || wozspojler == 603)
	{
	    return 1;
	}
	return 0;
}

UsunBron(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		PlayerInfo[playerid][pGun0] = 0;//Pi�� lub kastet
		PlayerInfo[playerid][pGun1] = 0;//Bro� bia�a
		PlayerInfo[playerid][pGun2] = 0;//Pistolety
		PlayerInfo[playerid][pGun3] = 0;//Shotguny
		PlayerInfo[playerid][pGun4] = 0;//Bro� maszynowa
		PlayerInfo[playerid][pGun5] = 0;//Karabiny
		PlayerInfo[playerid][pGun6] = 0;//Snajperki
		PlayerInfo[playerid][pGun7] = 0;//Ci�ka bro�
		PlayerInfo[playerid][pGun8] = 0;//Bro� wybuchowa
		PlayerInfo[playerid][pGun9] = 0;//Sprej/Gasnica/Aparat
		PlayerInfo[playerid][pGun10] = 0;//Nietypowa bro� bia�a
		PlayerInfo[playerid][pGun11] = 0;//Spadochron
		PlayerInfo[playerid][pGun12] = 0;//Detonator
		PlayerInfo[playerid][pAmmo0] = 0;
		PlayerInfo[playerid][pAmmo1] = 0;
		PlayerInfo[playerid][pAmmo2] = 0;
		PlayerInfo[playerid][pAmmo3] = 0;
		PlayerInfo[playerid][pAmmo4] = 0;
		PlayerInfo[playerid][pAmmo5] = 0;
		PlayerInfo[playerid][pAmmo6] = 0;
		PlayerInfo[playerid][pAmmo7] = 0;
		PlayerInfo[playerid][pAmmo8] = 0;
		PlayerInfo[playerid][pAmmo9] = 0;
		PlayerInfo[playerid][pAmmo10] = 0;
		PlayerInfo[playerid][pAmmo11] = 0;
		PlayerInfo[playerid][pAmmo12] = 0;
		return 1;
	}
	return 0;
}
stock RemoveWeaponFromSlot(playerid, iWeaponSlot) 
{
    new wps[13][2];
    for(new i = 0; i < 13; i++) GetPlayerWeaponData(playerid, i, wps[i][0], wps[i][1]);

    wps[iWeaponSlot][0] = 0;

    ResetPlayerWeapons(playerid);

    for(new i = 0; i < 13; i++) GivePlayerWeapon(playerid, wps[i][0], wps[i][1]);

}


stock RemovePlayerWeaponsTemporarity(playerid) 
{
    new wps[13][2];
   	for(new i,j=13;i<j;i++)
	{
		GetPlayerWeaponData(playerid,i,wps[i][0],wps[i][1]);
		if(wps[i][0] > 0)
		{
			SetPlayerAmmo(playerid,wps[i][0],0);
		}
	} 

	ResetPlayerWeapons(playerid);
	SetPlayerArmedWeapon(playerid, 0);
	MyWeapon[playerid] = 0;
}

DajBronieFrakcyjne(playerid)
{
	if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 3; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 1;
	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	    if(PlayerInfo[playerid][pGun3] == 0 || PlayerInfo[playerid][pGun3] == 25 && PlayerInfo[playerid][pAmmo3] < 50 || PlayerInfo[playerid][pAmmo3] <= 5)
	    {
	        PlayerInfo[playerid][pGun3] = 25; PlayerInfo[playerid][pAmmo3] = 100;
	        playerWeapons[playerid][weaponLegal4] = 1;
	    }
	    if(PlayerInfo[playerid][pGun4] == 0 || PlayerInfo[playerid][pGun4] == 29 && PlayerInfo[playerid][pAmmo4] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun4] = 29; PlayerInfo[playerid][pAmmo4] = 530;
	        playerWeapons[playerid][weaponLegal5] = 1;
	    }
	    if(PlayerInfo[playerid][pGun5] == 0 || PlayerInfo[playerid][pGun5] == 31 && PlayerInfo[playerid][pAmmo5] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun5] = 31; PlayerInfo[playerid][pAmmo5] = 730;
	        playerWeapons[playerid][weaponLegal6] = 1;
	    }
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 41 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 41; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	else if(PlayerInfo[playerid][pMember] == 2)
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 3; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 1;
	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	    if(PlayerInfo[playerid][pGun3] == 0 || PlayerInfo[playerid][pGun3] == 25 && PlayerInfo[playerid][pAmmo3] < 50 || PlayerInfo[playerid][pAmmo3] <= 5)
	    {
	        PlayerInfo[playerid][pGun3] = 25; PlayerInfo[playerid][pAmmo3] = 150;
	        playerWeapons[playerid][weaponLegal4] = 1;
	    }
	    if(PlayerInfo[playerid][pGun4] == 0 || PlayerInfo[playerid][pGun4] == 29 && PlayerInfo[playerid][pAmmo4] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun4] = 29; PlayerInfo[playerid][pAmmo4] = 1030;
	        playerWeapons[playerid][weaponLegal5] = 1;
	    }
	    if(PlayerInfo[playerid][pGun5] == 0 || PlayerInfo[playerid][pGun5] == 31 && PlayerInfo[playerid][pAmmo5] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun5] = 31; PlayerInfo[playerid][pAmmo5] = 730;
	        playerWeapons[playerid][weaponLegal6] = 1;
	    }
	    if(PlayerInfo[playerid][pGun6] == 0 || PlayerInfo[playerid][pGun6] == 33 && PlayerInfo[playerid][pAmmo6] < 20  || PlayerInfo[playerid][pAmmo4] <= 5)
	    {
	        PlayerInfo[playerid][pGun6] = 34; PlayerInfo[playerid][pAmmo6] = 69;
	        playerWeapons[playerid][weaponLegal7] = 1;
	    }
	    if(PlayerInfo[playerid][pGun8] == 0 || PlayerInfo[playerid][pGun8] == 17 && PlayerInfo[playerid][pAmmo8] < 10 || PlayerInfo[playerid][pAmmo8] <= 2)
	    {
	        PlayerInfo[playerid][pGun8] = 17; PlayerInfo[playerid][pAmmo8] = 20;
	        playerWeapons[playerid][weaponLegal9] = 1;
	    }
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 41 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 41; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal9] = 10;
	    }
	}
	else if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
	{
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	    if(PlayerInfo[playerid][pGun3] == 0 || PlayerInfo[playerid][pGun3] == 25 && PlayerInfo[playerid][pAmmo3] < 50 || PlayerInfo[playerid][pAmmo3] <= 5)
	    {
	        PlayerInfo[playerid][pGun3] = 25; PlayerInfo[playerid][pAmmo3] = 150;
	        playerWeapons[playerid][weaponLegal4] = 1;
	    }
	    if(PlayerInfo[playerid][pGun4] == 0 || PlayerInfo[playerid][pGun4] == 29 && PlayerInfo[playerid][pAmmo4] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun4] = 29; PlayerInfo[playerid][pAmmo4] = 1030;
	        playerWeapons[playerid][weaponLegal5] = 1;
	    }
	    if(PlayerInfo[playerid][pGun5] == 0 || PlayerInfo[playerid][pGun5] == 31 && PlayerInfo[playerid][pAmmo5] < 200 || PlayerInfo[playerid][pAmmo5] <= 30)
	    {
	        PlayerInfo[playerid][pGun5] = 31; PlayerInfo[playerid][pAmmo5] = 730;
	        playerWeapons[playerid][weaponLegal6] = 1;
	    }
	    if(PlayerInfo[playerid][pGun6] == 0 || PlayerInfo[playerid][pGun6] == 33 && PlayerInfo[playerid][pAmmo6] < 20 || PlayerInfo[playerid][pAmmo6] <= 5)
	    {
	        PlayerInfo[playerid][pGun6] = 33; PlayerInfo[playerid][pAmmo6] = 50;
	        playerWeapons[playerid][weaponLegal7] = 1;
	    }
	    if(PlayerInfo[playerid][pGun8] == 0)
	    {
	        PlayerInfo[playerid][pGun8] = 16; PlayerInfo[playerid][pAmmo8] = 2;
	        playerWeapons[playerid][weaponLegal9] = 1;
	    }
     	if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 41 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 41; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	else if(PlayerInfo[playerid][pMember] == FRAC_ERS || PlayerInfo[playerid][pLider] == FRAC_ERS)
	{
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 42 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30 )
	    {
	        PlayerInfo[playerid][pGun9] = 42; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
    else if(GetPlayerFraction(playerid) == FRAC_ERS && PlayerInfo[playerid][pRank] <= 3)
	{
        if(JobDuty[playerid] == 1)
        {
    	    if(PlayerInfo[playerid][pGun1] == 0)
    	    {
    	        PlayerInfo[playerid][pGun1] = 6; PlayerInfo[playerid][pAmmo1] = 1;
    	        playerWeapons[playerid][weaponLegal2] = 1;
    	    }
            if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 42)
    	    {
    	        PlayerInfo[playerid][pGun9] = 42; PlayerInfo[playerid][pAmmo9] = 10000;
    	        playerWeapons[playerid][weaponLegal10] = 1;
    	    }
        }
	}
	else if(PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLider] == 7)
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 3; PlayerInfo[playerid][pAmmo1] = 1;
	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 50 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 207;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
	    if(PlayerInfo[playerid][pGun3] == 0 || PlayerInfo[playerid][pGun3] == 25 && PlayerInfo[playerid][pAmmo3] < 50 || PlayerInfo[playerid][pAmmo3] <= 5)
	    {
	        PlayerInfo[playerid][pGun3] = 25; PlayerInfo[playerid][pAmmo3] = 100;
	        playerWeapons[playerid][weaponLegal4] = 1;
	    }
	    if(PlayerInfo[playerid][pGun4] == 0 || PlayerInfo[playerid][pGun4] == 29 && PlayerInfo[playerid][pAmmo4] < 200 || PlayerInfo[playerid][pAmmo4] <= 30)
	    {
	        PlayerInfo[playerid][pGun4] = 29; PlayerInfo[playerid][pAmmo4] = 530;
	        playerWeapons[playerid][weaponLegal5] = 1;
	    }
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 41 && PlayerInfo[playerid][pAmmo9] < 500 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 41; PlayerInfo[playerid][pAmmo9] = 10000;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	else if(PlayerInfo[playerid][pMember] == 8 || PlayerInfo[playerid][pLider] == 8)
	{
	    if(PlayerInfo[playerid][pGun1] == 0)
	    {
	        PlayerInfo[playerid][pGun1] = 4; PlayerInfo[playerid][pAmmo1] = 1;
	        playerWeapons[playerid][weaponLegal2] = 0;

	    }
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 25 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 107;
	        playerWeapons[playerid][weaponLegal3] = 0;
	    }//HA
	}
	else if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
	{
	    if(PlayerInfo[playerid][pGun9] == 0 || PlayerInfo[playerid][pGun9] == 43 && PlayerInfo[playerid][pAmmo9] < 10 || PlayerInfo[playerid][pAmmo9] <= 30)
	    {
	        PlayerInfo[playerid][pGun9] = 43; PlayerInfo[playerid][pAmmo9] = 100;
	        playerWeapons[playerid][weaponLegal10] = 1;
	    }
	}
	else if(PlayerInfo[playerid][pLider] == 11)
	{
	    if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 23 && PlayerInfo[playerid][pAmmo2] < 25 || PlayerInfo[playerid][pAmmo2] <= 7)
	    {
	        PlayerInfo[playerid][pGun2] = 23; PlayerInfo[playerid][pAmmo2] = 107;
	        playerWeapons[playerid][weaponLegal3] = 1;
	    }
		if(PlayerInfo[playerid][pGun11] == 0)
		{
			PlayerInfo[playerid][pGun11] = 46; PlayerInfo[playerid][pAmmo11] = 1;
			playerWeapons[playerid][weaponLegal11] = 0;
		}
		if(PlayerInfo[playerid][pGun1] == 0)
		{
			PlayerInfo[playerid][pGun1] = 2; PlayerInfo[playerid][pAmmo1] = 1;
			playerWeapons[playerid][weaponLegal1] = 1;
		}
	}
	return 1;
}

DajBroniePracy(playerid)
{
	switch(PlayerInfo[playerid][pJob])
	{
		case JOB_MECHANIC:
		{
			if(PlayerInfo[playerid][pGun1] == 0)
			{
				PlayerInfo[playerid][pGun1] = 6; PlayerInfo[playerid][pAmmo1] = 1;
				playerWeapons[playerid][weaponLegal2] = 1;
			}
		}
		case JOB_DRUG_DEALER:
		{
			if(PlayerInfo[playerid][pGun1] == 0)
			{
				PlayerInfo[playerid][pGun1] = 5; PlayerInfo[playerid][pAmmo1] = 1;
				playerWeapons[playerid][weaponLegal2] = 0;
			}
		}
		case JOB_GUN_DEALER:
		{
			if(PlayerInfo[playerid][pGun1] == 0)
			{
				PlayerInfo[playerid][pGun1] = 5; PlayerInfo[playerid][pAmmo1] = 1;
				playerWeapons[playerid][weaponLegal2] = 0;
			}
		}
		/*case JOB_LOWCA:
		{
			if(PlayerInfo[playerid][pGun2] == 0 || PlayerInfo[playerid][pGun2] == 24 && PlayerInfo[playerid][pAmmo2] < 25 || PlayerInfo[playerid][pAmmo2] <= 7)
			{
				PlayerInfo[playerid][pGun2] = 24; PlayerInfo[playerid][pAmmo2] = 107;
			}
		}*/
	}
}

PrzywrocBron(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    ResetPlayerWeapons(playerid);
		new startowabron = 0;
	    if(PlayerInfo[playerid][pGun0] == 1)
		{
			startowabron = 1;
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun0], PlayerInfo[playerid][pAmmo0]);
		}
		if(PlayerInfo[playerid][pGun1] >= 2)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pAmmo1]);
		}
		if(PlayerInfo[playerid][pGun2] >= 2 && PlayerInfo[playerid][pAmmo2] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pAmmo2]);
		}
		if(PlayerInfo[playerid][pGun3] >= 2 && PlayerInfo[playerid][pAmmo3] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pAmmo3]);
		}
		if(PlayerInfo[playerid][pGun4] >= 2 && PlayerInfo[playerid][pAmmo4] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pAmmo4]);
		}
		if(PlayerInfo[playerid][pGun5] >= 2 && PlayerInfo[playerid][pAmmo5] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun5], PlayerInfo[playerid][pAmmo5]);
		}
		if(PlayerInfo[playerid][pGun6] >= 2 && PlayerInfo[playerid][pAmmo6] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun6], PlayerInfo[playerid][pAmmo6]);
		}
		if(PlayerInfo[playerid][pGun7] >= 2 && PlayerInfo[playerid][pAmmo7] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun7], PlayerInfo[playerid][pAmmo7]);
		}
		if(PlayerInfo[playerid][pGun8] >= 2 && PlayerInfo[playerid][pAmmo8] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun8], PlayerInfo[playerid][pAmmo8]);
		}
		if(PlayerInfo[playerid][pGun9] >= 2  && PlayerInfo[playerid][pAmmo9] >= 1)
		{
            GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun9], PlayerInfo[playerid][pAmmo9]);
		}
		if(PlayerInfo[playerid][pGun10] >= 2)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun10], PlayerInfo[playerid][pAmmo10]);
		}
		if(PlayerInfo[playerid][pGun11] >= 2  && PlayerInfo[playerid][pAmmo11] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun11], PlayerInfo[playerid][pAmmo11]);
		}
		if(PlayerInfo[playerid][pGun12] >= 2  && PlayerInfo[playerid][pAmmo12] >= 1)
		{
		    GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun12], PlayerInfo[playerid][pAmmo12]);
		}
		PrzedmiotyZmienBron(playerid, startowabron);
		return 1;
	}
	return 0;
}

WyjmijBron(playerid)
{
    new dom = PlayerInfo[playerid][pDom];
    new bron[2000];
    new a2,a3,a4,a5,a6,a7,a8,a9;
    new b0[100],b1[100],b2[100],b3[100],b4[100],b5[100],b6[100],b7[100],b8[100],b9[100],b10[100],b11[100];
    format(b0, sizeof(b0), "%s", GunNames[Dom[dom][hS_G0]]);
    format(b1, sizeof(b1), "%s", GunNames[Dom[dom][hS_G1]]);
    format(b2, sizeof(b2), "%s", GunNames[Dom[dom][hS_G2]]);
    format(b3, sizeof(b3), "%s", GunNames[Dom[dom][hS_G3]]);
    format(b4, sizeof(b4), "%s", GunNames[Dom[dom][hS_G4]]);
    format(b5, sizeof(b5), "%s", GunNames[Dom[dom][hS_G5]]);
    format(b6, sizeof(b6), "%s", GunNames[Dom[dom][hS_G6]]);
    format(b7, sizeof(b7), "%s", GunNames[Dom[dom][hS_G7]]);
    format(b8, sizeof(b8), "%s", GunNames[Dom[dom][hS_G8]]);
    format(b9, sizeof(b9), "%s", GunNames[Dom[dom][hS_G9]]);
    format(b10, sizeof(b10), "%s", GunNames[Dom[dom][hS_G10]]);
    format(b11, sizeof(b11), "%s", GunNames[Dom[dom][hS_G11]]);
    a2 = Dom[dom][hS_A2];
    a3 = Dom[dom][hS_A3];
    a4 = Dom[dom][hS_A4];
    a5 = Dom[dom][hS_A5];
    a6 = Dom[dom][hS_A6];
    a7 = Dom[dom][hS_A7];
    a8 = Dom[dom][hS_A8];
    a9 = Dom[dom][hS_A9];
    format(bron, sizeof(bron), "%s\n%s\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\n%s",b0,b1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,a9,b10,b11);
    ShowPlayerDialogEx(playerid, 8241, DIALOG_STYLE_LIST, "Wybierz bro� kt�r� chcesz wyj��", bron, "Wybierz", "Cofnij");
}

SchowajBron(playerid)
{
    new BronieF[13][2];
	for(new i = 0; i < 13; i++) { GetPlayerWeaponData(playerid, i, BronieF[i][0], BronieF[i][1]); }
 	new b0[100],b1[100],b2[100],b3[100],b4[100],b5[100],b6[100],b7[100],b8[100],b9[100],b10[100],b11[100];
	new a2,a3,a4,a5,a6,a7,a8,a9;
	format(b0, sizeof(b0), "%s", GunNames[BronieF[0][0]]);
	format(b1, sizeof(b1), "%s", GunNames[BronieF[1][0]]);
	if(BronieF[2][1] >= 1) { format(b2, sizeof(b2), "%s", GunNames[BronieF[2][0]]); a2 = BronieF[2][1]; }
	if(BronieF[3][1] >= 1) { format(b3, sizeof(b3), "%s", GunNames[BronieF[3][0]]); a3 = BronieF[3][1]; }
	if(BronieF[4][1] >= 1) { format(b4, sizeof(b4), "%s", GunNames[BronieF[4][0]]); a4 = BronieF[4][1]; }
	if(BronieF[5][1] >= 1) { format(b5, sizeof(b5), "%s", GunNames[BronieF[5][0]]); a5 = BronieF[5][1]; }
	if(BronieF[6][1] >= 1) { format(b6, sizeof(b6), "%s", GunNames[BronieF[6][0]]); a6 = BronieF[6][1]; }
	if(BronieF[7][1] >= 1) { format(b7, sizeof(b7), "%s", GunNames[BronieF[7][0]]); a7 = BronieF[7][1]; }
	if(BronieF[8][1] >= 1) { format(b8, sizeof(b8), "%s", GunNames[BronieF[8][0]]); a8 = BronieF[8][1]; }
	if(BronieF[9][1] >= 1) { format(b9, sizeof(b9), "%s", GunNames[BronieF[9][0]]); a9 = BronieF[9][1]; }
	format(b10, sizeof(b10), "%s", GunNames[BronieF[10][0]]);
	format(b11, sizeof(b11), "%s", GunNames[BronieF[11][0]]);
	new bron28itrzyipol[2000];
 	format(bron28itrzyipol, sizeof(bron28itrzyipol), "%s\n%s\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\n%s",b0,b1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,a9,b10,b11);
 	ShowPlayerDialogEx(playerid, 8242, DIALOG_STYLE_LIST, "Wybierz bro� kt�r� chcesz schowa�", bron28itrzyipol, "Wybierz", "Cofnij");
}

ListaBroni(playerid)
{
	new dom = PlayerInfo[playerid][pDom];
    new bron[2000];
    new a2,a3,a4,a5,a6,a7,a8,a9;
    new b0[100],b1[100],b2[100],b3[100],b4[100],b5[100],b6[100],b7[100],b8[100],b9[100],b10[100],b11[100];
    format(b0, sizeof(b0), "%s", GunNames[Dom[dom][hS_G0]]);
    format(b1, sizeof(b1), "%s", GunNames[Dom[dom][hS_G1]]);
    format(b2, sizeof(b2), "%s", GunNames[Dom[dom][hS_G2]]);
    format(b3, sizeof(b3), "%s", GunNames[Dom[dom][hS_G3]]);
    format(b4, sizeof(b4), "%s", GunNames[Dom[dom][hS_G4]]);
    format(b5, sizeof(b5), "%s", GunNames[Dom[dom][hS_G5]]);
    format(b6, sizeof(b6), "%s", GunNames[Dom[dom][hS_G6]]);
    format(b7, sizeof(b7), "%s", GunNames[Dom[dom][hS_G7]]);
    format(b8, sizeof(b8), "%s", GunNames[Dom[dom][hS_G8]]);
    format(b9, sizeof(b9), "%s", GunNames[Dom[dom][hS_G9]]);
    format(b10, sizeof(b10), "%s", GunNames[Dom[dom][hS_G10]]);
    format(b11, sizeof(b11), "%s", GunNames[Dom[dom][hS_G11]]);
    a2 = Dom[dom][hS_A2];
    a3 = Dom[dom][hS_A3];
    a4 = Dom[dom][hS_A4];
    a5 = Dom[dom][hS_A5];
    a6 = Dom[dom][hS_A6];
    a7 = Dom[dom][hS_A7];
    a8 = Dom[dom][hS_A8];
    a9 = Dom[dom][hS_A9];
    format(bron, sizeof(bron), "%s\n%s\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\tAmunicja:%d\n%s\n%s",b0,b1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,a9,b10,b11);
    ShowPlayerDialogEx(playerid, 8243, DIALOG_STYLE_LIST, "Lista broni", bron, "Usu�", "Cofnij");
}

MaZapisanaBron(playerid)
{
    if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pGun0] == 1)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun1] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun2] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun3] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun4] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun5] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun6] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun7] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun8] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun9] >= 2)
		{
            return 1;
		}
		else if(PlayerInfo[playerid][pGun10] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun11] >= 2)
		{
		    return 1;
		}
		else if(PlayerInfo[playerid][pGun12] >= 2)
		{
		    return 1;
		}
	}
	return 0;
}

IsAKogutCar(veh)
{
	new model = GetVehicleModel(veh);
	if(model == 415)//cheetah
    {
        return 1;
    }
    else if(model == 412)//voodoo
    {
        return 1;
    }
    else if(model == 421)//washington
    {
        return 1;
    }
    else if(model == 426)//premier
    {
        return 1;
    }
    else if(model == 428)//Securicar
    {
        return 1;
    }
    else if(model == 402)//Buffalo
    {
        return 1;
    }
    else if(model == 401)//bravura
    {
        return 1;
    }
    else if(model == 405)//Sentinel
    {
        return 1;
    }
    else if(model == 411)//infenus
    {
        return 1;
    }
    else if(model == 429)//banshee
    {
        return 1;
    }
    else if(model == 451)//turismo
    {
        return 1;
    }
    else if(model == 470)//hummer
    {
        return 1;
    }
    else if(model == 477)//zr-350
    {
        return 1;
    }
    else if(model == 506)//super gt
    {
        return 1;
    }
    else if(model == 507)//elegant
    {
        return 1;
    }
    else if(model == 541)//bullet
    {
        return 1;
    }
    else if(model == 560)//sultan
    {
        return 1;
    }
    else if(model == 562)//elegy
    {
        return 1;
    }
    else if(model == 558)//uranus
    {
        return 1;
    }
	else
	{
		return 0;
	}
}

PrzyczepKogut(playerid, veh)
{
	new model = GetVehicleModel(veh);

    new Float:x, Float:y, Float:z;
    if(model == 415)//cheetah
    {
        x = -0.5;
        y = -0.1;
        z = 0.65;
    }
    else if(model == 412)//voodoo
    {
        x = -0.5;
        y = -0.1;
        z = 0.75;
    }
    else if(model == 421)//washington
    {
        x = -0.5;
        y = 0.15;
        z = 0.75;
    }
    else if(model == 426)//premier
    {
        x = -0.55;
        y = 0.01;
        z = 0.9;
    }
    else if(model == 428)//Securicar
    {
        x = -0.9;
        y = 1.0;
        z = 1.4;
    }
    else if(model == 402)//Buffalo
    {
        x = -0.55;
        y = -0.5;
        z = 0.82;
    }
    else if(model == 401)//bravura
    {
        x = -0.5;
        y = -0.2;
        z = 0.82;
    }
    else if(model == 405)//Sentinel
    {
        x = -0.5;
        y = -0.1;
        z = 0.8;
    }
    else if(model == 411)//infenus
    {
        x = -0.5;
        y = -0.1;
        z = 0.75;
    }
    else if(model == 429)//banshee
    {
        x = -0.75;
        y = -1.3;
        z = 0.5;
    }
    else if(model == 451)//turismo
    {
        x = -0.5;
        y = -0.5;
        z = 0.65;
    }
    else if(model == 470)//hummer
    {
        x = -0.57;
        y = 0.1;
        z = 1.15;
    }
    else if(model == 477)//zr-350
    {
        x = -0.57;
        y = -0.27;
        z = 0.75;
    }
    else if(model == 506)//super gt
    {
        x = -0.57;
        y = -0.98;
        z = 0.65;
    }
    else if(model == 507)//elegant
    {
        x = -0.57;
        y = -0.01;
        z = 0.82;
    }
    else if(model == 541)//bullet
    {
        x = -0.5;
        y = 0.01;
        z = 0.70;
    }
    else if(model == 560)//sultan
    {
        x = -0.5;
        y = 0.01;
        z = 0.89;
    }
    else if(model == 562)//elegy
    {
        x = -0.5;
        y = 0.01;
        z = 0.8;
    }
    else if(model == 558)//uranus
    {
        x = -0.55;
        y = 0.01;
        z = 0.88;
    }
    else
    {
        SendClientMessage(playerid, COLOR_WHITE, "Na tym wozie nie mo�na przyczepi� koguta");
    }
    VehicleUID[veh][vSiren] = CreateDynamicObject(18646, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
    AttachDynamicObjectToVehicle(VehicleUID[veh][vSiren], veh, x,y,z, 0.0, 0.0, 0.0);
	return 1;
}

stock IsAtAmmunationLosSantos(playerid)
{
	if(GetPlayerVirtualWorld(playerid) == 5 && IsPlayerInRangeOfPoint(playerid, 100.0, 1815.6812,-1172.1915,61.5103)) return 1;
	return 0;
}

IsAtTheDMVWindows(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7228,-1792.1116,77.9502))//okienko 1
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7327,-1795.6041,77.9612))//okienko 2
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7328,-1798.7909,77.9612))//okienko 3
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1455.7350,-1802.1936,77.9502))//okienko 4
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.2709,-1791.4561,77.9502))//okienko 5
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.3060,-1794.1992,77.9612))//okienko 6
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.3192,-1797.6259,77.9612))//okienko 7
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1445.3387,-1800.7615,77.9612))//okienko 8
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1450.0565,-1854.4873,81.4670))//biuro burmistrza
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.0, 1454.3301,-1782.8667,77.9502))//kamery bor
	{
	
		return 1;
	}

	return 0;
}
IsAtPlaceGetHP(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 0.5, 1483.4926,-1816.1971,77.9512))//DMV
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 0.5, 2130.9885,-1787.2729,13.6544))//Pizza idle
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 0.5, 783.4033,-1020.2896,26.3594))//Red house hotel
	{
	
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 0.5, 737.7260,-1467.0419,22.5948))//Jetty
	{
	
		return 1;
	}
	return 0;
}

IsAtHealingPlace(playerid)
{
	if(GetPlayerVirtualWorld(playerid) == 90)
	{
		return 1;
	}
	else if(GetPlayerVirtualWorld(playerid) == 32 || GetPlayerInterior(playerid) == 1)
	{
		return 1;
	}
	return 0;
}

IsAtBank(playerid)
{
	return PlayerInfo[playerid][pLocal] == PLOCAL_INNE_BANK;
}

IsAtBankomat(playerid)
{
    if(IsPlayerInRangeOfPoint(playerid, 2.5, 2127.66210938,-1153.92480469,23.48433304))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1040.38732910,-1131.23059082,23.46322632))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1493.25781250,-1022.13476562,23.46905136))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2842.70239258,-1562.88049316, 10.73664951))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2072.01953125,-1825.50097656, 13.18))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1928.63220215,-1768.14794922, 13.21))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1787.46899414,-1867.33886719,13.21315384))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 852.48236084,-2061.84008789,12.51009178))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 341.01486206,-1517.85717773,32.83914185))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2701.67407227,-2417.54223633,13.27571201))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1186.23657227,-1368.89025879,13.30330658))
    {
        return 1;
    }
    else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1505.4449,-1754.8218,13.5469))
    {
        return 1;
    }
	//PA�DZIOCH
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2423.41968, -2066.13257, 13.16730))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1001.01910, -923.60107, 41.94500))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 388.61719, -1806.26758, 7.45220))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 647.26550, -1368.86865, 13.26730))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 661.38593, -575.82269, 15.95790))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2273.16821, -76.34060, 26.18810))
    {
        return 1;
    }
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1822.5533,-1544.7983,13.3347))
	{
		return 1;
	}
	//Nowe 2.6
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 2024.5298,997.9246,10.8203))//Four Dragons LV
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 222.7831,-63.5663,1.5781))//Blueberry
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1036.0112,-1025.2030,32.1016))//trans LS
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1380.6733,-1766.1440,13.5469))//za DMV
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 1319.7610,339.2741,19.5547))//Montgomery
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, 421.4708,2533.3391,16.5737))//Lotnisko Verdant
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -1504.4927,2617.1204,55.8359))//miasteczko na pustyni LV
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -2446.6143,2321.3167,4.9766))//BaySide 
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -2278.0667,936.9093,66.6484))//San Fierro
	{
		return 1;
	}
	else if(IsPlayerInRangeOfPoint(playerid, 2.5, -1690.4055,864.8093,24.8906))//San Fierro 2
	{
		return 1;
	}
	// Vice City
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -3842.4971, 3380.7435, 1219.7744))
	{// North Point Mall
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -3842.2944, 3378.2677, 1219.8038))
	{// North Point Mall
		return 1;
	}

	// Vice City centrum handlowe
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -4196.9902, 1321.3622, 10.5760))
	{
		return 1;
	}

	if(IsPlayerInRangeOfPoint(playerid, 2.5, -4195.0254, 1321.2914, 10.5760))
	{
		return 1;
	}

	if(IsPlayerInRangeOfPoint(playerid, 2.5, -4197.0806, 1300.5468, 10.5760))
	{
		return 1;
	}

	if(IsPlayerInRangeOfPoint(playerid, 2.5, -4195.0981, 1300.3383, 10.5760))
	{
		return 1;
	}
	
	return 0;
}

IsAtClothShop(playerid)
{
	for(new i; i < sizeof(ShopPickupsPos); i++)
	{
		if(PlayerToPoint(5.0,playerid,ShopPickupsPos[i][0],ShopPickupsPos[i][1],ShopPickupsPos[i][2]))
		{
			return 1;
		}
	}	
	return 0;
}

IsAtAirport(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 7.0, 1585.2,-2286.6,13.7)
	|| IsPlayerInRangeOfPoint(playerid, 7.0, 1886.1,-2286.4,14))
	{ // Lotnisko LS
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 7.0, -1421.4000244141,-287.29998779297,14.10000038147) 
	|| IsPlayerInRangeOfPoint(playerid, 7.0, -1376.3000488281,-261.10000610352,14.300000190735))
	{ // Lotnisko SF
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 7.0, 1673.3000488281, 1447.8000488281, 10.89999961853)
	|| IsPlayerInRangeOfPoint(playerid, 7.0, 1597.6999511719, 1448.3000488281, 10.89999961853))
	{ // Lotnisko LV
		return 1;
	}
	if(IsPlayerInRangeOfPoint(playerid, 7.0, -5590.2937,1382.0626,9.3325) 
	|| IsPlayerInRangeOfPoint(playerid, 7.0, -5848.8413,1719.1116,9.3242))
	{ // Lotnisko Vice City
		return 1;
	}
	return 0;
}

IsAt247(playerid)
{
	return PlayerToPoint(100, playerid,-30.875, -88.9609, 1004.53);
}

IsAtTicketMachine(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(5.0, playerid, 1757.00513, -1943.20789, 13.26766) || PlayerToPoint(5.0, playerid,  1746.97949, -1943.71838, 13.45185) || PlayerToPoint(5.0, playerid, 825.69000, -1354.49915, 13.11831) || PlayerToPoint(5.0, playerid, 2293.0547,-1175.9962,26.0441))
		{
		
			return 1;
		}
	}
	return 0;

}

IsAtGasStation(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerToPoint(10.0,playerid,1004.0070,-939.3102,42.1797) || PlayerToPoint(10.0,playerid,1944.3260,-1772.9254,13.3906))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(10.0,playerid,-90.5515,-1169.4578,2.4079) || PlayerToPoint(10.0,playerid,-1609.7958,-2718.2048,48.5391))
		{//LS
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,-2029.4968,156.4366,28.9498) || PlayerToPoint(8.0,playerid,-2408.7590,976.0934,45.4175))
		{//SF
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,-2243.9629,-2560.6477,31.8841) || PlayerToPoint(8.0,playerid,-1676.6323,414.0262,6.9484))
		{//Between LS and SF
		    return 1;
		}
		else if(PlayerToPoint(6.0,playerid,2202.2349,2474.3494,10.5258) || PlayerToPoint(10.0,playerid,614.9333,1689.7418,6.6968))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1328.8250,2677.2173,49.7665) || PlayerToPoint(6.0,playerid,70.3882,1218.6783,18.5165))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,2113.7390,920.1079,10.5255) || PlayerToPoint(6.0,playerid,-1327.7218,2678.8723,50.0625))
		{//LV
		    return 1;
		}
		else if(PlayerToPoint(12.0,playerid,-1471.86, 1864.23, 32.63))
		{//lv pustynia
			return 1;
		}
		else if(PlayerToPoint(8.0,playerid,-1130.1172,-1018.0840,129.2188))
		{//�u�el
		    return 1;
		}
		else if(PlayerToPoint(7.0,playerid,2482.4558,-2130.1379,13.5530))
		{//zajezdnia busowa
		    return 1;
		}
		else if(PlayerToPoint(5.0,playerid,654.9174,-559.6597,16.5015) || PlayerToPoint(5.0,playerid,656.3661,-570.4130,16.5015))
		{//Dillimore
		    return 1;
		}
		else if(PlayerToPoint(3.0,playerid,2584.5634765625,61.7255859375,25.61093711853) || PlayerToPoint(2.5,playerid,2584.5595703125,66.3486328125,25.61093711853))
		{//Palomino Creek
		    return 1;
		}
		else if(PlayerToPoint(8.0,playerid,1381.5094,459.3204,20.3452))
		{//Montgomery
			return 1;
		}
		else if(PlayerToPoint(15.0,playerid,1362.5422,-1819.4730,13.5639))
		{//Plac manewrowy
		    return 1;
		}
		else if(PlayerToPoint(10.0,playerid,2471.2898,-2105.1948,14.1259) || PlayerToPoint(6.0,playerid,1011.8489,-1356.9026,13.5839))
		{//Stacja pod p�czkiem LS
		    return 1;
		}
		else if(PlayerToPoint(10.0,playerid,2489.6565,-2101.3022,13.5620)) 
		{//stacja w bazie KT
			return 1;
		}
		// Vice City
		if(IsPlayerInRangeOfPoint(playerid, 10.0, -4161.6709,1193.3607,4.9239))
		{// stacja benzynowa ocean beach
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, -4142.6313,1174.8871,4.9239))
		{// stacja benzynowa ocean beach 2
			return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 25.0, -5208.868164, 1355.265625, 6.349887))
		{// stacja benzynowa mechy sunshine autos
			return 1;
		}
	}
	return 0;
}

IsPlayerInTheirFractionVehicle(playerid)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(vehicleid != 0)
	{
		new lcarid = VehicleUID[vehicleid][vUID];
		if(CarData[lcarid][c_OwnerType] == CAR_OWNER_FRACTION && CarData[lcarid][c_Owner] == GetPlayerFraction(playerid))
		{
			return 1;
		}
	} 

	return 0;
}

IsAFractionGasStationValidUser(playerid)
{
	if(IsPlayerConnected(playerid) && IsPlayerInTheirFractionVehicle(playerid))
	{
		if(GetPlayerFraction(playerid) == FRAC_LSPD && PlayerToPoint(12.0, playerid, 1530.2, -1673.4, 6.5))
		{// tankowanie dla LSPD - parking dolny LSPD
			return 1;
		}
	}
	return 0;
}

IsAtBar(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, 4.0, 495.7801,-76.0305,998.7578) || IsPlayerInRangeOfPoint(playerid, 4.0, 499.9654,-20.2515,1000.6797))
		{//In grove street bar (with girlfriend), and in Havanna
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 10.0, 1215.5813,-15.2610,1000.9219) || IsPlayerInRangeOfPoint(playerid, 10.0, -2658.9749,1407.4136,906.2734))
		{//PIG Pen  i Alhambra
		    return 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid,4.0,-785.6683,498.2613,1371.7422) || IsPlayerInRangeOfPoint(playerid,7.0,598.6794,-2204.8613,1.8190))
		{//Basen "tsunami i W�oska restauracja
		    return 1;
 		}
		else if(IsPlayerInRangeOfPoint(playerid, 4.0, 1980.4153,-1290.2195,5620.3687) || IsPlayerInRangeOfPoint(playerid,4.0,-223.3081,1406.5033,27.7734))
		{//bar Kacpra i bar Vagos
		  	return 1;
		}
        else if(IsPlayerInRangeOfPoint(playerid, 4.0, 1983.4441,-1296.2300,-9.1928))
		{//bar       glenpark
		  	return 1;
		}
		if(IsPlayerInRangeOfPoint(playerid, 5.0, 5467.5771, -1006.0907, 1003.5313))
		{ // bar malibu
			return 1;
		}
	}
	return 0;
}

IsARower(carid)
{
	if(GetVehicleModel(carid) == 509 || GetVehicleModel(carid) == 481 || GetVehicleModel(carid) == 510)//rowery
	{
		return 1;
	}
	return 0;
}

IsABike(carid)
{
	if(GetVehicleModel(carid) == 509 || GetVehicleModel(carid) == 481 || GetVehicleModel(carid) == 510)//rowery
	{
		return 1;
	}
	if(GetVehicleModel(carid) == 462 || GetVehicleModel(carid) == 448 || GetVehicleModel(carid) == 581 || GetVehicleModel(carid) == 522 
	|| GetVehicleModel(carid) == 461 || GetVehicleModel(carid) == 521 || GetVehicleModel(carid) == 523 || GetVehicleModel(carid) == 463 
	|| GetVehicleModel(carid) == 586 || GetVehicleModel(carid) == 468)//motory
	{
		return 1;
	}
	if(GetVehicleModel(carid) == 471)//quad
	{
		return 1;
	}
	return 0;
}

IsABikeModel(model)
{
	switch(model)
	{
		case 509, 481, 510, 462, 448, 581, 522, 461, 521, 523, 463, 586, 468, 471:
		{
			return 1;
		}
	}
	return 0;
}

IsABoat(carid)
{
	if(GetVehicleModel(carid) == 472 || GetVehicleModel(carid) == 473 || GetVehicleModel(carid) == 493 || GetVehicleModel(carid) == 595 || GetVehicleModel(carid) == 484 || GetVehicleModel(carid) == 430 || GetVehicleModel(carid) == 453 || GetVehicleModel(carid) == 452 || GetVehicleModel(carid) == 446 || GetVehicleModel(carid) == 454)//�odzie
	{
		return 1;
	}
	return 0;
}

IsAPlane(carid)
{
	if(GetVehicleModel(carid) == 592 || GetVehicleModel(carid) == 577 || GetVehicleModel(carid) == 511 || GetVehicleModel(carid) == 512 || GetVehicleModel(carid) == 593 || GetVehicleModel(carid) == 520 || GetVehicleModel(carid) == 553 || GetVehicleModel(carid) == 476 || GetVehicleModel(carid) == 519 || GetVehicleModel(carid) == 460 || GetVehicleModel(carid) == 513)//samoloty
	{
		return 1;
	}
	if(GetVehicleModel(carid) == 548 || GetVehicleModel(carid) == 425 || GetVehicleModel(carid) == 417 || GetVehicleModel(carid) == 487 || GetVehicleModel(carid) == 488 || GetVehicleModel(carid) == 497 || GetVehicleModel(carid) == 563 || GetVehicleModel(carid) == 447 || GetVehicleModel(carid) == 469)//helikoptery
	{
		return 1;
	}
	return 0;
}

IsACopCar(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
    if(CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION)
    {
        if(CarData[lID][c_Owner] == FRAC_LSPD) return 1;
        else if(CarData[lID][c_Owner] == FRAC_FBI) return 1;
        else if(CarData[lID][c_Owner] == FRAC_NG) return 1;
    }
	return 0;
}

IsAnAmbulance(carid)
{
    new lID = VehicleUID[carid][vUID];
    if(lID == 0) return 0;
    if(CarData[lID][c_OwnerType] == CAR_OWNER_FRACTION)
    {
        if(CarData[lID][c_Owner] == FRAC_ERS) return 1;
    }
	if(GetVehicleModel(carid) == 416) return 1;
	return 0;
}

IsAInteriorVehicle(model)
{
	//484- Jacht(Marquis), 519 - Shamal, 553 - Nevada, 409 - Stretch, 416 - Ambulance, 508 - Journey, 582 - Newsvan
	return (model == 484 || model == 519 || model == 553 || model == 409 || model == 416 || model == 508 || model == 582 || model == 431 || model == 427 || model == 570);
}

WejdzInt(playerid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:tolerancja, interior, vw, komunikat[]="", local, gametext[]="")
{
    if (IsPlayerInRangeOfPoint(playerid, tolerancja, x, y, z))
    {
		if(x==x2 && y==y2 && z==z2) return sendErrorMessage(playerid, "Nie mo�na tutaj wej��.");
		//Komunikaty funkcji:
		if(strlen(komunikat) > 0)
		{
			SendClientMessage(playerid, -1, komunikat);
		}
		if(strlen(gametext) > 0)
		{
			GameTextForPlayer(playerid, gametext, 5000, 1);
		}
		PlayerInfo[playerid][pLocal] = local;
		SprawdzMuzyke(playerid);
		SetPlayerPos(playerid, x2, y2, z2);
		SetPlayerVirtualWorld(playerid, vw);
		SetPlayerWeather(playerid, 3);
		SetPlayerInterior(playerid, interior);
		Wchodzenie(playerid);
	}
	return 1;
}
/*
WyjdzInt(playerid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:tolerancja, interior, vw, komunikat[]="", local)
{
    if(x==x2 && y==y2 && z==z2) return 0;
    if(GetPlayerVirtualWorld(playerid) == vw && GetPlayerInterior(playerid) == interior && IsPlayerInRangeOfPoint(playerid, tolerancja, x, y, z))
    {
		if(vw == 55)// KASYNO 55
		{
			if(GetPVarInt(playerid, "kostka") == 1) return sendTipMessageEx(playerid, COLOR_PANICRED, "Nie mo�esz wyj�� z kasyna b�d�c w trakcie gry!");
			PlayerPlaySound(playerid, 5454, 0.0, 0.0, 0.0);
		}
        if(vw == 43)// BASEN 43
        {
        	if(PlayerInfo[playerid][pChar] > 0)
			{
				SetPlayerSkinEx(playerid, PlayerInfo[playerid][pChar]);
			}
			else
			{
				SetPlayerSkinEx(playerid, PlayerInfo[playerid][pModel]);
			}
		}
		
		if(strlen(komunikat) > 0)
		{
			GameTextForPlayer(playerid, komunikat, 5000, 1);
		}

		PlayerInfo[playerid][pLocal] = local;
		SetPlayerTime(playerid, ServerTime, 0); 
		SetPlayerWeather(playerid, 2);
		SetPlayerPos(playerid, x2, y2, z2);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		Wchodzenie(playerid);
	}
	return 1;
}
*/ 

SetServerWeatherAndTime(playerid)
{
	SetPlayerWeatherEx(playerid, ServerWeather);
	SetPlayerTime(playerid, ServerTime, 0);
	return 1;
}
SetInteriorTimeAndWeather(playerid)
{
	SetPlayerWeatherEx(playerid, 2);
	SetPlayerTime(playerid, 14, 0);
	return 1;
}
Wejdz(playerid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:tolerancja, komunikat[]="")
{
    if (IsPlayerInRangeOfPoint(playerid, tolerancja, x, y, z))
    {
    	SetPlayerPos(playerid, x2, y2, z2);
	 	SetPlayerVirtualWorld(playerid, 235);
        Wchodzenie(playerid);
		
		if(strlen(komunikat) > 0)
		{
			GameTextForPlayer(playerid, komunikat, 5000, 1);
		}
	}
	return 1;
}

Wyjdz(playerid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2, Float:tolerancja, komunikat[]="")
{
    if (IsPlayerInRangeOfPoint(playerid, tolerancja, x, y, z))
    {
    	SetPlayerPos(playerid, x2, y2, z2);
	 	SetPlayerVirtualWorld(playerid, 0);
        Wchodzenie(playerid);
		
		if(strlen(komunikat) > 0)
		{
			GameTextForPlayer(playerid, komunikat, 5000, 1);
		}
	}
	return 1;
}

JoinChannel(playerid, number, line[])
{
    if(IsPlayerConnected(playerid))
	{
	    if(strcmp(IRCInfo[number][iPassword],line, true ) == 0 )
		{
	        JoinChannelNr(playerid, number);
	    }
	    else
	    {
	        SendClientMessage(playerid, COLOR_GREY, "   Z�e has�o !");
	    }
	}
	return 1;
}

JoinChannelNr(playerid, number)
{
	if(IsPlayerConnected(playerid))
	{
	    new string[256];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(PlayersChannel[playerid] < 999)
	    {
			format(string, sizeof(string), "* %s opu�ci� ten kana�.", sendername);
			SendIRCMessage(PlayersChannel[playerid], COLOR_GREEN, string);
			IRCInfo[PlayersChannel[playerid]][iPlayers] -= 1;
	    }
		new channel; channel = number; channel += 1;
	    PlayersChannel[playerid] = number;
	    IRCInfo[PlayersChannel[playerid]][iPlayers] += 1;
    	new wstring[128];
		format(string, sizeof(string), "%s", sendername);
		strmid(wstring, string, 0, strlen(string), 255);
		if(strcmp(IRCInfo[number][iAdmin],wstring, true ) == 0 )
		{
		    format(string, sizeof(string), "* Do��czy�e� do kana�u numer %d jako Administartor.", channel);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		else
		{
		    format(string, sizeof(string), "* Do��czy�e� do kana�u numer %d, Administrator kana�u: %s.", channel, IRCInfo[number][iAdmin]);
			SendClientMessage(playerid, COLOR_YELLOW, string);
		}
		format(string, sizeof(string), "MOTD: %s.", IRCInfo[number][iMOTD]);
		SendClientMessage(playerid, COLOR_YELLOW, string);
		format(string, sizeof(string), "* %s do��czy� do tego kana�u.", sendername);
		SendIRCMessage(number, COLOR_GREEN, string);
	}
	return 1;
}

ClearMarriage(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "Nikt");
		strmid(PlayerInfo[playerid][pMarriedTo], string, 0, strlen(string), 255);
		PlayerInfo[playerid][pMarried] = 0;
	}
	return 1;
}

ClearCrime(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new string[MAX_PLAYER_NAME];
		format(string, sizeof(string), "********");
		strmid(PlayerCrime[playerid][pBplayer], string, 0, strlen(string), 255);
		strmid(PlayerCrime[playerid][pVictim], string, 0, strlen(string), 255);
		strmid(PlayerCrime[playerid][pAccusing], string, 0, strlen(string), 255);
		strmid(PlayerCrime[playerid][pAccusedof], string, 0, strlen(string), 255);
	}
	return 1;
}


Lotto(number)
{
	new winners=0, string[256], status=1; 
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pLottoNr] > 0)
			{
				if(PlayerInfo[i][pLottoNr] == number)
				{
					winners++; 
					status=2;
				}
				else 
				{
					format(string, sizeof(string), "Niestety nie uda�o Ci si� wygra� loterii z numerem %d.", PlayerInfo[i][pLottoNr]);
					SendClientMessage(i, COLOR_WHITE, string);
					PlayerInfo[i][pLottoNr] = 0; 
				}
			}
		}
	}
	new dzielnik = winners;
	foreach(new i2 : Player)
	{
		if(status == 1)
		{
			if(winners == 0)
			{
				new rand = random(200000); 
				Jackpot = Jackpot+rand; 
				format(string, sizeof(string), "Nikt nie wygra�. Nagroda zosta�a podwy�szona do %d$", Jackpot);
				OOCOff(COLOR_WHITE, string);  
				break; 
			}
		}
		if(status == 2)
		{
			if(winners == 0)
			{
				new rand = random(350000);
				Jackpot = rand; 
				format(string, sizeof(string), "Lotto rozpoczyna kolejn� loteri�, kasa wyj�cia to %d$", Jackpot); 
				OOCOff(COLOR_WHITE, string); 
				status = 1;
				break;
			}
			if(PlayerInfo[i2][pLottoNr] > 0 && PlayerInfo[i2][pLottoNr] == number)
			{
				new kasaWin = Jackpot/dzielnik; 
				format(string, sizeof(string), "%s wygra� w totolotku %d$", GetNick(i2), kasaWin); 
				OOCOff(COLOR_WHITE, string);
				DajKase(i2, kasaWin);
				PlayerInfo[i2][pLottoNr] =0;
				winners--;   
			}
		}
			
	}
}

NocOczyszczenia()
{
	new day, month, year, hour, minuite, second;
	getdate(year, month, day);
	gettime(hour, minuite, second);
	#pragma unused second

	if(year == 2025 && month == 5 && day == 18 && hour > 18 && hour < 22)
	{
		return 1;
	}

	return 0;
}

NadajWL(playerid, wl, reason[], giveplayerid=INVALID_PLAYER_ID)
{
	if(NocOczyszczenia()) return;

	if(playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid)) return;

	PoziomPoszukiwania[playerid] = clamp(PoziomPoszukiwania[playerid] + wl, 0, 10);
	SetPlayerCriminal(playerid, giveplayerid, reason);
	SetPlayerWantedLevel(playerid, PoziomPoszukiwania[playerid]);
	PlayCrimeReportForPlayer(playerid, playerid, 3 + random(20));
}

SetPlayerCriminal(playerid,declare,reason[], bool:sendmessage=true)
{
	if(IsPlayerConnected(playerid))
	{
	    PlayerInfo[playerid][pCrimes] += 1;
	    new points = PoziomPoszukiwania[playerid];
		new turned[MAX_PLAYER_NAME];
		new turner[MAX_PLAYER_NAME];
		new turnmes[128];
		new wantedmes[128];
		strmid(PlayerCrime[playerid][pAccusedof], reason, 0, strlen(reason), 255);
		GetPlayerName(playerid, turned, sizeof(turned));
		if (declare == INVALID_PLAYER_ID)
		{
		    if(PoziomPoszukiwania[playerid] <= 5)
		    {
				format(turner, sizeof(turner), "Monitoring LSPD");
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
			}
			else if(PoziomPoszukiwania[playerid] >= 6)
			{
				format(turner, sizeof(turner), "Satelity FBI");
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
			}
		}
		else
		{
		    if(IsPlayerConnected(declare))
		    {
				GetPlayerName(declare, turner, sizeof(turner));
				strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
				strmid(PlayerCrime[declare][pBplayer], turned, 0, strlen(turned), 255);
				strmid(PlayerCrime[declare][pAccusing], reason, 0, strlen(reason), 255);
			}
		}
		format(turnmes, sizeof(turnmes), "Pope�ni�e� przest�pstwo ( %s ). Zg�osi�: %s.",reason,turner);
		SendClientMessage(playerid, COLOR_LIGHTRED, turnmes);
		PlayCrimeReportForPlayer(playerid, declare,5);
		if(points > 0)
		{
			if(PoziomPoszukiwania[playerid] > 0)
			{
			    if((IsAPolicja(playerid) || IsABOR(playerid)) && OnDuty[playerid] == 1)
			    {
      				PoziomPoszukiwania[playerid] = 0;
				}
			}

			SetPlayerWantedLevel(playerid, (PoziomPoszukiwania[playerid] > 6 ? 6 : PoziomPoszukiwania[playerid]));
			
			if(sendmessage)
			{
				format(wantedmes, sizeof(wantedmes), "Posiadany Wanted Level: %d", PoziomPoszukiwania[playerid]);
				SendClientMessage(playerid, COLOR_YELLOW, wantedmes);
				new pZone[MAX_ZONE_NAME];
            	GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);//Dzielnica
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
					    if(IsAPolicja(i) && (OnDutyCD[i] || OnDuty[i]))
					    {
					        if(gCrime[i] == 0)
					        {
								format(cbjstore, sizeof(turnmes), "HQ: Przest�pstwo: %s | Nadawca: %s",reason, turner);
								SendClientMessage(i, COLOR_LFBI, cbjstore);
								format(cbjstore, sizeof(turnmes), "HQ: Podejrzany: %s, ostatnia lokalizacja: %s",turned, pZone);
								SendClientMessage(i, COLOR_LFBI, cbjstore);
							}
						}
					}
				}
			}
		}
	}//not connected
}

ShowStats2(playerid)
{
	SetPVarInt(playerid, "podglada-stats", 1); 
	new plUID[64], plLVL[64], plPlec[64];
	new plPochodzenie[64], plZdrowie[64], plBank[64], plKasa[64];
	new plTelefon[64], plKP[64], plWiek[64], plSlub[64], plData[64], plCzas[64], plPKT[64], plWantedD[64];
	new plPraca[64], plFraction[64], plFractionRank[64], plAdmin[64], plDrugs[64], plMats[64];
	new plPrzestepstwa[64], plZN[64], plZabic[64], plSmierci[64], plAresztCzas[64], plWL[64]; 
	new year, month, day, hour, minute, second, plRyba[64], plWozKlucz[64];
	gettime(hour,minute,second);
	FixHour(hour);
	hour = shifthour;
	getdate(year, month, day);
	format(plData, sizeof(plData), "%d.%d.%d", day, month, year);
	format(plCzas, sizeof(plCzas), "%d:%d", hour, minute); 
	format(plPKT, sizeof(plPKT), "Punkty Karne: %d", PlayerInfo[playerid][pPK]);
	format(plWL, sizeof(plWL), "WantedLevel: %d", PlayerInfo[playerid][pWL]); 
	format(plRyba, sizeof(plRyba), "Ryba: %d kg", PlayerInfo[playerid][pBiggestFish]); 
	format(plWozKlucz, sizeof(plWozKlucz), "Klucze auta: %d", PlayerInfo[playerid][pKluczeAuta]);
	format(plWantedD, sizeof(plWantedD), "Wanted-Death: %d", PlayerInfo[playerid][pWantedDeaths]);
	format(plAresztCzas, sizeof(plAresztCzas), "Czas aresztu: %d", PlayerInfo[playerid][pArrested]);  
	new plRodzina[64], plRespekt[64], plOnline[64], plRodzinkaRank[64], plBMID[64], plBOID[64], plDom[64], plSkin[64], plWarny[64]; 
	format(plUID, sizeof(plUID), "UID: %d", PlayerInfo[playerid][pUID]);
	format(plSmierci, sizeof(plSmierci), "Smierci: %d", PlayerInfo[playerid][pDeaths]);
	format(plZabic, sizeof(plZabic), "Zabic: %d", PlayerInfo[playerid][pKills]);
	format(plZN, sizeof(plZN), "ZmienNick: %d", PlayerInfo[playerid][pZmienilNick]); 
	format(plPrzestepstwa, sizeof(plPrzestepstwa), "Crimes: %d", PlayerInfo[playerid][pCrimes]); 
	format(plLVL, sizeof(plLVL), "Level: %d", PlayerInfo[playerid][pLevel]); 
	format(plKasa, sizeof(plKasa), "Kasa: %d$", kaska[playerid]); 
	format(plBank, sizeof(plBank), "Bank: %d$", PlayerInfo[playerid][pAccount]); 
	format(plZdrowie, sizeof(plZdrowie), "Zdrowie: %.1f", PlayerInfo[playerid][pSHealth]+50);
	format(plTelefon, sizeof(plTelefon), "Telefon: %d", PlayerInfo[playerid][pPnumber]);
	format(plOnline, sizeof(plOnline), "On-line: %d", PlayerInfo[playerid][pConnectTime]);
	format(plBMID, sizeof(plBMID), "B-MID: %d", PlayerInfo[playerid][pBusinessMember]); 
	format(plBOID, sizeof(plBOID), "B-OID: %d", PlayerInfo[playerid][pBusinessOwner]); 
	format(plSkin, sizeof(plSkin), "Skin: %d", PlayerInfo[playerid][pSkin]); 
	format(plWarny, sizeof(plWarny), "Warny: %d", PlayerInfo[playerid][pWarns]); 
	format(plMats, sizeof(plMats), "Mats: %d", PlayerInfo[playerid][pMats]);
	format(plDrugs, sizeof(plDrugs), "Drugs: %d", PlayerInfo[playerid][pDrugs]); 
	format(plAdmin, sizeof(plAdmin), "Admin: %d", PlayerInfo[playerid][pAdmin]); 
	format(plPraca, sizeof(plPraca), "Praca: %s", GetJobName(PlayerInfo[playerid][pJob])); 
	format(plDom, sizeof(plDom), "Dom: %d", PlayerInfo[playerid][pDom]);
	format(plRodzinkaRank, sizeof(plRodzinkaRank), "Ranga: Unknow"); 
	format(plRespekt, sizeof(plRespekt), "Respekt: %d/%d", PlayerInfo[playerid][pExp], ((PlayerInfo[playerid][pLevel]+1)*levelexp)); 
	format(plWiek, sizeof(plWiek), "Wiek: %d",PlayerInfo[playerid][pAge]);
	if(IsPlayerPremiumOld(playerid)) { plKP = "~y~Sponsor"; }
	else { plKP = "~y~Zwykly wieprz"; }
	if(PlayerInfo[playerid][pOrigin] == 1) { plPochodzenie = "Pochodzenie: USA"; }
	else if(PlayerInfo[playerid][pOrigin] == 2) { plPochodzenie = "Pochodzenie: Europa"; }
	else if(PlayerInfo[playerid][pOrigin] == 3) { plPochodzenie = "Pochodzoenie: Azja"; }
	if(PlayerInfo[playerid][pSex] == 1) { plPlec = "Plec: Mezczyzna"; }
	else if(PlayerInfo[playerid][pSex] == 2) { plPlec = "Plec: Kobieta"; }
	if(strlen(PlayerInfo[playerid][pMarriedTo]) > 20)
	{
		format(plSlub, sizeof(plSlub), "Slub: Unknow");
	}
	else if(strlen(PlayerInfo[playerid][pMarriedTo]) <= 20 && strlen(PlayerInfo[playerid][pMarriedTo]) > 3)
	{
		format(plSlub, sizeof(plSlub), "Slub: %s", PlayerInfo[playerid][pMarriedTo]);
	}
	else if(strlen(PlayerInfo[playerid][pMarriedTo]) <= 3)
	{
		format(plSlub, sizeof(plSlub), "Slub: Brak"); 
	}
	
	new org = GetPlayerOrg(playerid);
	if(org != 0)
	{
		if(IsActiveOrg(org)) format(plRodzina, 30, "Rodzina: %s",OrgInfo[org][o_Name]);
		//Przypisane rangi
		if(strlen(OrgRank[GetPlayerOrg(playerid)][PlayerInfo[playerid][pRank]]) > 1)
		{
			format(plRodzinkaRank, sizeof(plRodzinkaRank), "%s", OrgRank[org][PlayerInfo[playerid][pRank]]);
		}
		//Rangi podstawowe
		else
		{
			format(plRodzinkaRank, sizeof(plRodzinkaRank), "Ranga: %s", OrgRank[0][PlayerInfo[playerid][pRank]]);
		}
		plFraction = "Frakcja: Brak";
		plFractionRank = "Ranga: Brak"; 

	}
	else if(GetPlayerFraction(playerid) > 0)
	{
		plRodzina= "Rodzina: Brak";
		plRodzinkaRank= "Ranga: Brak";
		format(plFractionRank, sizeof(plFractionRank), "Ranga: %s", FracRang[PlayerInfo[playerid][pMember]][PlayerInfo[playerid][pRank]]);
		format(plFraction, sizeof(plFraction), "Frakcja: %s", FractionNames[GetPlayerFraction(playerid)]);
	}
	else
	{
		plRodzina= "Rodzina: Brak";
		plRodzinkaRank= "Ranga: Brak";
		plFraction = "Frakcja: Brak";
		plFractionRank = "Ranga: Brak"; 	
	}
	
	if(IsPlayerConnected(playerid))
	{
		PlayerTextDrawShow(playerid, TXDSTATS_Background[playerid]); 
		//set
		PlayerTextDrawSetString(playerid, TXDSTATS_UID[playerid], plUID);
		PlayerTextDrawSetString(playerid, TXDSTATS_LVL[playerid], plLVL);
		PlayerTextDrawSetString(playerid, TXDSTATS_NICK[playerid], GetNick(playerid)); 
		PlayerTextDrawSetString(playerid, TXDSTATS_PLEC[playerid], plPlec); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Pochodzenie[playerid], plPochodzenie);
		PlayerTextDrawSetString(playerid, TXDSTATS_Zdrowie[playerid], plZdrowie); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Kasa[playerid], plKasa);
		PlayerTextDrawSetString(playerid, TXDSTATS_Bank[playerid], plBank);
		PlayerTextDrawSetString(playerid, TXDSTATS_Telefon[playerid], plTelefon);
		PlayerTextDrawSetString(playerid, TXDSTATS_KP[playerid], plKP); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Wiek[playerid], plWiek);
		PlayerTextDrawSetString(playerid, TXDSTATS_Slub[playerid], plSlub);
		PlayerTextDrawSetString(playerid, TXDSTATS_OnLine[playerid], plOnline);
		PlayerTextDrawSetString(playerid, TXDSTATS_Respekt[playerid], plRespekt);
		PlayerTextDrawSetString(playerid, TXDSTATS_Rodzina[playerid], plRodzina); 
		PlayerTextDrawSetString(playerid, TXDSTATS_RodzinaRanga[playerid], plRodzinkaRank);
		PlayerTextDrawSetString(playerid, TXDSTATS_BMID[playerid], plBMID);
		PlayerTextDrawSetString(playerid, TXDSTATS_BOID[playerid], plBOID);
		PlayerTextDrawSetString(playerid, TXDSTATS_Skin[playerid], plSkin); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Dom[playerid], plDom);
		PlayerTextDrawSetString(playerid, TXDSTATS_Warny[playerid], plWarny);
		PlayerTextDrawSetString(playerid, TXDSTATS_Praca[playerid], plPraca);
		PlayerTextDrawSetString(playerid, TXDSTATS_Admin[playerid], plAdmin);
		PlayerTextDrawSetString(playerid, TXDSTATS_Drugs[playerid], plDrugs);
		PlayerTextDrawSetString(playerid, TXDSTATS_Mats[playerid], plMats);
		PlayerTextDrawSetString(playerid, TXDSTATS_Fraction[playerid], plFraction);
		PlayerTextDrawSetString(playerid, TXDSTATS_FractionRank[playerid], plFractionRank);  
		PlayerTextDrawSetString(playerid, TXDSTATS_Przestepstwa[playerid], plPrzestepstwa);
		PlayerTextDrawSetString(playerid, TXDSTATS_Smierci[playerid], plSmierci);
		PlayerTextDrawSetString(playerid, TXDSTATS_Zabic[playerid], plZabic);
		PlayerTextDrawSetString(playerid, TXDSTATS_ZmienNick[playerid], plZN); 
		PlayerTextDrawSetString(playerid, TXDSTATS_AresztTime[playerid], plAresztCzas);
		PlayerTextDrawSetString(playerid, TXDSTATS_WL[playerid], plWL); 
		PlayerTextDrawSetString(playerid, TXDSTATS_WozKlucz[playerid], plWozKlucz); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Pkt[playerid], plPKT);
		PlayerTextDrawSetString(playerid, TXDSTATS_WantedDeath[playerid], plWantedD); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Ryba[playerid], plRyba); 
		PlayerTextDrawSetString(playerid, TXDSTATS_Data[playerid], plData);
		PlayerTextDrawSetString(playerid, TXDSTATS_Czas[playerid], plCzas);
		PlayerTextDrawSetPreviewModel(playerid, TXDSTATS_SkinShow[playerid], PlayerInfo[playerid][pSkin]); 

		//show
		PlayerTextDrawShow(playerid, TXDSTATS_UID[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_SkinShow[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_LogoMRP[playerid]);  
		PlayerTextDrawShow(playerid, TXDSTATS_LVL[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_NICK[playerid]);  
		PlayerTextDrawShow(playerid, TXDSTATS_PLEC[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Pochodzenie[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Zdrowie[playerid]);  
		PlayerTextDrawShow(playerid, TXDSTATS_Kasa[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Bank[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Telefon[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_KP[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Wiek[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Slub[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_OnLine[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Respekt[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Rodzina[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_RodzinaRanga[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_BOID[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_BMID[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Skin[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Dom[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Warny[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Praca[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Admin[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Drugs[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Mats[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Fraction[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_FractionRank[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Przestepstwa[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Zabic[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Smierci[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_ZmienNick[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_AresztTime[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_WozKlucz[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Pkt[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Sila[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_WL[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_WantedDeath[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Ryba[playerid]); 
		PlayerTextDrawShow(playerid, TXDSTATS_Data[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Czas[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_LogoMRP[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Linia_01[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Linia_02[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Linia_03[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_Linia_04[playerid]);
		PlayerTextDrawShow(playerid, TXDSTATS_ZnakWodny[playerid]); 
	}
}
HideStats2(playerid)
{
	PlayerTextDrawHide(playerid, TXDSTATS_Background[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_UID[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_SkinShow[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_LogoMRP[playerid]);  
	PlayerTextDrawHide(playerid, TXDSTATS_LVL[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_NICK[playerid]);  
	PlayerTextDrawHide(playerid, TXDSTATS_PLEC[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Pochodzenie[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Zdrowie[playerid]);  
	PlayerTextDrawHide(playerid, TXDSTATS_Kasa[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Bank[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Telefon[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_KP[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Wiek[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Slub[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_OnLine[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Respekt[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Rodzina[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_RodzinaRanga[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_BOID[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_BMID[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Skin[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Dom[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Warny[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Praca[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Admin[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Drugs[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Mats[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Fraction[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_FractionRank[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Przestepstwa[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Zabic[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Smierci[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_ZmienNick[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_AresztTime[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_WozKlucz[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Pkt[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Sila[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_WL[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_WantedDeath[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Ryba[playerid]); 
	PlayerTextDrawHide(playerid, TXDSTATS_Data[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Czas[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_LogoMRP[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_01[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_02[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_03[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_Linia_04[playerid]);
	PlayerTextDrawHide(playerid, TXDSTATS_ZnakWodny[playerid]); 
}
ShowStats(playerid, targetid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
		new atext[20];
		if(PlayerInfo[targetid][pSex] == 1) { atext = "M�czyzna"; }
		else if(PlayerInfo[targetid][pSex] == 2) { atext = "Kobieta"; }
  		new otext[20];
		if(PlayerInfo[targetid][pOrigin] == 1) { otext = "USA"; }
		else if(PlayerInfo[targetid][pOrigin] == 2) { otext = "Europa"; }
		else if(PlayerInfo[targetid][pOrigin] == 3) { otext = "Azja"; }
		new drank[20];
		if(IsPlayerPremiumOld(targetid)) { drank = "Sponsor"; }
		else { drank = "Zwykly wieprz"; }
	    new fracText[40];
        format(fracText, sizeof(fracText), "%s", FractionNames[GetPlayerFraction(targetid)]);
		new org = GetPlayerOrg(targetid);
		new orgText[MAX_ORG_NAME_LENGTH];
	    if(IsActiveOrg(org)) { format(orgText, sizeof(orgText), "%s", OrgInfo[org][o_Name]); }
		else { orgText = "Brak"; }

		new nextLevel = PlayerInfo[targetid][pLevel]+1;
		new nextLevelExp = nextLevel * levelexp;
		new nextLevelCost = nextLevel * levelcost;
		new name[MAX_PLAYER_NAME];
		GetPlayerName(targetid, name, sizeof(name));

		SendClientMessage(playerid, COLOR_GREEN,"___________________| Statystyki |____________________");
		SendClientMessage(playerid, COLOR_WHITE,  sprintf("*** %s ({8FCB04}UID: %d{FFFFFF}) ***", 
			name, PlayerInfo[targetid][pUID]));
		SendClientMessage(playerid, COLOR_GRAD1, sprintf("Level:[%d] P�e�:[%s] Wiek:[%d] Pochodzenie:[%s] Kasa:[$%d] Bank:[$%d]", 
			PlayerInfo[targetid][pLevel], atext, PlayerInfo[targetid][pAge], otext, kaska[targetid], PlayerInfo[targetid][pAccount]));
		SendClientMessage(playerid, COLOR_GRAD2, sprintf("Konto Premium:[%s] MruCoins:[%d] Zmian nick�w:[%d] On-Line:[%d] Respekt:[%d/%d] Bonus Levelowy:[$%d]", 
			drank, PremiumInfo[targetid][pMC], PlayerInfo[targetid][pZmienilNick], PlayerInfo[targetid][pConnectTime], PlayerInfo[targetid][pExp], nextLevelExp, nextLevelCost));
		SendClientMessage(playerid, COLOR_GRAD3, sprintf("Telefon:[%d] Dom:[%d] Klucz Wozu: [%d] Drugs:[%d] Mats:[%d] Kontrabanda:[%d] Apteczki:[%d] Zestawy naprawcze:[%d]", 
			PlayerInfo[targetid][pPnumber], PlayerInfo[targetid][pDom], PlayerInfo[targetid][pKluczeAuta], PlayerInfo[targetid][pDrugs], PlayerInfo[targetid][pMats], PlayerInfo[targetid][pContraband], PlayerInfo[targetid][pHealthPacks], PlayerInfo[targetid][pFixKit]));
		SendClientMessage(playerid, COLOR_GRAD4, sprintf("Aresztowa�:[%d] Przest�pstwa:[%d] Punkty karne:[%d] Smierci b�d�c Poszukiwanym:[%d] Zabi�:[%d] �mierci:[%d] WL:[%d]", 
			PlayerInfo[targetid][pArrested], PlayerInfo[targetid][pCrimes], PlayerInfo[targetid][pPK], PlayerInfo[targetid][pWantedDeaths], PlayerInfo[targetid][pKills], PlayerInfo[targetid][pDeaths], PoziomPoszukiwania[targetid]));
		SendClientMessage(playerid, COLOR_GRAD5, sprintf("�lub z:[%s] Ryb Z�owionych:[%d] Najwi�ksza Ryba:[%d] LottoNr:[%d] Warny:[%d]", 
			PlayerInfo[targetid][pMarriedTo], CalculateFishes(targetid), PlayerInfo[targetid][pBiggestFish], PlayerInfo[targetid][pLottoNr], PlayerInfo[targetid][pWarns]));
		SendClientMessage(playerid, COLOR_GRAD6, sprintf("Praca:[%s] Frakcja:[%s] Organizacja:[%s] Ranga:[%d] Skin ID:[%d] Uniform:[%d]", 
			GetJobName(PlayerInfo[targetid][pJob]), fracText, orgText, PlayerInfo[targetid][pRank], PlayerInfo[targetid][pSkin], PlayerInfo[targetid][pUniform], PlayerInfo[targetid][pUniform]));
		SendClientMessage(playerid, COLOR_GREEN,"_____________________________________________________");
	}
}

RemoveLeadersFromFraction(giveplayerid, playerid)//Usuwa lider�w frakcji - giveplayerid to lider, playerid to osoba nadaj�ca
{
	new query[256], string[124];
	new givePlayerFrac = GetPlayerFraction(giveplayerid); 
	//Najpierw sprawdzanie czy s� inni liderzy on-LINE
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pLider] == givePlayerFrac && i != giveplayerid) 
		{
			PlayerInfo[i][pMember] = 0;
			PlayerInfo[i][pLider] = 0;
			PlayerInfo[i][pJob] = 0;
			RemovePlayerFromOrg(i);
			MedicBill[i] = 0;
			SetPlayerSpawn(i);
			format(string, sizeof(string), "  Wyrzuci�es %s z frakcji.", GetNick(i));
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string), "Zosta�e� wyrzucony z lidera, poniewa� %s usun�� GLD [%s]", GetNick(playerid), GetNick(giveplayerid)); 
			sendTipMessage(i, string); 
		}
	}
	Remove_MySQL_Leaders(givePlayerFrac);
	format(query, sizeof(query), "Usuni�to wszystkich lider�w z frakcji %s", FractionNames[givePlayerFrac]);
	sendTipMessageEx(playerid, COLOR_DBLUE, query); 
	format(string, sizeof(string), "* Zosta�e� wyrzucony z frakcji przez %s.", GetNick(playerid));
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
	SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, "* Jeste� cywilem.");
	Log(adminLog, INFO, "Admin %s usun�� gracza %s z frakcji %s - usuwajac VLD.", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetFractionLogName(givePlayerFrac));
	PlayerInfo[giveplayerid][pMember] = 0;
	PlayerInfo[giveplayerid][pLider] = 0;
	PlayerInfo[giveplayerid][pJob] = 0;
	RemovePlayerFromOrg(giveplayerid);
	MedicBill[giveplayerid] = 0;
	SetPlayerSpawn(giveplayerid);
	format(string, sizeof(string), "  Wyrzuci�es %s z frakcji.", GetNick(giveplayerid));
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
}
SetPlayerToTeamColor(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(PlayerInfo[playerid][pMember] == 1 || PlayerInfo[playerid][pLider] == 1)
		{
		    if(OnDuty[playerid] && OnDutyCD[playerid] == 0)
		    {
		    	SetPlayerColor(playerid, COLOR_LIGHTBLUE);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
		else if(PlayerInfo[playerid][pMember] == 3 || PlayerInfo[playerid][pLider] == 3)
		{
		    if(OnDuty[playerid])
		    {
		    	SetPlayerColor(playerid, COLOR_GREEN);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
		else if(PlayerInfo[playerid][pMember] == FRAC_ERS || PlayerInfo[playerid][pLider] == FRAC_ERS || GetPlayerJob(playerid) == JOB_MEDIC)
		{
		    if(JobDuty[playerid])
		    {
		    	SetPlayerColor(playerid, COLOR_LIGHTRED);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
		else if(PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLider] == 7)
		{
		    if(OnDuty[playerid])
		    {
		    	SetPlayerColor(playerid, COLOR_PURPLE);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
		else if(PlayerInfo[playerid][pMember] == 9 || PlayerInfo[playerid][pLider] == 9)
		{
		    if(SanDuty[playerid])
		    {
		    	SetPlayerColor(playerid, COLOR_NEWS);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
		else if(PlayerInfo[playerid][pMember] == 10 || PlayerInfo[playerid][pLider] == 10)
		{
			if(JobDuty[playerid])
		    {
		    	SetPlayerColor(playerid, COLOR_YELLOW);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
		else if(PlayerInfo[playerid][pMember] == 11 || PlayerInfo[playerid][pLider] == 11)
		{
		    if(JobDuty[playerid])
		    {
		    	SetPlayerColor(playerid, COLOR_LIGHTGREEN);
		    }
		    else
		    {
		        SetPlayerColor(playerid,TEAM_HIT_COLOR); // white
		    }
		}
        else SetPlayerColor(playerid,TEAM_HIT_COLOR);
	}
}

LoadBoxer()
{
	new arrCoords[3][64];
	new strFromFile2[256];
	new File: file = fopen("boxer.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		Titel[TitelWins] = strval(arrCoords[0]);
		strmid(Titel[TitelName], arrCoords[1], 0, strlen(arrCoords[1]), 255);
		Titel[TitelLoses] = strval(arrCoords[2]);
		fclose(file);
	}
	return 1;
}

SaveBoxer()
{
	new coordsstring[256];
	format(coordsstring, sizeof(coordsstring), "%d,%s,%d", Titel[TitelWins],Titel[TitelName],Titel[TitelLoses]);
	new File: file2 = fopen("boxer.ini", io_write);
    if(file2)
    {
    	fwrite(file2, coordsstring);
    	fclose(file2);
    }
	return 1;
}

LoadStuff()
{
	new arrCoords[4][64];
	new strFromFile2[256];
	new File: file = fopen("stuff.ini", io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		Jackpot = strval(arrCoords[0]);
		Tax = strval(arrCoords[1]);
		TaxValue = strval(arrCoords[2]);
		Security = strval(arrCoords[3]);
		fclose(file);
	}
	return 1;
}

SaveStuff()
{
	new coordsstring[256];
	format(coordsstring, sizeof(coordsstring), "%d,%d,%d,%d", Jackpot,Tax,TaxValue,Security);
	new File: file2 = fopen("stuff.ini", io_write);
    if(file2)
    {
        fwrite(file2, coordsstring);
    	fclose(file2);
    }
	return 1;
}

LoadIRC()
{
	new arrCoords[5][64];
	new strFromFile2[256];
	new File: file = fopen("channels.cfg", io_read);
	if (file)
	{
		new idx;
		while(idx < sizeof(IRCInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, '|');
			strmid(IRCInfo[idx][iAdmin], arrCoords[0], 0, strlen(arrCoords[0]), 255);
			strmid(IRCInfo[idx][iMOTD], arrCoords[1], 0, strlen(arrCoords[1]), 255);
			strmid(IRCInfo[idx][iPassword], arrCoords[2], 0, strlen(arrCoords[2]), 255);
			IRCInfo[idx][iNeedPass] = strval(arrCoords[3]);
			IRCInfo[idx][iLock] = strval(arrCoords[4]);
			idx++;
		}
		fclose(file);
	}
	return 1;
}

SaveIRC()
{
	new idx;
	new File: file2;
	while(idx < sizeof(IRCInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%s|%s|%s|%d|%d\n",
		IRCInfo[idx][iAdmin],
		IRCInfo[idx][iMOTD],
		IRCInfo[idx][iPassword],
		IRCInfo[idx][iNeedPass],
		IRCInfo[idx][iLock]);
		if(idx == 0)
		{
			file2 = fopen("channels.cfg", io_write);
		}
		else
		{
			file2 = fopen("channels.cfg", io_append);
		}
		if(file2)
        {
            fwrite(file2, coordsstring);
    		fclose(file2);
        }
        idx++;
	}
	return 1;
}

GetClosestPlayer(p1)
{
	new x,Float:dis,Float:dis2,player;
	player = -1;
	dis = 99999.99;
	for(x=0;x<MAX_PLAYERS;x++)
	{
		if(IsPlayerConnected(x))
		{
			if(x != p1)
			{
				dis2 = GetDistanceBetweenPlayers(x,p1);
				if(dis2 < dis && dis2 != -1.00)
				{
					dis = dis2;
					player = x;
				}
			}
		}
	}
	return player;
}

ZaladujTrasy()
{
	new trasaS[24];
	new numerCH[12];
	new s, e;
	s = GetTickCount();
    for(new i=0; i<sizeof(Wyscig); i++)
	{
	    format(trasaS, sizeof(trasaS), "Inne/trasa_%d.ini", i);
	    if(dini_Exists(trasaS))
	    {
		    Wyscig[i][wStworzony] = dini_Int(trasaS, "Stworzony");
			strcat(Wyscig[i][wNazwa], dini_Get(trasaS, "Nazwa"), 20);
			strcat(Wyscig[i][wOpis], dini_Get(trasaS, "Opis"), 50);
			Wyscig[i][wCheckpointy] = dini_Int(trasaS, "Checkpointy");
			Wyscig[i][wNagroda] = dini_Int(trasaS, "Nagroda");
			Wyscig[i][wTypCH] = dini_Int(trasaS, "TypCH");
			Wyscig[i][wRozmiarCH] = dini_Float(trasaS, "Rozmiar");
			for(new ii; ii<MAX_CHECKPOINTS; ii++)
			{
			    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
				wCheckpoint[i][ii][0] = dini_Float(trasaS, numerCH);
				format(numerCH, sizeof(numerCH), "CH%d_y", ii);
		  		wCheckpoint[i][ii][1] = dini_Float(trasaS, numerCH);
		  		format(numerCH, sizeof(numerCH), "CH%d_z", ii);
		    	wCheckpoint[i][ii][2] = dini_Float(trasaS, numerCH);
		    }
		}
		else
		{
		    dini_Create(trasaS);
			dini_IntSet(trasaS, "Stworzony", 0);
			dini_Set(trasaS, "Nazwa", "Wolne");
			dini_Set(trasaS, "Opis", "Brak");
			dini_IntSet(trasaS, "Checkpointy", 0);
			dini_IntSet(trasaS, "Nagroda", 0);
			dini_IntSet(trasaS, "TypCH", 0);
			dini_IntSet(trasaS, "TypW", 0);
			dini_FloatSet(trasaS, "Rozmiar", 0);
			for(new ii; ii<MAX_CHECKPOINTS; ii++)
			{
			    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
			    dini_FloatSet(trasaS, numerCH, 0);
				format(numerCH, sizeof(numerCH), "CH%d_y", ii);
			    dini_FloatSet(trasaS, numerCH, 0);
			    format(numerCH, sizeof(numerCH), "CH%d_z", ii);
			    dini_FloatSet(trasaS, numerCH, 0);
		    }
		    Wyscig[i][wStworzony] = dini_Int(trasaS, "Stworzony");
			strcat(Wyscig[i][wNazwa], dini_Get(trasaS, "Nazwa"), 20);
			strcat(Wyscig[i][wOpis], dini_Get(trasaS, "Opis"), 50);
			Wyscig[i][wCheckpointy] = dini_Int(trasaS, "Checkpointy");
			Wyscig[i][wNagroda] = dini_Int(trasaS, "Nagroda");
			Wyscig[i][wTypCH] = dini_Int(trasaS, "TypCH");
			Wyscig[i][wRozmiarCH] = dini_Float(trasaS, "Rozmiar");
			for(new ii; ii<MAX_CHECKPOINTS; ii++)
			{
			    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
				wCheckpoint[i][ii][0] = dini_Float(trasaS, numerCH);
				format(numerCH, sizeof(numerCH), "CH%d_y", ii);
		  		wCheckpoint[i][ii][1] = dini_Float(trasaS, numerCH);
		  		format(numerCH, sizeof(numerCH), "CH%d_z", ii);
		    	wCheckpoint[i][ii][2] = dini_Float(trasaS, numerCH);
		    }
		}
	}
	e = GetTickCount();
	printf("DINI1: LADOWANIE TRAS czas wykonania: %d", e-s);
	return 1;
}

ZapiszTrase(trasa)
{
	new trasaS[24];
	new numerCH[12];
    format(trasaS, sizeof(trasaS), "Inne/trasa_%d.ini", trasa);
    dini_IntSet(trasaS, "Stworzony", Wyscig[trasa][wStworzony]);
	dini_Set(trasaS, "Nazwa", Wyscig[trasa][wNazwa]);
	dini_Set(trasaS, "Opis", Wyscig[trasa][wOpis]);
	dini_IntSet(trasaS, "Checkpointy", Wyscig[trasa][wCheckpointy]);
	dini_IntSet(trasaS, "Nagroda", Wyscig[trasa][wNagroda]);
	dini_IntSet(trasaS, "TypCH", Wyscig[trasa][wTypCH]);
	dini_FloatSet(trasaS, "Rozmiar", Wyscig[trasa][wRozmiarCH]);
	for(new ii; ii<MAX_CHECKPOINTS; ii++)
	{
	    format(numerCH, sizeof(numerCH), "CH%d_x", ii);
	    dini_FloatSet(trasaS, numerCH, wCheckpoint[trasa][ii][0]);
		format(numerCH, sizeof(numerCH), "CH%d_y", ii);
	    dini_FloatSet(trasaS, numerCH, wCheckpoint[trasa][ii][1]);
	    format(numerCH, sizeof(numerCH), "CH%d_z", ii);
	    dini_FloatSet(trasaS, numerCH, wCheckpoint[trasa][ii][2]);
    }
	return 1;
}


MRP_ShopPurchaseCar(playerid, model, cena)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        SendClientMessage(playerid, COLOR_GRAD2, "Wyjd� z pojazdu.");
        return 0;
    }
    new komunikat[256];

    if(CountPlayerCars(playerid) >= PlayerInfo[playerid][pCarSlots])
    {
        SendClientMessage(playerid, COLOR_YELLOW, "Nie masz wolnych slot�w.");
        return 0;
    }
	new carid;
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));

    //Create
	new Float:x, Float:y, Float:z, Float:a;

    if(IsABoatModel(model))
	{
		if(IsPlayerAtViceCity(playerid))
		{
    		new losuj = random(sizeof(LosowyParkingLodzVC));
			x = LosowyParkingLodzVC[losuj][0];
			y = LosowyParkingLodzVC[losuj][1];
			z = LosowyParkingLodzVC[losuj][2];
			a = LosowyParkingLodzVC[losuj][3];
		}
		else
		{
    		new losuj = random(sizeof(LosowyParkingLodz));
			x = LosowyParkingLodz[losuj][0];
			y = LosowyParkingLodz[losuj][1];
			z = LosowyParkingLodz[losuj][2];
			a = LosowyParkingLodz[losuj][3];
		}
	}
	else if(IsAWodolotModel(model))
	{
		new losuj = random(sizeof(LosowyParkingWodolotVC));
		x = LosowyParkingWodolotVC[losuj][0];
		y = LosowyParkingWodolotVC[losuj][1];
		z = LosowyParkingWodolotVC[losuj][2];
		a = LosowyParkingWodolotVC[losuj][3];
	}
	else if(IsAPlaneModel(model))
	{
		if(IsPlayerAtViceCity(playerid))
		{
    		new losuj = random(sizeof(LosowyParkingLotVC));
			x = LosowyParkingLotVC[losuj][0];
			y = LosowyParkingLotVC[losuj][1];
			z = LosowyParkingLotVC[losuj][2];
			a = LosowyParkingLotVC[losuj][3];
		}
		else
		{
    		new losuj = random(sizeof(LosowyParkingLot));
			x = LosowyParkingLot[losuj][0];
			y = LosowyParkingLot[losuj][1];
			z = LosowyParkingLot[losuj][2];
			a = LosowyParkingLot[losuj][3];
		}
	}
	else if(IsAHeliModel(model))
	{
		if(IsPlayerAtViceCity(playerid))
		{
    		new losuj = random(sizeof(LosowyParkingHeliVC));
			x = LosowyParkingHeliVC[losuj][0];
			y = LosowyParkingHeliVC[losuj][1];
			z = LosowyParkingHeliVC[losuj][2];
			a = LosowyParkingHeliVC[losuj][3];
		}
		else
		{
    		new losuj = random(sizeof(LosowyParkingHeli));
			x = LosowyParkingHeli[losuj][0];
			y = LosowyParkingHeli[losuj][1];
			z = LosowyParkingHeli[losuj][2];
			a = LosowyParkingHeli[losuj][3];
		}
	}
	else if(IsABikeModel(model) && IsPlayerAtViceCity(playerid))
	{
		new losuj = random(sizeof(LosowyParkingMotorVC));
		x = LosowyParkingMotorVC[losuj][0];
		y = LosowyParkingMotorVC[losuj][1];
		z = LosowyParkingMotorVC[losuj][2];
		a = LosowyParkingMotorVC[losuj][3];
	}
    else 
	{
		if(IsPlayerAtViceCity(playerid))
		{
    		new losuj = random(sizeof(LosowyParkingVC));
			x = LosowyParkingVC[losuj][0];
			y = LosowyParkingVC[losuj][1];
			a = LosowyParkingVC[losuj][3];
			z = LosowyParkingVC[losuj][2];
		}
		else
		{
    		new losuj = random(sizeof(LosowyParking));
			x = LosowyParking[losuj][0];
			y = LosowyParking[losuj][1];
			z = LosowyParking[losuj][2];
			a = LosowyParking[losuj][3];
		}
	}

	carid = Car_Create(model, x, y, z, a, 228, 228);
    if(carid == -1)
    {
        SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na stworzy� pojazdu! Rekord nie zosta� dodany do bazy.");
        return 0;
    }
    //Assign
    Car_MakePlayerOwner(playerid, carid);
	
	ZabierzMC(playerid, cena);

    //Info
    format(komunikat, sizeof(komunikat), "Kupi�e� unikatowy %s za %d MC. Komendy auta znajdziesz w /auto. Gratulujemy zakupu!",VehicleNames[model-400], cena);

    _MruAdmin(playerid, komunikat);

	//SendClientMessage(playerid,COLOR_NEWS, komunikat);

	Log(premiumLog, INFO, "%s kupi� unikatowy pojazd %s za %dMC", GetPlayerLogName(playerid), GetVehicleLogName(CarData[carid][c_ID]), cena);
    if(carid >= MAX_CARS)
    {
        sendErrorMessage(playerid, "Nie mo�na stworzy� pojazdu! Mo�liwe przepe�nienie, auto zosta�o kupione lecz nie mo�esz go u�y�.");
        return 1;
    }
	PutPlayerInVehicleEx(playerid, CarData[carid][c_ID], 0);
	return 1;
}

KupowaniePojazdu(playerid, model, kolor1, kolor2, cena)
{
    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD2, "Wyjd� z pojazdu.");
    new komunikat[256];
	if(kaska[playerid] >= cena)
	{
	    if(model >= 400 && model <= 611)
	    {
            if(CountPlayerCars(playerid) >= PlayerInfo[playerid][pCarSlots]) return SendClientMessage(playerid, COLOR_YELLOW, "Nie masz wolnych slot�w.");
			new carid;
			new nick[MAX_PLAYER_NAME];
			GetPlayerName(playerid, nick, sizeof(nick));

            //Create
			new Float:x, Float:y, Float:z, Float:a;
			if(IsABoatModel(model))
			{
				if(IsPlayerAtViceCity(playerid))
				{
					new losuj = random(sizeof(LosowyParkingLodzVC));
					x = LosowyParkingLodzVC[losuj][0];
					y = LosowyParkingLodzVC[losuj][1];
					z = LosowyParkingLodzVC[losuj][2];
					a = LosowyParkingLodzVC[losuj][3];
				}
				else
				{
					new losuj = random(sizeof(LosowyParkingLodz));
					x = LosowyParkingLodz[losuj][0];
					y = LosowyParkingLodz[losuj][1];
					z = LosowyParkingLodz[losuj][2];
					a = LosowyParkingLodz[losuj][3];
				}
			}
			else if(IsAWodolotModel(model))
			{
				new losuj = random(sizeof(LosowyParkingWodolotVC));
				x = LosowyParkingWodolotVC[losuj][0];
				y = LosowyParkingWodolotVC[losuj][1];
				z = LosowyParkingWodolotVC[losuj][2];
				a = LosowyParkingWodolotVC[losuj][3];
			}
			else if(IsAPlaneModel(model))
			{
				if(IsPlayerAtViceCity(playerid))
				{
					new losuj = random(sizeof(LosowyParkingLotVC));
					x = LosowyParkingLotVC[losuj][0];
					y = LosowyParkingLotVC[losuj][1];
					z = LosowyParkingLotVC[losuj][2];
					a = LosowyParkingLotVC[losuj][3];
				}
				else
				{
					new losuj = random(sizeof(LosowyParkingLot));
					x = LosowyParkingLot[losuj][0];
					y = LosowyParkingLot[losuj][1];
					z = LosowyParkingLot[losuj][2];
					a = LosowyParkingLot[losuj][3];
				}
			}
			else if(IsAHeliModel(model))
			{
				if(IsPlayerAtViceCity(playerid))
				{
					new losuj = random(sizeof(LosowyParkingHeliVC));
					x = LosowyParkingHeliVC[losuj][0];
					y = LosowyParkingHeliVC[losuj][1];
					z = LosowyParkingHeliVC[losuj][2];
					a = LosowyParkingHeliVC[losuj][3];
				}
				else
				{
					new losuj = random(sizeof(LosowyParkingHeli));
					x = LosowyParkingHeli[losuj][0];
					y = LosowyParkingHeli[losuj][1];
					z = LosowyParkingHeli[losuj][2];
					a = LosowyParkingHeli[losuj][3];
				}
			}
			else if(IsABikeModel(model) && IsPlayerAtViceCity(playerid))
			{
				new losuj = random(sizeof(LosowyParkingMotorVC));
				x = LosowyParkingMotorVC[losuj][0];
				y = LosowyParkingMotorVC[losuj][1];
				z = LosowyParkingMotorVC[losuj][2];
				a = LosowyParkingMotorVC[losuj][3];
			}
			else 
			{
				if(IsPlayerAtViceCity(playerid))
				{
					new losuj = random(sizeof(LosowyParkingVC));
					x = LosowyParkingVC[losuj][0];
					y = LosowyParkingVC[losuj][1];
					a = LosowyParkingVC[losuj][3];
					z = LosowyParkingVC[losuj][2];
				}
				else
				{
					new losuj = random(sizeof(LosowyParking));
					x = LosowyParking[losuj][0];
					y = LosowyParking[losuj][1];
					z = LosowyParking[losuj][2];
					a = LosowyParking[losuj][3];
				}
			}
            
			carid = Car_Create(model, x, y, z, a, kolor1, kolor2);
            if(carid == -1) return SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na stworzy� pojazdu! Rekord nie zosta� dodany do bazy.");
            //Assign
            Car_MakePlayerOwner(playerid, carid);

            //Info
            format(komunikat, sizeof(komunikat), "Kupi�e� %s za %d$. Komendy auta znajdziesz w /auto. Gratulujemy zakupu!",VehicleNames[model-400], cena);
			SendClientMessage(playerid,COLOR_NEWS, komunikat);

            ZabierzKase(playerid, cena);

			Log(payLog, INFO, "%s kupi� pojazd %s za %d$", GetPlayerLogName(playerid), GetVehicleLogName(CarData[carid][c_ID]), cena);
            if(carid >= MAX_CARS) return SendClientMessage(playerid, COLOR_PANICRED, "Nie mo�na stworzy� pojazdu! Mo�liwe przepe�nienie, auto zosta�o kupione lecz nie mo�esz go u�y�.");

			PutPlayerInVehicleEx(playerid, CarData[carid][c_ID], 0);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_WHITE, "B��D - z�y model! Zg�o� okoliczno�ci na forum.");
		}
	}
	else
 	{
 	    format(komunikat, sizeof(komunikat), "Nie sta� Ci� na zakup tego pojazdu. Kosztuje on %d$ a Ty posiadasz tylko %d$.",cena, kaska[playerid]);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, komunikat);
	}
	return 1;
}

ZaladujDomy()
{
	new string[256];
	if(dini_Exists("Domy/NRD.ini"))
	{
	    for(new i = 0; i <= dini_Int("Domy/NRD.ini", "NrDomow"); i++)
	    {
	        format(string, sizeof(string), "Domy/Dom%d.ini", i);
	        if(dini_Exists(string))
	        {
	            new GeT[MAX_PLAYER_NAME];
	            new message[128];
	            new SEJF[20];
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Wlasciciel"));
				/*if(strfind(GeT, "Zamaskowany", true) != -1) //chwilowy fix, po u�yciu na produkcji wyrzuci�
				{
					new playernick[26];
    				strmid(playernick, MruMySQL_GetNameFromUID(dini_Int(string, "UID_Wlascicela")), 0, MAX_PLAYER_NAME, MAX_PLAYER_NAME);
					format(GeT, sizeof(GeT), "%s", playernick);
				}*/
    			Dom[i][hID] = i;
    			Dom[i][hDomNr] = dini_Int(string, "DomNr");
    			Dom[i][hZamek] = dini_Int(string, "Zamek");
				Dom[i][hWlasciciel] = GeT;
				Dom[i][hKupiony] = dini_Int(string, "Kupiony");
				Dom[i][hBlokada] = dini_Int(string, "Blokada");
				Dom[i][hOplata] = dini_Int(string, "Dodatkowa_Oplata");
				format(message, sizeof(message), "%s", dini_Get(string, "Komunikat_Wynajmu"));
				Dom[i][hKomunikatWynajmu] = message;
				Dom[i][hCena] = dini_Int(string, "Cena");
				Dom[i][hUID_W] = dini_Int(string, "UID_Wlascicela");
				Dom[i][hData_DD] = dini_Int(string, "Data");
				Dom[i][hWej_X] = dini_Float(string, "Wej_X");
				Dom[i][hWej_Y] = dini_Float(string, "Wej_Y");
				Dom[i][hWej_Z] = dini_Float(string, "Wej_Z");
				Dom[i][hInt_X] = dini_Float(string, "Int_X");
				Dom[i][hInt_Y] = dini_Float(string, "Int_Y");
				Dom[i][hInt_Z] = dini_Float(string, "Int_Z");
				Dom[i][hInterior] = dini_Int(string, "Interior");
				Dom[i][hParcela] = dini_Int(string, "Parcela");
				Dom[i][hVW] = dini_Int(string, "VirtualWorld");
				//format(GeT, sizeof(GeT), "%s", dini_Get(string, "Tekst_3D"));
				//Dom[i][h3D_txt] = GeT;
				//hK_3D,
				Dom[i][hSwiatlo] = dini_Int(string, "Oswietlenie");
				Dom[i][hPokoje] = dini_Int(string, "Pokoje");
				Dom[i][hPDW] = dini_Int(string, "Pokoi_Dowynajecia");
				Dom[i][hPW] = dini_Int(string, "Pokoi_Wynajmowanych");
                if(Dom[i][hPW] < 0) Dom[i][hPW] = 0;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator1"));
				Dom[i][hL1] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator2"));
				Dom[i][hL2] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator3"));
				Dom[i][hL3] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator4"));
				Dom[i][hL4] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator5"));
				Dom[i][hL5] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator6"));
				Dom[i][hL6] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator7"));
				Dom[i][hL7] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator8"));
				Dom[i][hL8] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator9"));
				Dom[i][hL9] = GeT;
				format(GeT, sizeof(GeT), "%s", dini_Get(string, "Lokator10"));
				Dom[i][hL10] = GeT;
				Dom[i][hWynajem] = dini_Int(string, "Wynajmowanie");
				Dom[i][hWW] = dini_Int(string, "Warunek_Wynajmu");
				Dom[i][hTWW] = dini_Int(string, "Tryb_WW");
				Dom[i][hCenaWynajmu] = dini_Int(string, "CenaWynajmu");
				Dom[i][hKomunikatDomowy] = dini_Int(string, "KomunikatDomowy");
				Dom[i][hUL_Z] = dini_Int(string, "Uprawnienia_Lokatorow_Zamek");
				Dom[i][hUL_D] = dini_Int(string, "Uprawnienia_Lokatorow_Dodatki");
				Dom[i][hApteczka] = dini_Int(string, "Apteczka");
				Dom[i][hKami] = dini_Int(string, "Kamizelka");
				Dom[i][hSejf] = dini_Int(string, "Sejf");
				format(SEJF, sizeof(SEJF), "%s", dini_Get(string, "Kod_Do_Sejfu"));
				Dom[i][hKodSejf] = SEJF;
				Dom[i][hZbrojownia] = dini_Int(string, "Zbrojownia");
				Dom[i][hGaraz] = dini_Int(string, "Garaz");
				Dom[i][hLadowisko] = dini_Int(string, "Ladowisko");
				Dom[i][hAlarm] = dini_Int(string, "Alarm");
				Dom[i][hZamekD] = dini_Int(string, "Zamek_Dodatkowy");
				Dom[i][hKomputer] = dini_Int(string, "Komputer");
				Dom[i][hRTV] = dini_Int(string, "Sprzet_RTV");
				Dom[i][hHazard] = dini_Int(string, "Zestaw_Hazardowy");
				Dom[i][hSzafa] = dini_Int(string, "Szafa");
				Dom[i][hTajemnicze] = dini_Int(string, "Tajemniczy_Dodatek");
				Dom[i][hS_kasa] = dini_Int(string, "S_kasa");
				Dom[i][hS_mats] = dini_Int(string, "S_mats");
				Dom[i][hS_ziolo] = dini_Int(string, "S_ziolo");
				Dom[i][hS_drugs] = dini_Int(string, "S_drugs");
				Dom[i][hS_PG1] = dini_Int(string, "S_PG1");
				Dom[i][hS_PG2] = dini_Int(string, "S_PG2");
				Dom[i][hS_PG3] = dini_Int(string, "S_PG3");
				Dom[i][hS_PG4] = dini_Int(string, "S_PG4");
				Dom[i][hS_PG5] = dini_Int(string, "S_PG5");
				Dom[i][hS_PG6] = dini_Int(string, "S_PG6");
				Dom[i][hS_PG7] = dini_Int(string, "S_PG7");
				Dom[i][hS_PG8] = dini_Int(string, "S_PG8");
				Dom[i][hS_PG9] = dini_Int(string, "S_PG9");
				Dom[i][hS_PG10] = dini_Int(string, "S_PG10");
				Dom[i][hS_PG11] = dini_Int(string, "S_PG11");
				Dom[i][hS_G0] = dini_Int(string, "S_G0");
				Dom[i][hS_G1] = dini_Int(string, "S_G1");
				Dom[i][hS_G2] = dini_Int(string, "S_G2");
				Dom[i][hS_G3] = dini_Int(string, "S_G3");
				Dom[i][hS_G4] = dini_Int(string, "S_G4");
				Dom[i][hS_G5] = dini_Int(string, "S_G5");
				Dom[i][hS_G6] = dini_Int(string, "S_G6");
				Dom[i][hS_G7] = dini_Int(string, "S_G7");
				Dom[i][hS_G8] = dini_Int(string, "S_G8");
				Dom[i][hS_G9] = dini_Int(string, "S_G9");
				Dom[i][hS_G10] = dini_Int(string, "S_G10");
				Dom[i][hS_G11] = dini_Int(string, "S_G11");
				Dom[i][hS_A1] = dini_Int(string, "S_A1");
				Dom[i][hS_A2] = dini_Int(string, "S_A2");
				Dom[i][hS_A3] = dini_Int(string, "S_A3");
				Dom[i][hS_A4] = dini_Int(string, "S_A4");
				Dom[i][hS_A5] = dini_Int(string, "S_A5");
				Dom[i][hS_A6] = dini_Int(string, "S_A6");
				Dom[i][hS_A7] = dini_Int(string, "S_A7");
				Dom[i][hS_A8] = dini_Int(string, "S_A8");
				Dom[i][hS_A9] = dini_Int(string, "S_A9");
				Dom[i][hS_A10] = dini_Int(string, "S_A10");
				Dom[i][hS_A11] = dini_Int(string, "S_A11");
				Dom[i][hIkonka] = -1;
				if(Dom[i][hKupiony] == 0)
				{
				    Dom[i][hPickup] = CreateDynamicPickup(1273, 1, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z], -1, -1, -1, 125.0);
				}
				else
				{
				    Dom[i][hPickup] = CreateDynamicPickup(1239, 1, Dom[i][hWej_X], Dom[i][hWej_Y], Dom[i][hWej_Z], -1, -1, -1, 125.0);
				}
	        }
	    }
	}
	else
	{
	    dini_Create("Domy/NRD.ini");
	    dini_IntSet("Domy/NRD.ini", "NrDomow", 0);
	}
	return 1;
}

ZapiszDomy()
{
	new string[256];
    for(new i = 0; i <= dini_Int("Domy/NRD.ini", "NrDomow"); i++)
    {
    	format(string, sizeof(string), "Domy/Dom%d.ini", i);
     	if(dini_Exists(string))
      	{
   			//dini_IntSet(string, "ID", Dom[i][hID]);
   			dini_IntSet(string, "DomNr", Dom[i][hDomNr]);
			dini_Set(string, "Wlasciciel", Dom[i][hWlasciciel]);
			dini_IntSet(string, "Zamek", Dom[i][hZamek]);
			dini_IntSet(string, "Kupiony", Dom[i][hKupiony]);
			dini_IntSet(string, "Blokada", Dom[i][hBlokada]);
		 	dini_IntSet(string, "Dodatkowa_Oplata", Dom[i][hOplata]);
		 	dini_Set(string, "Komunikat_Wynajmu", Dom[i][hKomunikatWynajmu]);
		 	dini_IntSet(string, "Cena", Dom[i][hCena]);
			dini_IntSet(string, "UID_Wlascicela", Dom[i][hUID_W]);
			dini_IntSet(string, "Data", Dom[i][hData_DD]);
			dini_FloatSet(string, "Wej_X", Dom[i][hWej_X]);
			dini_FloatSet(string, "Wej_Y", Dom[i][hWej_Y]);
			dini_FloatSet(string, "Wej_Z", Dom[i][hWej_Z]);
			dini_FloatSet(string, "Int_X", Dom[i][hInt_X]);
			dini_FloatSet(string, "Int_Y", Dom[i][hInt_Y]);
			dini_FloatSet(string, "Int_Z", Dom[i][hInt_Z]);
			dini_IntSet(string, "Interior", Dom[i][hInterior]);
			dini_IntSet(string, "Parcela", Dom[i][hParcela]);
			dini_IntSet(string, "VirtualWorld", Dom[i][hVW]);
			//format(GeT, sizeof(GeT), "%s", dini_Get(string, "Tekst_3D"));
			//Dom[i][h3D_txt] = GeT;
			//hK_3D,
			dini_IntSet(string, "Oswietlenie", Dom[i][hSwiatlo]);
			dini_IntSet(string, "Pokoje", Dom[i][hPokoje]);
			dini_IntSet(string, "Pokoi_Dowynajecia", Dom[i][hPDW]);
			dini_IntSet(string, "Pokoi_Wynajmowanych", Dom[i][hPW]);
			dini_Set(string, "Lokator1", Dom[i][hL1]);
			dini_Set(string, "Lokator2", Dom[i][hL2]);
			dini_Set(string, "Lokator3", Dom[i][hL3]);
			dini_Set(string, "Lokator4", Dom[i][hL4]);
			dini_Set(string, "Lokator5", Dom[i][hL5]);
			dini_Set(string, "Lokator6", Dom[i][hL6]);
			dini_Set(string, "Lokator7", Dom[i][hL7]);
			dini_Set(string, "Lokator8", Dom[i][hL8]);
			dini_Set(string, "Lokator9", Dom[i][hL9]);
			dini_Set(string, "Lokator10", Dom[i][hL10]);
			dini_IntSet(string, "Wynajmowanie", Dom[i][hWynajem]);
			dini_IntSet(string, "CenaWynajmu", Dom[i][hCenaWynajmu]);
            dini_IntSet(string, "KomunikatDomowy", Dom[i][hKomunikatDomowy]);
			dini_IntSet(string, "Uprawnienia_Lokatorow_Zamek", Dom[i][hUL_Z]);
			dini_IntSet(string, "Uprawnienia_Lokatorow_Dodatki", Dom[i][hUL_D]);
            dini_IntSet(string, "Warunek_Wynajmu", Dom[i][hWW]);
            dini_IntSet(string, "Tryb_WW", Dom[i][hTWW]);
			dini_IntSet(string, "Apteczka", Dom[i][hApteczka]);
			dini_IntSet(string, "Kamizelka", Dom[i][hKami]);
			dini_IntSet(string, "Sejf", Dom[i][hSejf]);
			dini_Set(string, "Kod_Do_Sejfu", Dom[i][hKodSejf]);
			dini_IntSet(string, "Zbrojownia", Dom[i][hZbrojownia]);
			dini_IntSet(string, "Garaz", Dom[i][hGaraz]);
			dini_IntSet(string, "Ladowisko", Dom[i][hLadowisko]);
			dini_IntSet(string, "Alarm", Dom[i][hAlarm]);
		 	dini_IntSet(string, "Zamek_Dodatkowy", Dom[i][hZamekD]);
			dini_IntSet(string, "Komputer", Dom[i][hKomputer]);
			dini_IntSet(string, "Sprzet_RTV", Dom[i][hRTV]);
			dini_IntSet(string, "Zestaw_Hazardowy", Dom[i][hHazard]);
			dini_IntSet(string, "Szafa", Dom[i][hSzafa]);
			dini_IntSet(string, "Tajemniczy_Dodatek", Dom[i][hTajemnicze]);
			dini_IntSet(string, "S_kasa", Dom[i][hS_kasa]);
			dini_IntSet(string, "S_mats", Dom[i][hS_mats]);
			dini_IntSet(string, "S_ziolo", Dom[i][hS_ziolo]);
			dini_IntSet(string, "S_drugs", Dom[i][hS_drugs]);
			dini_IntSet(string, "S_PG1", Dom[i][hS_PG1]);
			dini_IntSet(string, "S_PG2", Dom[i][hS_PG2]);
			dini_IntSet(string, "S_PG3", Dom[i][hS_PG3]);
			dini_IntSet(string, "S_PG4", Dom[i][hS_PG4]);
			dini_IntSet(string, "S_PG5", Dom[i][hS_PG5]);
			dini_IntSet(string, "S_PG6", Dom[i][hS_PG6]);
			dini_IntSet(string, "S_PG7", Dom[i][hS_PG7]);
			dini_IntSet(string, "S_PG8", Dom[i][hS_PG8]);
			dini_IntSet(string, "S_PG9", Dom[i][hS_PG9]);
			dini_IntSet(string, "S_PG10", Dom[i][hS_PG10]);
			dini_IntSet(string, "S_PG11", Dom[i][hS_PG11]);
			dini_IntSet(string, "S_G0", Dom[i][hS_G0]);
			dini_IntSet(string, "S_G1", Dom[i][hS_G1]);
			dini_IntSet(string, "S_G2", Dom[i][hS_G2]);
			dini_IntSet(string, "S_G3", Dom[i][hS_G3]);
			dini_IntSet(string, "S_G4", Dom[i][hS_G4]);
			dini_IntSet(string, "S_G5", Dom[i][hS_G5]);
			dini_IntSet(string, "S_G6", Dom[i][hS_G6]);
			dini_IntSet(string, "S_G7", Dom[i][hS_G7]);
			dini_IntSet(string, "S_G8", Dom[i][hS_G8]);
			dini_IntSet(string, "S_G9", Dom[i][hS_G9]);
			dini_IntSet(string, "S_G10", Dom[i][hS_G10]);
			dini_IntSet(string, "S_G11", Dom[i][hS_G11]);
			dini_IntSet(string, "S_A1", Dom[i][hS_A1]);
			dini_IntSet(string, "S_A2", Dom[i][hS_A2]);
			dini_IntSet(string, "S_A3", Dom[i][hS_A3]);
			dini_IntSet(string, "S_A4", Dom[i][hS_A4]);
			dini_IntSet(string, "S_A5", Dom[i][hS_A5]);
			dini_IntSet(string, "S_A6", Dom[i][hS_A6]);
			dini_IntSet(string, "S_A7", Dom[i][hS_A7]);
			dini_IntSet(string, "S_A8", Dom[i][hS_A8]);
			dini_IntSet(string, "S_A9", Dom[i][hS_A9]);
			dini_IntSet(string, "S_A10", Dom[i][hS_A10]);
			dini_IntSet(string, "S_A11", Dom[i][hS_A11]);
        }
    }
    return 1;
}

ZapiszDom(domid)
{
    new string[256];
    format(string, sizeof(string), "Domy/Dom%d.ini", domid);
  	if(dini_Exists(string))
  	{
   		//dini_IntSet(string, "ID", Dom[domid][hID]);
   		dini_IntSet(string, "DomNr", Dom[domid][hDomNr]);
  		dini_Set(string, "Wlasciciel", Dom[domid][hWlasciciel]);
  		dini_IntSet(string, "Zamek", Dom[domid][hZamek]);
  		dini_IntSet(string, "Kupiony", Dom[domid][hKupiony]);
  		dini_IntSet(string, "Blokada", Dom[domid][hBlokada]);
	 	dini_IntSet(string, "Dodatkowa_Oplata", Dom[domid][hOplata]);
	 	dini_Set(string, "Komunikat_Wynajmu", Dom[domid][hKomunikatWynajmu]);
	 	dini_IntSet(string, "Cena", Dom[domid][hCena]);
		dini_IntSet(string, "UID_Wlascicela", Dom[domid][hUID_W]);
		dini_IntSet(string, "Data", Dom[domid][hData_DD]);
		dini_FloatSet(string, "Wej_X", Dom[domid][hWej_X]);
		dini_FloatSet(string, "Wej_Y", Dom[domid][hWej_Y]);
		dini_FloatSet(string, "Wej_Z", Dom[domid][hWej_Z]);
		dini_FloatSet(string, "Int_X", Dom[domid][hInt_X]);
		dini_FloatSet(string, "Int_Y", Dom[domid][hInt_Y]);
		dini_FloatSet(string, "Int_Z", Dom[domid][hInt_Z]);
		dini_IntSet(string, "Interior", Dom[domid][hInterior]);
		dini_IntSet(string, "Parcela", Dom[domid][hParcela]);
		dini_IntSet(string, "VirtualWorld", Dom[domid][hVW]);
		//format(GeT, sizeof(GeT), "%s", dini_Get(string, "Tekst_3D"));
		//Dom[domid][h3D_txt] = GeT;
		//hK_3D,
		dini_IntSet(string, "Oswietlenie", Dom[domid][hSwiatlo]);
		dini_IntSet(string, "Pokoje", Dom[domid][hPokoje]);
		dini_IntSet(string, "Pokoi_Dowynajecia", Dom[domid][hPDW]);
		dini_IntSet(string, "Pokoi_Wynajmowanych", Dom[domid][hPW]);
		dini_Set(string, "Lokator1", Dom[domid][hL1]);
		dini_Set(string, "Lokator2", Dom[domid][hL2]);
		dini_Set(string, "Lokator3", Dom[domid][hL3]);
		dini_Set(string, "Lokator4", Dom[domid][hL4]);
		dini_Set(string, "Lokator5", Dom[domid][hL5]);
		dini_Set(string, "Lokator6", Dom[domid][hL6]);
		dini_Set(string, "Lokator7", Dom[domid][hL7]);
		dini_Set(string, "Lokator8", Dom[domid][hL8]);
		dini_Set(string, "Lokator9", Dom[domid][hL9]);
		dini_Set(string, "Lokator10", Dom[domid][hL10]);
		dini_IntSet(string, "Wynajmowanie", Dom[domid][hWynajem]);
		dini_IntSet(string, "CenaWynajmu", Dom[domid][hCenaWynajmu]);
		dini_IntSet(string, "KomunikatDomowy", Dom[domid][hKomunikatDomowy]);
		dini_IntSet(string, "Uprawnienia_Lokatorow_Zamek", Dom[domid][hUL_Z]);
		dini_IntSet(string, "Uprawnienia_Lokatorow_Dodatki", Dom[domid][hUL_D]);
		dini_IntSet(string, "Warunek_Wynajmu", Dom[domid][hWW]);
  		dini_IntSet(string, "Tryb_WW", Dom[domid][hTWW]);
		dini_IntSet(string, "Apteczka", Dom[domid][hApteczka]);
		dini_IntSet(string, "Kamizelka", Dom[domid][hKami]);
		dini_IntSet(string, "Sejf", Dom[domid][hSejf]);
		dini_Set(string, "Kod_Do_Sejfu", Dom[domid][hKodSejf]);
		dini_IntSet(string, "Zbrojownia", Dom[domid][hZbrojownia]);
		dini_IntSet(string, "Garaz", Dom[domid][hGaraz]);
		dini_IntSet(string, "Ladowisko", Dom[domid][hLadowisko]);
		dini_IntSet(string, "Alarm", Dom[domid][hAlarm]);
	 	dini_IntSet(string, "Zamek_Dodatkowy", Dom[domid][hZamekD]);
		dini_IntSet(string, "Komputer", Dom[domid][hKomputer]);
		dini_IntSet(string, "Sprzet_RTV", Dom[domid][hRTV]);
		dini_IntSet(string, "Zestaw_Hazardowy", Dom[domid][hHazard]);
		dini_IntSet(string, "Szafa", Dom[domid][hSzafa]);
		dini_IntSet(string, "Tajemniczy_Dodatek", Dom[domid][hTajemnicze]);
		dini_IntSet(string, "S_kasa", Dom[domid][hS_kasa]);
		dini_IntSet(string, "S_mats", Dom[domid][hS_mats]);
		dini_IntSet(string, "S_ziolo", Dom[domid][hS_ziolo]);
		dini_IntSet(string, "S_drugs", Dom[domid][hS_drugs]);
		dini_IntSet(string, "S_PG1", Dom[domid][hS_PG1]);
		dini_IntSet(string, "S_PG2", Dom[domid][hS_PG2]);
		dini_IntSet(string, "S_PG3", Dom[domid][hS_PG3]);
		dini_IntSet(string, "S_PG4", Dom[domid][hS_PG4]);
		dini_IntSet(string, "S_PG5", Dom[domid][hS_PG5]);
		dini_IntSet(string, "S_PG6", Dom[domid][hS_PG6]);
		dini_IntSet(string, "S_PG7", Dom[domid][hS_PG7]);
		dini_IntSet(string, "S_PG8", Dom[domid][hS_PG8]);
		dini_IntSet(string, "S_PG9", Dom[domid][hS_PG9]);
		dini_IntSet(string, "S_PG10", Dom[domid][hS_PG10]);
		dini_IntSet(string, "S_PG11", Dom[domid][hS_PG11]);
		dini_IntSet(string, "S_G0", Dom[domid][hS_G0]);
		dini_IntSet(string, "S_G1", Dom[domid][hS_G1]);
		dini_IntSet(string, "S_G2", Dom[domid][hS_G2]);
		dini_IntSet(string, "S_G3", Dom[domid][hS_G3]);
		dini_IntSet(string, "S_G4", Dom[domid][hS_G4]);
		dini_IntSet(string, "S_G5", Dom[domid][hS_G5]);
		dini_IntSet(string, "S_G6", Dom[domid][hS_G6]);
		dini_IntSet(string, "S_G7", Dom[domid][hS_G7]);
		dini_IntSet(string, "S_G8", Dom[domid][hS_G8]);
		dini_IntSet(string, "S_G9", Dom[domid][hS_G9]);
		dini_IntSet(string, "S_G10", Dom[domid][hS_G10]);
		dini_IntSet(string, "S_G11", Dom[domid][hS_G11]);
		dini_IntSet(string, "S_A1", Dom[domid][hS_A1]);
		dini_IntSet(string, "S_A2", Dom[domid][hS_A2]);
		dini_IntSet(string, "S_A3", Dom[domid][hS_A3]);
		dini_IntSet(string, "S_A4", Dom[domid][hS_A4]);
		dini_IntSet(string, "S_A5", Dom[domid][hS_A5]);
		dini_IntSet(string, "S_A6", Dom[domid][hS_A6]);
		dini_IntSet(string, "S_A7", Dom[domid][hS_A7]);
		dini_IntSet(string, "S_A8", Dom[domid][hS_A8]);
		dini_IntSet(string, "S_A9", Dom[domid][hS_A9]);
		dini_IntSet(string, "S_A10", Dom[domid][hS_A10]);
		dini_IntSet(string, "S_A11", Dom[domid][hS_A11]);
    }
	return 1;
}

StworzDom(playerid, interior, oplata)
{
	if(interior == 8 || interior == 14)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior zosta� usuni�ty");
	    return 1;
	} // loled
	if(interior == 33)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 36.");
	    return 1;
	}
	if(interior == 24)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 23.");
	    return 1;
	}
    new string[256];
    new dld = dini_Int("Domy/NRD.ini", "NrDomow")+1;
    format(string, sizeof(string), "Domy/Dom%d.ini", dld);
    new mnoznik;
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	mnoznik = Mnoznik(pZone);
	if(dini_Exists(string))
	{
	    SendClientMessageToAll(COLOR_RED, "B�AD PRZY TWORZENIU DOMU");
	    return 1;
	}
	else
	{
	    new GeT[MAX_PLAYER_NAME];
	    new message[128];
	    new Float:Wej_X, Float: Wej_Y, Float: Wej_Z;
     	GetPlayerPos(playerid, Wej_X, Wej_Y, Wej_Z);
	 	dini_Create(string);
    	//dini_IntSet(string, "ID", Dom[domid][hID]);
		Dom[dld][hID] = dld;
		Dom[dld][hDomNr] = interior;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hWlasciciel] = GeT;
		Dom[dld][hZamek] = 0;
		Dom[dld][hKupiony] = 0;
		Dom[dld][hBlokada] = 0;
		Dom[dld][hOplata] = oplata;
		format(message, sizeof(message), "Wynajmujesz dom");
		Dom[dld][hKomunikatWynajmu] = message;
		Dom[dld][hUID_W] = 0;
		Dom[dld][hData_DD] = 0;
		Dom[dld][hWej_X] = Wej_X;
		Dom[dld][hWej_Y] = Wej_Y;
		Dom[dld][hWej_Z] = Wej_Z;
		Dom[dld][hInt_X] = IntInfo[interior][Int_X];
		Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];
		Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];
		Dom[dld][hInterior] = IntInfo[interior][Int];
		//Dom[dld][hParcela] = dini_Int(string, "Parcela");//niet
		
		if(interior == 47)
			Dom[dld][hVW] = 2001;
		else
			Dom[dld][hVW] = dld;
		//format(GeT, sizeof(GeT), "%s", dini_Get(string, "Tekst_3D"));
		//Dom[dld][h3D_txt] = GeT;
		//hK_3D,
		Dom[dld][hSwiatlo] = 0;
		Dom[dld][hPokoje] = IntInfo[interior][Pokoje];
		Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
		Dom[dld][hPW] = 0;//pokoi wynajmowanych
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL1] = GeT;
		Dom[dld][hL2] = GeT;
		Dom[dld][hL3] = GeT;
		Dom[dld][hL4] = GeT;
		Dom[dld][hL5] = GeT;
		Dom[dld][hL6] = GeT;
		Dom[dld][hL7] = GeT;
		Dom[dld][hL8] = GeT;
		Dom[dld][hL9] = GeT;
		Dom[dld][hL10] = GeT;
		Dom[dld][hWynajem] = 0;
		Dom[dld][hWW] = 1;
		Dom[dld][hTWW] = 1;
		Dom[dld][hCenaWynajmu] = 1000;
		Dom[dld][hKomunikatDomowy] = 0;
		Dom[dld][hUL_Z] = 0;
		Dom[dld][hUL_D] = 0;
		Dom[dld][hApteczka] = 0;
		Dom[dld][hKami] = 0;
		Dom[dld][hSejf] = 1;
		new GeT2[20];
		format(GeT2, sizeof(GeT2), "500500500500");
		Dom[dld][hKodSejf] = GeT2;
		Dom[dld][hZbrojownia] = 0;
		Dom[dld][hGaraz] = 0;
		Dom[dld][hLadowisko] = 0;
		Dom[dld][hAlarm] = 0;
		Dom[dld][hZamekD] = 0;
		Dom[dld][hKomputer] = 0;
		Dom[dld][hRTV] = 0;
		Dom[dld][hHazard] = 0;
		Dom[dld][hSzafa] = 0;
		Dom[dld][hTajemnicze] = 0;
		Dom[dld][hS_kasa] = 0;
		Dom[dld][hS_mats] = 0;
		Dom[dld][hS_ziolo] = 0;
		Dom[dld][hS_drugs] = 0;
		Dom[dld][hS_PG1] = 0;
		Dom[dld][hS_PG2] = 0;
		Dom[dld][hS_PG3] = 0;
		Dom[dld][hS_PG4] = 0;
		Dom[dld][hS_PG5] = 0;
		Dom[dld][hS_PG6] = 0;
		Dom[dld][hS_PG7] = 0;
		Dom[dld][hS_PG8] = 0;
		Dom[dld][hS_PG9] = 0;
		Dom[dld][hS_PG10] = 0;
		Dom[dld][hS_PG11] = 0;
		Dom[dld][hS_G0] = 0;
		Dom[dld][hS_G1] = 0;
		Dom[dld][hS_G2] = 0;
		Dom[dld][hS_G3] = 0;
		Dom[dld][hS_G4] = 0;
		Dom[dld][hS_G5] = 0;
		Dom[dld][hS_G6] = 0;
		Dom[dld][hS_G7] = 0;
		Dom[dld][hS_G8] = 0;
		Dom[dld][hS_G9] = 0;
		Dom[dld][hS_G10] = 0;
		Dom[dld][hS_G11] = 0;
		Dom[dld][hS_A1] = 0;
		Dom[dld][hS_A2] = 0;
		Dom[dld][hS_A3] = 0;
		Dom[dld][hS_A4] = 0;
		Dom[dld][hS_A5] = 0;
		Dom[dld][hS_A6] = 0;
		Dom[dld][hS_A7] = 0;
		Dom[dld][hS_A8] = 0;
		Dom[dld][hS_A9] = 0;
		Dom[dld][hS_A10] = 0;
		Dom[dld][hS_A11] = 0;
	    Dom[dld][hPickup] = CreateDynamicPickup(1273, 1, Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], -1, -1, -1, 125.0);
	    Dom[dld][hIkonka] = -1;
		dini_IntSet("Domy/NRD.ini", "NrDomow", dld);
		new intcena = IntInfo[Dom[dld][hDomNr]][Cena];
		new Float:koxX = mnoznik/10;
  		new Float:cenadomu = ((intcena*koxX)+oplata);//cena domu
		Dom[dld][hCena] = floatround(cenadomu, floatround_ceil);
		new string2[256];
		format(string2, sizeof(string2), "Dom %d || NrDom %d || Mno�nik %d || Parcela %s || Cene og�lna %d$.", dld, Dom[dld][hDomNr], mnoznik, pZone, floatround(cenadomu, floatround_ceil));
		SendClientMessage(playerid, COLOR_NEWS, string2);
		//
		ZapiszDom(dld);
	}
	return dld;
}

Dom_ChangeInt(playerid, dld, interior)
{
	if(interior == 8 || interior == 14)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior zosta� usuni�ty");
	    return 1;
	}
	if(interior == 33)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 36.");
	    return 1;
	}
	if(interior == 24)
	{
	    SendClientMessage(playerid, COLOR_RED, "Ten interior jest taki sam jak interior 23.");
	    return 1;
	}
    new string[128];

	new oldInt = Dom[dld][hDomNr];
    new Float:Wej_X, Float: Wej_Y, Float: Wej_Z;
 	GetPlayerPos(playerid, Wej_X, Wej_Y, Wej_Z);

    Dom[dld][hPokoje] = IntInfo[interior][Pokoje];
    Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1;
	Dom[dld][hWej_X] = Wej_X;
	Dom[dld][hWej_Y] = Wej_Y;
	Dom[dld][hWej_Z] = Wej_Z;
	Dom[dld][hInt_X] = IntInfo[interior][Int_X];
	Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];
	Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];
	Dom[dld][hInterior] = IntInfo[interior][Int];
    Dom[dld][hDomNr] = interior;

    new mnoznik;
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	mnoznik = Mnoznik(pZone);
    new intcena = IntInfo[interior][Cena];
	new Float:koxX = mnoznik/10;
	new Float:cenadomu = (intcena*koxX);//cena domu
	Dom[dld][hCena] = floatround(cenadomu, floatround_ceil);

    DestroyDynamicPickup(Dom[dld][hPickup]);
	if(Dom[dld][hIkonka] != -1) DestroyDynamicMapIcon(Dom[dld][hIkonka]);
    Dom[dld][hPickup] = CreateDynamicPickup(1239, 1, Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], -1, -1, -1, 125.0);
    Dom[dld][hIkonka] = -1;

	format(string, sizeof(string), "Zmiana Interioru - OK. || Dom %d || NrDom %d || Interior: %d || Cena %d", dld, Dom[dld][hDomNr], interior, Dom[dld][hCena]);
	SendClientMessage(playerid, COLOR_NEWS, string);
        
	Log(adminLog, INFO, "Admin %s zmieni� interior domu %s z %d na %d", GetPlayerLogName(playerid), GetHouseLogName(dld), oldInt, interior);
	//
	ZapiszDom(dld);
	return 1;
}

Dom_ChangeOwner(playerid, dom, forid)
{
    new string[128];

	Log(adminLog, INFO, "Admin %s zmieni� w�a�ciciela domu %s z {Player: %s[%d]} na %s", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hWlasciciel], Dom[dom][hUID_W], GetPlayerLogName(forid));
    PlayerInfo[forid][pDom] = dom;
	Dom[dom][hWlasciciel] = GetNickEx(forid);
	Dom[dom][hKupiony] = 1;
	Dom[dom][hUID_W] = PlayerInfo[forid][pUID];

	format(string, sizeof(string), "Zmiana wlasciciela - OK. || Dom %d || NrDom %d || Wlasciciel: %s", dom, Dom[dom][hDomNr], GetNickEx(forid));
	SendClientMessage(playerid, COLOR_NEWS, string);

	//
	ZapiszDom(dom);
	return 1;
}

L_StworzDom(playerid, kategoria, oplata)
{
    new string[256];
    new dld = dini_Int("Domy/NRD.ini", "NrDomow")+1;
    new mnoznik;
	new pZone[MAX_ZONE_NAME];
    GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
	mnoznik = Mnoznik(pZone);
    format(string, sizeof(string), "Domy/Dom%d.ini", dld );
	if(dini_Exists(string))
	{
	    SendClientMessageToAll(COLOR_RED, "B�AD PRZY TWORZENIU DOMU (DOM INSTNIEJE)");
	    return 1;
	}
	else
	{
	    new GeT[MAX_PLAYER_NAME];
	    new message[128];
	    new Float:Wej_X, Float: Wej_Y, Float: Wej_Z;
     	GetPlayerPos(playerid, Wej_X, Wej_Y, Wej_Z);
	 	dini_Create(string);
    	//dini_IntSet(string, "ID", Dom[domid][hID]);
		Dom[dld][hID] = dld;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hWlasciciel] = GeT;
		Dom[dld][hZamek] = 0;
		Dom[dld][hKupiony] = 0;
		Dom[dld][hOplata] = oplata;
		format(message, sizeof(message), "Wynajmujesz dom");
		Dom[dld][hKomunikatWynajmu] = message;
		Dom[dld][hUID_W] = 0;
		Dom[dld][hData_DD] = 0;
		Dom[dld][hWej_X] = Wej_X;
		Dom[dld][hWej_Y] = Wej_Y;
		Dom[dld][hWej_Z] = Wej_Z;
		if(kategoria == 1)
		{
		    new interior = random(5);
		    if(interior == 0)
		    {
		        interior = 1;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 2)
		{
		    new interior = random(13)+7;
		    if(interior == 8)
		    {
		        interior = 7;
		    }
		    if(interior == 14)
		    {
                interior = 15;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 3)
		{
		    new interior = random(8)+21;
		    if(interior == 24)
		    {
		        interior = 23;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 4)
		{
		    new interior = random(6)+30;
		    if(interior == 33)
		    {
		        interior = 36;
		    }
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 5)
		{
		    new interior = random(5)+37;
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 6)
		{
		    new interior = random(2)+43;
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else if(kategoria == 7)
		{
		    new interior = random(2)+45;
		    Dom[dld][hDomNr] = interior;
		    Dom[dld][hPokoje] = IntInfo[interior][Pokoje]; //Pokoi_Dowynajecia
			Dom[dld][hPDW] = IntInfo[interior][Pokoje]-1; //Pokoi_Dowynajecia
			Dom[dld][hInt_X] = IntInfo[interior][Int_X];//Pos X
			Dom[dld][hInt_Y] = IntInfo[interior][Int_Y];//Pos Y
			Dom[dld][hInt_Z] = IntInfo[interior][Int_Z];//Pos Z
			Dom[dld][hInterior] = IntInfo[interior][Int];//Interior
		}
		else
		{
		    SendClientMessageToAll(COLOR_RED, "B�AD PRZY TWORZENIU DOMU (Z�A KATEGORIA)");
	    	return 1;
		}
		//Dom[dld][hParcela] = dini_Int(string, "Parcela");//niet
		Dom[dld][hVW] = dld;
		//format(GeT, sizeof(GeT), "%s", dini_Get(string, "Tekst_3D"));
		//Dom[dld][h3D_txt] = GeT;
		//hK_3D,
		Dom[dld][hPW] = 0;//pokoi wynajmowanych
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL1] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL2] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL3] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL4] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL5] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL6] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL7] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL8] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL9] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dld][hL10] = GeT;
		Dom[dld][hWynajem] = 0;
		Dom[dld][hWW] = 1;
		Dom[dld][hTWW] = 1;
		Dom[dld][hCenaWynajmu] = 1000;
		Dom[dld][hKomunikatDomowy] = 0;
		Dom[dld][hApteczka] = 0;
		Dom[dld][hKami] = 0;
		Dom[dld][hSejf] = 1;
		new GeT2[20];
		format(GeT2, sizeof(GeT2), "500500500500");
		Dom[dld][hKodSejf] = GeT2;
		Dom[dld][hGaraz] = 0;
		Dom[dld][hLadowisko] = 0;
		Dom[dld][hAlarm] = 0;
		Dom[dld][hZamekD] = 0;
		Dom[dld][hKomputer] = 0;
		Dom[dld][hRTV] = 0;
		Dom[dld][hHazard] = 0;
		Dom[dld][hSzafa] = 0;
		Dom[dld][hTajemnicze] = 0;
		Dom[dld][hS_kasa] = 0;
		Dom[dld][hS_mats] = 0;
		Dom[dld][hS_ziolo] = 0;
		Dom[dld][hS_drugs] = 0;
		Dom[dld][hS_PG1] = 0;
		Dom[dld][hS_PG2] = 0;
		Dom[dld][hS_PG3] = 0;
		Dom[dld][hS_PG4] = 0;
		Dom[dld][hS_PG5] = 0;
		Dom[dld][hS_PG6] = 0;
		Dom[dld][hS_PG7] = 0;
		Dom[dld][hS_PG8] = 0;
		Dom[dld][hS_PG9] = 0;
		Dom[dld][hS_PG10] = 0;
		Dom[dld][hS_PG11] = 0;
		Dom[dld][hS_G0] = 0;
		Dom[dld][hS_G1] = 0;
		Dom[dld][hS_G2] = 0;
		Dom[dld][hS_G3] = 0;
		Dom[dld][hS_G4] = 0;
		Dom[dld][hS_G5] = 0;
		Dom[dld][hS_G6] = 0;
		Dom[dld][hS_G7] = 0;
		Dom[dld][hS_G8] = 0;
		Dom[dld][hS_G9] = 0;
		Dom[dld][hS_G10] = 0;
		Dom[dld][hS_G11] = 0;
		Dom[dld][hS_A1] = 0;
		Dom[dld][hS_A2] = 0;
		Dom[dld][hS_A3] = 0;
		Dom[dld][hS_A4] = 0;
		Dom[dld][hS_A5] = 0;
		Dom[dld][hS_A6] = 0;
		Dom[dld][hS_A7] = 0;
		Dom[dld][hS_A8] = 0;
		Dom[dld][hS_A9] = 0;
		Dom[dld][hS_A10] = 0;
		Dom[dld][hS_A11] = 0;
		Dom[dld][hPickup] = CreateDynamicPickup(1273, 1, Dom[dld][hWej_X], Dom[dld][hWej_Y], Dom[dld][hWej_Z], -1, -1, -1, 125.0);
	    Dom[dld][hIkonka] = -1;
		dini_IntSet("Domy/NRD.ini", "NrDomow", dld);
		new intcena = IntInfo[Dom[dld][hDomNr]][Cena];
		new Float:koxX = mnoznik/10;
  		new Float:cenadomu = ((intcena*koxX)+oplata);//cena domu
		Dom[dld][hCena] = floatround(cenadomu, floatround_ceil);
		new string2[256];
		format(string2, sizeof(string2), "Dom %d || NrDom %d || Mno�nik %d || Parcela %s || Cene og�lna %d$.", dld, Dom[dld][hDomNr], mnoznik, pZone, floatround(cenadomu, floatround_ceil));
		SendClientMessage(playerid, COLOR_NEWS, string2);
		//
		ZapiszDom(dld);
	}
	return 1;
}

KupowanieDomu(playerid, dom, platnosc)
{
    new string[256];
    format(string, sizeof(string), "Domy/Dom%d.ini", dom);
	if(!dini_Exists(string))
	{
        format(string, 256, "B�AD PRZY KUPOWANIU DOMU - Dom %d gracz %d", dom, playerid);
	    SendClientMessageToAll(COLOR_RED, string);
	    return 1;
	}
	else
	{
		if(Dom[dom][hKupiony] == 1)
		{
			SendClientMessage(playerid, COLOR_RED, "Dom ju� jest kupiony!");
			return 1;
		}
	    //new doplata = Dom[dom][hOplata];
		//new interior = IntInfo[Dom[dom][hDomNr]][Cena];
		//new mnoznik;
		//new pZone[MAX_ZONE_NAME];
		new str2[256];
		//GetPlayer2DZone(playerid, pZone, MAX_ZONE_NAME);
		//
		//mnoznik = Mnoznik(pZone);
		//new cenadomu = ((interior*mnoznik)/10)+doplata;//cena domu
		new cenadomu = Dom[dom][hCena];
	    if(platnosc == 1)
	    {
	        if(kaska[playerid] >= cenadomu && cenadomu != 0 && cenadomu > 0 && kaska[playerid] != 0 && kaska[playerid] > 0)
	        {
				ZabierzKase(playerid, cenadomu);
				format(str2, sizeof(str2), "Gratulacje! Kupi�e� dom za %d$. Masz teraz %d$.", cenadomu, kaska[playerid]);
				SendClientMessage(playerid, COLOR_NEWS, str2);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_NEWS, "Nie sta� ci�!!!!");
			    return 1;
			}
	    }
	    if(platnosc == 2)
		{
		    if(PlayerInfo[playerid][pAccount] >= cenadomu && cenadomu != 0 && cenadomu > 0 && PlayerInfo[playerid][pAccount] != 0 && PlayerInfo[playerid][pAccount] > 0)
	        {
				PlayerInfo[playerid][pAccount] += -cenadomu;
				format(str2, sizeof(str2), "Gratulacje! Kupi�e� dom za %d$. Zosta�o one odliczone od twojego konta bankowego kt�re wynosi teraz %d", cenadomu, PlayerInfo[playerid][pAccount]);
				SendClientMessage(playerid, COLOR_PANICRED, str2);
			}
			else
			{
			    SendClientMessage(playerid, COLOR_PANICRED, "Nie sta� ci�!!!!");
			    return 1;
			}
		}
		printf(str2);
		PlayerInfo[playerid][pDom] = dom;
	    new h, m;
		GetPlayerTime(playerid, h, m);
		Dom[dom][hWlasciciel] = GetNickEx(playerid);
		Dom[dom][hKupiony] = 1;
		Dom[dom][hUID_W] = PlayerInfo[playerid][pUID];
		Dom[dom][hData_DD] = 0;
		DestroyDynamicPickup(Dom[dom][hPickup]);
		if(Dom[dom][hIkonka] != -1) DestroyDynamicMapIcon(Dom[dom][hIkonka]);
	    Dom[dom][hPickup] = CreateDynamicPickup(1239, 1, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z], -1, -1, -1, 125.0);
	    Dom[dom][hIkonka] = -1;
	    SetPlayerPos(playerid, Dom[dom][hInt_X], Dom[dom][hInt_Y], Dom[dom][hInt_Z]);
	    SetPlayerInterior(playerid, Dom[dom][hInterior]);
	    SetPlayerVirtualWorld(playerid, Dom[dom][hVW]);
	    PlayerInfo[playerid][pDomWKJ] = dom;
	    PlayerInfo[playerid][pDomT] = h;
	    SendClientMessage(playerid, COLOR_NEWS, "Aby zobaczy� komendy domu wpisz /dompomoc");
		Log(payLog, INFO, "%s kupi� dom %s za %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), cenadomu);
		ZapiszDom(dom);
	}
	return 1;
}

ZlomowanieDomu(playerid, dom)
{
	new plik[256];
    format(plik, sizeof(plik), "Domy/Dom%d.ini", dom);
	//
	if(dini_Exists(plik))
	{
	    new GeT[MAX_PLAYER_NAME];
		Dom[dom][hZamek] = 0;
		Dom[dom][hKupiony] = 0;
		Dom[dom][hUID_W] = 0;
		Dom[dom][hData_DD] = 0;
		Dom[dom][hSwiatlo] = 0;
		Dom[dom][hPW] = 0;//pokoi wynajmowanych
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL1] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL2] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL3] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL4] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL5] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL6] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL7] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL8] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL9] = GeT;
		format(GeT, sizeof(GeT), "Brak");
		Dom[dom][hL10] = GeT;
		Dom[dom][hWynajem] = 0;
		Dom[dom][hWW] = 1;
		Dom[dom][hTWW] = 1;
		Dom[dom][hCenaWynajmu] = 1000;
		Dom[dom][hKomunikatDomowy] = 0;
		Dom[dom][hUL_Z] = 0;
		Dom[dom][hUL_D] = 0;
		Dom[dom][hApteczka] = 0;
		Dom[dom][hKami] = 0;
		Dom[dom][hSejf] = 1;
		new GeT3[20];
		format(GeT3, sizeof(GeT3), "500500500500");
		Dom[dom][hKodSejf] = GeT3;
		Dom[dom][hGaraz] = 0;
		Dom[dom][hLadowisko] = 0;
		Dom[dom][hAlarm] = 0;
		Dom[dom][hZamekD] = 0;
		Dom[dom][hKomputer] = 0;
		Dom[dom][hRTV] = 0;
		Dom[dom][hHazard] = 0;
		Dom[dom][hSzafa] = 0;
		Dom[dom][hTajemnicze] = 0;
		Dom[dom][hS_kasa] = 0;
		Dom[dom][hS_mats] = 0;
		Dom[dom][hS_ziolo] = 0;
		Dom[dom][hS_drugs] = 0;
		Dom[dom][hS_PG1] = 0;
		Dom[dom][hS_PG2] = 0;
		Dom[dom][hS_PG3] = 0;
		Dom[dom][hS_PG4] = 0;
		Dom[dom][hS_PG5] = 0;
		Dom[dom][hS_PG6] = 0;
		Dom[dom][hS_PG7] = 0;
		Dom[dom][hS_PG8] = 0;
		Dom[dom][hS_PG9] = 0;
		Dom[dom][hS_PG10] = 0;
		Dom[dom][hS_PG11] = 0;
		Dom[dom][hS_G0] = 0;
		Dom[dom][hS_G1] = 0;
		Dom[dom][hS_G2] = 0;
		Dom[dom][hS_G3] = 0;
		Dom[dom][hS_G4] = 0;
		Dom[dom][hS_G5] = 0;
		Dom[dom][hS_G6] = 0;
		Dom[dom][hS_G7] = 0;
		Dom[dom][hS_G8] = 0;
		Dom[dom][hS_G9] = 0;
		Dom[dom][hS_G10] = 0;
		Dom[dom][hS_G11] = 0;
		Dom[dom][hS_A1] = 0;
		Dom[dom][hS_A2] = 0;
		Dom[dom][hS_A3] = 0;
		Dom[dom][hS_A4] = 0;
		Dom[dom][hS_A5] = 0;
		Dom[dom][hS_A6] = 0;
		Dom[dom][hS_A7] = 0;
		Dom[dom][hS_A8] = 0;
		Dom[dom][hS_A9] = 0;
		Dom[dom][hS_A10] = 0;
		Dom[dom][hS_A11] = 0;
		Dom[dom][hZbrojownia] = 0;
		DestroyDynamicPickup(Dom[dom][hPickup]);
		if(Dom[dom][hIkonka] != -1) DestroyDynamicMapIcon(Dom[dom][hIkonka]);
	    Dom[dom][hPickup] = CreateDynamicPickup(1273, 1, Dom[dom][hWej_X], Dom[dom][hWej_Y], Dom[dom][hWej_Z], -1, -1, -1, 125.0);
	    Dom[dom][hIkonka] = -1;
		ZapiszDom(dom);
		//
		if(playerid != 9999)
		{
		    new GeT4[MAX_PLAYER_NAME];
		    GetPlayerName(playerid, GeT4, sizeof(GeT4));
			PlayerInfo[playerid][pDom] = 0;
			DajKase(playerid, (Dom[dom][hCena]/2));
			new GeT2[512];
			format(GeT2, sizeof(GeT2), "Sprzeda�e� sw�j dom za %d$. Osoby wynajmuj�ce zosta�y wyeksmitowane. Przedmioty w sejfie oraz dodatki do domu przepad�y.", (Dom[dom][hCena]/2));
			SendClientMessage(playerid, COLOR_NEWS, GeT2);
			Log(payLog, INFO, "%s zez�omowa� dom %s i dosta� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), (Dom[dom][hCena]/2));
			format(GeT, sizeof(GeT), "Brak");
			Dom[dom][hWlasciciel] = GeT;
		}
		else
		{
			if(strcmp(Dom[dom][hWlasciciel], "Gracz Nieaktywny") != 0)
			{
				Log(serverLog, INFO, "Dom %s zosta� zez�omowany z powodu nieaktywno�ci w�a�ciciela %s.", GetHouseLogName(dom), Dom[dom][hWlasciciel]);
				format(GeT, sizeof(GeT), "Gracz Nieaktywny");
				Dom[dom][hWlasciciel] = GeT;
			}
		}
	}
	else
	{
	    SendClientMessage(playerid, COLOR_NEWS, "B�AD - Tw�j dom nie istnieje, zg�o� to na forum !!");
	}
    return 1;
}

SprawdzSpojnoscWlascicielaDomu(playerid)
{
	new string[64];
	format(string, sizeof(string), "Domy/Dom%d.ini", PlayerInfo[playerid][pDom]);
	if(dini_Exists(string))
	{
		if(strcmp(Dom[PlayerInfo[playerid][pDom]][hWlasciciel], GetNickEx(playerid), true) != 0)
		{
			return 0;
		}
	}
	else
	{
		return -1;
	}
	return 1;
}

NaprawSpojnoscWlascicielaDomu(playerid)
{
	new domcheck = SprawdzSpojnoscWlascicielaDomu(playerid);
	new dom = PlayerInfo[playerid][pDom];
	if(domcheck == 1)
	{
		if(Dom[dom][hKupiony] == 0)
		{
			Dom[dom][hWlasciciel] = GetNickEx(playerid);
			Dom[dom][hKupiony] = 1;
			Dom[dom][hUID_W] = PlayerInfo[playerid][pUID];
			ZapiszDom(dom);
			SendClientMessage(playerid, COLOR_PANICRED, "Wykryto bug z niekupionym domem, zosta� on automatycznie naprawiony. Je�eli komunikat b�dzie si� powtarza� lub wyst�pi� inne bugi, zg�o� to koniecznie na forum!");
			Log(serverLog, WARNING, "%s posiada� bug z niekupionym domem %s. Naprawiono.", GetPlayerLogName(playerid), GetHouseLogName(dom));
		}
	}
	else if(domcheck == 0)
	{
		if(Dom[dom][hKupiony] == 0)
		{
			Dom[dom][hWlasciciel] = GetNickEx(playerid);
			Dom[dom][hKupiony] = 1;
			Dom[dom][hUID_W] = PlayerInfo[playerid][pUID];
			ZapiszDom(dom);
			SendClientMessage(playerid, COLOR_PANICRED, "Wykryto bug z niekupionym domem, zosta� on automatycznie naprawiony. Je�eli komunikat b�dzie si� powtarza� lub wyst�pi� inne bugi, zg�o� to koniecznie na forum!");
			Log(serverLog, WARNING, "%s posiada� bug z niekupionym domem %s. Naprawiono.", GetPlayerLogName(playerid), GetHouseLogName(dom));

			// DajKase(playerid, (Dom[dom][hCena]/2));
			// SendClientMessage(playerid, COLOR_PANICRED, "Tw�j dom zosta� zabrany z powodu nieaktywno�ci, otrzymujesz po�ow� wartosci domu!");
			// Log(payLog, INFO, "%s straci� dom %s z powodu nieaktywno�ci i otrzyma� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hCena]/2);
			// PlayerInfo[playerid][pDom] = 0;
		}
		else
		{
			DajKase(playerid, (Dom[dom][hCena]));
			SendClientMessage(playerid, COLOR_PANICRED, "Wykro bug z dwoma w�a�cicielami! Jeste� drugim w�a�cicielem, wi�c tracisz dom i otrzymujesz zwrot pieni�dzy.");
			Log(payLog, INFO, "%s straci� dom %s z powodu nieaktywno�ci (2 w�a�cicieli) i otrzyma� %d$", GetPlayerLogName(playerid), GetHouseLogName(dom), Dom[dom][hCena]);
			PlayerInfo[playerid][pDom] = 0;
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_PANICRED, "Tw�j dom nie istnieje! Prawdopodobnie zosta� usuni�ty lub co� posz�o nie tak.");
		Log(serverLog, ERROR, "Brak domu %s gracza %s. Usuwam mu dom.", GetPlayerLogName(playerid), GetHouseLogName(dom));
		PlayerInfo[playerid][pDom] = 0;
	}
}

DialogZbrojowni(playerid)
{
    ShowPlayerDialogEx(playerid, 8282, DIALOG_STYLE_LIST, "Kup przystosowanie do przechowywania:", "Kastetu\t\t\t\t\t1 000$\nSpadochronu\t\t\t\t5 000$\nSpreju, ga�nicy i aparatu\t\t40 000$\nWibrator�w,kwiat�w i laski\t\t50 000$\nBroni bia�ej\t\t\t\t750 000$\nPistolet�w\t\t\t\t250 000$\nStrzelb\t\t\t\t\t450 000$\nPistolet�w maszynowych\t\t550 000$\nKarabin�w szturmowych\t\t850 000$\nSnajperek\t\t\t\t700 000$\nBroni ci�kiej\t\t\t\t2 000 000$\n�adunk�w wybuchowych\t\t4 000 000$", "Wybierz", "Cofnij");
}

ShowSpawnChangeDialog(playerid)
{
	ShowPlayerDialogEx(playerid, 814, DIALOG_STYLE_LIST, "Wybierz typ spawnu", "Normalny spawn\nSpawn przed domem\nSpawn w domu\nSpawn w Vice City", "Wybierz", "Wr��");
}

Mnoznik(zone[])
{
	new mnoznik;
	if(strcmp(zone,"Commerce", false) == 0)
 	{
  		mnoznik = 62;
  	}
  	else if(strcmp(zone,"Conference Center", false) == 0)
   	{
    	mnoznik = 67;
   	}
   	else if(strcmp(zone,"Dillimore", false) == 0)
   	{
    	mnoznik = 53;
   	}
   	else if(strcmp(zone,"Downtown", false) == 0)
   	{
    	mnoznik = 58;
  	}
   	else if(strcmp(zone,"East Beach", false) == 0)
   	{
    	mnoznik = 29;
   	}
   	else if(strcmp(zone,"East Los Santos", false) == 0)
   	{
	   mnoznik = 28;
   	}
   	else if(strcmp(zone,"El Corona", false) == 0)
   	{
    	mnoznik = 45;
   	}
   	else if(strcmp(zone,"Ganton", false) == 0)
   	{
    	mnoznik = 45;
   	}
   	else if(strcmp(zone,"Glen Park", false) == 0)
   	{
    	mnoznik = 63;
   	}
   	else if(strcmp(zone,"Idlewood", false) == 0)
   	{
    	mnoznik = 51;
   	}
   	else if(strcmp(zone,"Jefferson", false) == 0)
   	{
    	mnoznik = 33;
   	}
   	else if(strcmp(zone,"Las Colinas", false) == 0)
   	{
    	mnoznik = 33;
   	}
   	else if(strcmp(zone,"Little Mexico", false) == 0)
   	{
    	mnoznik = 33;
	}
   	else if(strcmp(zone,"Los Flores", false) == 0)
   	{
    	mnoznik = 44;
   	}
   	else if(strcmp(zone,"Lotnisko", false) == 0)
   	{
    	mnoznik = 20;
   	}
   	else if(strcmp(zone,"Marina", false) == 0)
   	{
    	mnoznik = 59;
   	}
   	else if(strcmp(zone,"Market", false) == 0)
   	{
    	mnoznik = 66;
   	}
   	else if(strcmp(zone,"Mulholland", false) == 0)
   	{
		mnoznik = 60;
   	}
   	else if(strcmp(zone,"Ocean Docks", false) == 0)
   	{
    	mnoznik = 30;
   	}
   	else if(strcmp(zone,"North Rock", false) == 0)
   	{
    	mnoznik = 10;
   	}
   	else if(strcmp(zone,"Pershing Square", false) == 0)
   	{
    	mnoznik = 81;
   	}
   	else if(strcmp(zone,"Playa del Seville", false) == 0)
   	{
    	mnoznik = 40;
    }
   	else if(strcmp(zone,"Richman", false) == 0)
   	{
    	mnoznik = 59;
   	}
   	else if(strcmp(zone,"Rodeo", false) == 0)
   	{
    	mnoznik = 59;
   	}
   	else if(strcmp(zone,"Santa Maria Beach", false) == 0)
   	{
    	mnoznik = 61;
   	}
   	else if(strcmp(zone,"Temple", false) == 0)
   	{
    	mnoznik = 49;
   	}
   	else if(strcmp(zone,"Unity Station", false) == 0)
   	{
    	mnoznik = 73;
   	}
   	else if(strcmp(zone,"Verona Beach", false) == 0)
   	{
    	mnoznik = 63;
   	}
   	else if(strcmp(zone,"Vinewood", false) == 0)
   	{
    	mnoznik = 53;
   	}
   	else if(strcmp(zone,"Willowfield", false) == 0)
   	{
    	mnoznik = 51;
   	}
   	else if(strcmp(zone,"Los Santos", false) == 0)
   	{
		mnoznik = 10;
   	}
    /*else if(strcmp(zone,"Las Venturas", false) == 0)
   	{
   		mnoznik = 4;
   	}
   	else if(strcmp(zone,"San Fierro", false) == 0)
   	{
   		mnoznik = 4;
   	}*/
   	else
   	{
  		mnoznik = 10;
   	}

	return mnoznik;
}

KupowanieDodatkow(playerid, dom)
{
    new Sejf[100];
    new Zbrojownia[100];
    new Garaz[100];
    new Apteczka[100];
    new Pancerz[100];
    new Ladowisko[100];
    new Alarm[100];
    new Zamek[100];
    new Komputer[100];
    new RTV[100];
    new Hazard[100];
    new Szafa[100];
    new Tajne[100];
    new strALL[1300];
    format(Sejf, sizeof(Sejf), "Sejf\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hSejf]+1, 100000*(Dom[dom][hSejf]+1));
    if(Dom[dom][hZbrojownia] == 0)
	{
    	format(Zbrojownia, sizeof(Zbrojownia), "Zbrojownia\t\t\t\tCena: 1000000$\n");
	}
	else
	{
	    format(Zbrojownia, sizeof(Zbrojownia), "Przystosuj Zbrojownie do przechowywania broni.\n");
	}
	if(Dom[dom][hGaraz] == 0)
	{
		format(Garaz, sizeof(Garaz), "Gara�\t\t\tLevel: %d\tCena: %d$\n", 1, 1000000);
	}
	else
	{
	    format(Garaz, sizeof(Garaz), "Gara�\t\t\tLevel: %d\tCena: %d$\n", (Dom[dom][hGaraz]/20)+1, 500000*((Dom[dom][hGaraz]/20)+1));
	}
	if(Dom[dom][hApteczka] == 0)
	{
		format(Apteczka, sizeof(Apteczka), "Apteczka\t\t\t\tCena: %d$\n", 100000);//apteczka
	}
	else
	{
 		format(Apteczka, sizeof(Apteczka), "Apteczka w twoim domu jest na maksymalnym poziomie (%d)\n", Dom[dom][hApteczka]);//apteczka
	}
	if(Dom[dom][hKami] != 10)
	{
 		format(Pancerz, sizeof(Pancerz), "Pancerz\t\tLevel: %d\tCena: %d$\n", Dom[dom][hKami]+1, 100000*(Dom[dom][hKami]+1));
	}
	else
	{
	    format(Pancerz, sizeof(Pancerz), "Pancerz w twoim domu jest na maksymalnym poziomie (%d)\n", Dom[dom][hKami]);
	}
	if(Dom[dom][hLadowisko] == 0)
	{
	    format(Ladowisko, sizeof(Ladowisko), "L�dowisko\t\tLevel: %d\tCena: %d$\n", 1, 10000000);
	}
	else
	{
	    format(Ladowisko, sizeof(Ladowisko), "L�dowisko\t\tLevel: %d\tCena: %d$\n", (Dom[dom][hLadowisko]/20)+1, 1000000*((Dom[dom][hLadowisko]/20)+1));
	}
  	format(Alarm, sizeof(Alarm), "Alarm\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hAlarm]+1, 0*(Dom[dom][hAlarm]+1));
   	format(Zamek, sizeof(Zamek), "Zamek\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hZamekD]+1, 0*(Dom[dom][hZamekD]+1));
    format(Komputer, sizeof(Komputer), "Komputer\t\tLevel: %d\tCena: %d$\n", Dom[dom][hKomputer]+1, 0*(Dom[dom][hKomputer]+1));
    format(RTV, sizeof(RTV), "Sprz�t RTV\t\tLevel: %d\tCena: %d$\n", Dom[dom][hRTV]+1, 0*(Dom[dom][hRTV]+1));
    format(Hazard, sizeof(Hazard), "Zestaw hazardzisty\tLevel: %d\tCena: %d$\n", Dom[dom][hHazard]+1, 0*(Dom[dom][hHazard]+1));
    format(Szafa, sizeof(Szafa), "Szafa\t\t\tLevel: %d\tCena: %d$\n", Dom[dom][hSzafa]+1, 0*(Dom[dom][hSzafa]+1));
    format(Tajne, sizeof(Tajne), "Tajemnicze dodatki\tLevel: %d\tCena: %d$\n", Dom[dom][hTajemnicze]+1, 0*(Dom[dom][hTajemnicze]+1));
    //ALL
	format(strALL, sizeof(strALL), "%s%s%s%s%s%s%s%s%s%s%s%s%s", Sejf, Zbrojownia, Garaz, Apteczka, Pancerz, Ladowisko, Alarm, Zamek, Komputer, RTV, Hazard, Szafa, Tajne);
    ShowPlayerDialogEx(playerid, 826, DIALOG_STYLE_LIST, "Kupowanie dodatk�w", strALL, "Wybierz", "Wyjd�");
    return 1;
}

Do_WnetrzaWozu(playerid, vehicleid, model)
{
	if(model == 484)//jacht
	{
		SetPlayerInterior(playerid, 9);
	    SetPlayerPos(playerid, 1935.6661376953, 1360.8430175781, 12313.875976563);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~w~Witamy na ~b~jachcie", 5000, 1);
	}
	else if(model == 519)//shamal
	{
		SetPlayerInterior(playerid, 9);
	    SetPlayerPos(playerid, 1074.3032226563, -1843.8029785156, 10657.265625);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~odrzutowcu!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 553)//nevada
	{
        SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1.808619,32.384357,1199.593750);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~nevadzie!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 409)//limuzyna
	{
		SetPlayerInterior(playerid, 9);
	    SetPlayerPos(playerid, 2985.498046875, 1866.7770996094, 371.35998535156);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~limuzynie!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 416)//karetka
	{
		SetPlayerVirtualWorld(playerid, 32);
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1079.5173, -1309.6299, 22.0575);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Skalpel ~r~w dlon!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 508)//journey
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 2512.8455,-1729.0057,778.6371);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Witaj w ~r~domu!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	else if(model == 431)//autobus
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1450.3420,-1779.3888,3.6388);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Zapinaj Pasy - Jedziemy do piekla!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	
	}
	else if(model == 427)//Enforcer pd
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 1479.1534,-1617.7773,-4.2809);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Lap za bron!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	
	}
	else if(model == 570)//Wagony KT
	{
			SetPlayerInterior(playerid, 1);
			SetPlayerPos(playerid, 1708.72290, -1953.05688, -17.18891);
			Wchodzenie(playerid);
			GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Zajmuj miejsce, bo trzesie!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
			sendTipMessage(playerid, ">>Pomy�lnie wszed�e� do poci�gu! Bilet zosta� zu�yty!");
			sendTipMessage(playerid, ">>>Interior stworzony przez: Charlie112");
			PlayerInfo[playerid][pBiletpociag] = 0;
	}
	else if(model == 582)//sanvan
	{
		SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 739.3749,-1365.0778,7.4080);
        Wchodzenie(playerid);
	    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Mikrofon w dlon!~n~~y~Wychodzisz ~p~/wyjdzw", 4000, 4);
	}
	SetPlayerVirtualWorld(playerid, vehicleid);
    WnetrzeWozu[playerid] = vehicleid;
	return 1;
}

Z_WnetrzaWozu(playerid, vehicleid)
{
    new Float:vehx, Float:vehy, Float:vehz, model;
	GetVehiclePos(vehicleid, vehx, vehy, vehz);
	model = GetVehicleModel(vehicleid);
    if(model == 484)//jacht
	{
	    SetPlayerPos(playerid, vehx, vehy, vehz+2);
	}
	else if(model == 519)//shamal
	{
	    SetPlayerPos(playerid, vehx-0.5, vehy-2, vehz);
	}
	else if(model == 553)//nevada
	{
	    SetPlayerPos(playerid, vehx-7, vehy, vehz);
	}
	else if(model == 409)//limuzyna
	{
	    SetPlayerPos(playerid, vehx-2, vehy-1, vehz);
	}
	else if(model == 416)//karetka
	{
		SetPlayerPos(playerid, vehx-1, vehy-1, vehz);
	}
	else if(model == 508)//journey
	{
		SetPlayerPos(playerid, vehx, vehy+0.23, vehz);
	}
	else if(model == 570)//kt 
	{
		SetPlayerPos(playerid, vehx, vehy+3, vehz);
	
	}
	else if(model == 427)
	{
		SetPlayerPos(playerid, vehx, vehy+0.23, vehz);
	}
	else if(model == 431)
	{
		SetPlayerPos(playerid, vehx, vehy+0.23, vehz);
	}
	else if(model == 582)//sanvan
	{
	    SetPlayerPos(playerid, vehx-1, vehy-1, vehz);
	}
	GameTextForPlayer(playerid, "~w~Opusciles pojazd", 5000, 1);
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
    WnetrzeWozu[playerid] = 0;
	Wchodzenie(playerid);
	return 1;
}

LadujInteriory()
{
	//kategoria 1
    IntInfo[1][Int_X] = 244.5000;//dom 1
    IntInfo[1][Int_Y] = 305.0000;
    IntInfo[1][Int_Z] = 999.1484;
    IntInfo[1][Int] = 1;
    IntInfo[1][Kategoria] = 1;
    IntInfo[1][Pokoje] = 1;
    IntInfo[1][Cena] = 500000;
    IntInfo[2][Int_X] = 301.3000;//dom 2
    IntInfo[2][Int_Y] = 306.3000;
    IntInfo[2][Int_Z] = 1003.5391;
    IntInfo[2][Int] = 4;
    IntInfo[2][Kategoria] = 1;
    IntInfo[2][Pokoje] = 2;
    IntInfo[2][Cena] = 535000;
    IntInfo[3][Int_X] = 344.83898925781;//dom 3
    IntInfo[3][Int_Y] = 305.42208862305;
    IntInfo[3][Int_Z] = 999.1484375;
    IntInfo[3][Int] = 6;
    IntInfo[3][Kategoria] = 1;
    IntInfo[3][Pokoje] = 1;
    IntInfo[3][Cena] = 250000;
    IntInfo[4][Int_X] = -68.816932678223;//dom 4
    IntInfo[4][Int_Y] = 1354.1055908203;
    IntInfo[4][Int_Z] = 1080.2109375;
    IntInfo[4][Int] = 6;
    IntInfo[4][Kategoria] = 1;
    IntInfo[4][Pokoje] = 3;
    IntInfo[4][Cena] = 2500000;
    IntInfo[5][Int_X] = 2333.1157226563;//dom 5
    IntInfo[5][Int_Y] = -1074.7203369141;
    IntInfo[5][Int_Z] = 1049.0234375;
    IntInfo[5][Int] = 6;
    IntInfo[5][Kategoria] = 1;
    IntInfo[5][Pokoje] = 2;
    IntInfo[5][Cena] = 2000000;
    IntInfo[6][Int_X] = 1207.6346435547;//dom 6 DOMEK Z MUZYCZK�
    IntInfo[6][Int_Y] = -42.482707977295;
    IntInfo[6][Int_Z] = 1000.953125;
    IntInfo[6][Int] = 3;
    IntInfo[6][Kategoria] = 1;
    IntInfo[6][Pokoje] = 1;
    IntInfo[6][Cena] = 250000;
    //kategoria 2
    IntInfo[7][Int_X] = 267.1000;//dom 7 MALY JASNY DOMEK
    IntInfo[7][Int_Y] = 305.0000;
    IntInfo[7][Int_Z] = 999.1484;
    IntInfo[7][Int] = 2;
    IntInfo[7][Kategoria] = 2;
    IntInfo[7][Pokoje] = 1;
    IntInfo[7][Cena] = 500000;
    //loled
    /*IntInfo[8][Int_X] = -42.8151;//dom 8
    IntInfo[8][Int_Y] = 1408.4419;
    IntInfo[8][Int_Z] = 1084.4297;
    IntInfo[8][Int] = 8;
    IntInfo[8][Kategoria] = 1;
    IntInfo[8][Pokoje] = 3;
	IntInfo[8][Cena] = 2500000;*/
	//loled
    IntInfo[9][Int_X] = 2467.2964;//dom 9
    IntInfo[9][Int_Y] = -1698.1704;
    IntInfo[9][Int_Z] = 1013.5078;
    IntInfo[9][Int] = 2;
    IntInfo[9][Kategoria] = 2;
    IntInfo[9][Pokoje] = 3;
    IntInfo[9][Cena] = 2000000;
    IntInfo[10][Int_X] = 221.6465;//dom 10
    IntInfo[10][Int_Y] = 1148.6022;
    IntInfo[10][Int_Z] = 1082.6094;
    IntInfo[10][Int] = 4;
    IntInfo[10][Kategoria] = 2;
    IntInfo[10][Pokoje] = 3;
    IntInfo[10][Cena] = 1800000;
    IntInfo[11][Int_X] = 2254.3000;//dom 11 bug
    IntInfo[11][Int_Y] = -1140.0000;
    IntInfo[11][Int_Z] = 1050.6328;
    IntInfo[11][Int] = 9;
    IntInfo[11][Kategoria] = 2;
    IntInfo[11][Pokoje] = 3;
    IntInfo[11][Cena] = 2000000;
    IntInfo[12][Int_X] = 2261.3000;//dom 12
    IntInfo[12][Int_Y] = -1135.9000;
    IntInfo[12][Int_Z] = 1050.63280;
    IntInfo[12][Int] = 10;
    IntInfo[12][Kategoria] = 2;
    IntInfo[12][Pokoje] = 3;
    IntInfo[12][Cena] = 2000000;
    IntInfo[13][Int_X] = -42.796955108643;//dom 13 taki sam jak 8
    IntInfo[13][Int_Y] = 1407.6802978516;
    IntInfo[13][Int_Z] = 1084.4296875;
    IntInfo[13][Int] = 8;
    IntInfo[13][Kategoria] = 2;
    IntInfo[13][Pokoje] = 3;
    IntInfo[13][Cena] = 2000000;
    //loled
    /*IntInfo[14][Int_X] = -285.69171142578;//dom 14
    IntInfo[14][Int_Y] = 1471.2047119141;
    IntInfo[14][Int_Z] = 1084.3755;
    IntInfo[14][Int] = 15;
    IntInfo[14][Kategoria] = 2;
    IntInfo[14][Pokoje] = 4;
	IntInfo[14][Cena] = 1250000;*/
	//loled
    IntInfo[15][Int_X] = 2308.8254394531;//dom 15
    IntInfo[15][Int_Y] = -1211.2672119141;
    IntInfo[15][Int_Z] = 1049.0234375;
    IntInfo[15][Int] = 6;
    IntInfo[15][Kategoria] = 2;
    IntInfo[15][Pokoje] = 2;
    IntInfo[15][Cena] = 750000;
    IntInfo[16][Int_X] = 2216.4047851563;//dom 16
    IntInfo[16][Int_Y] = -1076.3693847656;
    IntInfo[16][Int_Z] = 1050.484375;
    IntInfo[16][Int] = 1;
    IntInfo[16][Kategoria] = 2;
    IntInfo[16][Pokoje] = 2;
    IntInfo[16][Cena] = 750000;
    IntInfo[17][Int_X] = 2283.1279296875;//dom 17
    IntInfo[17][Int_Y] = -1138.7651367188;
    IntInfo[17][Int_Z] = 1050.89843751;
    IntInfo[17][Int] = 11;
    IntInfo[17][Kategoria] = 2;
    IntInfo[17][Pokoje] = 3;
    IntInfo[17][Cena] = 750000;
    IntInfo[18][Int_X] = 223.14936828613;//dom 18
    IntInfo[18][Int_Y] = 1287.5688476563;
    IntInfo[18][Int_Z] = 1082.140625;
    IntInfo[18][Int] = 1;
    IntInfo[18][Kategoria] = 2;
    IntInfo[18][Pokoje] = 4;
    IntInfo[18][Cena] = 2750000;
    IntInfo[19][Int_X] = 2233.7893066406;//dom 19
    IntInfo[19][Int_Y] = -1115.1715087891;
    IntInfo[19][Int_Z] = 1050.8828125;
    IntInfo[19][Int] = 5;
    IntInfo[19][Kategoria] = 2;
    IntInfo[19][Pokoje] = 1;
    IntInfo[19][Cena] = 1250000;
    IntInfo[20][Int_X] = 443.49890136719;//dom 20 bug
    IntInfo[20][Int_Y] = 509.49703979492;
    IntInfo[20][Int_Z] = 1001.41949462892;
    IntInfo[20][Int] = 12;
    IntInfo[20][Kategoria] = 2;
    IntInfo[20][Pokoje] = 2;
    IntInfo[20][Cena] = 2500000;
    //kategoria 3
    IntInfo[21][Int_X] = 385.5547;//dom 21
    IntInfo[21][Int_Y] = 1471.6407;
    IntInfo[21][Int_Z] = 1080.1949;
    IntInfo[21][Int] = 15;
    IntInfo[21][Kategoria] = 3;
    IntInfo[21][Pokoje] = 3;
    IntInfo[21][Cena] = 7000000;
    IntInfo[22][Int_X] = 261.8072;//dom 22
    IntInfo[22][Int_Y] = 1241.7100;
    IntInfo[22][Int_Z] = 1084.2578;
    IntInfo[22][Int] = 9;
    IntInfo[22][Kategoria] = 3;
    IntInfo[22][Pokoje] = 4;
    IntInfo[22][Cena] = 9000000;
    IntInfo[23][Int_X] = 23.7709;//dom 23 taki sam jak nizej
    IntInfo[23][Int_Y] = 1341.2079;
    IntInfo[23][Int_Z] = 1084.3750;
    IntInfo[23][Int] = 10;
    IntInfo[23][Kategoria] = 3;
    IntInfo[23][Pokoje] = 4;
    IntInfo[23][Cena] = 8000000;
    /*IntInfo[24][Int_X] = 23.7709;//dom 24 taki sam jak wyzej
    IntInfo[24][Int_Y] = 1341.2079;
    IntInfo[24][Int_Z] = 1084.375010;
    IntInfo[24][Int] = 10;
    IntInfo[24][Kategoria] = 3;
    IntInfo[24][Pokoje] = 4;
	IntInfo[24][Cena] = 7000000;*/
    IntInfo[25][Int_X] = 329.1805;//dom 25
    IntInfo[25][Int_Y] = 1478.9669;
    IntInfo[25][Int_Z] = 1084.437515;
    IntInfo[25][Int] = 15;
    IntInfo[25][Kategoria] = 3;
    IntInfo[25][Pokoje] = 5;
    IntInfo[25][Cena] = 7000000;
    IntInfo[26][Int_X] = 2807.6186523438;//dom 26
    IntInfo[26][Int_Y] = -1173.2073974609;
    IntInfo[26][Int_Z] = 1025.57031258;
    IntInfo[26][Int] = 8;
    IntInfo[26][Kategoria] = 3;
    IntInfo[26][Pokoje] = 3;
    IntInfo[26][Cena] = 7000000;
    IntInfo[27][Int_X] = 2237.5952148438;//dom 27
    IntInfo[27][Int_Y] = -1079.6644287109;
    IntInfo[27][Int_Z] = 1049.02343752;
    IntInfo[27][Int] = 2;
    IntInfo[27][Kategoria] = 3;
    IntInfo[27][Pokoje] = 3;
    IntInfo[27][Cena] = 7800000;
    IntInfo[28][Int_X] = 261.16397094727;//dom 28
    IntInfo[28][Int_Y] = 1286.0953369141;
    IntInfo[28][Int_Z] = 1080.25781254;
    IntInfo[28][Int] = 4;
    IntInfo[28][Kategoria] = 3;
    IntInfo[28][Pokoje] = 4;
    IntInfo[28][Cena] = 8000000;
    IntInfo[29][Int_X] = -262.10150146484;//dom 29
    IntInfo[29][Int_Y] = 1456.7391357422;
    IntInfo[29][Int_Z] = 1084.36718754;
    IntInfo[29][Int] = 4;
    IntInfo[29][Kategoria] = 3;
    IntInfo[29][Pokoje] = 3;
    IntInfo[29][Cena] = 6000000;
    //Kategoria 4 (apartamenty)
    IntInfo[30][Int_X] = 376.3023;//dom 30
    IntInfo[30][Int_Y] = 1417.1825;
    IntInfo[30][Int_Z] = 1081.3281;
    IntInfo[30][Int] = 15;
    IntInfo[30][Kategoria] = 4;
    IntInfo[30][Pokoje] = 4;
    IntInfo[30][Cena] = 12000000;
    IntInfo[31][Int_X] = 446.5189;//dom 31
    IntInfo[31][Int_Y] = 1399.3490;
    IntInfo[31][Int_Z] = 1084.3047;
    IntInfo[31][Int] = 2;
    IntInfo[31][Kategoria] = 4;
    IntInfo[31][Pokoje] = 5;
    IntInfo[31][Cena] = 18000000;
    IntInfo[32][Int_X] = 295.4799;//dom 32
    IntInfo[32][Int_Y] = 1473.8265;
    IntInfo[32][Int_Z] = 1080.2578;
    IntInfo[32][Int] = 15;
    IntInfo[32][Kategoria] = 4;
    IntInfo[32][Pokoje] = 5;
    IntInfo[32][Cena] = 15000000;
    /*IntInfo[33][Int_X] = 2365.0375976563;//dom 33 taki sam jak 36
    IntInfo[33][Int_Y] = -1132.5759277344;
    IntInfo[33][Int_Z] = 1050.875;
    IntInfo[33][Int] = 8;
    IntInfo[33][Kategoria] = 4;
    IntInfo[33][Pokoje] = 4;
	IntInfo[33][Cena] = 19000000;*/
    IntInfo[34][Int_X] = 2195.7058105469;//dom 34
    IntInfo[34][Int_Y] = -1204.3842773438;
    IntInfo[34][Int_Z] = 1049.0234375;
    IntInfo[34][Int] = 6;
    IntInfo[34][Kategoria] = 4;
    IntInfo[34][Pokoje] = 6;
    IntInfo[34][Cena] = 19000000;
    IntInfo[35][Int_X] = 2269.0183105469;//dom 35
    IntInfo[35][Int_Y] = -1210.4658203125;
    IntInfo[35][Int_Z] = 1047.5625;
    IntInfo[35][Int] = 10;
    IntInfo[35][Kategoria] = 4;
    IntInfo[35][Pokoje] = 4;
    IntInfo[35][Cena] = 20000000;
    IntInfo[36][Int_X] = 2365.2951660156;//dom 36 taki sam jak 33
    IntInfo[36][Int_Y] = -1134.3520507813;
    IntInfo[36][Int_Z] = 1050.8990478516;
    IntInfo[36][Int] = 8;
    IntInfo[36][Kategoria] = 4;
    IntInfo[36][Pokoje] = 4;
    IntInfo[36][Cena] = 15000000;
    //Kategoria 5 (Ville)
    IntInfo[37][Int_X] = 235.5197;//dom 37
    IntInfo[37][Int_Y] = 1188.7935;
    IntInfo[37][Int_Z] = 1080.2578;
    IntInfo[37][Int] = 3;
    IntInfo[37][Kategoria] = 5;
    IntInfo[37][Pokoje] = 6;
    IntInfo[37][Cena] = 16000000;
    IntInfo[38][Int_X] = 140.50755310059;//dom 38
    IntInfo[38][Int_Y] = 1368.2507324219;
    IntInfo[38][Int_Z] = 1083.8626708984;
    IntInfo[38][Int] = 5;
    IntInfo[38][Kategoria] = 5;
    IntInfo[38][Pokoje] = 5;
    IntInfo[38][Cena] = 30000000;
    IntInfo[39][Int_X] = 83.150199890137;//dom 39
    IntInfo[39][Int_Y] = 1324.0864257813;
    IntInfo[39][Int_Z] = 1083.859375;
    IntInfo[39][Int] = 9;
    IntInfo[39][Kategoria] = 5;
    IntInfo[39][Pokoje] = 6;
    IntInfo[39][Cena] = 25000000;
    IntInfo[40][Int_X] = 231.4000;//dom 42
    IntInfo[40][Int_Y] = 1114.1000;
    IntInfo[40][Int_Z] = 1080.9922;
    IntInfo[40][Int] = 5;
    IntInfo[40][Kategoria] = 5;
    IntInfo[40][Pokoje] = 8;
    IntInfo[40][Cena] = 22500000;
    IntInfo[41][Int_X] = 225.6000;//dom 43
    IntInfo[41][Int_Y] = 1023.5000;
    IntInfo[41][Int_Z] = 1084.0117;
    IntInfo[41][Int] = 7;
    IntInfo[41][Kategoria] = 5;
    IntInfo[41][Pokoje] = 9;
    IntInfo[41][Cena] = 35000000;
    IntInfo[42][Int_X] = 2324.3999;//dom 44
    IntInfo[42][Int_Y] = -1147.5000;
    IntInfo[42][Int_Z] = 1050.7101;
    IntInfo[42][Int] = 12;
    IntInfo[42][Kategoria] = 5;
    IntInfo[42][Pokoje] = 11;
    IntInfo[42][Cena] = 40000000;
    //Kategoria 6 (pa�ace)
    IntInfo[43][Int_X] = 1263.1934814453;//dom 43 MADD DOG kategoria 8
    IntInfo[43][Int_Y] = -785.47039794922;
    IntInfo[43][Int_Z] = 1091.90625;
    IntInfo[43][Int] = 5;
    IntInfo[43][Kategoria] = 6;
    IntInfo[43][Pokoje] = 15;
    IntInfo[43][Cena] = 100000000;
    IntInfo[44][Int_X] = 1298.8577880859;//dom 44 MADD DOGG kategoria 8
    IntInfo[44][Int_Y] = -794.06591796875;
    IntInfo[44][Int_Z] = 1084.0078125;
    IntInfo[44][Int] = 5;
    IntInfo[44][Kategoria] = 6;
    IntInfo[44][Pokoje] = 11;
    IntInfo[44][Cena] = 100000000;
    //Kategoria 7 (Inne)
    IntInfo[45][Int_X] = 744.2455;//dom 45 PORNODOM
    IntInfo[45][Int_Y] = 1437.2065;
    IntInfo[45][Int_Z] = 1102.7031;
    IntInfo[45][Int] = 6;
    IntInfo[45][Kategoria] = 7;
    IntInfo[45][Pokoje] = 4;
    IntInfo[45][Cena] = 10000000;
    IntInfo[46][Int_X] = 2526.3950;//dom 3 ZBUGOWANY PRZESWIT
    IntInfo[46][Int_Y] = -1679.4390;
    IntInfo[46][Int_Z] = 1015.498;
    IntInfo[46][Int] = 1;
    IntInfo[46][Kategoria] = 7;
    IntInfo[46][Pokoje] = 4;
    IntInfo[46][Cena] = 5000000;

    IntInfo[47][Int_X] = 1284.1958;//WO�P
    IntInfo[47][Int_Y] = -810.7264;
    IntInfo[47][Int_Z] = 109.1989;
    IntInfo[47][Int] = 0;
    IntInfo[47][Kategoria] = 5;
    IntInfo[47][Pokoje] = 7;
    IntInfo[47][Cena] = 40000000;

    IntInfo[48][Int_X] = 2149.0562;//Julia 1 - �adny
    IntInfo[48][Int_Y] = -1322.0059;
    IntInfo[48][Int_Z] = 25.8396;
    IntInfo[48][Int] = 1188;
    IntInfo[48][Kategoria] = 4;
    IntInfo[48][Pokoje] = 2;
    IntInfo[48][Cena] = 10000000;

    IntInfo[49][Int_X] = 2150.1968;//Julia 2 - �adny ma�y
    IntInfo[49][Int_Y] = -1283.3784;
    IntInfo[49][Int_Z] = 24.2428;
    IntInfo[49][Int] = 1188;
    IntInfo[49][Kategoria] = 4;
    IntInfo[49][Pokoje] = 2;
    IntInfo[49][Cena] = 10000000;

    IntInfo[50][Int_X] = 2126.7422;//Julia 3 - dwupi�trowy
    IntInfo[50][Int_Y] = -1320.4714;
    IntInfo[50][Int_Z] = 26.6311;
    IntInfo[50][Int] = 1188;
    IntInfo[50][Kategoria] = 4;
    IntInfo[50][Pokoje] = 4;
    IntInfo[50][Cena] = 20000000;

    IntInfo[51][Int_X] = 2131.7869;//Julia 4 - �adny
    IntInfo[51][Int_Y] = -1278.2720;
    IntInfo[51][Int_Z] = 26.0321;
    IntInfo[51][Int] = 1188;
    IntInfo[51][Kategoria] = 4;
    IntInfo[51][Pokoje] = 3;
    IntInfo[51][Cena] = 10000000;

    IntInfo[52][Int_X] = 2099.9829;//Julia 5 - czarny elegancki
    IntInfo[52][Int_Y] = -1324.0430;
    IntInfo[52][Int_Z] = 26.6471;
    IntInfo[52][Int] = 1188;
    IntInfo[52][Kategoria] = 4;
    IntInfo[52][Pokoje] = 1;
    IntInfo[52][Cena] = 10000000;

    IntInfo[53][Int_X] = 2091.5286;//Julia 6 - �adny
    IntInfo[53][Int_Y] = -1276.3370;
    IntInfo[53][Int_Z] = 26.1449;
    IntInfo[53][Int] = 1188;
    IntInfo[53][Kategoria] = 4;
    IntInfo[53][Pokoje] = 2;
    IntInfo[53][Cena] = 10000000;
    return 1;
}

//-----------------------[chaty]------------------------------

BroadCast(color,const string[])
{
	SendClientMessageToAll(color, string);
	return 1;
}

ABroadCast(color,const string[],level, podglad = 0)
{
	foreach(new i : Player)
	{
		
		if(IsPlayerConnected(i))
		{
			if(podglad == 0)
			{
				if (PlayerInfo[i][pAdmin] >= level)
				{
					SendClientMessage(i, color, string);
				}
				else if (PlayerInfo[i][pNewAP] >= level)
				{
					SendClientMessage(i, color, string);
				}
				else if (PlayerInfo[i][pZG] >= level)
				{
					SendClientMessage(i, color, string);
				}
			}
			else
			{
				if (PlayerInfo[i][pAdmin] >= level && TogPodglad[i] == 0)
				{
					SendClientMessage(i, color, string);
				}
				else if (PlayerInfo[i][pNewAP] >= level && TogPodglad[i] == 0)
				{
					SendClientMessage(i, color, string);
				}	
			}
		}
	}
	printf("%s", string);
	return 1;
}

OOCOff(color,const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gOoc[i])
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

OOCNewbie(const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gNewbie[i] && GetPVarInt(i, "TOG_newbie") == 0 && PlayerPersonalization[i][PERS_NEWBIE] == 0)
		    {
				SendClientMessage(i, 0x8D8DFF00, string);
			}
		}
	}
}

/*OOCOgloszenie(color,const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gOgloszenie[i])
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}*/

OOCNews(color,const string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gNews[i] && PlayerPersonalization[i][PERS_AD] == 0)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}


SendNews_2(const txdString[])
{
	foreach(new i : Player)
	{
		if(!gNews[i] && PlayerPersonalization[i][PERS_AD] == 0)
		{
			PlayerTextDrawSetString(i, SN_MESS[i], txdString);
			PlayerTextDrawShow(i, SN_MESS[i]); 	
		}
	}
}

SendTeamMessage(team, color, string[], isDepo = 0)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pMember] == team || PlayerInfo[i][pLider] == team)
		    {
		    	if(isDepo == 1 && gMuteDepo[i] == 0) 
                {
                    SendClientMessage(i, color, string);
                }
              	if(isDepo == 0) {
              		SendClientMessage(i, color, string);
              	}
				//SendClientMessage(i, color, string);
			}
		}
	}
}
SendTeamMessageOnDuty(team, color, string[], bool:isBW = false)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if((PlayerInfo[i][pMember] == team || PlayerInfo[i][pLider] == team) && (OnDuty[i] == 1 || JobDuty[i] == 1))
		    {
				if(isBW == true)
				{
					if(gBW[i] == 0) SendClientMessage(i, color, string);
				}
				else
				{
              		SendClientMessage(i, color, string);
				}
			}
		}
	}
}

PlayCrimeReportForPlayersTeam(team, suspectid, level = 16)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pMember] == team || PlayerInfo[i][pLider] == team)
		    {
		    	PlayCrimeReportForPlayer(i, suspectid, level);
			}
		}
	}
}

SendRadioMessage(member, color, string[], ooc = 0)
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pMember] == member || PlayerInfo[i][pLider] == member)
		    {
		        if(member == 9 && SanDuty[i] == 1)
		        {
		            SendClientMessage(i, color, string);
				}
				else
				{
					if(gRO[i] == 1 && ooc == 1) continue;
				    SendClientMessage(i, color, string);
				}
			}
		}
	}
}

SendLeaderRadioMessage(member, color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pLider] == member)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendJobMessage(job, color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pJob] == job)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}


GetPlayerIDFromName(playerName[])
{
	foreach(new i : Player)
	{
		if(strcmp(GetNick(i), playerName, false, strlen(playerName)) == 0)
		{
			return i; 
		}
	}
	return INVALID_PLAYER_ID; 
}
WyscigMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(ScigaSie[i] != 666)
		{
			SendClientMessage(i, color, string);
		}
	}
}

SendFamilyMessage(family, color, string[], onduty = false)
{
	#pragma unused onduty
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pMember] == family || PlayerInfo[i][pLider] == family)
		    {
                if(!gFam[i])
                {
					/*if(onduty) 
					{
						if(OnDuty[i] == 1 || OnDutyCD[i] == 1) SendClientMessage(i, color, string);
					}
					else
					{*/
						SendClientMessage(i, color, string);
					//}
				}
			}
		}
	}
}

SendIRCMessage(channel, color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayersChannel[i] == channel)
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendSMSMessageToAll(senderNumber, message[])
{
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pPnumber] != 0)
		{
			SendSMSMessage(senderNumber, i, message);
		}
	}
}

SendSMSMessage(senderNumber, reciverid, message[])
{
	new string[144], string2[144];
	
	new slotKontaktu = PobierzSlotKontaktuPoNumerze(reciverid, senderNumber);
	if(strlen(message) < 78)
	{
		if(slotKontaktu >= 0)
		{
			format(string, sizeof(string), "SMS: %s, Nadawca: %s (%d)", message, Kontakty[reciverid][slotKontaktu][eNazwa], senderNumber);
		}
		else
		{
			format(string, sizeof(string), "SMS: %s, Nadawca: %d", message, senderNumber);
		}
		SendClientMessage(reciverid, COLOR_YELLOW, string);
	}
	else
	{
		new pos = strfind(message, " ", true, strlen(message) / 2);
		if(pos != -1)
		{
			new text2[64], text[128];
			strmid(text2, text, pos, strlen(text));
			strdel(text, pos, strlen(text));

			if(slotKontaktu >= 0)
			{
				format(string2, sizeof(string2), "[.] %s, Nadawca: %s (%d)", text2, Kontakty[reciverid][slotKontaktu][eNazwa], senderNumber);
			}
			else
			{
				format(string2, sizeof(string2), "[.] %s, Nadawca: %d", text2, senderNumber);
			}

			format(string, sizeof(string), "SMS: %s [.]", text);
			SendClientMessage(reciverid, COLOR_YELLOW, string);
			SendClientMessage(reciverid, COLOR_YELLOW, string2);
		}
	}

	PlayerPlaySound(reciverid, 6401, 0.0, 0.0, 0.0);
	LastSMSNumber[reciverid] = senderNumber;
}

StartACall(playerid, reciverid)
{
	Mobile[playerid] = reciverid;
	Mobile[reciverid] = playerid;
	
	RingTone[reciverid] = 1;
	CellTime[playerid] = 1;
}

StopACall(playerid)
{
	new reciverid = Mobile[playerid];
	StopACallForPlayer(playerid);
	
	new payer = playerid;
	if(reciverid >= 0)
	{
		StopACallForPlayer(reciverid);
		if(CellTime[reciverid] != 0) 
		{
			payer = reciverid;
		}
		
		if(TalkingLive[playerid] == reciverid)
		{
			TalkingLive[playerid] = INVALID_PLAYER_ID;
			TalkingLive[reciverid] = INVALID_PLAYER_ID;
		}
	}
	
	if(CellTime[payer] != 0)
	{
		new string[64];
		new cost = CellTime[payer] * callcost;
		ZabierzKase(payer, cost);
		CellTime[payer] = 0;
		format(string, sizeof(string), "~w~Koszt rozmowy: ~n~~r~$%d", cost);
		GameTextForPlayer(payer, string, 5000, 1);
	}
	
}

StopACallForPlayer(playerid)
{
	Mobile[playerid] = INVALID_PLAYER_ID;
	RingTone[playerid] = 0;
	Callin[playerid] = CALL_NONE;
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_NONE);
}

CzyGraczMaKontakty(playerid)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] != 0)
		{
			return 1;
		}
	}
	return 0;
}

PobierzSlotKontaktuPoNumerze(playerid, numer)
{
	if(numer <= 0)
	{
		return -1;
	}

	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == numer)
		{
			return i;
		}
	}
	return -1;
}

ListaKontaktowGracza(playerid)
{
	new string[58*MAX_KONTAKTY];
	
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == 0)
		{
			continue;
		}
		
		if(FindPlayerByNumber(Kontakty[playerid][i][eNumer]) != INVALID_PLAYER_ID)
		{
			//aktywny
			format(string, sizeof(string), "{FFFFFF}%s%s - %d {00FF00}(on-line)\n", string, Kontakty[playerid][i][eNazwa], Kontakty[playerid][i][eNumer]);
		}
		else
		{
			//nieaktywny
			format(string, sizeof(string), "{FFFFFF}%s%s - %d {FF0000}(off-line)\n", string, Kontakty[playerid][i][eNazwa], Kontakty[playerid][i][eNumer]);
		}
	}
	
	safe_return string;
}


PobierzWolnySlotNaKontakt(playerid)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == 0)
		{
			return i;
		}
	}
	return -1; //error
}

CzyMaWolnySlotNaKontakt(playerid)
{
	return PobierzWolnySlotNaKontakt(playerid) != -1;
}

CzyKontaktIstnieje(playerid, numer)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] == numer)
		{
			return true;
		}
	}
	return false;
}

DodajKontakt(playerid, nazwa[], numer)
{
	new slot = PobierzWolnySlotNaKontakt(playerid);
	if(slot == -1) return 0; //error
	format(Kontakty[playerid][slot][eNazwa], MAX_KONTAKT_NAME, "%s", nazwa);
	Kontakty[playerid][slot][eNumer] = numer;
	Kontakty[playerid][slot][eUID] = MruMySQL_AddPhoneContact(playerid, nazwa, numer);
	return 1;
}

EdytujKontakt(playerid, slot, nazwa[])
{
	format(Kontakty[playerid][slot][eNazwa], MAX_KONTAKT_NAME, "%s", nazwa);
	MruMySQL_EditPhoneContact(Kontakty[playerid][slot][eUID], nazwa);
	return 1;
}

UsunKontakt(playerid, slot)
{
	MruMySQL_DeletePhoneContact(Kontakty[playerid][slot][eUID]);
	
	Kontakty[playerid][slot][eUID] = 0;
	format(Kontakty[playerid][slot][eNazwa], MAX_KONTAKT_NAME, "%s", "");
	Kontakty[playerid][slot][eNumer] = 0;
	return 1;
}

PobierzIdKontaktuZDialogu(playerid, listitem)
{
	new count = listitem+1;
	for(new i; i<MAX_KONTAKTY; i++)
	{
		if(Kontakty[playerid][i][eNumer] != 0)
		{
			count--;
		}
		if(count == 0)
		{
			return i;
		}
	}
	return -1;
}

ZerujKontakty(playerid)
{
	for(new i; i<MAX_KONTAKTY; i++)
	{
		Kontakty[playerid][i][eUID] = 0;
		Kontakty[playerid][i][eNumer] = 0;
	}
}

SendAdminMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1 || IsAScripter(i))
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

SendCommandLogMessage(string[])
{
	foreach(new i : Player)
	{
	    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1 || IsAScripter(i))
	    {
			if(GetPVarInt(i, "togcmdlog") == 0) SendClientMessage(i, 0xD8C173FF, string);
		}
	}
}

SendPunishMessage(string[], playerid=INVALID_PLAYER_ID)
{
	foreach(new i : Player)
	{
		if(GetPVarInt(i, "togadmincmd") == 0) SendClientMessage(i, COLOR_LIGHTRED, string);
        else if(playerid == i) SendClientMessage(i, COLOR_LIGHTRED, string);
	}
}

SendZGMessage(color, string[])
{
	foreach(new i : Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(PlayerInfo[i][pAdmin] >= 1 || PlayerInfo[i][pNewAP] >= 1 || PlayerInfo[i][pZG] >= 1 || IsAScripter(i))
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

//-----------------------[koniec chaty]------------------------------
AddCar(car, model = -1, col1 = -1, col2 = 1, respawnDelay = -1)
{
	if(col1 == -1)
	{
		col1 = random(126);
	}
	if(model == -1)
	{
		new randomModelIdx = GetRandomStealableVehModel();
		model = RandCars[randomModelIdx][0];
	}
	new id = AddStaticVehicleEx(model, CarSpawns[car][pos_x], CarSpawns[car][pos_y], CarSpawns[car][pos_z], CarSpawns[car][z_angle], col1, col2, respawnDelay);
	return id;
}

ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		foreach(new i : Player)
		{
			if(IsPlayerConnected(i))
			{
				if(!BigEar[i])
				{
				    if(GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i))
				    {
						GetPlayerPos(i, posx, posy, posz);
						tempposx = (oldposx -posx);
						tempposy = (oldposy -posy);
						tempposz = (oldposz -posz);
						//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
						if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
						{
							SendClientMessage(i, col1, string);
						}
						else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
						{
							SendClientMessage(i, col2, string);
						}
						else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
						{
							SendClientMessage(i, col3, string);
						}
						else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
						{
							SendClientMessage(i, col4, string);
						}
						else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
						{
							SendClientMessage(i, col5, string);
						}
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}//not connected
	return 1;
}

PolicjantWStrefie(Float:radi, playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    foreach(new i : Player)
		{
		    new Float:rangex, Float:rangey, Float:rangez;
		    GetPlayerPos(playerid, rangex, rangey, rangez);
	    	if(IsPlayerInRangeOfPoint(i, radi, rangex, rangey, rangez))
	        {
	            if(IsAPolicja(i) && Spectate[i] == INVALID_PLAYER_ID && i != playerid)
	            {
	            	return 1;
	            }
	        }
	    }
	}
	return 0;
}

ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
	{
		if(Spectate[targetid] != INVALID_PLAYER_ID || Spectate[playerid] != INVALID_PLAYER_ID)
		{
			return 0; // admini na spec nie s� blisko
		}

		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		//radi = 2.0; //Trigger Radius
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

ProxDetectorW(Float:radi, Float:Pozy_X, Float:Pozy_Y, Float:Pozy_Z, ColorW, Wiadomosc[])
{
	new Float:Pozycja_Xx, Float:Pozycja_Yy, Float:Pozycja_Zz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	foreach(new i : Player)
	{
        GetPlayerPos(i, Pozycja_Xx, Pozycja_Yy, Pozycja_Zz);
        tempposx = (Pozycja_Xx - Pozy_X);
        tempposy = (Pozycja_Yy - Pozy_Y);
        tempposz = (Pozycja_Zz - Pozy_Z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
		    SendClientMessage(i, ColorW, Wiadomosc);
		}
	}
}

PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		if(IsPlayerInRangeOfPoint(playerid, radi, x, y, z))
		{
			return 1;
		}
	}
	return 0;
}

VehicleToPoint(Float:radi, vehicleid, Float:x, Float:y, Float:z)
{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetVehiclePos(vehicleid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
		return 0;
}
/* ========[STARA NIE U�YWANA FUNKCJA]========
IsVehicleInUse(vehicleid)
{
	new temp;
	foreach(new i : Player)
	{
		if(GetPlayerVehicleID(i)==vehicleid)
		{
			temp++;
		}
	}
	if(temp > 0)return true;
    else return false;
}

SetCamBack(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		new Float:plocx,Float:plocy,Float:plocz;
		GetPlayerPos(playerid, plocx, plocy, plocz);
		SetPlayerPos(playerid, -1863.15, -21.6598, 1060.15); // Warp the player
		SetPlayerInterior(playerid,14);
	}
}
*/
FixHour(hour)
{
	hour = timeshift+hour+1;
	if (hour < 0)
	{
		hour = hour+24;
	}
	else if (hour > 23)
	{
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}

stock ShowPlayerInfoDialog(playerid, caption[], info[], bool:dialogTimer=false)
{
	if(dialAccess[playerid] == 0)
	{
		ShowPlayerDialogEx(playerid, DIALOG_EMPTY_SC, DIALOG_STYLE_MSGBOX, caption, info, "Okej", "");
		if(dialogTimer == true)
		{
			dialTimer[playerid] = SetTimerEx("timerDialogs", 5000, true, "i", playerid);
			dialAccess[playerid] = 1; 
		}
	}
	else
	{
		sendErrorMessage(playerid, "Odczekaj 15 sekund przed wywo�aniem kolejnego dialogu"); 
	}
	return 1;
}
stock ShowPlayerDialogEx(playerid, dialogid, style, caption[], info[], button1[], button2[], bool:dialogTimer=false)
{
	if(dialAccess[playerid] == 0)
	{
		ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
		iddialog[playerid] = dialogid;
		antyHider[playerid] = 1;
		if(dialogTimer == true)
		{
			dialTimer[playerid] = SetTimerEx("timerDialogs", 5000, true, "i", playerid);
			dialAccess[playerid] = 1; 
		}
	}
	else
	{
		sendErrorMessage(playerid, "Odczekaj 15 sekund przed wywo�aniem kolejnego dialogu"); 
	}
	return 1;
}

SoundForAll(sound)
{
	for(new i = 0, j = MAX_PLAYERS; i < j; i ++)
		if (IsPlayerConnected(i))
			PlayerPlaySound(i,sound,0.0,0.0,0.0);
}

ListaWyscigow()
{
	new trasy[3000];
	for(new i=0; i<sizeof(Wyscig); i++)
	{
		if(Wyscig[i][wStworzony] == 1)
		{
			format(trasy, sizeof(trasy), "%s\n{7CFC00}Nazwa:{FFFFFF} %s\t{7CFC00}Wygrana:{FFFFFF} %d$", trasy, Wyscig[i][wNazwa], Wyscig[i][wNagroda]);
		}
		else
		{
			strcat(trasy, "{7CFC00}Nazwa:{FFFFFF} brak trasy\n");
		}
	}
	return trasy;
}

FunkcjaK(string[])
{
	new Float:x;
	new ilosc_k=0;

	if(strval(string) != 0 && strlen(string) > 1)
	{
		for(new i=strlen(string); i>0; i--)
		{
			if(string[i] == 'k')
				ilosc_k++;
            else if(string[i] == 'K')
				ilosc_k++;
		}
		if(ilosc_k != 0)
		{
			strdel(string, strlen(string)-ilosc_k, strlen(string));
			x=floatstr(string);
			return floatround((ilosc_k==1) ? (x*1000) : ((ilosc_k==2) ? (x*1000000) : (x*1000000000)), floatround_tozero); //zbugowane pot�gi: x*(1000^ilosc_k)
		}
	}
	return strval(string);
}

forward MUSIC_Response(index, response_code, data[]);
public MUSIC_Response(index, response_code, data[])
{
    if(index == 40)
    {
        if(response_code == 404)
        {
            strcat(AUDIO_LoginFormat, "mp3");
        }
        else strcat(AUDIO_LoginFormat, "ogg");
    }
    return 1;
}

timer StartLogin[100](playerid, sessionID)
{
	if(!IsPlayerConnected(playerid))
	{
		return 1;
	}

	if(SessionID[playerid] != sessionID)
	{
		return 1; // timer wywo�any przez innego gracza
	}

	if(LoggingIn[playerid] != 0)
	{
		return 1; // inny timer aktywuj�cy logowanie ju� zosta� wywo�any
	}
	LoggingIn[playerid] = 1;

    new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, MAX_PLAYER_NAME);

    TogglePlayerControllable(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    TogglePlayerControllable(playerid, 0);

	// Zwyk�a kamera w Los Santos
    //TourCamera(playerid, 0);
	// Kamera Vice City
	ViceCityTour(playerid, false);

	if(GetPVarInt(playerid, "IsDownloadingContent") == 1) DeletePVar(playerid, "IsDownloadingContent");
    //Strefy load
    ZonePTXD_Load(playerid);
    ZonePlayerTimer[playerid]=0;
    for(new j=0;j<MAX_ZONES;j++)
    {
        if(ZoneControl[j] > 100) GangZoneShowForPlayer(playerid, ZoneIDs[j], OrgInfo[clamp(ZoneControl[j]-100, 0, MAX_ORG-1)][o_Color] & 0xFFFFFF44);
        else GangZoneShowForPlayer(playerid, ZoneIDs[j], 0xC6E2F144);
    }

	SetPlayerHealth(playerid, 100);
	GUIExit[playerid] = 1;
	SafeTime[playerid] = 60*3;//ogarniczenie 3 minuty na logowanie
	SetPlayerColor(playerid,COLOR_GRAD2);

	LoadingHide(playerid);
	BottomBar(playerid, 1);
    new result;
    result = MruMySQL_DoesAccountExist(nick);
	//Sprawdzanie czy konto istnieje:
	if(result == -1 || result == 1) //logowanie
	{
        //Logowanie
		new string[256];
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na serwerze Mrucznik Role Play! Zaloguj si� aby rozpocz�� gr�.");
		format(string, sizeof(string), "Nick %s jest zarejestrowany.\nZaloguj si� wpisuj�c w okienko poni�ej has�o.\nJe�li nie znasz has�a do tego konta, wejd� pod innym nickiem", nick);
		ShowPlayerDialogEx(playerid, D_LOGIN, DIALOG_STYLE_PASSWORD, "Logowanie", string, "Zaloguj", "Wyjd�");
		gPlayerAccount[playerid] = 1; //logowanie
	}
    else if(result == -999)
    {
        new string[256];
		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na serwerze Mrucznik Role Play! Zaloguj si� aby rozpocz�� gr�.");
		format(string, sizeof(string), "Nick podobny do %s jest zarejestrowany.\n{FF0000}Podobny nick jest ju� w bazie, sprawd� wielkos� znak�w.", nick);
        SendClientMessage(playerid, COLOR_RED, string);
        SendClientMessage(playerid, COLOR_RED, string);
        SendClientMessage(playerid, COLOR_RED, string);
        KickEx(playerid, "zbyt podobny nick");
    }
	else //rejestracja
	{
        if(VAR_MySQLREGISTER)
        {
    		SendClientMessage(playerid, COLOR_YELLOW, "Witaj na serwerze Mrucznik Role Play! Zarejestruj swoje konto aby rozpocz�� gr�.");
    		ShowPlayerDialogEx(playerid, D_REGISTER, DIALOG_STYLE_INPUT, "Rejestracja konta", "Witaj. Aby zacz�� gr� na serwerze musisz si� zarejestrowa�.\nAby to zrobi� wpisz w okienko poni�ej has�o kt�re chcesz u�ywa� w swoim koncie.\nZapami�taj je gdy� b�dziesz musia� go u�ywa� za ka�dym razem kiedy wejdziesz na serwer", "Rejestruj", "Wyjd�");
    		gPlayerAccount[playerid] = 0;//rejestracja
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "Rejestracja zosta�a wy��czona na czas atak�w, przepraszamy za uniedogodnienia.");
            KickEx(playerid, "wy��czona rejestracja");
        }
	}
    return 1;
}

public NG_OpenGateWithKey(playerid)
{
    new ngstr[6];
    GetPVarString(playerid, "ng-key", ngstr, 6);
    if(strval(ngstr) == STANOWE_GATE_KEY)
    {
    	CancelSelectTextDraw(playerid);
        TextDrawHideForPlayer(playerid,NG_GateTD[0]);
		TextDrawHideForPlayer(playerid,NG_GateTD[1]);
		TextDrawHideForPlayer(playerid,NG_GateTD[2]);
		TextDrawHideForPlayer(playerid,NG_GateTD[3]);
		TextDrawHideForPlayer(playerid,NG_GateTD[4]);
		TextDrawHideForPlayer(playerid,NG_GateTD[5]);
		TextDrawHideForPlayer(playerid,NG_GateTD[6]);
		TextDrawHideForPlayer(playerid,NG_GateTD[7]);
	    /*if(moveng[11] == 0)
	    {
	        moveng[11] = 1;
	        MoveDynamicObject(bramkang[11],2720.24146, -2504.48486, 8.9220,3);
	    }
	    else
	    {
	        moveng[11] = 0;
	        MoveDynamicObject(bramkang[11],2720.24146, -2504.48486, 15.39000,3);
	    }*/
        VAR_NGKeypad = false;
    }
    else
    {
        SendClientMessage(playerid,-1,"Zle Haslo !!");
    }
    TextDrawSetString(NG_GateTD[7], "0000");
    DeletePVar(playerid, "ng-key");
	return 1;
}

UnFrakcja(playerid, para1, bool:respawn = true)
{
	new string[64];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];
	if (!GetPlayerFraction(playerid) && !GetPlayerOrg(playerid)) {
		MruMessageFail(playerid, "Gracz nie ma frakcji ani organizacji");
		return 1;
	}
	if(PlayerInfo[para1][pLider] > 0 && PlayerInfo[para1][pLiderValue] == 1)
	{
		SetPVarInt(playerid, "ID_LIDERA", para1);  
		ShowPlayerDialogEx(playerid, DIALOG_UNFRAKCJA, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play", sprintf("%s jest g��wnym liderem organizacji.\nCzy chcesz zwolni� WSZYSTKICH lider�w z organizacji?\n(Zabierze VLD)", GetNick(para1)), "Tak", "Nie"); 
		return 1;
	}
	GetPlayerName(para1, giveplayer, sizeof(giveplayer));
	GetPlayerName(playerid, sendername, sizeof(sendername));
	format(string, sizeof(string), "* Zosta�e� wyrzucony z frakcji przez %s.", sendername);
	SendClientMessage(para1, COLOR_LIGHTBLUE, string);
	SendClientMessage(para1, COLOR_LIGHTBLUE, "* Jeste� cywilem.");
	SetPlayerColor(para1,TEAM_HIT_COLOR);
	Log(adminLog, INFO, "Admin %s usun�� gracza %s z frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(para1), GetFractionLogName(PlayerInfo[para1][pMember]));
	PlayerInfo[para1][pMember] = 0;
	PlayerInfo[para1][pLider] = 0;
	PlayerInfo[para1][pJob] = 0;
	RemovePlayerFromOrg(para1);
	MedicBill[para1] = 0;
	if(respawn)
	{
		SetPlayerSpawn(para1);
	}
	else
	{
		SetPlayerSpawnSkin(playerid);
		SetPlayerSpawnWeapon(playerid);
	}
	format(string, sizeof(string), "  Wyrzuci�es %s z frakcji.", giveplayer);
	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	return 1;
}

OddajZycie(playerid, timevalue, const tekst[],  bool:tekstwyswietl = false)
{
	new Float:health;
	new timeobl;
	new string[128];
	timeobl = timevalue*1000;
	GetPlayerHealth(playerid, health);
	SetPVarFloat(playerid, "odnowaZyciaAdmin", health); 
	TimerOddaniaZycia[playerid] = SetTimerEx("OddajZycieTimer", timeobl, true, "i", playerid);
	SetPVarInt(playerid, "StatusZycia", timeobl);
	format(string, sizeof(string), "%s", tekst); 
	if(tekstwyswietl == true)
	{
		sendTipMessage(playerid, string); 
	}
	return 1;
}
//      Aktualizacja    09.06.2014  KUBI  fix 09 
ElevatorTravel(playerid, Float:x, Float:y, Float:z, vw, Float:face)
{
    if(LSMCElevatorQueue) return;
    LSMCElevatorQueue = true;
    ChangeLSMCElevatorState(); //close them?

    new Float:px, Float:py, Float:pz, pvw;
    GetPlayerPos(playerid, px, py, pz);
    pvw = GetPlayerVirtualWorld(playerid);

    if(!ElevatorVar) ElevatorVar=true;

    foreach(new i : Player)
    {
        if(pvw == GetPlayerVirtualWorld(i) && IsPlayerInRangeOfPoint(i, 2.0, px, py, pz))
        {
            SetPVarFloat(i, "ElX", x);
            SetPVarFloat(i, "ElY", y);
            SetPVarFloat(i, "ElZ", z);
            SetPVarFloat(i, "ElFace", face);
            SetPVarInt(i, "ElVW", vw);

            SetTimerEx("ElevatorTravelEND", 3500, 0, "i", i);
            GameTextForPlayer(i, "~r~Zamykanie windy", 3000, 5);
        }
    }
}

public ElevatorTravelEND(playerid)
{
    SetPlayerPos(playerid, GetPVarFloat(playerid, "ElX"),GetPVarFloat(playerid, "ElY"), GetPVarFloat(playerid, "ElZ"));
    SetPlayerFacingAngle(playerid,GetPVarFloat(playerid, "ElFace"));
    SetCameraBehindPlayer(playerid);
    SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "ElVW"));
    TogglePlayerControllable(playerid, false);
    GameTextForPlayer(playerid, "~g~Otwieranie windy", 1000, 5);
    Wchodzenie(playerid);
    PlayerPlaySound(playerid, 6401, 0.0, 0.0, 0.0);
    //Release doors
    if(ElevatorVar)
    {
        ElevatorVar=false;
        ChangeLSMCElevatorState(); //open again
        SetTimer("LSMCElevatorFree", 3000, 0);
    }
    return 1;
}

public LSMCElevatorFree()
{
    LSMCElevatorQueue = false;
    return 1;
}

ChangeLSMCElevatorState()
{
    for(new i=0;i<8;i++)
    {
        if(ElevatorObject[i] == 0)  break;
        if(ElevatorDoorsState[i]) //close them
        {
            if(floatround(ElevatorDoors[i][3]) == 90)
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
            }
            else
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0],ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
            }
            ElevatorDoorsState[i] = false;
        }
        else //open them
        {
            if(floatround(ElevatorDoors[i][3]) == 90)
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0]+1.7,ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0]-1.7,ElevatorDoors[i][1],ElevatorDoors[i][2], 1.0);
            }
            else
            {
                MoveDynamicObject(ElevatorObject[i],ElevatorDoors[i][0],ElevatorDoors[i][1]-1.7,ElevatorDoors[i][2], 1.0);
                MoveDynamicObject(ElevatorObject[i]+1,ElevatorDoors[i][0],ElevatorDoors[i][1]+1.7,ElevatorDoors[i][2], 1.0);
            }
            ElevatorDoorsState[i] = true;
        }
    }
}

LoadServerInfo()
{
    ServerInfo="\0";
    mysql_query("SELECT `info` FROM `mru_serverinfo` WHERE `aktywne`=1 LIMIT 1");
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(ServerInfo, "|");
        new lPos=0;
        while((lPos = strfind(ServerInfo, "\\n", false, lPos)) != -1)
        {
            strdel(ServerInfo, lPos, lPos+2);
            strins(ServerInfo, "\n", lPos);
            lPos++;
        }
        lPos=0;
        while((lPos = strfind(ServerInfo, "\\t", false, lPos)) != -1)
        {
            strdel(ServerInfo, lPos, lPos+2);
            strins(ServerInfo, "\t", lPos);
            lPos++;
        }
        foreach(new i : Player)
        {
            if(gPlayerLogged[i] == 1) TextDrawShowForPlayer(i, TXD_Info);
        }
    }
	mysql_free_result();
}

LoadConfig()
{
    new query[1024], data[256];
    mysql_query("SELECT * FROM `mru_config`");
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(query, "|");
        sscanf(query, "p<|>s[128]s[128]dds[256]dd", RadioSANUno, RadioSANDos, ZONE_DISABLED, ZONE_DEF_TIME, data, STANOWE_GATE_KEY, TJD_Materials);
        sscanf(data, "a<s[16]>[20]", AUDIO_LoginData);
    }
	mysql_free_result();
    for(new i=0;i<20;i++)
    {
        if(strlen(AUDIO_LoginData[i]) > 1) AUDIO_LoginTotal++;
        else break;
    }

    format(data, 256, "mrucznik-loginsound.lqs.pl/game/audio/%s.ogg", AUDIO_LoginData[0]);

    format(VINYL_Stream, 128, "%s",RadioSANDos);

    print("Wczytano podstawow� konfiguracj�");
}

WordWrap(source[], bool:spaces, dest[], size = sizeof(dest), chars = 30)
{
    new length = strlen(source);

    strcat((dest[0] = '\0', dest), source, size);

    if (length <= 0)
        return 0;

    while (--length != 0) if ((length % chars) == 0)
    {
        if (!spaces) {
            strins(dest, "\r\n", length, size);
        }
        else for(new i = length; dest[i] != '\0'; i ++) if (dest[i] == ' ' && dest[i + 1] != '\r') {
            strins(dest, "\r\n", i + 1, size); break;
        }
    }
    return 1;
}

stock wordwrapEx(givenString[128])
{
	new temporalString[ 128 ];
	memcpy(temporalString, givenString, 0, 128 * 4);

	new comaPosition = strfind(temporalString, ",", true, 0),
		dotPosition  = strfind(temporalString, ".", true, 0);
	while(comaPosition != -1)
	{
		if(temporalString[comaPosition+1] != ' ') strins(temporalString, " ", comaPosition + 1);
		comaPosition = strfind(temporalString, ",", true, comaPosition + 1);
	}
	while(dotPosition != -1)
	{
		if(temporalString[dotPosition+1] != ' ') strins(temporalString, " ", dotPosition + 1);
		dotPosition = strfind(temporalString, ",", true, dotPosition + 1);
	}

	new spaceCounter = 0,
		spacePosition = strfind(temporalString, " ", true, 0);

	while(spacePosition != -1)
	{
		spaceCounter++;
		if(spaceCounter % 4 == 0 && spaceCounter != 0)
		{
			strins(temporalString, "\n", spacePosition + 1);
		}
		spacePosition = strfind(temporalString, " ", true, spacePosition + 1);
	}
	return temporalString;
}

//Sjefy
Sejf_Add(frakcja, kasa)
{
    Sejf_Frakcji[frakcja]+=kasa;
    Sejf_Save(frakcja);
	Log(sejfLog, INFO, "SEJF FRAKCJA [%d] + [%d] - poprzednio [%d]", frakcja, kasa, Sejf_Frakcji[frakcja]);
}

SejfR_Add(frakcja, kasa)
{
    Sejf_Rodziny[frakcja]+=kasa;
    SejfR_Save(frakcja);
    Log(sejfLog, INFO, "SEJF RODZINA [%d] + [%d] - poprzednio [%d]", frakcja, kasa, Sejf_Rodziny[frakcja]);
}

Sejf_AddMats(frakcja, mats)
{
    Frakcja_Mats[frakcja]+=mats;
    Sejf_Save(frakcja);
	Log(sejfLog, INFO, "SEJF MATS FRAKCJA [%d] + [%d] - poprzednio [%d]", frakcja, mats, Frakcja_Mats[frakcja]);
}

SejfR_AddMats(frakcja, mats)
{
    Rodzina_Mats[frakcja]+=mats;
    SejfR_Save(frakcja);
    Log(sejfLog, INFO, "SEJF MATS RODZINA [%d] + [%d] - poprzednio [%d]", frakcja, mats, Rodzina_Mats[frakcja]);
}

SejfR_AddContraband(frakcja, contraband)
{
    Rodzina_Contraband[frakcja]+=contraband;
    SejfR_Save(frakcja);
    Log(sejfLog, INFO, "SEJF KONTRABANDA RODZINA [%d] + [%d] - poprzednio [%d]", frakcja, contraband, Rodzina_Contraband[frakcja]);
}

Sejf_Save(frakcja)
{
    if(!SafeLoaded) return;
    new query[128];
    format(query, 128, "UPDATE `mru_sejfy` SET `kasa`=%d, `mats`=%d WHERE `ID`=%d AND `typ`=1", Sejf_Frakcji[frakcja], Frakcja_Mats[frakcja], frakcja);
    mysql_query(query);
}

SejfR_Save(frakcja)
{
    if(!SafeLoaded) return;
    new query[128];
    format(query, 128, "UPDATE `mru_sejfy` SET `kasa`=%d, `mats`=%d, `contraband`=%d WHERE `ID`=%d AND `typ`=2", 
		Sejf_Rodziny[frakcja], Rodzina_Mats[frakcja], Rodzina_Contraband[frakcja], frakcja);
    mysql_query(query);
}

SejfR_Show(playerid) {
	ShowPlayerDialogEx(playerid, 495, DIALOG_STYLE_LIST, "Sejf organizacji", "Stan\nWyp�a�\nWp�a�\nWyjmij materia�y\nSchowaj materia�y\nWyjmij kontraband�\nSchowaj kontraband�", "Wybierz", "Wyjd�");
}

Sejf_Load()
{
    new query[128], id, typ, kasa, mats, contraband, bool:validF[MAX_FRAC]={false,...}, bool:validR[MAX_ORG]={false,...};
    mysql_query("SELECT `ID`, `typ`, `kasa`, `mats`, `contraband` FROM `mru_sejfy`");
    mysql_store_result();
    while(mysql_fetch_row_format(query, "|"))
    {
        sscanf(query, "p<|>ddddd", id, typ, kasa, mats, contraband);
        if(typ == 1) Sejf_Frakcji[id] = kasa, Frakcja_Mats[id] = mats, validF[id] = true;
        else if(typ == 2) Sejf_Rodziny[id] = kasa, Rodzina_Mats[id] = mats, Rodzina_Contraband[id] = contraband, validR[id] = true;
        SafeLoaded = true;
    }
    mysql_free_result();
}


IsNickCorrect(nick[])
{
	if(regex_match(nick, NICK_REGEX) >= 0)
	{
		return 1;
	}
	return 0;
}

CheckAlfaNumeric(password[])
{
    new charsets[46] = "0123456789a�bc�de�fghijkl�mn�o�prs�tuvwyz��xq";

    new bool:validchars[64]={false,...};

    new bool:doeschange=false;
    for(new i=0;i<strlen(password);i++)
    {
        for(new a=0;a<46;a++)
        {
            if(tolower(password[i]) == charsets[a]) validchars[i] = true;
        }
        if(!validchars[i]) //!alpha
        {
            password[i] = charsets[random(sizeof(charsets))];
            if(!doeschange) doeschange=true;
        }
    }
    return doeschange;
}

/*stock NameValidator(playerid)
{
    new pname[MAX_PLAYER_NAME],underline=0;
    GetPlayerName(playerid, pname, sizeof(pname));
    if(strfind(pname,"[",true) != (-1)) return 0;
    else if(strfind(pname,"]",true) != (-1)) return 0;
    else if(strfind(pname,"$",true) != (-1)) return 0;
    else if(strfind(pname,"(",true) != (-1)) return 0;
    else if(strfind(pname,")",true) != (-1)) return 0;
    else if(strfind(pname,"=",true) != (-1)) return 0;
    else if(strfind(pname,"@",true) != (-1)) return 0;
    else if(strfind(pname,"1",true) != (-1)) return 0;
    else if(strfind(pname,"2",true) != (-1)) return 0;
    else if(strfind(pname,"3",true) != (-1)) return 0;
    else if(strfind(pname,"4",true) != (-1)) return 0;
    else if(strfind(pname,"5",true) != (-1)) return 0;
    else if(strfind(pname,"6",true) != (-1)) return 0;
    else if(strfind(pname,"7",true) != (-1)) return 0;
    else if(strfind(pname,"8",true) != (-1)) return 0;
    else if(strfind(pname,"9",true) != (-1)) return 0;
    new maxname = strlen(pname);
    for(new i=0; i<maxname; i++)
    {
       if(pname[i] == '_') underline ++;
    }
    if(!(0 < underline < 3)) return 0;
    if(pname[0] == '_')  //Nick typu _Name_
    {
        if(underline != 2) return 0;
        if(pname[maxname-1] != '_') return 0;
        pname[1] = toupper(pname[1]);
        for(new x=2; x<maxname-1; x++)
        {
            if(pname[x] != '_' && pname[x-1] != '_') pname[x] = tolower(pname[x]);
        }
    }
    else //Nicki typu Name_Surname lub Name_Second_Surname
    {
        pname[0] = toupper(pname[0]);
        for(new x=1; x<maxname; x++)
        {
            if(pname[x] == '_') pname[x+1] = toupper(pname[x+1]);
            else if(pname[x] != '_' && pname[x-1] != '_') pname[x] = tolower(pname[x]);
        }
    }
    SetPlayerName(playerid, "Fix_Name");
    SetPlayerName(playerid, pname);
    return 1;
}*/

GetVehicleMaxPassengers(iModel) //RydeR
{
    if(400 <= iModel <= 611)
    {
        static
            s_MaxPassengers[] =
            {
                271782163, 288428337, 288559891, -2146225407, 327282960, 271651075, 268443408, 286339857, 319894289, 823136512, 805311233,
                285414161, 286331697, 268513553, 18026752, 286331152, 286261297, 286458129, 856765201, 286331137, 856690995, 269484528,
                51589393, -15658689, 322109713, -15527663, 65343
            }
        ;
        return ((s_MaxPassengers[(iModel -= 400) >>> 3] >>> ((iModel & 7) << 2)) & 0xF);
    }
    return 0xF;
}

issafefortextdraw(str[]) { //JerneL

	new safetil = -5;

	for(new i = 0; i < strlen(str); i++) {

		if ((str[i] == 126) && (i > safetil)) {

			if (i >= strlen(str) - 1) // not enough room for the tag to end at all.
				return false;

			if (str[i + 1] == 126)
				return false; // a tilde following a tilde.

			if (str[i + 2] != 126)
				return false; // a tilde not followed by another tilde after 2 chars

			safetil = i + 2; // tilde tag was verified as safe, ignore anything up to this location from further checks (otherwise it'll report tag end tilde as improperly started tag..).
		}
	}

	return true;
}

//Kubi AIRLINES system TOWER manager 3D

Render_Smart3D(playerid, vehicleid, Float:x, Float:y, Float:z)
{
    z = (80.4125) - ((y+2297.7136 +250.0)/600);
    y=-2297.7136;
    x = (1627.3287)-((1627.3287-x +100.0)/600);

    new str[32];
    format(str, 32, ".\n%d-%s", vehicleid, VehicleNames[GetVehicleModel(vehicleid)-400]);
    TOWER_TrafficHologram[playerid][vehicleid] = CreatePlayer3DTextLabel(playerid, str, 0xFF0000FF, x, y, z, 8.0);
}

AirTower3DDelete(playerid)
{
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if(_:TOWER_TrafficHologram[playerid][i] != 0)
        {
            DeletePlayer3DTextLabel(playerid, TOWER_TrafficHologram[playerid][i]);
            TOWER_TrafficHologram[playerid][i]=PlayerText3D:0;
        }
    }
}

public INT_AirTower_RadarLoop(playerid)
{
    if(TOWER_ActivePlayers <= 0) return;
    AirTower3DDelete(playerid);
    new Float:x, Float:y, Float:z;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if(!IsAPlane(i)) continue;
        GetVehiclePos(i, x, y, z);
        if(VectorSize(x-1671.0825,y+2538.0308,z-13.5469) < 1500.0)
        {
            if(GetCarSpeed(i) > 2) //moving somewhere
            {
                Render_Smart3D(playerid, i, x, y, z);
            }
        }
    }
}

INT_AirTower_RadarInit(playerid) //first step
{
    TOWER_PlayerHologram[playerid] = CreatePlayer3DTextLabel(playerid, "=========================================\n=                                                                                |\n=========================================\n\n\n\n\n                          TOWER", 0xFFFF00FF, 1627.3287, -2297.7136, 80.4125, 8.0);

    INT_AirTower_RadarLoop(playerid);
    TOWET_LoopTimer[playerid] = SetTimerEx("INT_AirTower_RadarLoop", 1000, 1, "i", playerid);
}

INT_AirTower_RadarExit(playerid)
{
    DeletePlayer3DTextLabel(playerid, TOWER_PlayerHologram[playerid]);
    AirTower3DDelete(playerid);
}

public TRAIN_DoHorn(veh)
{
    new Float:x, Float:y, Float:z;
    GetVehiclePos(veh, x, y,z);
    new Float:angle, Float:ix, Float:iy, Float:iz, Float:dist;
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerInRangeOfPoint(i, 100.0, x, y, z))
        {
            SetPVarInt(i, "train-horn", 1);
            GetPlayerPos(i, ix, iy, iz);
            dist = VectorSize(ix-x, iy-y, iz-z);
            if(dist > 18.0)
            {
                dist = dist - (floatsqroot(dist)*1.5);
                angle = 180.0-atan2(x-ix,y-iy);
                x+=dist*floatsin(-angle, degrees);
                y+=dist*floatcos(-angle, degrees);
                PlayerPlaySound(i, 9200, x, y, z);
            }
            else if(dist < 1.5)
            {
                PlayerPlaySound(i, 9200, 0.0, 0.0, 0.0);
            }
        }
        else if(GetPVarInt(i, "train-horn") == 1)
        {
            PlayerPlaySound(i, 8199, 0.0, 0.0, 0.0);
            SetPVarInt(i, "train-horn", 0);
        }
    }
}

//BLINK

SetCarBlinking(veh, side, bool:skip=false) //0 - left 1 - right 2 - emergy
{
    if(IsCarBlinking(veh) && !skip) return DisableCarBlinking(veh);
    new model=GetVehicleModel(veh),obj[4];
    new id = model-400, trailer;

    if(!skip) BlinkSide[veh] = side;

    GetVehicleZAngle(veh, BlinkR[veh]);

    if(id > -1)
    {
        if(BlinkOffset[id][bX] != 0.0)
        {
            if(side == 0)
            {
                obj[0] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //blink yellow  front
                Blink[veh][0] = obj[0];
            }
            else
            {
                obj[2] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                Blink[veh][2] = obj[2];
            }
        }
        if((trailer = GetVehicleTrailer(veh)) != 0)
        {
            if(B_IsTrailer(trailer))
            {
                if(side == 0)
                {
                    obj[1] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //blink yellow back truck only trailer
                    Blink[veh][1] = obj[1];
                }
                else
                {
                    obj[3] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                    Blink[veh][3] = obj[3];
                }
            }
        }
        else
        {
            if(BlinkOffset[id][brX] != 0.0)
            {
                if(side == 0)
                {
                    obj[1] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0); //blink yellow back truck only trailer
                    Blink[veh][1] = obj[1];
                }
                else
                {
                    obj[3] = CreateDynamicObject(19294, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
                    Blink[veh][3] = obj[3];
                }
            }
        }

        if(side == 0) //left
        {
            if(obj[0] != 0) AttachDynamicObjectToVehicle(obj[0], veh, BlinkOffset[id][bX],BlinkOffset[id][bY],BlinkOffset[id][bZ], 0.0, 0.0, 0.0);
            if(trailer != 0)
            {
                id = GetVehicleModel(trailer)-400;
                AttachDynamicObjectToVehicle(obj[1], trailer, BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
            else
            {
                if(obj[1] != 0) AttachDynamicObjectToVehicle(obj[1], veh, BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
        }
        else if(side == 1) //right
        {
            if(obj[2] != 0) AttachDynamicObjectToVehicle(obj[2], veh, -BlinkOffset[id][bX],BlinkOffset[id][bY],BlinkOffset[id][bZ], 0.0, 0.0, 0.0);
            if(trailer != 0)
            {
                id = GetVehicleModel(trailer)-400;
                AttachDynamicObjectToVehicle(obj[3], trailer, -BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
            else
            {
                if(obj[3] != 0) AttachDynamicObjectToVehicle(obj[3], veh, -BlinkOffset[id][brX],BlinkOffset[id][brY],BlinkOffset[id][brZ], 0.0, 0.0, 0.0);
            }
        }
        else if(side == 2)  //emergency
        {
            SetCarBlinking(veh, 0, true);
            SetCarBlinking(veh, 1, true);
        }
    }
	return 1;
}

public B_DisableBlinks(vehicleid)
{
    for(new i=0;i<4;i++)
    {
    	if(Blink[vehicleid][i] != -1) DestroyDynamicObject(Blink[vehicleid][i]);
    	Blink[vehicleid][i] = -1;
    }
    return 1;
}

DisableCarBlinking(veh)
{
	if(!IsCarBlinking(veh)) return 1;
    B_DisableBlinks(veh);
	return 1;
}

IsCarBlinking(vehicleid)
{
    if((BlinkSide[vehicleid] == 0 && Blink[vehicleid][0] == -1 && Blink[vehicleid][1] == -1) || (BlinkSide[vehicleid] == 1 && Blink[vehicleid][2] == -1 && Blink[vehicleid][3] == -1)) return 0;
    else if(Blink[vehicleid][0] == -1 && Blink[vehicleid][1] == -1 && Blink[vehicleid][2] == -1 && Blink[vehicleid][3] == -1) return 0;
    return 1;
}

B_IsTrailer(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 435, 450, 584, 591, 606: return 1;
    }
    return 0;
}

public B_OnTrailerDetached(trailerid, fromvehicleid)
{
    if(IsCarBlinking(fromvehicleid))
    {
        DisableCarBlinking(fromvehicleid);
        SetCarBlinking(fromvehicleid, BlinkSide[fromvehicleid]);
    }
    TrailerVehicle[trailerid] = 0;
}

public B_OnTrailerAttached(trailerid, tovehicleid)
{
    if(IsCarBlinking(tovehicleid))
    {
        DisableCarBlinking(tovehicleid);
        SetCarBlinking(tovehicleid, BlinkSide[tovehicleid]);
    }
    TrailerVehicle[trailerid] = tovehicleid;
}

public B_TrailerCheck()
{
    new trailer;
    for(new i=0;i<MAX_VEHICLES;i++)
    {
        if((trailer = GetVehicleTrailer(i)) != 0)
        {
            if(BlinkTrailer[i] == 0)
            {
                BlinkTrailer[i]=trailer;
                B_OnTrailerAttached(trailer, i);
            }
        }
        else if(BlinkTrailer[i] != 0)
        {
            B_OnTrailerDetached(BlinkTrailer[i], i);
            BlinkTrailer[i] = 0;
        }
    }
}

//END SYSTEM

/*public Speedo_CalculateSpeed(playerid, veh)
{
    if(IsPlayerNPC(playerid)) return 1;
    if(veh == 0) return 1;
    new Float:vel[3], Float:speed, str[8];
    GetVehicleVelocity(veh, vel[0], vel[1], vel[2]);
    speed = VectorSize(vel[0], vel[1], vel[2]) * 166.666666;
    format(str, 8, "%.0f", speed);
    PlayerTextDrawSetString(playerid, Speedo_Speed[playerid], str);
    PlayerTextDrawShow(playerid, Speedo_Speed[playerid]);

    new fuel = Gas[veh];//zmienic na Fuel[veh];
    format(str, 8, "%d", fuel);
    PlayerTextDrawSetString(playerid, Speedo_Paliwo[playerid], str);
    PlayerTextDrawShow(playerid, Speedo_Paliwo[playerid]);

    for(new i=5;i>0;i--)
    {
        if(fuel >= 100 - (20*(5-i))) PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][i-1], 0x00FF00FF);
        else PlayerTextDrawColor(playerid,Speedo_Fuel[playerid][i-1], -1);
        PlayerTextDrawShow(playerid, Speedo_Fuel[playerid][i-1]);
    }
    return 1;
}*/

Car_Lock(playerid, veh)
{
	if(IsABike(veh)) return sendErrorMessage(playerid, "Nie mo�esz u�y� /lock na motocyklu");
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);
    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "INT_HOUSE", "wash_up",4.1, 0, 0, 0, 0, 0, 1);
    if(doors == 0)
    {
        doors=1;
        GameTextForPlayer(playerid, "Zamek w drzwiach ~r~zamkniety!", 2000, 5);
    }
    else
    {
        doors=0;
        GameTextForPlayer(playerid, "Zamek w drzwiach ~g~otwarty!", 2000, 5);
    }
    SetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

    return 1;
}


SetVehicleAsObjective(vehicleid, bool:objective)
{
	new bool:engine, bool:lights, bool:alarm, bool:doors, bool:bonnet, bool:boot, bool:unused;

	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, unused);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
}

//13.08
//--------------------------------------------------

GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;

    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT; 	// Up & Left key pressed
		else if(ud > 0) direction = MOVE_BACK_LEFT; 	// Back & Left key pressed
		else            direction = MOVE_LEFT;          // Left key pressed
	}
	else if(lr > 0) 	// Right pressed
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;  // Up & Right key pressed
		else if(ud > 0) direction = MOVE_BACK_RIGHT;     // Back & Right key pressed
		else			direction = MOVE_RIGHT;          // Right key pressed
	}
	else if(ud < 0) 	direction = MOVE_FORWARD; 	// Up key pressed
	else if(ud > 0) 	direction = MOVE_BACK;		// Down key pressed

	return direction;
}

//--------------------------------------------------

MoveCamera(playerid)
{
	new Float:FV[3], Float:ncCP[3];
	GetPlayerCameraPos(playerid, ncCP[0], ncCP[1], ncCP[2]);          // 	Cameras position in space
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);  //  Where the camera is looking at

	// Increases the acceleration multiplier the longer the key is held
	if(noclipdata[playerid][accelmul] <= 1) noclipdata[playerid][accelmul] += ACCEL_RATE;

	// Determine the speed to move the camera based on the acceleration multiplier
	new Float:speed = MOVE_SPEED * noclipdata[playerid][accelmul];

	// Calculate the cameras next position based on their current position and the direction their camera is facing
	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(noclipdata[playerid][mode], ncCP, FV, X, Y, Z);
	MovePlayerObject(playerid, noclipdata[playerid][flyobject], X, Y, Z, speed);

    if(noclipdata[playerid][fireobject] != 0) MoveDynamicObject(noclipdata[playerid][fireobject], X, Y, Z, speed);

	// Store the last time the camera was moved as now
	noclipdata[playerid][lastmove] = GetTickCount();
	return 1;
}

//--------------------------------------------------

GetNextCameraPosition(move_mode, Float:ncCP[3], Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    // Calculate the cameras next position based on their current position and the direction their camera is facing
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = ncCP[0]+OFFSET_X;
			Y = ncCP[1]+OFFSET_Y;
			Z = ncCP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = ncCP[0]-OFFSET_X;
			Y = ncCP[1]-OFFSET_Y;
			Z = ncCP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = ncCP[0]-OFFSET_Y;
			Y = ncCP[1]+OFFSET_X;
			Z = ncCP[2];
		}
		case MOVE_RIGHT:
		{
			X = ncCP[0]+OFFSET_Y;
			Y = ncCP[1]-OFFSET_X;
			Z = ncCP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = ncCP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = ncCP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = ncCP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = ncCP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = ncCP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = ncCP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = ncCP[0]+(OFFSET_X  - OFFSET_Y);
			Y = ncCP[1]+(OFFSET_Y  + OFFSET_X);
			Z = ncCP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = ncCP[0]+(OFFSET_X  + OFFSET_Y);
			Y = ncCP[1]+(OFFSET_Y  - OFFSET_X);
			Z = ncCP[2]+OFFSET_Z;
		}
	}
}
//--------------------------------------------------

CancelFlyMode(playerid)
{
    GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
	DeletePVar(playerid, "FlyMode");
	CancelEdit(playerid);
	GameTextForPlayer(playerid, "L O A D I N G", 1000, 3);
    SetTimerEx("SpecEnd", 500, false, "d", playerid);
	DestroyPlayerObject(playerid, noclipdata[playerid][flyobject]);
	noclipdata[playerid][cameramode] = CAMERA_MODE_NONE;
    if(noclipdata[playerid][fireobject] != 0)
    {
        DestroyDynamicObject(noclipdata[playerid][fireobject]);
        noclipdata[playerid][fireobject] = 0;
    }
	return 1;
}

//--------------------------------------------------
FlyMode(playerid, typ)
{
	// Create an invisible object for the players camera to be attached to
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);
	noclipdata[playerid][flyobject] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);

    if(noclipdata[playerid][flyobject] == INVALID_OBJECT_ID) return SendClientMessage(playerid, -1, " B��d limitu obiekt�w.");

    GetPlayerPos(playerid, Unspec[playerid][Coords][0], Unspec[playerid][Coords][1], Unspec[playerid][Coords][2]);
    Unspec[playerid][sPint] = GetPlayerInterior(playerid);
    Unspec[playerid][sPvw] = GetPlayerVirtualWorld(playerid);

	// Place the player in spectating mode so objects will be streamed based on camera location
	TogglePlayerSpectating(playerid, true);
	// Attach the players camera to the created object
	AttachCameraToPlayerObject(playerid, noclipdata[playerid][flyobject]);

    if(typ != 0)
    {
        noclipdata[playerid][fireobject] = CreateDynamicObject(typ, X-0.5, Y, Z, 90.0, 90.0, 0.0);
    }

	SetPVarInt(playerid, "FlyMode", 1);
	noclipdata[playerid][cameramode] = CAMERA_MODE_FLY;
	return 1;
}

Kolczatka_GetID()
{
    new id=-1;
    for(new i=0;i<MAX_KOLCZATEK;i++)
    {
        if(KolID[i] == -1)
        {
            id=i;
            break;
        }
    }
    return id;
}

Kolczatka_Delete(id)
{
    if(KolID[id] == -1) return 1;
    DestroyDynamicObject(KolID[id]);
    KolID[id] = -1;
    KolTime[id] = 0;
    KolDelay[KolVehicle[id]] = false;
    KolVehicle[id] = 0;
    DestroyDynamicArea(KolArea[id]);
    return 1;
}

public OnPlayerEnterSpikes(playerid)
{
    new panels, doors, lights, tires, veh = GetPlayerVehicleID(playerid);
    if(IsACopCar(veh)) return 1;
    GetVehicleDamageStatus(veh, panels, doors, lights, tires);
    UpdateVehicleDamageStatus(veh, panels, doors, lights, 0b1111);
    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Ooops... poslizg!", 1500, 3);
    return 1;
}

GetVehicleRotation(vehicleid,&Float:heading, &Float:attitude, &Float:bank)
{
    new Float:quat_w,Float:quat_x,Float:quat_y,Float:quat_z;
    GetVehicleRotationQuat(vehicleid,quat_w,quat_x,quat_y,quat_z);
    ConvertNonNormaQuatToEuler(quat_w,quat_x,quat_z,quat_y, heading, attitude, bank);
    bank = -1*bank;
    return 1;
}

ConvertNonNormaQuatToEuler(Float: qw, Float: qx, Float:qy, Float:qz,
                                &Float:heading, &Float:attitude, &Float:bank)
{
    new Float: sqw = qw*qw;
    new Float: sqx = qx*qx;
    new Float: sqy = qy*qy;
    new Float: sqz = qz*qz;
    new Float: unit = sqx + sqy + sqz + sqw;

    new Float: test = qx*qy + qz*qw;
    if (test > 0.499*unit)
    {
        heading = 2*atan2(qx,qw);
        attitude = 3.141592653/2;
        bank = 0;
        return 1;
    }
    if (test < -0.499*unit)
    {
        heading = -2*atan2(qx,qw);
        attitude = -3.141592653/2;
        bank = 0;
        return 1;
    }
    heading = atan2(2*qy*qw - 2*qx*qz, sqx - sqy - sqz + sqw);
    attitude = asin(2*test/unit);
    bank = atan2(2*qx*qw - 2*qy*qz, -sqx + sqy - sqz + sqw);
    return 1;
}

Patrol_Init()
{
    //BLUE
    PatrolZones[0] = GangZoneCreate(78.125,-1777.34375,625.0,-816.40625);//1
    PatrolZones[1] = GangZoneCreate(625.0,-1392.25,1320.3125,-593.75);
    //GREEN
    PatrolZones[2] = GangZoneCreate(625.0,-1949.21875,1851.5625,-1392.25);//1
    PatrolZones[3] = GangZoneCreate(1320.3125,-1392.25,1851.5625,-859.375);
    //RED
    PatrolZones[4] = GangZoneCreate(1851.5625,-1949.21875,2718.75,-960.9375);//1
    PatrolZones[5] = GangZoneCreate(2718.75,-2046.875,2859.375,-1011.71875);
    //YELLOW
    PatrolZones[6] = GangZoneCreate(984.375,-2765.625,2226.5625,-1949.21875);//1
    PatrolZones[7] = GangZoneCreate(2226.5625,-2234.375,2824.21875,-1949.21875);

    PatrolMap = TextDrawCreate(130.000000, 65.000000, "samaps:gtasamapbit4"); //127.000000, 55.125000
    TextDrawLetterSize(PatrolMap, 0.000000, 0.000000);
    TextDrawTextSize(PatrolMap, 380.000000, 315.000000); //250x250
    TextDrawAlignment(PatrolMap, 1);
    TextDrawColor(PatrolMap, -1);
    TextDrawSetShadow(PatrolMap, 0);
    TextDrawSetOutline(PatrolMap, 0);
    TextDrawFont(PatrolMap, 4);

    PatrolAlfa[0] = TextDrawCreate(140.000000, 151.062500, "~n~");
    TextDrawLetterSize(PatrolAlfa[0], 17.974994, 10.713175);  //Box height multi = letter Y * 10.5478         X * 11.4603
    TextDrawTextSize(PatrolAlfa[0], 206.000000, 113.000000);  //Box width is normal - heigh is equal letter Y * 10.5478
    TextDrawAlignment(PatrolAlfa[0], 1);
    TextDrawUseBox(PatrolAlfa[0], true);
    TextDrawBoxColor(PatrolAlfa[0], 52309);
    TextDrawBackgroundColor(PatrolAlfa[0], 51);
    TextDrawFont(PatrolAlfa[0], 1);
    TextDrawSetProportional(PatrolAlfa[0], 1);
    TextDrawSetSelectable(PatrolAlfa[0], true);

    PatrolAlfa[1] = TextDrawCreate(210.000000, 127.125000, "~n~");
    TextDrawLetterSize(PatrolAlfa[1], 17.981990, 9.015682);
    TextDrawTextSize(PatrolAlfa[1], 297.000000,  95.110000);
    TextDrawAlignment(PatrolAlfa[1], 1);
    TextDrawUseBox(PatrolAlfa[1], true);
    TextDrawBoxColor(PatrolAlfa[1], 52309);
    TextDrawBackgroundColor(PatrolAlfa[1], 51);
    TextDrawFont(PatrolAlfa[1], 1);
    TextDrawSetProportional(PatrolAlfa[1], 1);
    TextDrawSetSelectable(PatrolAlfa[1], true);

    PatrolBeta[0] = TextDrawCreate(301.000000, 156.562500, "~n~");
    TextDrawLetterSize(PatrolBeta[0], 17.987489, 5.738808);
    TextDrawTextSize(PatrolBeta[0], 363.000000,  60.544000);
    TextDrawAlignment(PatrolBeta[0], 1);
    TextDrawUseBox(PatrolBeta[0], true);
    TextDrawBoxColor(PatrolBeta[0], 13369429);
    TextDrawBackgroundColor(PatrolBeta[0], 51);
    TextDrawFont(PatrolBeta[0], 1);
    TextDrawSetProportional(PatrolBeta[0], 1);
    TextDrawSetSelectable(PatrolBeta[0], true);

    PatrolBeta[1] = TextDrawCreate(209.500000, 211.812500, "~n~");
    TextDrawLetterSize(PatrolBeta[1], 17.972496, 6.307557);
    TextDrawTextSize(PatrolBeta[1], 362.500000,  66.544000);
    TextDrawAlignment(PatrolBeta[1], 1);
    TextDrawUseBox(PatrolBeta[1], true);
    TextDrawBoxColor(PatrolBeta[1], 13369429);
    TextDrawBackgroundColor(PatrolBeta[1], 51);
    TextDrawFont(PatrolBeta[1], 1);
    TextDrawSetProportional(PatrolBeta[1], 1);
    TextDrawSetSelectable(PatrolBeta[1], true);

    PatrolGamma[0] = TextDrawCreate(366.000000, 163.375000, "~n~");
    TextDrawLetterSize(PatrolGamma[0], 18.033477, 11.693190);
    TextDrawTextSize(PatrolGamma[0], 470.000000, 123.614810);
    TextDrawAlignment(PatrolGamma[0], 1);
    TextDrawUseBox(PatrolGamma[0], true);
    TextDrawBoxColor(PatrolGamma[0], -872415147);
    TextDrawBackgroundColor(PatrolGamma[0], 51);
    TextDrawFont(PatrolGamma[0], 1);
    TextDrawSetProportional(PatrolGamma[0], 1);
    TextDrawSetSelectable(PatrolGamma[0], true);

    PatrolGamma[1] = TextDrawCreate(474.000000, 170.500000, "~n~");
    TextDrawLetterSize(PatrolGamma[1], 18.018476, 11.706321);
    TextDrawTextSize(PatrolGamma[1], 493.000000, 123.614810);
    TextDrawAlignment(PatrolGamma[1], 1);
    TextDrawUseBox(PatrolGamma[1], true);
    TextDrawBoxColor(PatrolGamma[1], -872415147);
    TextDrawBackgroundColor(PatrolGamma[1], 51);
    TextDrawFont(PatrolGamma[1], 1);
    TextDrawSetProportional(PatrolGamma[1], 1);
    TextDrawSetSelectable(PatrolGamma[1], true);

    PatrolDelta[0] = TextDrawCreate(257.000000, 271.250000, "~n~");
    TextDrawLetterSize(PatrolDelta[0], 17.960977, 9.068202);
    TextDrawTextSize(PatrolDelta[0], 411.500000, 95.110000);
    TextDrawAlignment(PatrolDelta[0], 1);
    TextDrawUseBox(PatrolDelta[0], true);
    TextDrawBoxColor(PatrolDelta[0], -859045803);
    TextDrawBackgroundColor(PatrolDelta[0], 51);
    TextDrawFont(PatrolDelta[0], 1);
    TextDrawSetProportional(PatrolDelta[0], 1);
    TextDrawSetSelectable(PatrolDelta[0], true);

    PatrolDelta[1] = TextDrawCreate(414.500000, 271.250000, "~n~");
    TextDrawLetterSize(PatrolDelta[1], 17.914997, 3.000041);
    TextDrawTextSize(PatrolDelta[1], 487.000000, 31.650000);
    TextDrawAlignment(PatrolDelta[1], 1);
    TextDrawUseBox(PatrolDelta[1], true);
    TextDrawBoxColor(PatrolDelta[1], -859045803);
    TextDrawBackgroundColor(PatrolDelta[1], 51);
    TextDrawFont(PatrolDelta[1], 1);
    TextDrawSetProportional(PatrolDelta[1], 1);
    TextDrawSetSelectable(PatrolDelta[1], true);

    PatrolAlfaSq = TextDrawCreate(151.000000, 157.062500, "Alfa");
    TextDrawLetterSize(PatrolAlfaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolAlfaSq, 1);
    TextDrawColor(PatrolAlfaSq, -1);
    TextDrawSetShadow(PatrolAlfaSq, 0);
    TextDrawSetOutline(PatrolAlfaSq, 1);
    TextDrawBackgroundColor(PatrolAlfaSq, 51);
    TextDrawFont(PatrolAlfaSq, 2);
    TextDrawSetProportional(PatrolAlfaSq, 1);

    PatrolBetaSq = TextDrawCreate(217.500000, 218.437500, "Beta");
    TextDrawLetterSize(PatrolBetaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolBetaSq, 1);
    TextDrawColor(PatrolBetaSq, -1);
    TextDrawSetShadow(PatrolBetaSq, 0);
    TextDrawSetOutline(PatrolBetaSq, 1);
    TextDrawBackgroundColor(PatrolBetaSq, 51);
    TextDrawFont(PatrolBetaSq, 2);
    TextDrawSetProportional(PatrolBetaSq, 1);

    PatrolGammaSq = TextDrawCreate(371.500000, 167.812500, "Gamma");
    TextDrawLetterSize(PatrolGammaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolGammaSq, 1);
    TextDrawColor(PatrolGammaSq, -1);
    TextDrawSetShadow(PatrolGammaSq, 0);
    TextDrawSetOutline(PatrolGammaSq, 1);
    TextDrawBackgroundColor(PatrolGammaSq, 51);
    TextDrawFont(PatrolGammaSq, 2);
    TextDrawSetProportional(PatrolGammaSq, 1);

    PatrolDeltaSq = TextDrawCreate(265.500000, 274.687500, "Delta");
    TextDrawLetterSize(PatrolDeltaSq, 0.260000, 1.066876);
    TextDrawAlignment(PatrolDeltaSq, 1);
    TextDrawColor(PatrolDeltaSq, -1);
    TextDrawSetShadow(PatrolDeltaSq, 0);
    TextDrawSetOutline(PatrolDeltaSq, 1);
    TextDrawBackgroundColor(PatrolDeltaSq, 51);
    TextDrawFont(PatrolDeltaSq, 2);
    TextDrawSetProportional(PatrolDeltaSq, 1);

    PatrolLabel = TextDrawCreate(320.500000, 57.312500, "Mapa patroli~n~~y~LSPD");
    TextDrawLetterSize(PatrolLabel, 0.449999, 1.600000);
    TextDrawAlignment(PatrolLabel, 2);
    TextDrawColor(PatrolLabel, -1);
    TextDrawSetShadow(PatrolLabel, 0);
    TextDrawSetOutline(PatrolLabel, 1);
    TextDrawBackgroundColor(PatrolLabel, 51);
    TextDrawFont(PatrolLabel, 1);
    TextDrawSetProportional(PatrolLabel, 1);

    for(new i=0;i<MAX_PATROLS;i++)
    {
        PatrolMarker[i] = TextDrawCreate(0.0, 0.0, "_");
        TextDrawLetterSize(PatrolMarker[i], 0.000000, 0.000000);
        TextDrawTextSize(PatrolMarker[i], 19.500000, 17.062500);
        TextDrawAlignment(PatrolMarker[i], 1);
        TextDrawColor(PatrolMarker[i], -1);
        TextDrawSetShadow(PatrolMarker[i], 0);
        TextDrawSetOutline(PatrolMarker[i], 0);
        TextDrawFont(PatrolMarker[i], 4);
    }
}

Patrol_Unload()
{
    TextDrawDestroy(PatrolMap);
    TextDrawDestroy(PatrolAlfa[0]);
    TextDrawDestroy(PatrolAlfa[1]);
    TextDrawDestroy(PatrolBeta[0]);
    TextDrawDestroy(PatrolBeta[1]);
    TextDrawDestroy(PatrolGamma[0]);
    TextDrawDestroy(PatrolGamma[1]);
    TextDrawDestroy(PatrolDelta[0]);
    TextDrawDestroy(PatrolDelta[1]);
    TextDrawDestroy(PatrolAlfaSq);
    TextDrawDestroy(PatrolBetaSq);
    TextDrawDestroy(PatrolGammaSq);
    TextDrawDestroy(PatrolDeltaSq);
    TextDrawDestroy(PatrolLabel);

    for(new i = 0; i < MAX_PATROLS ; i++)
    {
        if(PatrolMarker[i] != Text:INVALID_TEXT_DRAW)
        {
            TextDrawDestroy(PatrolMarker[i]);
        }
    }
    for(new i = 0; i < 8 ; i++)
    {
        GangZoneDestroy(PatrolZones[i]);
    }
}

GetPatrolID()
{
    new id=-1;
    for(new i = 0; i < MAX_PATROLS ;i++)
    {
        if(PatrolInfo[i][pataktywny] == 0)
        {
            id = i;
            break;
        }
    }
    return id;
}

Patrol_ShowMap(playerid)
{
    TextDrawShowForPlayer(playerid, PatrolMap);
    TextDrawShowForPlayer(playerid, PatrolAlfa[0]);
    TextDrawShowForPlayer(playerid, PatrolAlfa[1]);
    TextDrawShowForPlayer(playerid, PatrolBeta[0]);
    TextDrawShowForPlayer(playerid, PatrolBeta[1]);
    TextDrawShowForPlayer(playerid, PatrolGamma[0]);
    TextDrawShowForPlayer(playerid, PatrolGamma[1]);
    TextDrawShowForPlayer(playerid, PatrolDelta[0]);
    TextDrawShowForPlayer(playerid, PatrolDelta[1]);
    TextDrawShowForPlayer(playerid, PatrolAlfaSq);
    TextDrawShowForPlayer(playerid, PatrolBetaSq);
    TextDrawShowForPlayer(playerid, PatrolGammaSq);
    TextDrawShowForPlayer(playerid, PatrolDeltaSq);
    TextDrawShowForPlayer(playerid, PatrolLabel);
    SelectTextDraw(playerid, 0xD2691E55);
    SetPVarInt(playerid, "patrolmap", 1);
}

Patrol_HideMap(playerid)
{
    TextDrawHideForPlayer(playerid, PatrolMap);
    TextDrawHideForPlayer(playerid, PatrolAlfa[0]);
    TextDrawHideForPlayer(playerid, PatrolAlfa[1]);
    TextDrawHideForPlayer(playerid, PatrolBeta[0]);
    TextDrawHideForPlayer(playerid, PatrolBeta[1]);
    TextDrawHideForPlayer(playerid, PatrolGamma[0]);
    TextDrawHideForPlayer(playerid, PatrolGamma[1]);
    TextDrawHideForPlayer(playerid, PatrolDelta[0]);
    TextDrawHideForPlayer(playerid, PatrolDelta[1]);
    TextDrawHideForPlayer(playerid, PatrolAlfaSq);
    TextDrawHideForPlayer(playerid, PatrolBetaSq);
    TextDrawHideForPlayer(playerid, PatrolGammaSq);
    TextDrawHideForPlayer(playerid, PatrolDeltaSq);
    TextDrawHideForPlayer(playerid, PatrolLabel);

    for(new i = 0; i < MAX_PATROLS ; i ++)
    {
        TextDrawHideForPlayer(playerid, PatrolMarker[i]);
    }
    CancelSelectTextDraw(playerid);
    SetPVarInt(playerid, "patrolmap", 0);
}

Patrol_DisplayZones(playerid)
{
    GangZoneShowForPlayer(playerid, PatrolZones[0], 0x0000CC55);
    GangZoneShowForPlayer(playerid, PatrolZones[1], 0x0000CC55);

    GangZoneShowForPlayer(playerid, PatrolZones[2], 0x00CC0055);
    GangZoneShowForPlayer(playerid, PatrolZones[3], 0x00CC0055);

    GangZoneShowForPlayer(playerid, PatrolZones[4], 0xCC000055);
    GangZoneShowForPlayer(playerid, PatrolZones[5], 0xCC000055);

    GangZoneShowForPlayer(playerid, PatrolZones[6], 0xCCCC0055);
    GangZoneShowForPlayer(playerid, PatrolZones[7], 0xCCCC0055);
}

Patrol_HideZones(playerid)
{
    GangZoneHideForPlayer(playerid, PatrolZones[0]);
    GangZoneHideForPlayer(playerid, PatrolZones[1]);

    GangZoneHideForPlayer(playerid, PatrolZones[2]);
    GangZoneHideForPlayer(playerid, PatrolZones[3]);

    GangZoneHideForPlayer(playerid, PatrolZones[4]);
    GangZoneHideForPlayer(playerid, PatrolZones[5]);

    GangZoneHideForPlayer(playerid, PatrolZones[6]);
    GangZoneHideForPlayer(playerid, PatrolZones[7]);
}

GPSMode(playerid, bool:red = false)
{
	new string[144], sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));

	if(PDGPS == playerid)
	{
		foreach(new i : Player)
		{
			if(IsAPolicja(i) || GetPlayerFraction(i) == FRAC_ERS || GetPlayerFraction(i) == FRAC_BOR || GetPlayerFraction(i) == FRAC_ERS || (PlayerInfo[i][pMember] == 9 && SanDuty[i] == 1) || (PlayerInfo[i][pLider] == 9 && SanDuty[i] == 1))
			{
				if(zawodnik[i] == 0)
					DisablePlayerCheckpoint(i);
			}
		}
	}

	if(red)
	{
		format(string, sizeof(string), "=: %s %s %s GPS %s :=", FracRang[GetPlayerFraction(playerid)][PlayerInfo[playerid][pRank]], sendername, (PDGPS == playerid) ? ("deaktywowa�") : ("aktywowa�"), (PDGPS == playerid) ? ("- odwo�uj� RED") : ("potrzebne wsparcie! - CODE RED"));
		PDGPS = (PDGPS == playerid) ? (-1) : (playerid);
	}
	else
	{
		format(string, sizeof(string), "=: %s %s %s GPS %s :=", FracRang[GetPlayerFraction(playerid)][PlayerInfo[playerid][pRank]], sendername, (PDGPS == playerid) ? ("deaktywowa�") : ("aktywowa�"), (PDGPS == playerid) ? ("") : ("potrzebne wsparcie!"));
		PDGPS = (PDGPS == playerid) ? (-1) : (playerid);
	}

	SendRadioMessage(1, COLOR_YELLOW2, string);
	SendRadioMessage(2, COLOR_YELLOW2, string);
	SendRadioMessage(3, COLOR_YELLOW2, string);
	SendRadioMessage(4, COLOR_YELLOW2, string);
	//SendRadioMessage(9, COLOR_YELLOW2, string);
	SendRadioMessage(FRAC_BOR, COLOR_YELLOW2, string); 
}

public PatrolGPS()
{
    new Float:x, Float:y, Float:z;
    for(new i = 0; i < MAX_PATROLS; i ++)
    {
        if(PatrolInfo[i][pataktywny] == 1)
        {
            GetPlayerPos(PatrolInfo[i][patroluje][0], x, y, z);

            Patrol_CreateMarker(i, x, y, PatrolInfo[i][patstan]);
        }
    }
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        if(GetPVarInt(i, "patrolmap") == 1)
        {
            for(new a = 0; a < MAX_PATROLS; a ++)
            {
                if(PatrolInfo[a][pataktywny] == 1)
                {
                    TextDrawShowForPlayer(i, PatrolMarker[a]);
                }
            }
        }
        //CHECKPOINT

    }
}

Patrol_CreateMarker(patrolid, Float:x, Float:y, type)
{
    if(PatrolMarker[patrolid] != Text:INVALID_TEXT_DRAW)
    {
        TextDrawDestroy(PatrolMarker[patrolid]);
        PatrolMarker[patrolid] = Text:INVALID_TEXT_DRAW;
    }
    new str[32];

    if(type == 1) str = "LD_CHAT:thumbup"; //OK
    else if(type == 2) str = "LD_CHAT:badchat"; //pomoc
    else if(type == 3) str = "hud:radar_impound"; //poscig
    else if(type == 4) str = "hud:radar_hostpital"; // ranny

    x = floatabs(320 - 0.126666 * (x + 3000)) + 70;
    y = floatabs(240 + 0.105 * (y - 3000)) - 27;

    if(x <= 130)
    {
        str = "LD_CHAT:thumbdn";
        x = 130;
    }
    else if(x >= 510)
    {
        str = "LD_CHAT:thumbdn";
        x=510;
    }
    if(y <= 65)
    {
        str = "LD_CHAT:thumbdn";
        y=65;
    }
    else if(y >= 380)
    {
        str = "LD_CHAT:thumbdn";
        y=380;
    }

    PatrolMarker[patrolid] = TextDrawCreate(x, y, str);
    TextDrawLetterSize(PatrolMarker[patrolid], 0.000000, 0.000000);
    TextDrawTextSize(PatrolMarker[patrolid], 19.500000, 17.062500);
    TextDrawAlignment(PatrolMarker[patrolid], 1);
    TextDrawColor(PatrolMarker[patrolid], -1);
    TextDrawSetShadow(PatrolMarker[patrolid], 0);
    TextDrawSetOutline(PatrolMarker[patrolid], 0);
    TextDrawFont(PatrolMarker[patrolid], 4);
    TextDrawSetSelectable(PatrolMarker[patrolid], true);
}

//------------------- OIL SYSTEM -------------------------------

public OnPlayerEnterOilSpot(playerid)
{
    new lVeh = GetPlayerVehicleID(playerid);
    new Float:lSpeed = GetCarSpeed(lVeh), Float:lAngle;
    GetVehicleZAngle(lVeh, lAngle);
    if(lSpeed < 20.0) return 0;
    new Float:lVel = floatsqroot(lSpeed)/150;
    if(lAngle - 180.0 > 0) lVel = -lVel;
    SetVehicleAngularVelocity(lVeh, 0.0, 0.0, lVel);
    GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~Ooops... poslizg!", 1500, 3);
    return 1;
}

Oil_LoadCleanProcedure(playerid)
{
    for(new i=0;i<5;i++)
    {
        PlayerOilKeys[playerid][i] = 0;
    }
    PlayerOilKeys[playerid][2] = 1+random(4);
    PlayerOilKeys[playerid][3] = 1+random(4);
    PlayerOilKeys[playerid][4] = 1+random(4);
    Oil_LoadPTXD(playerid);
    Oil_UpdateKeysSeq(playerid);
    TextDrawShowForPlayer(playerid, OilTXD_BG[0]);
    TextDrawShowForPlayer(playerid, OilTXD_BG[1]);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 0, 0, 0, -1);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 0, 0, 0, -1);
}

Oil_UpdateRandomKeys(playerid)
{
    for(new i=0;i<4;i++)
    {
        PlayerOilKeys[playerid][i] = PlayerOilKeys[playerid][i+1];
    }
    PlayerOilKeys[playerid][4] = 1+random(4);
}

Oil_OnPlayerPress(playerid, keys)
{
    if(GetTickDiff(GetTickCount(), GetPVarInt(playerid, "oil_press")) < 100) return 0;
    if((keys == KEY_UP) && PlayerOilKeys[playerid][2] == 3) Oil_PressedOK(playerid);
    else if((keys == KEY_DOWN) && PlayerOilKeys[playerid][2] == 4) Oil_PressedOK(playerid);
    else if((keys == KEY_LEFT*2) && PlayerOilKeys[playerid][2] == 1) Oil_PressedOK(playerid);
    else if((keys == KEY_RIGHT*2) && PlayerOilKeys[playerid][2] == 2) Oil_PressedOK(playerid);
    else
    {
        //Co si� dzieje gdy wcisni�to niepoprawny przycisk
        new lStr[16];
        PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
        if(OilData[GetPVarInt(playerid, "oil_id")][oilHP] < OIL_MAX_HEALTH)
        {
            OilData[GetPVarInt(playerid, "oil_id")][oilHP] ++;
        }
        format(lStr, 16, "~r~%d", OilData[GetPVarInt(playerid, "oil_id")][oilHP]);
        GameTextForPlayer(playerid, lStr, 1000, 5);
    }
    SetPVarInt(playerid, "oil_press", GetTickCount());
    Oil_UpdateRandomKeys(playerid);
    Oil_UpdateKeysSeq(playerid);
    return 1;
}

Oil_PressedOK(playerid)
{
    new lID = GetPVarInt(playerid, "oil_id");
    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    OilData[lID][oilHP]-=2;
    new Float:lPos[3];
    GetDynamicObjectPos(OilData[lID][oilObject], lPos[0], lPos[1], lPos[2]);
    if(OilData[lID][oilHP] < 0) Oil_Destroy(lID);
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 0, 0);
    new lStr[16];
    format(lStr, 16, "~g~%d", OilData[lID][oilHP]);
    GameTextForPlayer(playerid, lStr, 1000, 5);
}

Oil_UpdateKeysSeq(playerid)
{
    new lStr[8];
    for(new i=0;i<5;i++)
    {
        switch(PlayerOilKeys[playerid][i])
        {
            case 0: format(lStr, 8, "_");
            case 1: format(lStr, 8, "~<~");
            case 2: format(lStr, 8, "~>~");
            case 3: format(lStr, 8, "~u~");
            case 4: format(lStr, 8, "~d~");
        }
        PlayerTextDrawSetString(playerid, OilPTXD_Arrow[i][playerid], lStr);
        PlayerTextDrawShow(playerid, OilPTXD_Arrow[i][playerid]);
    }
}

Oil_GenerateFromVehicle(vehicleid)
{
    if(!bOilOccur[vehicleid])
    {
        if(IsAPlane(vehicleid)) return 0;
        if(IsABoat(vehicleid)) return 0;
        new Float:lX, Float:lY, Float:lZ;
        GetVehicleVelocity(vehicleid, lX, lY, lZ);
        if(!(-0.25 < lZ < 0.25)) return 0;

        if(GetVehicleModel(vehicleid) == 509 || GetVehicleModel(vehicleid) == 481 || GetVehicleModel(vehicleid) == 510) return 0;

        new lID = Oil_GenerateID();
        if(lID == -1) return 0;
        new Float:lPos[3];
        GetVehiclePos(vehicleid, lPos[0], lPos[1], lPos[2]);

        //Szansa na powstanie plamy olejowej w zaleznosci od tego, czy jest blisko LS
        new lChance=1;
        if(VectorSize(1600.0-lPos[0], -1100.0-lPos[1], 0.0) < 1000.0) lChance+=4;

        new lNear = Oil_GetIDAtPosition(lPos[0], lPos[1], lPos[2], 200.0);
        if(lNear == -1)
        {
            new Float:lUnused;
            GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, lUnused, lUnused, lX);
            GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_WHEELSFRONT, lUnused, lUnused, lY);
            GetVehicleZAngle(vehicleid, lZ);
            OilData[lID][oilPos][0] = lPos[0],
            OilData[lID][oilPos][1] = lPos[1],
            OilData[lID][oilPos][2] = lPos[2] - ((floatsqroot(lX)/4)-lY+0.05);

            OilData[lID][oilHP] = OIL_MAX_HEALTH;
            OilData[lID][oilObject] = CreateDynamicObject(2715, lPos[0], lPos[1], OilData[lID][oilPos][2], 90.0, 0.0, lZ);
            SetDynamicObjectMaterial(OilData[lID][oilObject], 0, 11384, "xenon_sfse", "ruffroadlas");

            OilData[lID][oilArea] = CreateDynamicCube(lPos[0]-3.0, lPos[1]-3.0, OilData[lID][oilPos][2]-5.0, lPos[0]+3.0, lPos[1]+3.0, OilData[lID][oilPos][2]+5.0);
            bOilOccur[vehicleid] = true;
            OilData[lID][oilTime] = gettime();
            printf("[OilSpot] Created ID %d at %.1f %.1f %.1f by car %d", lID, lPos[0], lPos[1], OilData[lID][oilPos][2], vehicleid);
        }
    }
    return 1;
}

Oil_Destroy(lID)
{
    OilData[lID][oilPos][0] = 0.0,
    OilData[lID][oilPos][1] = 0.0,
    OilData[lID][oilPos][2] = 0.0;

    DestroyDynamicObject(OilData[lID][oilObject]);
    DestroyDynamicArea(OilData[lID][oilArea]);

    foreach(new i : Player)
    {
        if(GetPVarInt(i, "oil_clear") != 1) continue;
        if(GetPVarInt(i, "oil_id") != lID) continue;
        Oil_UnloadPTXD(i);
        SetPVarInt(i, "oil_clear", 0);
		ClearAnimations(i);
	    SetPlayerSpecialAction(i,SPECIAL_ACTION_NONE);
        TogglePlayerControllable(i, 1);
        TextDrawHideForPlayer(i, OilTXD_BG[0]);
        TextDrawHideForPlayer(i, OilTXD_BG[1]);
        ApplyAnimation(i, "BOMBER", "BOM_Plant_Crouch_Out", 4.0, 0, 0, 0, 0, -1);
        SendClientMessage(i, COLOR_WHITE, "[ERS] Usun��e� plam� oleju! Otrzymujesz 12 500$! [ERS]");
        DajKase(i, 12500);
        SendFamilyMessage(4, COLOR_GREEN, "[ERS] Stra�ak usun�� plam� oleju! Na konto frakcji wp�ywa 5 000$! [ERS]");
        Sejf_Add(FRAC_ERS, 5000);
    }
}

Oil_GenerateID()
{
    for(new i=0;i<MAX_OILS;i++)
    {
        if(Oil_IsValid(i)) continue;
        return i;
    }
    return -1;
}

Oil_IsValid(id) return (OilData[id][oilPos][0] != 0.0);

Oil_GetIDAtPosition(Float:x, Float:y, Float:z, Float:radius)
{
    new id=-1, Float:lA, Float:lB=radius;
    for(new i=0;i<MAX_OILS;i++)
    {
        if(OilData[i][oilPos][0] == 0.0) continue;
        if((lA = VectorSize(OilData[i][oilPos][0]-x, OilData[i][oilPos][1]-y, OilData[i][oilPos][2]-z)) < radius)
        {
            if(lA < lB)
            {
                lB = lA;
                id = i;
            }
        }
    }
    return id;
}

ChangePlayerName(playerid, name[])
{
    if(strlen(name) >= 21)
	{
		SendClientMessage(playerid, COLOR_RED, "Nowy nick mo�e mie� maksymalnie 20 znak�w!");
		return 0;
	}

    if(toupper(name[0]) != name[0])
    {
        SendClientMessage(playerid, COLOR_RED, "Litery pocz�tkowe musz� zaczyna� si� od du�ej.");
        return 0;
    }
    if(name[strlen(name)-1] == '_')
    {
        SendClientMessage(playerid, COLOR_RED, "Nie moze byc pod�ogi na ko�cu.");
        return 0;
    }
    for(new i=0;i<strlen(name);i++)
    {
        if(name[i] == ' ')
        {
            SendClientMessage(playerid, COLOR_RED, "Nick zawiera spacj�, zmie� to.");
		    return 0;
        }
    }
    new stabcount=0;
    for(new i=0;i<strlen(name);i++)
    {
        if(name[i] == '_')
        {
            if(toupper(name[i+1]) != name[i+1])
            {
                SendClientMessage(playerid, COLOR_RED, "Litery pocz�tkowe musz� zaczyna� si� od du�ej.");
                return 0;
            }
            stabcount++;
        }
    }
    if(stabcount == 0 || stabcount > 2)
    {
        SendClientMessage(playerid, COLOR_RED, "Nick nie zawiera podkresle�, lub ma ich ponad 2.");
		return 0;
    }

    if(!IsNickCorrect(name))
    {
        SendClientMessage(playerid, COLOR_RED, "Nick zawiera niepoprawne znaki (znaki polskie, cyfry lub specjalne).");
        return 0;
    }
	
	if(ReturnUser(name) != INVALID_PLAYER_ID) 
	{
        SendClientMessage(playerid, COLOR_RED, "Gracz o takim nicku gra obecnie na serwerze!");
		return 0;
	}

	if(MruMySQL_DoesAccountExist(name) != 0)
	{
		SendClientMessage(playerid, COLOR_YELLOW, "Ten Nick jest ju� zaj�ty przez innego gracza.");
		return 0;
	}

    RemovePlayerFromOrg(playerid);
    PlayerInfo[playerid][pZmienilNick]--;
	PlayerInfo[playerid][pMember] = 0;
	if(PlayerInfo[playerid][pLider] > 0)
	{
		Remove_MySQL_Leader(playerid);
		PlayerInfo[playerid][pLider] = 0;
	}
	PlayerInfo[playerid][pJob] = 0;
	PlayerInfo[playerid][pRank] = 0;
	PoziomPoszukiwania[playerid] = 0;
	SetPlayerName(playerid, name);
	SetRPName(playerid);
	
    format(PlayerInfo[playerid][pNick], 32, "%s", name);
	
    MruMySQL_SaveAccount(playerid);
    return 1;
}
CheckVulgarityString(text[])
{
	new valueVulgarity;
	if(strfind(text, "kurwa", true) >=0 
	|| strfind(text, "chuj", true) >=0 
	|| strfind(text, "cipa", true) >=0 
	|| strfind(text, "fiut", true) >=0 
	|| strfind(text, "zjeb", true) >=0 
	|| strfind(text, "dick", true) >=0 
	|| strfind(text, "kurwy", true) >=0 
	|| strfind(text, "jeb", true)>=0 
	|| strfind(text , "huj" , true)>=0 
	|| strfind(text , "pizda" , true)>=0 
	|| strfind(text , "pizdy" , true)>=0 
	|| strfind(text , "frajer" , true)>=0
	|| strfind(text , "szmul" , true)>=0
	|| strfind(text , "dzban" , true)>=0  	
	|| strfind(text , "kurwa" , true)>=0
	|| strfind(text , "kutas" , true)>=0 
	|| strfind(text , "dupa" , true)>=0 
	|| strfind(text , "cipa" , true)>=0 
	|| strfind(text , "cipka" , true)>=0 
	|| strfind(text , "n00b" , true)>=0 
	|| strfind(text , "noob" , true)>=0 
	|| strfind(text , "n0b" , true)>=0
	|| strfind(text , "kurwy" , true)>=0)
	{	
		valueVulgarity = 1;
	}
	else 
	{
		valueVulgarity = 0;
	}
	return valueVulgarity;
}
SetRPName(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	format(nickRP[playerid], MAX_PLAYER_NAME, "%s", nick);
	strreplace2(nickRP[playerid], '_', ' ');
}

public VendCheck(playerid)
{
    if(GetPlayerAnimationIndex(playerid)==1660)
    {
        if(kaska[playerid] > 100)
        {
            new Float:hp;
            GetPlayerHealth(playerid, hp);
            SetPlayerHealth(playerid, float(clamp(floatround(hp)+25, 1, 100)));

            ZabierzKase(playerid, 100);
        }
        else PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
    }
}

//--------------------------------------------------
//--------------------------------------------------
//30.10
TJD_Exit()
{
    TextDrawDestroy(TXD_TJDBg);
    TextDrawDestroy(TXD_TJDImg);
    DestroyDynamic3DTextLabel(TJD_Label);

    new lStr[64];
    format(lStr, 64, "UPDATE mru_config SET `trucker_magazyn`='%d'", TJD_Materials);
    mysql_query(lStr);
}

TJD_Load()
{
    for(new i=0;i<7;i++) TJD_RestoreBox(i);

    //PACKEGES
    CreateDynamicObject(2991, 1731.05530, -2055.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1731.05530, -2055.54248, 14.46492,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1731.05530, -2059.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1731.05530, -2059.54248, 14.46490,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1733.05530, -2055.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1733.05530, -2055.54248, 14.46490,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(2991, 1733.05530, -2059.54248, 13.18880,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1558, 1730.61047, -2062.05151, 13.09371,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2900, 1733.04260, -2058.15479, 13.78380,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2900, 1732.79529, -2059.35864, 13.78380,   0.00000, 0.00000, 69.54000);
    CreateDynamicObject(2900, 1732.62561, -2060.59448, 13.78380,   0.00000, 0.00000, 88.97998);

    //OTHER
    CreateDynamicObject(5644, 1881.82031, -1315.92188, 56.06217,   0.0, 0.00000, 0.0, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(5463, 1881.80103, -1315.53516, 72.94360,   0.00000, 0.00000, 0.00000, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(5644, 1881.82031, -1315.92188, 81.33503,   0.0, 0.00000, 0.0, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(1384, 1912.12134, -1318.99951, 98.18674,   0.00000, 0.00000, 505.01999, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(1395, 1912.11914, -1318.93286, 45.80652,   0.00000, 0.00000, 0.00000, -1, -1, -1, 500.0, 500.0);
    CreateDynamicObject(3722, 1962.26563, -1319.45068, 26.43902,   0.00000, 354.00000, 0.00000);
    CreateDynamicObject(3577, 1904.26013, -1295.57019, 13.22326,   0.00000, 0.00000, 91.67999);
    CreateDynamicObject(1685, 1899.94019, -1295.36926, 13.27162,   0.00000, 0.00000, 28.74000);
    CreateDynamicObject(1685, 1901.01685, -1297.61292, 13.27162,   0.00000, 0.00000, -14.40000);
    CreateDynamicObject(1685, 1900.35999, -1296.59497, 14.77025,   0.00000, 0.00000, 24.78000);
    CreateDynamicObject(1685, 1894.32825, -1297.11597, 13.31168,   0.00000, 0.00000, -72.18000);
    CreateDynamicObject(1685, 1894.82996, -1299.18164, 13.31168,   0.00000, 0.00000, -126.42000);
    CreateDynamicObject(1685, 1892.21777, -1298.77466, 13.33171,   0.00000, 0.00000, -126.42000);
    CreateDynamicObject(1685, 1893.68005, -1298.55237, 14.82419,   0.00000, 0.00000, -87.77999);
    CreateDynamicObject(3722, 1903.02673, -1318.92017, 10.71766,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3722, 1906.18860, -1318.88501, 10.74245,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3722, 1899.99146, -1318.77747, 10.74245,   0.00000, 0.00000, 10.98000);
    CreateDynamicObject(3049, 1861.89880, -1330.82715, 14.81102,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1866.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1870.89880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1875.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3049, 1879.89880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3050, 1893.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3049, 1893.39880, -1330.82715, 14.81100,   0.00000, 0.00000, 180.00000);
    CreateDynamicObject(3050, 1902.55896, -1330.84766, 14.81100,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3049, 1861.84314, -1326.12708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1321.62708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1317.12708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1312.62708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1308.12708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(3049, 1861.84314, -1303.62708, 14.81100,   0.00000, 0.00000, 90.00000);
    CreateDynamicObject(1684, 1873.39368, -1295.73730, 14.20618,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(2984, 1882.75342, -1294.28650, 13.61465,   0.78000, 4.98000, 93.83998);
    CreateDynamicObject(3282, 1954.07092, -1330.16174, 20.98397,   0.00000, 350.00000, 0.00000);
    CreateDynamicObject(3282, 1943.15479, -1330.14172, 18.95337,   0.00000, 350.00000, 0.00000);
    CreateDynamicObject(4099, 1957.73157, -1314.00635, 22.71690,   -3.84000, 355.55994, 47.94000);
    CreateDynamicObject(1685, 656.87292, 805.57257, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 655.08154, 805.12305, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 653.25555, 804.66394, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 651.29852, 804.44727, -43.26763,   0.00000, 0.00000, 4.44000);
    CreateDynamicObject(1685, 649.52148, 804.27161, -43.26763,   0.00000, 0.00000, 4.44000);
    CreateDynamicObject(1685, 647.54663, 804.36176, -43.26763,   0.00000, 0.00000, -5.10000);
    CreateDynamicObject(1685, 658.74884, 806.05511, -43.26763,   0.00000, 0.00000, 15.90000);
    CreateDynamicObject(1685, 660.66547, 806.85052, -43.26763,   0.00000, 0.00000, 28.98002);
    CreateDynamicObject(1685, 662.36334, 807.90942, -43.26763,   0.00000, 0.00000, 38.58003);
    CreateDynamicObject(1685, 663.90851, 809.27466, -43.26763,   0.00000, 0.00000, 44.22004);
    CreateDynamicObject(1685, 665.25793, 810.72522, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 666.54218, 812.18915, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 667.92657, 813.74432, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 666.00769, 814.48474, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 664.59644, 812.92163, -43.26763,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 663.32581, 811.31384, -43.26763,   0.00000, 0.00000, 46.86004);
    CreateDynamicObject(1685, 661.85834, 809.96594, -43.26763,   0.00000, 0.00000, 40.80002);
    CreateDynamicObject(1685, 660.22931, 808.83923, -43.26763,   0.00000, 0.00000, 29.22001);
    CreateDynamicObject(1685, 658.44696, 807.97968, -43.26763,   0.00000, 0.00000, 18.42000);
    CreateDynamicObject(1685, 656.59784, 807.51935, -43.26763,   0.00000, 0.00000, 13.08000);
    CreateDynamicObject(1685, 654.76886, 806.93689, -43.26763,   0.00000, 0.00000, 14.64000);
    CreateDynamicObject(1685, 652.64288, 806.60767, -43.26763,   0.00000, 0.00000, -1.32000);
    CreateDynamicObject(1685, 650.59900, 806.32904, -43.26763,   0.00000, 0.00000, 18.06000);
    CreateDynamicObject(1685, 648.48517, 806.13599, -43.26763,   0.00000, 0.00000, -2.88000);
    CreateDynamicObject(1685, 666.19055, 813.26825, -41.79947,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 664.96112, 811.74066, -41.79947,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 663.70697, 810.08124, -41.79947,   0.00000, 0.00000, 49.68005);
    CreateDynamicObject(1685, 662.17474, 808.76434, -41.79947,   0.00000, 0.00000, 36.60006);
    CreateDynamicObject(1685, 660.62048, 807.66290, -41.79947,   0.00000, 0.00000, 30.42004);
    CreateDynamicObject(1685, 658.83423, 806.86768, -41.79947,   0.00000, 0.00000, 23.88003);
    CreateDynamicObject(1685, 656.84607, 806.26874, -41.79947,   0.00000, 0.00000, -1.61997);
    CreateDynamicObject(1685, 654.06512, 805.70148, -41.79947,   0.00000, 0.00000, 12.66003);
    CreateDynamicObject(1685, 652.13287, 805.36993, -41.79947,   0.00000, 0.00000, 12.66003);
    CreateDynamicObject(1685, 650.00317, 805.00964, -41.79947,   0.00000, 0.00000, 12.66003);
    CreateDynamicObject(1685, 647.91980, 805.08209, -41.79947,   0.00000, 0.00000, -6.65996);

    SetTimer("TJDTimer", 3000, 1);

    TXD_TJDBg = TextDrawCreate(553.000000, 107.000000, "~n~~n~~n~~n~~n~");
    TextDrawAlignment(TXD_TJDBg, 2);
    TextDrawBackgroundColor(TXD_TJDBg, 255);
    TextDrawFont(TXD_TJDBg, 1);
    TextDrawLetterSize(TXD_TJDBg, 0.500000, 1.000000);
    TextDrawColor(TXD_TJDBg, -1);
    TextDrawSetOutline(TXD_TJDBg, 0);
    TextDrawSetProportional(TXD_TJDBg, 1);
    TextDrawSetShadow(TXD_TJDBg, 1);
    TextDrawUseBox(TXD_TJDBg, 1);
    TextDrawBoxColor(TXD_TJDBg, -1724834202);
    TextDrawTextSize(TXD_TJDBg, 80.000000, 111.000000);
    TextDrawSetSelectable(TXD_TJDBg, 0);

    TXD_TJDImg = TextDrawCreate(489.000000, 103.000000, "New Textdraw");
    TextDrawAlignment(TXD_TJDImg, 2);
    TextDrawBackgroundColor(TXD_TJDImg, 0);
    TextDrawFont(TXD_TJDImg, 5);
    TextDrawLetterSize(TXD_TJDImg, 0.000000, 1.000000);
    TextDrawColor(TXD_TJDImg, -1);
    TextDrawSetOutline(TXD_TJDImg, 0);
    TextDrawSetProportional(TXD_TJDImg, 1);
    TextDrawSetShadow(TXD_TJDImg, 1);
    TextDrawUseBox(TXD_TJDImg, 1);
    TextDrawBoxColor(TXD_TJDImg, 255);
    TextDrawTextSize(TXD_TJDImg, 61.000000, 50.000000);
    TextDrawSetPreviewModel(TXD_TJDImg, 1558);
    TextDrawSetPreviewRot(TXD_TJDImg, 350.000000, 0.000000, 30.000000, 1.000000);
    TextDrawSetSelectable(TXD_TJDImg, 0);

    new lStr[64];
    format(lStr, 64, "Liczba materia��w\n{99311E}%d\n{646464}(/zlecenie)", TJD_Materials);
    TJD_Label = CreateDynamic3DTextLabel(lStr, -1, TransportJobData[0][eTJDStartX], TransportJobData[0][eTJDStartY], TransportJobData[0][eTJDStartZ]+1.0, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
}

TJD_UpdateLabel()
{
    new lStr[64];
    format(lStr, 64, "Liczba materia��w\n{99311E}%d\n{646464}(/zlecenie)", TJD_Materials);
    UpdateDynamic3DTextLabelText(TJD_Label, -1, lStr);
}
TJD_JobEnd(playerid, bool:quiter=false)
{
    SetPVarInt(playerid, "TJDend", 0);
    SetPVarInt(playerid, "TJDstartend", 0);
    new veh = GetPVarInt(playerid, "TJDveh");

    TJD_CheckForUsedBox(veh);

    if(!quiter)
    {
        RemovePlayerFromVehicleEx(playerid);
        TJD_DestroyTXD(playerid);
    }

    SetVehicleZAngle(veh, 0.0);
    SetVehiclePos(veh, GetPVarFloat(playerid, "transX"),GetPVarFloat(playerid, "transY"), GetPVarFloat(playerid, "transZ"));

    new str[64];
    new ile = GetPVarInt(playerid, "transboxes");
    SetPVarInt(playerid, "transboxes", 0);
    new money = ile*96;
    format(str, 64, "Praca zako�czona. Przewioz�es %d paczek.", ile);
    SendClientMessage(playerid, -1, str);
    if(quiter) money/=2, ile/=2;
    format(str, 64, "Zarabiasz $%d oraz otrzymujesz %d umiej�tnosci.", money, floatround(ile/5, floatround_floor));
    SendClientMessage(playerid, 0x99311EFF, str);
    DajKase(playerid, money);

    SetVehicleHealth(veh, 1000.0);
    Gas[veh] = 100;

    PlayerInfo[playerid][pTruckSkill] += floatround(ile/5, floatround_floor);
}

TJD_CallCheckpoint(playerid, veh)
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER) return 1;
    if(GetVehicleModel(veh) == 578)
    {
        new idx = GetPVarInt(playerid, "trans");
        if(idx != 0)
        {
            if(idx%2 == 1)
            {
                idx = (idx-1)/2;

                TJD_CheckForUsedBox(veh);

                SetPVarInt(playerid, "loadTimer", SetTimerEx("TJD_LoadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, 0, TransportJobData[idx][eTJDMaxItems]));
                GameTextForPlayer(playerid, "~r~Ladowanie towaru...", TJD_LOADUNLOAD_TIME*TransportJobData[idx][eTJDMaxItems], 4);
                TogglePlayerControllable(playerid, 0);
                DisablePlayerCheckpoint(playerid);
            }
            else
            {
                idx = (idx-1)/2;

                SetPVarInt(playerid, "unloadTimer", SetTimerEx("TJD_UnloadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, 0, TransportJobData[idx][eTJDMaxItems]));
                GameTextForPlayer(playerid, "~g~Wyladowanie towaru...", TJD_LOADUNLOAD_TIME*TransportJobData[idx][eTJDMaxItems], 4);
                TogglePlayerControllable(playerid, 0);
                DisablePlayerCheckpoint(playerid);
            }
            return 1;
        }
    }
    else if(TJDVehBox[veh] != 0)
    {
        new idx = TJDVehBox[veh]-1;
        TJDBoxUsed[idx] = false;
        DestroyDynamicObject(TJDBoxes[idx]);
        TJDBoxes[idx] = 0;
        TJD_RestoreBox(idx);
        TJDVehBox[veh] = 0;
        DisablePlayerCheckpoint(playerid);
        if(GetPVarInt(playerid, "transjob") == 1)
        {
            if(gettime() - GetPVarInt(playerid, "transtime") < 6)
            {
                SendClientMessage(playerid, COLOR_GRAD2, "Za szybko.");
                return 1;
            }
            if(GLOBAL_DISABLETRUCKER) return 1;
            SetPVarInt(playerid, "transboxes", GetPVarInt(playerid, "transboxes")+1);
            new str[8];
            format(str, 8, "%d", GetPVarInt(playerid, "transboxes"));
            PlayerTextDrawSetString(playerid, TXD_TJDCounter[playerid], str);
            PlayerTextDrawShow(playerid, TXD_TJDCounter[playerid]);

            TJD_Materials+=5;
            TJD_UpdateLabel();
        }
        return 1;
    }
    return 1;
}


TJD_CallRaceCheckpoint(playerid)
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER) return;
    if(GetPVarInt(playerid, "TJDend") == 1)
    {
        TJD_JobEnd(playerid);
        DisablePlayerRaceCheckpoint(playerid);
    }
}

TJD_CallEnterVeh(playerid, veh)
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER) return;
    if(GetVehicleModel(veh) == 530)
    {
        if(GLOBAL_DISABLETRUCKER) return;
        if(GetPVarInt(playerid, "transjob") == 0)
        {
            new Float:x, Float:y, Float:z;
            GetVehiclePos(veh, x, y, z);
            if(GetPVarInt(playerid, "TJDstartend") == 0)
            {
                SetPVarFloat(playerid, "transX", x);
                SetPVarFloat(playerid, "transY", y);
                SetPVarFloat(playerid, "transZ", z);
            }
            SetPVarInt(playerid, "transjob", 1);
            SetPVarInt(playerid, "TJDstartend", 1);
            SetPVarInt(playerid, "TJDveh", veh);
        }
        TJD_CreateTXD(playerid);
    }
}

TJD_CallExitVeh(playerid)
{
    if(PlayerInfo[playerid][pJob] != JOB_TRUCKER) return;
    if(GetPVarInt(playerid, "transjob") == 1)
    {
        if(GetPVarInt(playerid, "TJDend") == 1)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Pojazd zniknie za 30 sekund, a Ty dostaniesz mniej kasy.");
        }
        else
        {
            SetPVarInt(playerid, "transjob", 0);
        }
        TJD_DestroyTXD(playerid);
    }
}

TJD_CheckForUsedBox(vehicleid)
{
    if(TJDVehBox[vehicleid] != 0)
    {
        new idx = TJDVehBox[vehicleid]-1;
        TJDBoxUsed[idx] = false;
        DestroyDynamicObject(TJDBoxes[idx]);
        TJDBoxes[idx] = 0;
        TJD_RestoreBox(idx);
        TJDVehBox[vehicleid] = 0;
        new playerid = TJDBoxOwner[idx];
        if(GetPVarInt(playerid, "transjob") == 1)
        {
            DisablePlayerCheckpoint(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            TJD_JobEnd(playerid, true);
            SetPVarInt(playerid, "transjob", 0);
        }
    }
    else if(TJDTransporter[vehicleid]-1 >= 0 && GetPlayerVehicleID(TJDTransporter[vehicleid]-1) != vehicleid)
    {
        new pid = TJDTransporter[vehicleid]-1;
        for(new i=0;i<12;i++)
        {
            if(TransObjects[pid][i] != 0)
            {
                if(IsValidDynamicObject(TransObjects[pid][i]))
                {
                    DestroyDynamicObject(TransObjects[pid][i]);
                    TransObjects[pid][i] = 0;
                }
            }
        }
    }
}

TJD_TryPickup(playerid, veh)
{
    if(TJDVehBox[veh] == 0)
    {
        new idx=-1, Float:thisdist;
        new Float:x, Float:y, Float:z, Float:a;
        GetVehiclePos(veh, x, y, z);
        if(VectorSize(TJD_BoxPos[3][0]-x,TJD_BoxPos[3][1]-y,TJD_BoxPos[3][2]-z) < 20.0)
        {
            GetVehicleZAngle(veh, a);

            x+=1.5*floatsin(-a, degrees);
            y+=1.5*floatcos(-a, degrees);

            for(new i=0;i<7;i++)
            {
                if(TJDBoxUsed[i]) continue;
                thisdist = VectorSize(TJD_BoxPos[i][0]-x,TJD_BoxPos[i][1]-y,TJD_BoxPos[i][2]-z);
                if(thisdist < 0.75)
                {
                    idx=i;
                    break;
                }
            }
            if(idx != -1)
            {
                TJDBoxUsed[idx] = true;
                TJDVehBox[veh] = idx+1;
                TJDBoxOwner[idx] = playerid;
                // AttachDynamicObjectToVehicle(TJDBoxes[idx], veh, 0.0, 0.6, 0.43, 0.0, 0.0, 0.0);

                new rand = random(2);
                switch(rand)
                {
                    case 0: SetPlayerCheckpoint(playerid, 1766.8551, -2049.2805, 12.9831, 5.0);
                    case 1: SetPlayerCheckpoint(playerid, 1766.8551, -2032.2805, 12.9831, 5.0);
                }
                SetPVarInt(playerid, "transtime", gettime());
                if(GetPVarInt(playerid, "TJDstartend") == 1 && GetPVarInt(playerid, "TJDend") == 0)
                {
                    SetPVarInt(playerid, "TJDend", 1);
                    SetPlayerRaceCheckpoint(playerid, 1, GetPVarFloat(playerid, "transX"),GetPVarFloat(playerid, "transY"), GetPVarFloat(playerid, "transZ"), 0.0, 0.0, 0.0, 2.0);
                }
            }
        }
    }
}

TJD_RestoreBox(id)
{
    if(TJDBoxes[id] != 0) DestroyDynamicObject(TJDBoxes[id]);
    TJDBoxes[id] = CreateDynamicObject(1558, TJD_BoxPos[id][0],TJD_BoxPos[id][1],TJD_BoxPos[id][2],0.0,0.0,0.0);
}

public TJDTimer()
{
    for(new i=0;i<7;i++)
    {
        if(!TJDBoxUsed[i])
        {
            SetDynamicObjectPos(TJDBoxes[i], TJD_BoxPos[i][0], TJD_BoxPos[i][1], TJD_BoxPos[i][2]);
            SetDynamicObjectRot(TJDBoxes[i], 0.0, 0.0, 0.0);
        }
    }
}

public TJD_LoadTime(playerid, count, maxcount)
{
    new idx = (GetPVarInt(playerid, "trans")-1)/2;
    if(count == maxcount)
    {
        SetPVarInt(playerid, "trans", GetPVarInt(playerid, "trans")+1);
        SetPVarInt(playerid, "transtime", gettime());
        SetPlayerCheckpoint(playerid, TransportJobData[idx][eTJDEndX], TransportJobData[idx][eTJDEndY], TransportJobData[idx][eTJDEndZ], 5.0);
        SendClientMessage(playerid, 0x00FF00FF, "Towar za�adowany, udaj si� na miejsce wypakunku.");
        TogglePlayerControllable(playerid, 1);
    }
    else
    {
        // if(!IsPlayerInAnyVehicle(playerid))
        // {
        //     for(new i=0;i<12;i++)
        //     {
        //         if(TransObjects[playerid][i] != 0)
        //         {
        //             if(IsValidDynamicObject(TransObjects[playerid][i]))
        //             {
        //                 DestroyDynamicObject(TransObjects[playerid][i]);
        //                 TransObjects[playerid][i] = 0;
        //             }
        //         }
        //     }
        //     return;
        // }

        // TransObjects[playerid][count] = CreateDynamicObject(TransportJobData[idx][eTJDModel], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

        // new Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz;

        // new Float:step = floatdiv(floatsub(TJD_PLACE_MAX_Y, TJD_PLACE_MIN_Y),(maxcount));

        // if(maxcount > 5)
        // {
        //     if(count%2==0)
        //     {
        //         x = -TJD_PLACE_X;
        //         y = ((TJD_PLACE_MIN_Y+TJD_PLACE_MAX_Y)/2) - (step*(count-(maxcount/2)));
        //     }
        //     else
        //     {
        //         x = TJD_PLACE_X;
        //         y = ((TJD_PLACE_MIN_Y+TJD_PLACE_MAX_Y)/2) - (step*((count-1)-(maxcount/2)));
        //     }
        // }
        // else y = ((TJD_PLACE_MIN_Y+TJD_PLACE_MAX_Y)/2) - (step*(count-(maxcount/2)));
        // z = TJD_PLACE_Z;


        // if(TransportJobData[idx][eTJDModel] == 1454) rx = 90.0, z-=0.1;
        // else if(TransportJobData[idx][eTJDModel] == 1217) z -= 0.3;
        // else if(TransportJobData[idx][eTJDModel] == 1271)
        // {
        //     SetDynamicObjectMaterial(TransObjects[playerid][count], 0, 3630, "compthotrans_la", "sjmlawarplt3");
        //     z -= 0.4;
        //     if(count%2==0) x = -(TJD_PLACE_X/2);
        //     else x = TJD_PLACE_X/2;
        // }
        // else if(TransportJobData[idx][eTJDModel] == 3035)
        // {
        //     rz = 90.0;
        // }
        // else if(TransportJobData[idx][eTJDModel] == 944 && maxcount == 5)
        // {
        //     y+=0.6;
        // }

        // AttachDynamicObjectToVehicle(TransObjects[playerid][count], GetPlayerVehicleID(playerid), x,y,z, rx, ry, rz);

        TJDTransporter[GetPlayerVehicleID(playerid)] = playerid+1;

        count++;
        // Streamer_Update(playerid);
        SetTimerEx("TJD_LoadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, count, maxcount);
    }
}

public TJD_UnloadTime(playerid, count, maxcount)
{
    if(count == maxcount)
    {
        new idx = (GetPVarInt(playerid, "trans")-1)/2;
        SetPVarInt(playerid, "trans", 0);
        new str[64], Float:speed, ile;
        DisablePlayerCheckpoint(playerid);
		if(idx == -1) return;

        if(TransportJobData[idx][eTJDStartX] == 0.0) speed = floatdiv(VectorSize(TransportJobData[idx][eTJDEndX] - TransportJobData[0][eTJDStartX], TransportJobData[idx][eTJDEndY] - TransportJobData[0][eTJDStartY], TransportJobData[idx][eTJDEndZ] - TransportJobData[0][eTJDStartZ]),(gettime()-GetPVarInt(playerid, "transtime")));
        else speed = floatdiv(VectorSize(TransportJobData[idx][eTJDEndX] - TransportJobData[idx][eTJDStartX], TransportJobData[idx][eTJDEndY] - TransportJobData[idx][eTJDStartY], TransportJobData[idx][eTJDEndZ] - TransportJobData[idx][eTJDStartZ]),(gettime()-GetPVarInt(playerid, "transtime")));
        if(speed < 8.5) ile = TransportJobData[idx][eTJDMoney];
        else if(speed > 30) ile = -TransportJobData[idx][eTJDMoney];
		else ile = floatround(TransportJobData[idx][eTJDMoney] - ((speed - 8.5) * 100));

        format(str, 64, "Towar wy�adowany, zarabiasz %d$", ile);
        SendClientMessage(playerid, 0x00FF00FF, str);

        DajKase(playerid, ile);
        new lSkill = floatround((ile*8)/((TransportJobData[idx][eTJDMoney]*2)+(TransportJobData[idx][eTJDMoney]/4)));
        if(lSkill > 0)
        {
            format(str, 64, "+ %d skilla", lSkill);
            SendClientMessage(playerid, COLOR_GRAD2, str);
            PlayerInfo[playerid][pTruckSkill]++;
        }

        if(ile != TransportJobData[idx][eTJDMoney]) SendClientMessage(playerid, 0x00FF00FF, "Pami�taj, �e im szybciej jedziesz, tym wi�cej gubisz towaru!");
        TogglePlayerControllable(playerid, 1);
    }
    else
    {
        // DestroyDynamicObject(TransObjects[playerid][count]);
        // TransObjects[playerid][count] = 0;
        count++;
        SetTimerEx("TJD_UnloadTime", TJD_LOADUNLOAD_TIME, 0, "iii", playerid, count, maxcount);
    }
}

TJD_DestroyTXD(playerid)
{
    PlayerTextDrawDestroy(playerid, TXD_TJDCounter[playerid]);
    TextDrawHideForPlayer(playerid, TXD_TJDBg);
    TextDrawHideForPlayer(playerid, TXD_TJDImg);

    SetPlayerWorldBounds(playerid, 20000.0000, -20000.0000, 20000.0000, -20000.0000);
}

TJD_CreateTXD(playerid)
{
    new str[8];
    format(str, 8, "%d", GetPVarInt(playerid, "transboxes"));
    TXD_TJDCounter[playerid] = CreatePlayerTextDraw(playerid, 574.000000, 114.000000, str);
    PlayerTextDrawAlignment(playerid, TXD_TJDCounter[playerid], 2);
    PlayerTextDrawBackgroundColor(playerid, TXD_TJDCounter[playerid], 255);
    PlayerTextDrawFont(playerid, TXD_TJDCounter[playerid], 3);
    PlayerTextDrawLetterSize(playerid, TXD_TJDCounter[playerid], 0.600000, 3.000000);
    PlayerTextDrawColor(playerid, TXD_TJDCounter[playerid], -1);
    PlayerTextDrawSetOutline(playerid, TXD_TJDCounter[playerid], 0);
    PlayerTextDrawSetProportional(playerid, TXD_TJDCounter[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TXD_TJDCounter[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, TXD_TJDCounter[playerid], 0);
    PlayerTextDrawShow(playerid, TXD_TJDCounter[playerid]);
    TextDrawShowForPlayer(playerid, TXD_TJDBg);
    TextDrawShowForPlayer(playerid, TXD_TJDImg);

    SetPlayerWorldBounds(playerid, 1812.0, 1685.0, -2007.0, -2077.0);
}

//--------------------------------------------------

public BBD_Timer()
{
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerInAnyVehicle(i)) continue;
        for(new j=0;j<MAX_BOOMBOX;j++)
        {
            if(BoomBoxData[j][BBD_x] == 0.0 || !BoomBoxData[j][BBD_Standby]) continue;
            if(IsPlayerInRangeOfPoint(i, MAX_BBD_DISTANCE, BoomBoxData[j][BBD_x], BoomBoxData[j][BBD_y], BoomBoxData[j][BBD_z]))
            {
                if(GetPVarInt(i, "bbdid") != BoomBoxData[j][BBD_ID])
                {
                    SetPVarInt(i, "bbdid", BoomBoxData[j][BBD_ID]);
                    PlayAudioStreamForPlayer(i, BoomBoxData[j][BBD_URL], BoomBoxData[j][BBD_x], BoomBoxData[j][BBD_y], BoomBoxData[j][BBD_z], MAX_BBD_DISTANCE, 1);
                }
                break;
            }
            else if(GetPVarInt(i, "bbdid") == BoomBoxData[j][BBD_ID])
            {
                SetPVarInt(i, "bbdid", 0);
                StopAudioStreamForPlayer(i);
            }
        }
    }
}

BBD_Turn(id)
{
    if(BoomBoxData[id][BBD_Standby])
    {
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(IsPlayerInRangeOfPoint(i, MAX_BBD_DISTANCE, BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z]))
            {
                if(GetPVarInt(i, "bbdid") != BoomBoxData[id][BBD_ID] || BoomBoxData[id][BBD_Refresh])
                {
                    SetPVarInt(i, "bbdid", BoomBoxData[id][BBD_ID]);
                    PlayAudioStreamForPlayer(i, BoomBoxData[id][BBD_URL], BoomBoxData[id][BBD_x], BoomBoxData[id][BBD_y], BoomBoxData[id][BBD_z], MAX_BBD_DISTANCE, 1);
                }
            }
        }
    }
    else
    {
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPVarInt(i, "bbdid") == BoomBoxData[id][BBD_ID])
            {
                SetPVarInt(i, "bbdid", 0);
                StopAudioStreamForPlayer(i);
            }
        }
    }
    if(BoomBoxData[id][BBD_Refresh]) BoomBoxData[id][BBD_Refresh] = false;
}

BBD_Pickup(playerid, id)
{
    if(BoomBoxData[id][BBD_Carried]-1 >= 0) return;
    if(BoomBoxData[id][BBD_Standby])
    {
        BoomBoxData[id][BBD_Standby] = false;
        BBD_Turn(id);
        BoomBoxData[id][BBD_Standby] = true;
    }
    BoomBoxData[id][BBD_x] = 0;
    BoomBoxData[id][BBD_y] = 0;
    BoomBoxData[id][BBD_z] = 0;
    BoomBoxData[id][BBD_Carried] = playerid+1;
    SetPVarInt(playerid, "boomboxid", id);

    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_Out", 4.1, 0, 1, 1, 0, 0);

    SetPlayerAttachedObject(playerid, 9, 2226, 5, 0.42, 0.0, 0.0, 90.0, 270.0, 90.0);

    if(BoomBoxData[id][BBD_Obj] != 0) DestroyDynamicObject(BoomBoxData[id][BBD_Obj]);
}

BBD_Putdown(playerid, id)
{
    if(BoomBoxData[id][BBD_Carried]-1 < 0) return;
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    x+=0.9*floatsin(-a, degrees);
    y+=0.9*floatcos(-a, degrees);

    BoomBoxData[id][BBD_x] = x;
    BoomBoxData[id][BBD_y] = y;
    BoomBoxData[id][BBD_z] = z;
    BoomBoxData[id][BBD_Carried] = 0;

    RemovePlayerAttachedObject(playerid, 9);

    ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Crouch_In", 4.1, 0, 1, 1, 0, 0);

    BoomBoxData[id][BBD_Obj] = CreateDynamicObject(2226, x, y, z-0.95, 0.0, 0.0, a+180.0);

    if(GetPVarInt(playerid, "zoneid") == -1) return;
    else if(ZoneControl[GetPVarInt(playerid, "zoneid")] != GetPlayerFraction(playerid) && ZoneControl[GetPVarInt(playerid, "zoneid")]-100 != GetPlayerOrg(playerid)) return;

    BBD_Turn(id);
}

BBD_GetID()
{
    for(new i=0;i<MAX_BOOMBOX;i++)
    {
        if(BoomBoxData[i][BBD_ID] == 0) return i;
    }
    return -1;
}

public UnhireRentCar(playerid, veh)
{
    //Rent car system
    new caruid;
    if((caruid = VehicleUID[veh][vUID]) == 0) return 1;
    if(CarData[caruid][c_Owner] == RENT_CAR && CarData[caruid][c_OwnerType] == CAR_OWNER_SPECIAL)
    {
        if(CarData[caruid][c_Rang] != 0)
        {
            if(IsPlayerConnected(playerid))
            {
                if(GetPlayerVehicleID(playerid) == veh)
                {
                    SetVehicleVelocity(veh, 0.0, 0.0, 0.0);
                    RemovePlayerFromVehicleEx(playerid);
                    SendClientMessage(playerid, COLOR_YELLOW, "Czas wypo�yczenia min��!");
                }
                SetPVarInt(playerid, "rentTimer", 0);
            }
            CarData[caruid][c_Rang] = 0;
        }
    }
    return 1;
}

EDIT_ShowRangNames(playerid, typ, uid, bool:edit=false)
{
    new str[512];
    for(new i=0;i<10;i++)
    {
        if(strlen((typ == 0) ? (FracRang[uid][i]) : (OrgRank[uid][i])) < 2)
            format(str, 512, "%s[%d] -\n", str, i);
        else
            format(str, 512, "%s[%d] %s\n", str, i, (typ == 0) ? (FracRang[uid][i]) : (OrgRank[uid][i]));
    }
    if(edit) ShowPlayerDialogEx(playerid, D_EDIT_RANG_SET, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}rang", str, "Zmie�", "Wr��");
    else ShowPlayerDialogEx(playerid, D_INFO, DIALOG_STYLE_LIST, "{8FCB04}Nazwy {FFFFFF}rang", str, "Wyjdz", "");
    return 1;
}

EDIT_SaveRangs(typ, uid)
{
    new lStr[256], lStr_escaped[256], query[512];

    for(new i=0;i<MAX_RANG;i++)
    {
        if(strlen((typ == 0) ? (FracRang[uid][i]) : (OrgRank[uid][i])) < 2)
            format(lStr, 256, "%s-, ", lStr);
        else
            format(lStr, 256, "%s%s, ", lStr, (typ == 0) ? (FracRang[uid][i]) : (OrgRank[uid][i]));
    }
    strdel(lStr, strlen(lStr)-2, strlen(lStr));

    format(query, 512, "SELECT `ID` FROM mru_nazwyrang WHERE `ID`='%d' AND `typ`='%d'", uid, typ+1);
    mysql_query(query);
    mysql_store_result();
	mysql_real_escape_string(lStr, lStr_escaped);
    if(mysql_num_rows())
    {
        format(query, 512, "UPDATE mru_nazwyrang SET rangi='%s' WHERE `ID`='%d' AND `typ`='%d'", lStr_escaped, uid, typ+1);
    }
    else
    {
        format(query, 512, "INSERT INTO mru_nazwyrang (rangi, ID, typ) VALUES ('%s', '%d', '%d')", lStr_escaped, uid, typ+1);
    }
	mysql_free_result();
    mysql_query(query);
    RANG_ApplyChanges[typ][uid] = false;
    return 1;
}

forward TourCamera(playerid, step);
public TourCamera(playerid, step)
{
    if(GetPlayerState(playerid) != 0) return 0;
    if(gettime() - GetPVarInt(playerid, "tourcameratick") < 5) return 0;
    SetPVarInt(playerid, "tourcamerastep", step);
    SetPVarInt(playerid, "tourcameratick", gettime());
    if(GetPVarInt(playerid, "tourcameratimer") != 0)
    {
        SetPVarInt(playerid, "tourcameratimer", 0);
        KillTimer(GetPVarInt(playerid, "tourcameratimer"));
    }
    TogglePlayerControllable(playerid, 0);
    new lTime=0;
    switch(step)
    {
        case 0:
        {
            InterpolateCameraPos(playerid, 1854.0327, -1845.7213, 32.9084, 1802.8463, -1853.9320, 24.3721, 12000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1802.8463, -1853.9320, 24.3721, 1802.0990, -1854.0040, 24.4220, 11000, CAMERA_MOVE);
            SetPlayerPos(playerid, 1802.8463, -1853.9320, 0.0);
            Streamer_UpdateEx(playerid, 1802.8463, -1853.9320, 0.0);
            lTime = 13000;
        }
        case 1:
        {
            InterpolateCameraPos(playerid, 1597.6156, -1731.9628, 22.5997, 1481.4576, -1727.4557, 15.2575, 12000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1481.4576, -1727.4557, 15.2575, 1481.4741, -1728.4609, 15.6023, 11000, CAMERA_MOVE);
            SetPlayerPos(playerid,1597.6156, -1731.9628, 0.0);
            Streamer_UpdateEx(playerid, 1597.6156, -1731.9628, 0.0);
            lTime = 12000;
        }
        case 2:
        {
            InterpolateCameraPos(playerid, 1330.4507, -1423.9467, 69.1760, 1216.2252, -1343.8439, 18.0992, 15000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1216.2252, -1343.8439, 18.0992, 1215.3202, -1343.4011, 18.0841, 14000, CAMERA_MOVE);
            SetPlayerPos(playerid, 1216.2252, -1343.8439, 0.0);
            Streamer_UpdateEx(playerid, 1216.2252, -1343.8439, 0.0);
            lTime = 16000;
        }
        case 3:
        {
            InterpolateCameraPos(playerid, 1890.8367, -2133.2148, 31.2670, 1801.7451, -2073.0071, 18.8819, 9000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 1801.7451, -2073.0071, 18.8819, 1800.7998, -2072.6538, 18.7769, 8000, CAMERA_MOVE);
            SetPlayerPos(playerid, 1801.7451, -2073.0071,0.0);
            Streamer_UpdateEx(playerid, 1801.7451, -2073.0071, 0.0);
            lTime = 10000;
        }
        case 4:
        {
            InterpolateCameraPos(playerid, 2212.6924, -1750.6774, 15.7084, 2410.6738, -1750.8768, 15.7241, 15000, CAMERA_MOVE);
            InterpolateCameraLookAt(playerid, 2410.6738, -1750.8768, 15.7241, 2409.6650, -1750.8837, 15.7341, 12000, CAMERA_MOVE);
            SetPlayerPos(playerid, 2410.6738, -1750.8768, 0.0);
            Streamer_UpdateEx(playerid, 2410.6738, -1750.8768, 0.0);
            lTime = 16000;
        }
        case 5:
        {
            SetPlayerCameraPos(playerid,421.1918, -1756.8279, 12.7905);
            SetPlayerCameraLookAt(playerid, 420.8176, -1757.7660, 12.7204);
            SetPlayerPos(playerid, 421.1918, -1756.8279, 0.0);
            Streamer_UpdateEx(playerid, 421.1918, -1756.8279, 0.0);
        }
    }
    if(lTime != 0)
        SetPVarInt(playerid, "tourcameratimer", SetTimerEx("TourCamera", lTime, 0, "dd", playerid, step+1));
    return 1;
}

timer ViceCityTour[5000](playerid, bool:debugMode)
{
	if(gPlayerLogged[playerid])
	{
		return 0;
	}
	new step = random(8);
    
	TogglePlayerControllable(playerid, 0);
	TogglePlayerSpectating(playerid, true);

	new transitionTime;
    switch(step)
    {
        case 0:
        {
			// Look at motel Vice City Beach
			InterpolateCameraPos(playerid,
				-3936.6089, 901.0652, 32.7042,
				-3958.3398, 944.7529, 15.6349,
				12000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-3951.6792, 936.0242, 18.2425,
				-3954.2974, 992.3010, 11.8739,
				11000, CAMERA_MOVE);
			SetPlayerPos(playerid, -3961.4126, 971.4409, 0.0);
			Streamer_UpdateEx(playerid, -3961.4126, 971.4409, 0.0);
			transitionTime = 13000;
        }
        case 1:
        {
            // Look at motel Vice City Beach from far away
			InterpolateCameraPos(playerid,
				-3789.4600, 673.4785, 50.5040,
				-3938.2329, 931.4045, 40.0869,
				12000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-3807.8213, 717.3250, 45.7091,
				-3955.4219, 956.2981, 13.4688,
				11000, CAMERA_MOVE);
			SetPlayerPos(playerid, -3961.4126, 971.4409, 0.0);
			Streamer_UpdateEx(playerid, -3961.4126, 971.4409, 0.0);
            transitionTime = 13000;
        }
        case 2:
        {
            // Look at Malibu Club
			InterpolateCameraPos(playerid,
				-3717.0405, 2129.9884, 10.3759,
				-3682.6313, 2145.2284, 6.6211,
				12000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-3715.4146, 2151.9958, 8.1499,
				-3695.9390, 2158.4084, 6.6843,
				11000, CAMERA_MOVE);
			SetPlayerPos(playerid, -3704.8882, 2164.8639, 0.0);
			Streamer_UpdateEx(playerid, -3704.8882, 2164.8639, 0.0);
            transitionTime = 12000;
        }
        case 3:
        {
            // Look at Malibu Club c.d.
			InterpolateCameraPos(playerid,
				-3682.6313, 2145.2284, 6.6211,
				-3673.9155, 2191.1435, 7.1,
				12000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-3695.9390, 2158.4084, 6.6843,
				-3692.4189, 2191.1161, 7.7,
				11000, CAMERA_MOVE);
			SetPlayerPos(playerid, -3704.8882, 2164.8639, 0.0);
			Streamer_UpdateEx(playerid, -3704.8882, 2164.8639, 0.0);
            transitionTime = 12000;
        }
        case 4:
        {
            // Look at Vercetti's Mansion
			InterpolateCameraPos(playerid,
				-4574.9687, 1516.5393, 31.5133,
				-4578.7266, 1629.7839, 6.9646,
				12000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-4574.5474, 1568.2449, 18.7434,
				-4578.6851, 1645.0697, 5.5163,
				11000, CAMERA_MOVE);
			SetPlayerPos(playerid, -4579.8364, 1631.0680, 0.0);
			Streamer_UpdateEx(playerid, -4579.8364, 1631.0680, 0.0);
            transitionTime = 13000;
        }
        case 5:
        {
            // Look at Love Fist street
			InterpolateCameraPos(playerid,
				-5072.5322, 3065.5021, 20.3969,
				-5062.6592, 3383.1745, 12.9014,
				8000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-5070.4790, 3091.3341, 18.7814,
				-5062.2539, 3412.9454, 12.0244,
				8000, CAMERA_MOVE);
			SetPlayerPos(playerid, -5062.7104, 3414.4953, 0.0);
			Streamer_UpdateEx(playerid, -5062.7104, 3414.4953, 0.0);
            transitionTime = 8000;
        }
		case 6:
		{
			// Look at motel halway Window
			InterpolateCameraPos(playerid,
				-3626.8403, 2267.7020, 48.5019,
				-3641.1631, 2267.4291, 48.7707,
				8000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-3642.8276, 2267.2149, 48.2095,
				-3654.2837, 2267.0452, 46.7247,
				12000, CAMERA_MOVE);
			SetPlayerPos(playerid, -3632.1997, 2261.4823, 0.0);
			Streamer_UpdateEx(playerid, -3632.1997, 2261.4823, 0.0);
            transitionTime = 12000;
		}
		case 7:
		{
			// Look at destroyed building
			InterpolateCameraPos(playerid,
				-4134.2095, 2058.3291, 29.3655,
				-4049.2886, 1864.1302, 23.7590,
				12000, CAMERA_MOVE);
			InterpolateCameraLookAt(playerid,
				-4116.8853, 2022.4866, 31.0486,
				-4066.0747, 1828.5844, 24.9903,
				11000, CAMERA_MOVE);
			SetPlayerPos(playerid, -4063.0259, 1865.1730, 0.0);
			Streamer_UpdateEx(playerid, -4063.0259, 1865.1730, 0.0);
			transitionTime = 13000;
		}
    }
    if(transitionTime != 0)
	{
		defer ViceCityTour[transitionTime](playerid, debugMode);
	}
    return 1;
}
//--------------------------------------------------

GetRandomStealableVehModel()
{
	new randa = true_random(53);
	new model;

	if(randa == 0)
	{
		model = randa;
	}
	else if(randa <= 8)
	{
		model = floatround(float(randa) / 2.0, floatround_ceil);
	}
	else if(randa <= 32)
	{
		model = floatround(float(randa) / 3.0, floatround_floor) + 2;
	}
	else
	{
		model = floatround(float(randa) / 4.0, floatround_ceil) + 4;
	}

	return model;
}


ZaladujSamochodyDoKradziezy()
{
    new id;

    for(new i = 0; i < 183; i++)
	{
		if(i >= 165) // Faggio dla z�odziej�w aut w dziuplach - zawsze ma by� okre�lony model
		{
			id = AddCar(i, 462, 3, 3, 180);
		}
		else
		{
        	id = AddCar(i);
		}
    }

    CAR_End = id;
    printf("Wczytano %d aut do kradzie�y", CAR_End);
	return 1;
}

Support_GetID()
{
    for(new i=0;i<MAX_TICKETS;i++)
    {
        if(TICKET[i][suppValid]) continue;
        return i;
    }
    return -1;
}

Support_Add(caller, sub[], desc[])
{
    new id = Support_GetID();
    if(id == -1) return -1;

    TICKET[id][suppValid] = true;
    TICKET[id][suppCaller] = caller;
    strdel(TICKET[id][suppSub], 0, 16);
    strins(TICKET[id][suppSub], sub, 0, 16);

    strdel(TICKET[id][suppDesc], 0, 86);
    strins(TICKET[id][suppDesc], desc, 0, 86);
    return id;
}

Support_ClearTicket(id)
{
    TICKET[id][suppValid] = false;
    SetPVarInt(TICKET[id][suppCaller], "active_ticket", 0);

    foreach(new i : Player)
        if(GetPVarInt(i, "support_dialog") == 1)
            Support_ShowTickets(i);
    return 1;
}

Support_ShowTickets(playerid)
{
    new str[1024], shortname[24];
    for(new i=0;i<MAX_TICKETS;i++)
    {
        if(!TICKET[i][suppValid]) continue;
        if(!IsPlayerConnected(TICKET[i][suppCaller]))
        {
            Support_ClearTicket(i);
            continue;
        }
        strmid(shortname, TICKET[i][suppDesc], 0, 24);

        format(str, sizeof(str), "%s%d %s\t%s\t%s\n", str, i, name_add_tabs(GetNick(TICKET[i][suppCaller])), name_add_tabs(TICKET[i][suppSub]), shortname);
    }
    if(strlen(str) > 10)
    {
        ShowPlayerDialogEx(playerid, D_SUPPORT_LIST, DIALOG_STYLE_LIST, "Zg�oszenia", str, "Wybierz", "Wyjd�");
        SetPVarInt(playerid, "support_dialog", 1);
    }
    else
    {
        if(GetPVarInt(playerid, "support_dialog") == 1)
        {
            ShowPlayerDialogEx(playerid, -1, -1, "-1", "-1", "-1", "-1");
            SetPVarInt(playerid, "support_dialog", 0);
        }
    }
    return 1;
}

name_add_tabs(names[])
{
	new ret[40];
	if(strlen(names) <= 8)	format(ret, sizeof(ret), "%s\t\t", names);
	else			format(ret, sizeof(ret), "%s\t", names);
	return ret;
}

RGBAtoRGB(color)
{
    return (color & ~0xFF) >>> 8;
}

WeaponAC(playerid)
{	
	new weapons[13][2];
 
	for (new i = 1; i <= 12; i++)
	{
		GetPlayerWeaponData(playerid, i, weapons[i][0], weapons[i][1]);
		if(weapons[i][0] != 0 && CheckWeaponAC(playerid, i, weapons[i][0]))
		{
		    if(weapons[i][0] == 46) return false;
			else return i;
		}
	}
	return false;
}

//returns false if no cheat detected
CheckWeaponAC(playerid, slot, gun)
{
	if(slot == 1 && PlayerInfo[playerid][pGun1] != gun) return slot;
	else if(slot == 2 && PlayerInfo[playerid][pGun2] != gun) return slot;
	else if(slot == 3 && PlayerInfo[playerid][pGun3] != gun) return slot;
	else if(slot == 4 && PlayerInfo[playerid][pGun4] != gun) return slot;
	else if(slot == 5 && PlayerInfo[playerid][pGun5] != gun) return slot;
	else if(slot == 6 && PlayerInfo[playerid][pGun6] != gun) return slot;
	else if(slot == 7 && PlayerInfo[playerid][pGun7] != gun) return slot;
	else if(slot == 8 && PlayerInfo[playerid][pGun8] != gun) return slot;
	else if(slot == 9 && PlayerInfo[playerid][pGun9] != gun) return slot;
	else if(slot == 10 && PlayerInfo[playerid][pGun10] != gun) return slot;
	else if(slot == 11 && PlayerInfo[playerid][pGun11] != gun) return slot;
	return 0;
}

WeaponHackCheck(issuerid, weaponid)
{
	if(weaponid == 37 || weaponid == 51 || weaponid == 46)
	{
		
	}
    else if(weaponid > 2 && weaponid < 39)
    {
		return CheckWeaponAC(issuerid, GetWeaponSlot(weaponid), weaponid);
    }
	return false;
}
BuyVinylDrink(playerid, drinkID, dLVL, dAction)
{
	new dName[32], dCost;
	format(dName, 32, vinylDrinkNames[drinkID]);
	dCost = vinylDrinkCosts[drinkID];
	new string[128];
	if(GetPVarInt(playerid, "jestPrzyBarzeVIP") == 1)
	{
		if(kaska[playerid] >= (dCost/2))
		{
			format(string, sizeof(string), "%s kupi� w barze %s - zaczyna pi�", GetNick(playerid), dName);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerDrunkLevel(playerid, dLVL);
			SetPlayerSpecialAction(playerid, dAction);
			ZabierzKase(playerid, (dCost/2));
			GenerateFrontBusinessIncome(40, (dCost/2));
		}
		else
		{
			sendErrorMessage(playerid, "Nie masz takiej ilo�ci got�wki!"); 
			return 1;
		}
	}
	else if(GetPVarInt(playerid, "jestPrzyBarzeVIP") == 0)
	{
		if(kaska[playerid] >= dCost)
		{
			format(string, sizeof(string), "%s kupi� w barze %s - zaczyna pi�", GetNick(playerid), dName);
			ProxDetector(10.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			SetPlayerDrunkLevel(playerid, dLVL);
			SetPlayerSpecialAction(playerid, dAction);
			ZabierzKase(playerid, (dCost));
			GenerateFrontBusinessIncome(40, dCost);
		}
		else
		{
			sendErrorMessage(playerid, "Nie masz takiej ilo�ci got�wki!");
			return 1;
		}
	}
	return 1;
}
SetPlayerLocal(playerid, wartosc)
{
	PlayerInfo[playerid][pLocal] = wartosc;
	return 1;
}
GetPlayerLocal(playerid)
{
	new wartoscLocalu; 
	wartoscLocalu = PlayerInfo[playerid][pLocal];
	return wartoscLocalu;
}
SprawdzMuzyke(playerid) 
{
	if(muzykaON[11] == 1 && PlayerInfo[playerid][pLocal] == PLOCAL_FRAC_DMV)
	{
		PlayAudioStreamForPlayer(playerid, muzykaURL[11][muzykaString]);
	}
	if(muzykaON[2] == 1 && PlayerInfo[playerid][pLocal] == PLOCAL_FRAC_FBI)
	{
	
	
	}
	return 1;
}
ShowPersonalization(playerid, value)
{
	new persona_A[64];
	new persona_B[64];
	new persona_C[64];
	new persona_D[64];
	new string[356]; 
	if(value == 1)
	{
		if(PlayerPersonalization[playerid][PERS_LICZNIK] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Licznik w pojazdach\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_LICZNIK] == 0)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Licznik w pojazdach\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_CB] == 1)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "CB-RADIO\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_CB] == 0)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "CB-RADIO\t{80FF00}ON\n", 0);
		}
		format(string, sizeof(string), "%s%s", persona_A, persona_B);
		ShowPlayerDialogEx(playerid, D_PERS_VEH, DIALOG_STYLE_TABLIST, "Mrucznik Role Play", string, "Akceptuj", "Wyjdz");
	}
	if(value == 2)
	{
		if(PlayerPersonalization[playerid][PERS_AD] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Og�oszenia [AD]\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_AD] == 0)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Og�oszenia [AD]\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_NEWBIE] == 1)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "Newbie Chat\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_NEWBIE] == 0)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "Newbie Chat\t{80FF00}ON\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_FINFO] == 1)
		{
			strdel(persona_C, 0, 64);
			strins(persona_C, "Og�oszenia FRAKCJI\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_FINFO] == 0)
		{
			strdel(persona_C, 0, 64);
			strins(persona_C, "Og�oszenia FRAKCJI\t{80FF00}ON\n", 0);	
		}
		format(string, sizeof(string), "%s%s%s", persona_A, persona_B, persona_C);
		ShowPlayerDialogEx(playerid, D_PERS_CHAT, DIALOG_STYLE_TABLIST, "Mrucznik RP", string, "Akceptuj", "Odrzu�"); 

	}
	if(value == 3)
	{
		if(PlayerPersonalization[playerid][PERS_REPORT] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Reporty\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_REPORT] == 0)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Reporty\t{80FF00}ON\n ", 0);
		}
		if(PlayerPersonalization[playerid][WARNDEATH] == 1)
		{
			strdel(persona_B, 0, 64); 
			strins(persona_B,"Death Warning\t{FF6A6A}OFF\n", 0);
		}
		else if(PlayerPersonalization[playerid][WARNDEATH] == 0)
		{
			strdel(persona_B, 0, 64); 
			strins(persona_B,"Death Warning\t{80FF00}ON\n", 0);
		}
		format(string, sizeof(string), "%s%s", persona_A, persona_B);
		ShowPlayerDialogEx(playerid, D_PERS_ADMIN, DIALOG_STYLE_TABLIST, "Mrucznik Role Play", string, "Akceptuj", "Wyjdz");
	}
	if(value == 4)
	{
		if(PlayerPersonalization[playerid][PERS_KB] == 0)
		{
			strdel(persona_A, 0, 64); 
			strins(persona_A, "Przelew Kontem Bankowym\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_KB] == 1)
		{
			strdel(persona_A, 0, 64);
			strins(persona_A, "Przelew Kontem Bankowym\t{FF6A6A}OFF\n", 0);
		}
		if(PlayerPersonalization[playerid][PERS_NICKNAMES] == 0)
		{
			strdel(persona_B, 0, 64); 
			strins(persona_B, "Wy�wietlanie nick�w\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_NICKNAMES] == 1)
		{
			strdel(persona_B, 0, 64);
			strins(persona_B, "Wy�wietlanie nick�w\t{FF6A6A}OFF\n",0);
		}
		if(PlayerPersonalization[playerid][PERS_KARYTXD] == 0)
		{
			strdel(persona_C, 0, 64);
			strins(persona_C, "Kary w TXD\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_KARYTXD] == 1)
		{
			strdel(persona_C, 0, 64); 
			strins(persona_C, "Kary w TXD\t{FF6A6A}OFF\n", 0); 
		}
		if(PlayerPersonalization[playerid][PERS_GUNSCROLL] == 0)
		{
			strdel(persona_D, 0, 64);
			strins(persona_D, "Auto-GUI po zmianie broni\t{80FF00}ON\n", 0);
		}
		else if(PlayerPersonalization[playerid][PERS_GUNSCROLL] == 1)
		{
			strdel(persona_D, 0, 64); 
			strins(persona_D, "Auto-GUI po zmianie broni\t{FF6A6A}OFF\n", 0); 
		}
		format(string, sizeof(string), "%s%s%s%s", persona_A, persona_B, persona_C, persona_D);
		ShowPlayerDialogEx(playerid, D_PERS_INNE, DIALOG_STYLE_TABLIST, "Mrucznik Role Play", string, "Akceptuj", "Wyjdz"); 
	}
		 
	return 1;
}

stock SetPlayerTW(playerid, valueTime, time, weather)
{
	SetTAWForPlayer[playerid] = SetTimerEx("SetTimeAndWeather", valueTime,0,"d",playerid);
	SetPVarInt(playerid, "TimeToSet", time); 
	SetPVarInt(playerid, "WeatherToSet", weather); 
	sendTipMessage(playerid, "Trwa inicjowanie pogody i czasu - chwil� to potrwa!"); 
	return 1;
}

forward OnPlayerTakeDamageWeaponHack(playerid, weaponid, fakekillid);
public OnPlayerTakeDamageWeaponHack(playerid, weaponid, fakekillid)
{
	if(WeaponHackCheck(playerid, weaponid) > 0 && PlayerInfo[playerid][pAdmin] < 1 && IsPlayerConnected(fakekillid) && PlayerInfo[fakekillid][pLevel] > 1)
	{
		new string[128];
		format(string, sizeof string, "ACv2 [#2002]: %s mo�e mie� weapon hack. | Je�li fakekill, to: %s", GetNickEx(playerid), GetPlayerLogName(fakekillid));
		SendCommandLogMessage(string);
		Log(warningLog, INFO, "ACv2 [#2002]: %s mo�e mie� weapon hack. | Je�li fakekill, to: %s", GetPlayerLogName(playerid), GetPlayerLogName(fakekillid));
		return 1;
	}
	return 0;
}
RespawnVehicleEx(vehID)
{
	SetVehicleToRespawn(vehID);
	SetVehicleVirtualWorld(vehID, CarData[VehicleUID[vehID][vUID]][c_VW]);
	return 1;
}

stock GetVehicleDriverID(vehicleid)
{
    foreach(new i : Player) 
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i, vehicleid))
		{
			return i;
		}
	}
    return -1;
}

stock IsVehicleOccupied(vehicleid)
{
    foreach(new i : Player) 
	{
		if(GetPlayerState(i) == PLAYER_STATE_DRIVER && IsPlayerInVehicle(i, vehicleid))
		{
			return 1;
		}
	}
    return 0;
}

stock IsVehicleRangeOfPoint(vehicleid,Float:range,Float:x,Float:y,Float:z)
{
    if(vehicleid == INVALID_VEHICLE_ID) return 0;
    return GetVehicleDistanceFromPoint(vehicleid, x, y, z) <= range;
}  

stock GetClosestCar(playerid, Float:Prevdist=5.0)
{
	new Prevcar = -1;
	for(new carid = 0; carid < MAX_VEHICLES; carid++)
	{
		new Float:Dist = GetDistanceToCar(playerid,carid);
		if((Dist < Prevdist))
		{
			Prevdist = Dist;
			Prevcar = carid;
		}
	}
	return Prevcar;
} 
stock GetDistanceToCar(playerid, carid)
{
	new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2,Float:Dis;
	if (!IsPlayerConnected(playerid))return -1;
	GetPlayerPos(playerid,x1,y1,z1);GetVehiclePos(carid,x2,y2,z2);
	Dis = floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
	return floatround(Dis);
}

SavePlayerSentMessage(playerid, message[], MessageType:type)
{
	new idx = SentMessagesIndex[playerid];
	format(SentMessages[playerid][idx], 144, "%s", message);
	SentMessagesType[playerid][idx] = type;
	SentMessagesIndex[playerid] = (idx+1) % MAX_SENT_MESSAGES;
}

ShowPlayerSentMessages(playerid, forplayerid, max=MAX_SENT_MESSAGES)
{
	SendClientMessage(forplayerid, COLOR_WHITE, sprintf("--- Ostatnie wiadomo�ci gracza %s: ---", GetNick(playerid)));
	new index = SentMessagesIndex[playerid];
	new count;
	for(new i = index; i < MAX_SENT_MESSAGES; i++) {
		if(strlen(SentMessages[playerid][i])) {
			SendClientMessage(forplayerid, (SentMessagesType[playerid][i] == TOME ? COLOR_NEWS : COLOR_YELLOW), SentMessages[playerid][i]);
			if(++count > max)  return;
		}
	}

	for(new i; i < index; i++) {
		if(strlen(SentMessages[playerid][i])) {
			SendClientMessage(forplayerid, (SentMessagesType[playerid][i] == TOME ? COLOR_NEWS : COLOR_YELLOW), SentMessages[playerid][i]);
			if(++count > max)  return;
		}
	}
}

SavePlayerDamaged(playerid, attackerid, Float:damage, weapon)
{
	new hour, minute, second;
	new sec = gettime() + 7200;
	new day;
    day = floatround(sec / 86400);
    hour = floatround((sec - (day * 86400)) / 3600);
    minute = floatround((sec - (day * 86400) - (hour * 3600)) / 60);
    second = sec % 60;
	new idx = ObrazeniaIndex[playerid];
	format(Obrazenia[playerid][idx][ATTACKER], MAX_PLAYER_NAME, "%s", GetNick(attackerid));
	Obrazenia[playerid][idx][DAMAGE] = damage;
	Obrazenia[playerid][idx][WEAPONID] = weapon;
	Obrazenia[playerid][idx][HOURS] = hour;
	Obrazenia[playerid][idx][MINUTES] = minute;
	Obrazenia[playerid][idx][SECONDS] = second;
	ObrazeniaIndex[playerid] = (idx+1) % 20;
}

SavePlayerDamage(playerid, defenderid, Float:damage, weapon)
{
	new hour, minute, second;
	new sec = gettime() + 7200;
	new day;
    day = floatround(sec / 86400);
    hour = floatround((sec - (day * 86400)) / 3600);
    minute = floatround((sec - (day * 86400) - (hour * 3600)) / 60);
    second = sec % 60;
	new idx = ObrazeniaZadaneIndex[playerid];
	format(ObrazeniaZadane[playerid][idx][DEFENDER], MAX_PLAYER_NAME, "%s", GetNick(defenderid));
	ObrazeniaZadane[playerid][idx][DAMAGE] = damage;
	ObrazeniaZadane[playerid][idx][WEAPONID] = weapon;
	ObrazeniaZadane[playerid][idx][HOURS] = hour;
	ObrazeniaZadane[playerid][idx][MINUTES] = minute;
	ObrazeniaZadane[playerid][idx][SECONDS] = second;
	ObrazeniaZadaneIndex[playerid] = (idx+1) % 20;
}

ShowPlayerDamaged(playerid, forplayerid)
{
	SendClientMessage(forplayerid, COLOR_WHITE, sprintf("--- Damagelog gracza %s: ---", GetNick(playerid)));
	new index = ObrazeniaIndex[playerid];
	new string[72];
	new weapon_decoded[24];
	new godzina,minuta,sekunda,Float:hp;
	new atakujacy[MAX_PLAYER_NAME];
	if(index != 0) 
	{
		for(new i = index-1; i>=0; i--)
		{
			hp = Obrazenia[playerid][i][DAMAGE];
			if(hp <= 0.1) continue;
			switch(Obrazenia[playerid][i][WEAPONID])
			{
				case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[Obrazenia[playerid][i][WEAPONID]]);
				default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", Obrazenia[playerid][i][WEAPONID]);
			}
			godzina = Obrazenia[playerid][i][HOURS];
			minuta = Obrazenia[playerid][i][MINUTES];
			sekunda = Obrazenia[playerid][i][SECONDS];
			hp = hp / 2;
			format(atakujacy, sizeof(atakujacy), "%s", Obrazenia[playerid][i][ATTACKER]);
			format(string, sizeof(string), "%d:%d:%d | %s zada� mu %0.1fHP z %s[%d]", godzina, minuta, sekunda, atakujacy, hp, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
			SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
		}
	}
	for(new i= 19; i >= index; i--) 
	{
		hp = Obrazenia[playerid][i][DAMAGE];
		if(hp <= 0.1) continue;
		switch(Obrazenia[playerid][i][WEAPONID])
		{
			case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[Obrazenia[playerid][i][WEAPONID]]);
			default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", Obrazenia[playerid][i][WEAPONID]);
		}
		godzina = Obrazenia[playerid][i][HOURS];
		minuta = Obrazenia[playerid][i][MINUTES];
		sekunda = Obrazenia[playerid][i][SECONDS];
		hp = hp/2;
		format(atakujacy, sizeof(atakujacy), "%s", Obrazenia[playerid][i][ATTACKER]);
		format(string, sizeof(string), "%d:%d:%d | %s zada� mu %0.1fHP z %s[%d]", godzina, minuta, sekunda, atakujacy, hp, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
		SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
	}
	return 1;
}

ShowPlayerDamage(playerid, forplayerid)
{
	SendClientMessage(forplayerid, COLOR_WHITE, sprintf("--- Damagelog gracza %s: ---", GetNick(playerid)));
	new index = ObrazeniaZadaneIndex[playerid];
	new string[72];
	new weapon_decoded[24];
	new godzina,minuta,sekunda,Float:hp;
	new broniacy[MAX_PLAYER_NAME];
	if(index != 0) 
	{
		for(new i = index-1; i>=0; i--)
		{
			hp = ObrazeniaZadane[playerid][i][DAMAGE];
			if(hp <= 0.1) continue;
			switch(ObrazeniaZadane[playerid][i][WEAPONID])
			{
				case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[ObrazeniaZadane[playerid][i][WEAPONID]]);
				default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", ObrazeniaZadane[playerid][i][WEAPONID]);
			}
			godzina = ObrazeniaZadane[playerid][i][HOURS];
			minuta = ObrazeniaZadane[playerid][i][MINUTES];
			sekunda = ObrazeniaZadane[playerid][i][SECONDS];
			hp = hp / 2;
			format(broniacy, sizeof(broniacy), "%s", ObrazeniaZadane[playerid][i][DEFENDER]);
			format(string, sizeof(string), "%d:%d:%d | zada� %0.1fHP graczowi %s z %s[%d]", godzina, minuta, sekunda, hp, broniacy, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
			SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
		}
	}
	for(new i= 19; i >= index; i--) 
	{
		hp = ObrazeniaZadane[playerid][i][DAMAGE];
		if(hp <= 0.1) continue;
		switch(ObrazeniaZadane[playerid][i][WEAPONID])
		{
			case 0..42: format(weapon_decoded, sizeof(weapon_decoded), "%s", GunNames[ObrazeniaZadane[playerid][i][WEAPONID]]);
			default: format(weapon_decoded, sizeof(weapon_decoded), "[WeaponID %d]", ObrazeniaZadane[playerid][i][WEAPONID]);
		}
		godzina = ObrazeniaZadane[playerid][i][HOURS];
		minuta = ObrazeniaZadane[playerid][i][MINUTES];
		sekunda = ObrazeniaZadane[playerid][i][SECONDS];
		hp = hp / 2;
		format(broniacy, sizeof(broniacy), "%s", ObrazeniaZadane[playerid][i][DEFENDER]);
		format(string, sizeof(string), "%d:%d:%d | zada� %0.1fHP graczowi %s z %s[%d]", godzina, minuta, sekunda, hp, broniacy, weapon_decoded, Obrazenia[playerid][i][WEAPONID]);
		SendClientMessage(forplayerid, COLOR_LIGHTGREEN, string);
	}
	return 1;
}

IsPlayerInFight(playerid, time=60)
{
	return gettime() - GetPVarInt(playerid, "lastDamage") < time;
}


IsReasonAPursuitReason(result[])
{
	return (strfind(result, "ucieczka", true) != -1 || strfind(result, "poscig", true) != -1 || strfind(result, "po�cig", true) != -1 || strfind(result, "ucieka", true) != -1);
}

PursuitMode(playerid, giveplayerid)
{
	if(ProxDetectorS(80.0, playerid, giveplayerid))
	{
		if(poscig[giveplayerid] != 1)
		{
			SendClientMessage(playerid,COLOR_LIGHTBLUE,"Rozpocz��e� po�cig! Trwa on 7 minut.");
			SendClientMessage(giveplayerid,COLOR_PANICRED,"|_________________Tryb Po�cigu_________________|");
			SendClientMessage(giveplayerid,COLOR_WHITE,"S�u�by porz�dkowe ruszy�y za tob� w po�cig! W takim wypadku najlepiej si� podda�!");
			SendClientMessage(giveplayerid,COLOR_WHITE,"W trybie po�cigu nie mozesz wyj�� z gry, zgin�� oraz by� AFK.");
			SendClientMessage(giveplayerid,COLOR_WHITE,"Z�amanie tych zasad skutkuje kar� nadawan� automatycznie.");
			SendClientMessage(giveplayerid,COLOR_PANICRED,"|______________________________________________|");
			poscig[giveplayerid] = 1;
			SetTimerEx("PoscigTimer",7*60000,0,"d",giveplayerid);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Gracz jest za daleko by nada� mu tryb po�cigu.");
	}
}

// iloczyn skalarny
Float:CalculateDotProduct(Float:a[3], Float:b[3])
{
	return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
}

// metoda oparta na separating axis theorem w 3D
CheckIfCuboidsIntersect(Float:c[8][3], Float:c2[8][3])
{
    static Float:axes[15][3];
    
    for (new i = 0; i < 3; i++) 
    {
        axes[i][0] = c[1][i] - c[0][i];
        axes[i + 3][0] = c[2][i] - c[0][i];
        axes[i + 6][0] = c[4][i] - c[0][i];
        axes[i + 9][0] = c[0][i];
        
        axes[i][1] = c[3][i] - c[0][i];
        axes[i + 3][1] = c[5][i] - c[0][i];
        axes[i + 6][1] = c[6][i] - c[0][i];
        axes[i + 9][1] = c[1][i];
        
        axes[i][2] = c[2][i] - c[1][i];
        axes[i + 3][2] = c[5][i] - c[1][i];
        axes[i + 6][2] = c[7][i] - c[1][i];
        axes[i + 9][2] = c[3][i] - c[1][i];
    }

    for (new i = 0; i < 3; i++) 
    {
        axes[i + 12][0] = c2[0][i];
        axes[i + 12][1] = c2[1][i] - c2[0][i];
        axes[i + 12][2] = c2[3][i] - c2[0][i];
    }
    
    for (new i = 0; i < 15; i++) 
    {
        new Float:axis[3];
        for (new j = 0; j < 3; j++) 
        {
            axis[j] = axes[i][j];
        }

        new Float:min1, Float:max1, Float:min2, Float:max2;
        for (new j = 0; j < 8; j++) 
        {
            new Float:dot = CalculateDotProduct(axis, c[j]);
            if (j == 0 || dot < min1) min1 = dot;
            if (j == 0 || dot > max1) max1 = dot;
        }
        for (new j = 0; j < 8; j++) 
        {
            new Float:dot = CalculateDotProduct(axis, c2[j]);
            if (j == 0 || dot < min2) min2 = dot;
            if (j == 0 || dot > max2) max2 = dot;
        }

        if (!(max1 >= min2 && min1 <= max2)) 
        {
            return false;
        }
    }

    return true;
}

// obracanie punktu korzystaj�c z macierzy rotacji
RotatePointWithRMatrix(Float:x, Float:y, Float:z, &Float:xr, &Float:yr, &Float:zr, Float:rm[][])
{
	xr = rm[0][0] * x + 
		rm[0][1] * y + 
		rm[0][2] * z;
	yr = rm[1][0] * x + 
		rm[1][1] * y + 
		rm[1][2] * z;
	zr = rm[2][0] * x + 
		rm[2][1] * y + 
		rm[2][2] * z;
}

// obliczanie macierzy rotacji z kwaternion�w
CalculateRotationMatrixFromQuat(Float:a, Float:b, Float:c, Float:d, Float:rm[][])
{
	rm[0][0] = (1 - 2 * (c*c + d*d));
	rm[0][1] = (2 * (b * c - a * d));
	rm[0][2] = (2 * (b * d + a * c));
	rm[1][0] = (2 * (b * c + a * d));
	rm[1][1] = (1 - 2 * (b * b + d * d));
	rm[1][2] = (2 * (c * d - a * b));
	rm[2][0] = (2 * (b * d - a * c)); 
	rm[2][1] = (2 * (c * d + a * b)); 
	rm[2][2] = (1 - 2 * (b * b + c * c));
}

// wyznaczenie wierzcho�k�w prostopad�o�cianu, kt�ry wyznacza granice pojazdu
GetVehicleBoundingBox(vehicleid, Float:bbox[][])
{
	static const Float:scale = 0.8;

	new Float:x, Float:y, Float:z;
	GetVehiclePos(vehicleid, x, y, z);

	new vm = GetVehicleModel(vehicleid);

	new Float:wx, Float:wy, Float:wz;
	GetVehicleModelInfo(vm, VEHICLE_MODEL_INFO_SIZE, wx, wy, wz);

	new Float:a, Float:b, Float:c, Float:d;
	GetVehicleRotationQuat(vehicleid, a, b, c, d);

	if(a == 0.5 && b == 0.5 && c == 0.5 && d == 0.5) // rotacja nie zainicjowana w macierzy pojazd�w serwera
	{
		return 0;
	}

	new Float:rm[3][3];
	CalculateRotationMatrixFromQuat(a, -b, -c, -d, rm);

	new Float:cp_nr[8][3];
	cp_nr[0][0] = (-wx); cp_nr[0][1] = (-wy); cp_nr[0][2] = (-wz);
	cp_nr[1][0] = (-wx); cp_nr[1][1] = ( wy); cp_nr[1][2] = (-wz);
	cp_nr[2][0] = ( wx); cp_nr[2][1] = ( wy); cp_nr[2][2] = (-wz);
	cp_nr[3][0] = ( wx); cp_nr[3][1] = (-wy); cp_nr[3][2] = (-wz);
	cp_nr[4][0] = (-wx); cp_nr[4][1] = (-wy); cp_nr[4][2] = ( wz);
	cp_nr[5][0] = (-wx); cp_nr[5][1] = ( wy); cp_nr[5][2] = ( wz);
	cp_nr[6][0] = ( wx); cp_nr[6][1] = ( wy); cp_nr[6][2] = ( wz);
	cp_nr[7][0] = ( wx); cp_nr[7][1] = (-wy); cp_nr[7][2] = ( wz);

	for(new i = 0; i < 8; i++)
	{
		for(new j = 0; j < 3; j++)
		{
			cp_nr[i][j] /= 2.0;
		}
	}

	for(new i = 0; i < 8; i++)
	{
		RotatePointWithRMatrix(cp_nr[i][0], cp_nr[i][1], cp_nr[i][2], bbox[i][0], bbox[i][1], bbox[i][2], rm);

		bbox[i][0] *= scale;
		bbox[i][1] *= scale;
		bbox[i][2] *= scale;

		bbox[i][0] += x;
		bbox[i][1] += y;
		bbox[i][2] += z;
	}

	return 1;
}

// wyznaczanie d�ugo�ci nad�u�szej przek�tnej prostopad�o�cianu wyznaczaj�cego granice pojazdu
Float:GetVehicleBoundingBoxDiagonal(vehicleid)
{
	new vm = GetVehicleModel(vehicleid);
	new Float:wx, Float:wy, Float:wz;
	GetVehicleModelInfo(vm, VEHICLE_MODEL_INFO_SIZE, wx, wy, wz);
	return floatsqroot(wx*wx + wy*wy + wz*wz);
}

// https://github.com/katursis/Pawn.RakNet/wiki/AntiVehicleSpawn
stock IsVehicleUpsideDown(vehicleid)
{
    new Float:quat_w, Float:quat_x, Float:quat_y, Float:quat_z;
    GetVehicleRotationQuat(vehicleid, quat_w, quat_x, quat_y, quat_z);
    return (
        floatabs(
            atan2(2 * (quat_y * quat_z + quat_w * quat_x),
                quat_w * quat_w - quat_x * quat_x - quat_y * quat_y + quat_z * quat_z
            )
        ) > 90.0
    );
}

// Function to move an object to the left by a specified number of units, considering rotation in all axes (rx, ry, rz)
stock MoveObjectLeft3D(Float:distance, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, &Float:newX, &Float:newY, &Float:newZ)
{
	#pragma unused rx, ry // TODO: take into consideration the rotation of those axis
	new Float:degrees_to_radians = 0.01745329251; // PI / 180

    // Convert rotation angles from degrees to radians
	new Float:rzRad = rz * degrees_to_radians;

    // Calculate the direction to move left (which is along the negative X-axis in the local space)
    // Left movement based on rotation around the Z axis
    new Float:leftX = -distance * floatsin(rzRad);
    new Float:leftY = -distance * floatcos(rzRad);

    // Apply the translation to the object's current position
    newX = x + leftX;
    newY = y + leftY;
    newZ = z;  // No change in Z, since we're moving along the XY plane
}

// Function to set the player's velocity in the opposite direction of the specified coordinates
stock SetPlayerOppositeVelocity(playerid, Float:targetX, Float:targetY, Float:targetZ, Float:speed, Float:boostZ=0.0)
{
    // Variables to store player's current position
    new Float:playerX, Float:playerY, Float:playerZ;

    // Get player's current position
    GetPlayerPos(playerid, playerX, playerY, playerZ);

    // Calculate the direction vector (from player to target)
    new Float:dirX = targetX - playerX;
    new Float:dirY = targetY - playerY;
    new Float:dirZ = targetZ - playerZ;

    // Normalize the direction vector (get its unit length)
    new Float:length = floatsqroot(dirX * dirX + dirY * dirY + dirZ * dirZ);

    if(length == 0.0) return 0; // Prevent division by zero in case the coordinates are the same

    // Normalize the direction (to get unit vector)
    dirX /= length;
    dirY /= length;
    dirZ /= length;

    // Set velocity in the opposite direction (-dirX, -dirY, -dirZ) and scale by speed
    SetPlayerVelocity(playerid, -dirX * speed, -dirY * speed, -dirZ * speed + boostZ);

    return 1; // Successful execution
}

// Function to set the vehicle's velocity in the opposite direction of the specified coordinates
stock SetVehicleOppositeVelocity(vehicleid, Float:targetX, Float:targetY, Float:targetZ, Float:speed, Float:boostZ=0.0)
{
    // Variables to store vehicle's current position
    new Float:vehicleX, Float:vehicleY, Float:vehicleZ;

    // Get vehicle's current position
    GetVehiclePos(vehicleid, vehicleX, vehicleY, vehicleZ);

    // Calculate the direction vector (from vehicle to target)
    new Float:dirX = targetX - vehicleX;
    new Float:dirY = targetY - vehicleY;
    new Float:dirZ = targetZ - vehicleZ;

    // Normalize the direction vector (get its unit length)
    new Float:length = floatsqroot(dirX * dirX + dirY * dirY + dirZ * dirZ);

    if(length == 0.0) return 0; // Prevent division by zero in case the coordinates are the same

    // Normalize the direction (to get unit vector)
    dirX /= length;
    dirY /= length;
    dirZ /= length;

    // Set velocity in the opposite direction (-dirX, -dirY, -dirZ) and scale by speed
    SetVehicleVelocity(vehicleid, -dirX * speed, -dirY * speed, -dirZ * speed + boostZ);

    return 1; // Successful execution
}



stock IsAZasluzony(playerid) {
	return ZasluzeniON && PlayerInfo[playerid][pZG] == 10;
}

stock IsAZaufanyGracz(playerid, level=1)
{
	return PlayerInfo[playerid][pZG] >= level || IsAZasluzony(playerid);
}

public DeathAdminWarning(playerid, killerid, reason)
{
	new killername[MAX_PLAYER_NAME];
	new string[144];

	if((!IsPlayerConnected(playerid) || !gPlayerLogged[playerid]) || (IsPlayerConnected(killerid) && !gPlayerLogged[killerid])) return 1;
	if(killerid != INVALID_PLAYER_ID)
	{
		GetPlayerName(killerid, killername, sizeof(killername));
		new bwreason[24];
		if(PlayerInfo[playerid][pInjury] > 0) // jesli jest ranny
		{
			format(bwreason, sizeof(bwreason), "dobi� (szpital)");
		}
		else //jesli nie jest ranny
		{
			format(bwreason, sizeof(bwreason), "zrani� (ranny)");
		}
		new gun, ammo;
		GetPlayerWeaponData(playerid, GetWeaponSlot(reason), gun, ammo);

		if(GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
		{
			//-------<[  Logi  ]>---------
			Log(damageLog, INFO, "%s %s %s z broni %s b�d�c w aucie (mo�liwe DB/CK2).", GetPlayerLogName(killerid), bwreason, GetPlayerLogName(playerid), GetWeaponLogName(gun, ammo));
			SendClientMessage(killerid, COLOR_YELLOW, "DriveBy jest zakazane, robi�c DriveBy mo�esz zosta� ukarany przez admina!");
			if(PlayerInfo[killerid][pLevel] > 1)
			{
				format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] b�d� w aucie (mo�liwe DB/CK2) [GunID %d]!", killername, killerid, bwreason, GetNick(playerid), playerid, reason);
				SendMessageToAdmin(string, COLOR_YELLOW);
			}
			else
			{
				format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] z DB, dosta� kicka !", killername, killerid, bwreason, GetNick(playerid), playerid);
				SendMessageToAdmin(string, COLOR_YELLOW);
				Log(punishmentLog, INFO, "%s dosta� kicka od systemu za Drive-By", GetPlayerLogName(killerid));
				SendClientMessage(killerid, COLOR_PANICRED, "Dosta�e� kicka za Drive-By do ludzi.");
				KickEx(killerid, "drive-by");
				SetPVarInt(playerid, "skip_bw", 1);
				return 1;
			}
		}
		else
		{
			switch(reason)
			{
				case 38:
				{
					//-------<[  Logi  ]>---------
					// if(PlayerInfo[killerid][pGun7] != reason && PlayerInfo[killerid][pAdmin] < 1)
					// {
					// 	format(string, sizeof string, "ACv2 [#2003]: Sprawdzanie kodu - rzekomy fakekillid %s (%d).", GetNickEx(playerid), playerid);
					// 	SendCommandLogMessage(string);
					// 	Log(warningLog, INFO, string);
					// 	SetTimerEx("CheckCode2003", 250, false, "ii", killerid, playerid);
					// } else
					if(GetVehicleModel(GetPlayerVehicleID(killerid)) != 425)
					{
						format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] z miniguna, podejrzane !", killername, killerid, bwreason, GetNick(playerid), playerid);
						SendMessageToAdmin(string, COLOR_YELLOW);
						Log(warningLog, INFO, "%s zabi� gracza %s u�ywaj�c miniguna", GetPlayerLogName(killerid), GetPlayerLogName(playerid));
						SendMessageToAdminEx(string, COLOR_P@, 2);
					}
					else if(GetVehicleModel(GetPlayerVehicleID(killerid)) == 425)
					{
						format(string, sizeof(string), "{FF66CC}DeathWarning: {FFFFFF}%s[%d] %s %s[%d] z Huntera",  killername, killerid, bwreason, GetNick(playerid), playerid);
						SendMessageToAdminEx(string, COLOR_P@, 2);
					}
				}
				case 41:
				{
					//-------<[  Logi  ]>---------
					format(string, sizeof(string), "AdmWarning: %s[%d] %s %s[%d] ze spreya!", killername, killerid, bwreason, GetNick(playerid), playerid);
					SendMessageToAdmin(string, COLOR_YELLOW);
					Log(damageLog, INFO, "%s %s gracza %s u�ywaj�c %s", GetPlayerLogName(killerid), bwreason, GetPlayerLogName(playerid), GetWeaponLogName(gun, ammo));
					SendMessageToAdminEx(string, COLOR_P@, 2);
				}
				default:
				{
					if(reason <= 54 && reason > 0)
					{
						format(string, sizeof(string), "{FF66CC}DeathWarning: {FFFFFF}%s[%d] %s %s[%d] z %s", killername, killerid, bwreason, GetNick(playerid), playerid, (reason <= 46) ? GunNames[reason] : DeathNames[reason-46]);
						SendMessageToAdminEx(string, COLOR_P@, 2);
					}	
					if(GetPVarInt(playerid, "skip_bw")  == 0)
					{
						if(PlayerInfo[playerid][pInjury] > 0)
						{
							if(lowcaz[killerid] == playerid && lowcap[playerid] != killerid && poddaje[playerid] != 1)
							{
								format(string, sizeof(string), "AdmWarning: �owca Nagr�d %s[%d] %s %s[%d] bez oferty /poddajsie !", killername, killerid, bwreason, GetNick(playerid), playerid);
								SendMessageToAdmin(string, COLOR_YELLOW);
								Log(serverLog, INFO, "�owca nagr�d %s %s gracza %s bez oferty /poddajsie", GetPlayerLogName(killerid), bwreason, GetPlayerLogName(playerid));
							}

						}
					}	
				}
			}
		}
	}
	else
	{
		if(reason <= 54 && reason > 0)
		{
			format(string, sizeof(string), "{FF66CC}DeathWarning: %s [%d] umar� (%s)", GetNick(playerid), playerid, (reason <= 46) ? GunNames[reason] : DeathNames[reason-46]);
			SendMessageToAdminEx(string, COLOR_P@, 2);
		}
	}
	return 1;
}

GetPlayersCount()
{
	new count;
	foreach(new i : Player) 
	{
		count++;
	}
	return count;
}

new crashid = 0;

stock DumpPlayerStreamInfo(playerid)
{
	new Float:x,Float:y,Float:z;

	new visiblePlayers;
	foreach(new i : Player)
	{
		if (IsPlayerStreamedIn(i, playerid))
		{
			visiblePlayers++;
			Log(crashLog, INFO, "Crash %d / CrashPlayersInfo: {Nick: %s, Model: %d, Weapon: %d}", crashid, GetNick(i), GetPlayerSkin(i), GetPlayerWeapon(i));
		}
	}

	new visibleVehicles;
	for(new vehicleid = 1; vehicleid < MAX_VEHICLES; vehicleid++)
	{
		if (IsVehicleStreamedIn(vehicleid, playerid))
		{
			visibleVehicles++;

			new vehicleInfo[512];
			new model = GetVehicleModel(vehicleid);
			new panels, doors, lights, tires;
			GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
		
			format(vehicleInfo, sizeof(vehicleInfo), "VehicleID: %d, VehicleUID: %d, Model: %d, ModelName: %s, Panels: %d, Doors: %d, Lights: %d, Tires: %d, ", 
				vehicleid, VehicleUID[vehicleid][vUID],
				model, VehicleNames[model-400],
				panels, doors, lights, tires);

			for(new slot; slot < 14; slot++)
			{
				strcat(vehicleInfo, sprintf("Tuning%d: %d, ", slot, GetVehicleComponentInSlot(vehicleid, slot)));
			}

			Log(crashLog, INFO, "Crash %d / CrashVehiclesInfo: {%s}", crashid, vehicleInfo);
		}
	}


	new objects[MAX_OBJECTS + 10];
	new visibleObjects = Streamer_GetAllVisibleItems(playerid, STREAMER_TYPE_OBJECT, objects);
	for(new i; i<visibleObjects; i++)
	{
		new model = Streamer_GetIntData(STREAMER_TYPE_OBJECT, i, E_STREAMER_MODEL_ID);
		Log(crashLog, INFO, "Crash %d / CrashObjectsInfo: {%d,%f,%f,%f}", crashid, model, x, y, z);
	}

	new text3ds[MAX_3DTEXT_PLAYER + 10];
	new visibletext3ds = Streamer_GetAllVisibleItems(playerid, STREAMER_TYPE_3D_TEXT_LABEL, text3ds);
	for(new i; i<visibletext3ds; i++)
	{
		Streamer_GetItemPos(STREAMER_TYPE_3D_TEXT_LABEL, i, x,y,z);
		Log(crashLog, INFO, "Crash %d / CrashText3DsInfo: {%f,%f,%f}", crashid, x, y, z);
	}

	new pickups[MAX_PICKUPS + 10];
	new visiblePickups = Streamer_GetAllVisibleItems(playerid, STREAMER_TYPE_PICKUP, pickups);
	for(new i; i<visiblePickups; i++)
	{
		new model = Streamer_GetIntData(STREAMER_TYPE_PICKUP, i, E_STREAMER_MODEL_ID);
		Log(crashLog, INFO, "Crash %d / CrashPickupsInfo: {%d,%f,%f,%f}", crashid, model, x, y, z);
	}

	GetPlayerPos(playerid, x, y, z);

	Log(crashLog, INFO, "Crash %d / Player: %s / " \
		"Pos: %f,%f,%f / " \
		"VisibleObjects: %d / " \
		"VisiblePickups: %d / " \
		"VisibleCPs: %d / " \
		"VisibleRaceCPs: %d / " \
		"VisibleMapIcons: %d / " \
		"Visible3DTexts: %d / " \
		"VisibleAreas: %d / " \
		"VisibleActors: %d / " \
		"VisiblePlayers: %d / " \
		"VisibleVehicles: %d",
		crashid,
		GetNick(playerid),
		x,y,z,
		visibleObjects,
		visiblePickups,
		Streamer_CountVisibleItems(playerid, STREAMER_TYPE_CP),
		Streamer_CountVisibleItems(playerid, STREAMER_TYPE_RACE_CP),
		Streamer_CountVisibleItems(playerid, STREAMER_TYPE_MAP_ICON),
		visibletext3ds,
		Streamer_CountVisibleItems(playerid, STREAMER_TYPE_AREA),
		Streamer_CountVisibleItems(playerid, STREAMER_TYPE_ACTOR),
		visiblePlayers,
		visibleVehicles
	);

	crashid++;
    return 1;

}


forward TimeUpdater();
public TimeUpdater()
{
	new year, month, day;
    new hour, minute;
	getdate(year, month, day);
	gettime(hour, minute);
    format(realtime_string, 32, "%04d/%02d/%02d_%02d:%02d", year, month, day, hour, minute);
    TextDrawSetString(RealtimeTXD, realtime_string);
}

//--------------------------------------------------

public AddsOn()
{
	adds=1;
	return 1;
}

//EOF

