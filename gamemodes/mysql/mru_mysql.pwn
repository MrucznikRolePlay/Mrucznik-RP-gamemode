//mru_mysql.pwn

MruMySQL_Init()
{
	#if DEBUG_MODE == 1
		mysql_log(ALL);
	#else
		if(DEVELOPMENT)
		{
			mysql_log(DEBUG | INFO | WARNING | ERROR);
		}
		else
		{
			mysql_log(WARNING | ERROR);
		}
	#endif

	mysql_global_options(DUPLICATE_CONNECTIONS, false);
	mysql_global_options(DUPLICATE_CONNECTION_WARNING, true);

	mruMySQL_Connection = mysql_connect_file("mysql.ini");
	if(mruMySQL_Connection == MYSQL_INVALID_HANDLE)
	{
		mruMySQL_Connection = mysql_connect("mysqld", "root", "secret", "samp");
	}
	new errno = mysql_errno(mruMySQL_Connection);
	if (errno != 0) 
	{
		new error[100];
		mysql_error(error, sizeof (error), mruMySQL_Connection);
		print("[ERROR] MYSQL: Nieudane polaczenie z baza MySQL!");
		printf("[ERROR] #%d '%s'", errno, error);
		SendRconCommand("gamemodetext Brak polaczenia MySQL");
		SendRconCommand("exit");
		return 0;
	}
	
	mysql_set_charset("cp1250");
	return 1;
}

MruMySQL_Exit()
{
	mysql_close(mruMySQL_Connection);
}

MruMySQL_CreateKontaORM(playerid)
{
	new ORM:orm = PlayerInfo[playerid][pORM] = orm_create("mru_konta", mruMySQL_Connection);

	orm_addvar_int(orm, PlayerInfo[playerid][pUID], "UID");
	orm_addvar_string(orm, PlayerInfo[playerid][pNick], MAX_PLAYER_NAME, "Nick");
	orm_addvar_string(orm, PlayerInfo[playerid][pKey], WHIRLPOOL_LEN, "Key");
	orm_addvar_string(orm, PlayerInfo[playerid][pSalt], SALT_LENGTH, "Salt");
	orm_addvar_int(orm, PlayerInfo[playerid][pLevel], "Level");
	orm_addvar_int(orm, PlayerInfo[playerid][pAdmin], "Admin");
	orm_addvar_int(orm, PlayerInfo[playerid][pDonateRank], "DonateRank");
	orm_addvar_int(orm, PlayerInfo[playerid][gPupgrade], "UpgradePoints");
	orm_addvar_int(orm, PlayerInfo[playerid][pConnectTime], "ConnectedTime");
	orm_addvar_int(orm, PlayerInfo[playerid][pReg], "Registered");
	orm_addvar_int(orm, PlayerInfo[playerid][pSex], "Sex");
	orm_addvar_int(orm, PlayerInfo[playerid][pAge], "Age");
	orm_addvar_int(orm, PlayerInfo[playerid][pOrigin], "Origin");
	orm_addvar_int(orm, PlayerInfo[playerid][pCK], "CK");
	orm_addvar_int(orm, PlayerInfo[playerid][pMuted], "Muted");
	orm_addvar_int(orm, PlayerInfo[playerid][pExp], "Respect");
	orm_addvar_int(orm, PlayerInfo[playerid][pCash], "Money");
	orm_addvar_int(orm, PlayerInfo[playerid][pAccount], "Bank");
	orm_addvar_int(orm, PlayerInfo[playerid][pCrimes], "Crimes");
	orm_addvar_int(orm, PlayerInfo[playerid][pKills], "Kills");
	orm_addvar_int(orm, PlayerInfo[playerid][pDeaths], "Deaths");
	orm_addvar_int(orm, PlayerInfo[playerid][pArrested], "Arrested");
	orm_addvar_int(orm, PlayerInfo[playerid][pWantedDeaths], "WantedDeaths");
	orm_addvar_int(orm, PlayerInfo[playerid][pPhoneBook], "Phonebook");
	orm_addvar_int(orm, PlayerInfo[playerid][pLottoNr], "LottoNr");
	orm_addvar_int(orm, PlayerInfo[playerid][pFishes], "Fishes");
	orm_addvar_int(orm, PlayerInfo[playerid][pBiggestFish], "BiggestFish");
	orm_addvar_int(orm, PlayerInfo[playerid][pJob], "Job");
	orm_addvar_int(orm, PlayerInfo[playerid][pPayCheck], "Paycheck");
	orm_addvar_int(orm, PlayerInfo[playerid][pHeadValue], "HeadValue");
	orm_addvar_string(orm, PlayerInfo[playerid][pAJreason], 64, "AJreason");
	orm_addvar_int(orm, PlayerInfo[playerid][pBP], "BlokadaPisania");
	orm_addvar_int(orm, PlayerInfo[playerid][pJailed], "Jailed");
	orm_addvar_int(orm, PlayerInfo[playerid][pJailTime], "JailTime");
	orm_addvar_int(orm, PlayerInfo[playerid][pMats], "Materials");
	orm_addvar_int(orm, PlayerInfo[playerid][pDrugs], "Drugs");
	orm_addvar_int(orm, PlayerInfo[playerid][pMember], "Member"); //TODO: (gPlayerOrgLeader[playerid]) ? (PlayerInfo[playerid][pRank]+1000) : (PlayerInfo[playerid][pRank])
	orm_addvar_int(orm, PlayerInfo[playerid][pOrg], "FMember"); 
	orm_addvar_int(orm, PlayerInfo[playerid][pRank], "Rank");
	orm_addvar_int(orm, PlayerInfo[playerid][pChar], "Char");
	orm_addvar_int(orm, PlayerInfo[playerid][pSkin], "Skin");
	orm_addvar_int(orm, PlayerInfo[playerid][pContractTime], "ContractTime");
	orm_addvar_int(orm, PlayerInfo[playerid][pDetSkill], "DetSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pSexSkill], "SexSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pBoxSkill], "BoxSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pLawSkill], "LawSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pMechSkill], "MechSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pJackSkill], "JackSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pCarSkill], "CarSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pNewsSkill], "NewsSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pDrugsSkill], "DrugsSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pCookSkill], "CookSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pFishSkill], "FishSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pGunSkill], "GunSkill");
	orm_addvar_int(orm, PlayerInfo[playerid][pTruckSkill], "TruckSkill");
	orm_addvar_float(orm, PlayerInfo[playerid][pSHealth], "pSHealth");
	orm_addvar_float(orm, PlayerInfo[playerid][pHealth], "pHealth");
	orm_addvar_int(orm, PlayerInfo[playerid][pInt], "Int");
	orm_addvar_int(orm, PlayerInfo[playerid][pLocal], "Local");
	orm_addvar_int(orm, PlayerInfo[playerid][pTeam], "Team");
	orm_addvar_int(orm, PlayerInfo[playerid][pJobSkin], "JobSkin");
	orm_addvar_int(orm, PlayerInfo[playerid][pPnumber], "PhoneNr");
	orm_addvar_int(orm, PlayerInfo[playerid][pDom], "Dom");
	orm_addvar_int(orm, PlayerInfo[playerid][pBusinessOwner], "Bizz");
	orm_addvar_int(orm, PlayerInfo[playerid][pBusinessMember], "BizzMember");
	orm_addvar_int(orm, PlayerInfo[playerid][pWynajem], "Wynajem");
	orm_addvar_float(orm, PlayerInfo[playerid][pPos_x], "Pos_x");
	orm_addvar_float(orm, PlayerInfo[playerid][pPos_y], "Pos_y");
	orm_addvar_float(orm, PlayerInfo[playerid][pPos_z], "Pos_z");
	orm_addvar_int(orm, PlayerInfo[playerid][pCarLic], "CarLic");
	orm_addvar_int(orm, PlayerInfo[playerid][pFlyLic], "FlyLic");
	orm_addvar_int(orm, PlayerInfo[playerid][pBoatLic], "BoatLic");
	orm_addvar_int(orm, PlayerInfo[playerid][pFishLic], "FishLic");
	orm_addvar_int(orm, PlayerInfo[playerid][pGunLic], "GunLic");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun0], "Gun0");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun1], "Gun1");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun2], "Gun2");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun3], "Gun3");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun4], "Gun4");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun5], "Gun5");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun6], "Gun6");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun7], "Gun7");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun8], "Gun8");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun9], "Gun9");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun10], "Gun10");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun11], "Gun11");
	orm_addvar_int(orm, PlayerInfo[playerid][pGun12], "Gun12");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo0], "Ammo0");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo1], "Ammo1");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo2], "Ammo2");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo3], "Ammo3");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo4], "Ammo4");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo5], "Ammo5");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo6], "Ammo6");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo7], "Ammo7");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo8], "Ammo8");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo9], "Ammo9");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo10], "Ammo10");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo11], "Ammo11");
	orm_addvar_int(orm, PlayerInfo[playerid][pAmmo12], "Ammo12");
	orm_addvar_int(orm, PlayerInfo[playerid][pCarTime], "CarTime");
	orm_addvar_int(orm, PlayerInfo[playerid][pPayDay], "PayDay");
	orm_addvar_int(orm, PlayerInfo[playerid][pPayDayHad], "PayDayHad");
	orm_addvar_int(orm, PlayerInfo[playerid][pCDPlayer], "CDPlayer");
	orm_addvar_int(orm, PlayerInfo[playerid][pWins], "Wins");
	orm_addvar_int(orm, PlayerInfo[playerid][pLoses], "Loses");
	orm_addvar_int(orm, PlayerInfo[playerid][pAlcoholPerk], "AlcoholPerk");
	orm_addvar_int(orm, PlayerInfo[playerid][pDrugPerk], "DrugPerk");
	orm_addvar_int(orm, PlayerInfo[playerid][pMiserPerk], "MiserPerk");
	orm_addvar_int(orm, PlayerInfo[playerid][pPainPerk], "PainPerk");
	orm_addvar_int(orm, PlayerInfo[playerid][pTraderPerk], "TraderPerk");
	orm_addvar_int(orm, PlayerInfo[playerid][pTut], "Tutorial");
	orm_addvar_int(orm, PlayerInfo[playerid][pMissionNr], "Mission");
	orm_addvar_int(orm, PlayerInfo[playerid][pWarns], "Warnings");
	orm_addvar_int(orm, PlayerInfo[playerid][pBlock], "Block");
	orm_addvar_int(orm, PlayerInfo[playerid][pFuel], "Fuel");
	orm_addvar_int(orm, PlayerInfo[playerid][pMarried], "Married");
	orm_addvar_string(orm, PlayerInfo[playerid][pMarriedTo], MAX_PLAYER_NAME, "MarriedTo");
	orm_addvar_int(orm, PlayerInfo[playerid][pCB], "CBRADIO");
	orm_addvar_int(orm, PlayerInfo[playerid][pWL], "PoziomPoszukiwania");
	orm_addvar_int(orm, PlayerInfo[playerid][pDowod], "Dowod");
	orm_addvar_int(orm, PlayerInfo[playerid][pTajniak], "PodszywanieSie");
	orm_addvar_int(orm, PlayerInfo[playerid][pZmienilNick], "ZmienilNick");
	orm_addvar_int(orm, PlayerInfo[playerid][pWino], "Wino");
	orm_addvar_int(orm, PlayerInfo[playerid][pPiwo], "Piwo");
	orm_addvar_int(orm, PlayerInfo[playerid][pCygaro], "Cygaro");
	orm_addvar_int(orm, PlayerInfo[playerid][pSprunk], "Sprunk");
	orm_addvar_int(orm, PlayerInfo[playerid][pPodPW], "PodgladWiadomosci");
	orm_addvar_int(orm, PlayerInfo[playerid][pStylWalki], "StylWalki");
	orm_addvar_int(orm, PlayerInfo[playerid][pNewAP], "PAdmin");
	orm_addvar_int(orm, PlayerInfo[playerid][pZG], "ZaufanyGracz");
	orm_addvar_int(orm, PlayerInfo[playerid][pUniform], "Uniform");
	orm_addvar_int(orm, PlayerInfo[playerid][pCruiseController], "CruiseController");
	orm_addvar_int(orm, PlayerInfo[playerid][pFixKit], "FixKit");
	orm_addvar_int(orm, PlayerInfo[playerid][pKluczeAuta], "KluczykiDoAuta");
	orm_addvar_int(orm, PlayerInfo[playerid][pSpawn], "Spawn");
	orm_addvar_int(orm, PlayerInfo[playerid][pBW], "BW");
	orm_addvar_int(orm, PlayerInfo[playerid][pCzystka], "Czystka");
	orm_addvar_int(orm, PlayerInfo[playerid][pCarSlots], "CarSlots");
	orm_addvar_int(orm, PlayerInfo[playerid][pHat], "Hat");
	orm_addvar_int(orm, PlayerInfo[playerid][pFW], "FW");
	orm_addvar_int(orm, PlayerInfo[playerid][pConnected], "connected");
	orm_addvar_int(orm, PlayerInfo[playerid][pInjury], "HealthPacks");
	orm_addvar_int(orm, PlayerInfo[playerid][pHealthPacks], "Injury");

	orm_setkey(orm, "UID");
}

//--------------------------------------------------------------<[ Konta ]>--------------------------------------------------------------
MruMySQL_SaveAccount(playerid, bool:forcegmx = false, bool:forcequit = false)
{
    if(GLOBAL_EXIT) return 0;
    if(gPlayerLogged[playerid] != 1) return 0;

    if(forcequit)
    {
        //Punkty karne
        if(PlayerInfo[playerid][pPK] > 0)
		{
			PoziomPoszukiwania[playerid] += 10000+(PlayerInfo[playerid][pPK]*100);
		} 
    }

	new query[1024];
	new UID = PlayerInfo[playerid][pUID];

	if(forcegmx == false)
	{
		GetPlayerHealth(playerid,PlayerInfo[playerid][pHealth]);
	}

	PlayerInfo[playerid][pCash] = kaska[playerid];
    if(PlayerInfo[playerid][pLevel] == 0)
    {
        Log(mysqlLog, ERROR, "MySQL:: %s - b³¹d zapisu konta (zerowy level)!!!", GetPlayerLogName(playerid));
        return 0;
    }

	//wy³¹cz na chwilkê maskowanie nicku (pNick)
	new maska_nick[24];
	if(GetPVarString(playerid, "maska_nick", maska_nick, 24))
	{
		format(PlayerInfo[playerid][pNick], 24, "%s", maska_nick);
	}
	
	// SAVE ACCOUNT
	new oldRank = PlayerInfo[playerid][pRank];
	PlayerInfo[playerid][pRank] = (gPlayerOrgLeader[playerid]) ? (PlayerInfo[playerid][pRank]+1000) : (PlayerInfo[playerid][pRank]);
	PlayerInfo[playerid][pConnected] = forcequit ? 0 : 2;
	new fault = orm_update(PlayerInfo[playerid][pORM], "OnPlayerAccountSaved", "dd", playerid, forcequit);
	PlayerInfo[playerid][pRank] = oldRank;

	format(query, sizeof(query), "UPDATE `mru_personalization` SET \
		`KontoBankowe` = '%d', \
		`Ogloszenia` = '%d', \
		`LicznikPojazdu` = '%d', \
		`OgloszeniaFrakcji` = '%d', \
		`OgloszeniaRodzin` = '%d', \
		`OldNick` = '%d', \
		`CBRadio` = '%d', \
		`Report` = '%d', \
		`DeathWarning` = '%d', \
		`KaryTXD` = '%d', \
		`NewNick` = '%d', \
		`newbie` = '%d',	\
		`BronieScroll` = '%d'	\
		WHERE `UID`= '%d'",
		PlayerPersonalization[playerid][PERS_KB],
		PlayerPersonalization[playerid][PERS_AD],
		PlayerPersonalization[playerid][PERS_LICZNIK],
		PlayerPersonalization[playerid][PERS_FINFO],
		PlayerPersonalization[playerid][PERS_FAMINFO],
		PlayerPersonalization[playerid][PERS_NICKNAMES],
		PlayerPersonalization[playerid][PERS_CB],
		PlayerPersonalization[playerid][PERS_REPORT],
		PlayerPersonalization[playerid][WARNDEATH],
		PlayerPersonalization[playerid][PERS_KARYTXD],
		PlayerPersonalization[playerid][PERS_NEWNICK],
		PlayerPersonalization[playerid][PERS_NEWBIE],
		PlayerPersonalization[playerid][PERS_GUNSCROLL],
		UID); 
	mysql_tquery(mruMySQL_Connection, query);

	MruMySQL_SaveMc(playerid);
    saveLegale(playerid);
    saveKevlarPos(playerid);

	//przywróæ maskowanie nicku (pNick)
	if(GetPVarString(playerid, "maska_nick", maska_nick, 24))
	{
		new playernickname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playernickname, sizeof(playernickname));
		format(PlayerInfo[playerid][pNick], 24, "%s", playernickname);
	}
	return fault;
}

forward OnPlayerAccountSaved(playerid, forcequit);
public OnPlayerAccountSaved(playerid, forcequit)
{
	if(forcequit) orm_destroy(PlayerInfo[playerid][pORM]);
	return 1;
}

public MruMySQL_LoadAccount(playerid)
{
	MruMySQL_CreateKontaORM(playerid);
	new fault = orm_load(PlayerInfo[playerid][pORM], "OnPlayerAccountLoaded", "d", playerid);

	loadKamiPos(playerid);

	//legal
	new string[512];
	format(string, sizeof string, "SELECT * FROM `mru_legal` WHERE `pID`=%d", PlayerInfo[playerid][pUID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, string);

	playerWeapons[playerid][weaponLegal1] 	= 1;
	playerWeapons[playerid][weaponLegal2] 	= 1;
	playerWeapons[playerid][weaponLegal3] 	= 1;
	playerWeapons[playerid][weaponLegal4] 	= 1;
	playerWeapons[playerid][weaponLegal5] 	= 1;
	playerWeapons[playerid][weaponLegal6] 	= 1;
	playerWeapons[playerid][weaponLegal7] 	= 1;
	playerWeapons[playerid][weaponLegal8] 	= 1;
	playerWeapons[playerid][weaponLegal9] 	= 1;
	playerWeapons[playerid][weaponLegal10] 	= 1;
	playerWeapons[playerid][weaponLegal11] 	= 1;
	playerWeapons[playerid][weaponLegal12] 	= 1;
	playerWeapons[playerid][weaponLegal13] 	= 1;

	if(db_num_rows(db_result)) {
		playerWeapons[playerid][weaponLegal1] = db_get_field_assoc_int(db_result, "weapon1");
		playerWeapons[playerid][weaponLegal2] = db_get_field_assoc_int(db_result, "weapon2");
		playerWeapons[playerid][weaponLegal3] = db_get_field_assoc_int(db_result, "weapon3");
		playerWeapons[playerid][weaponLegal4] = db_get_field_assoc_int(db_result, "weapon4");
		playerWeapons[playerid][weaponLegal5] = db_get_field_assoc_int(db_result, "weapon5");
		playerWeapons[playerid][weaponLegal6] = db_get_field_assoc_int(db_result, "weapon6");
		playerWeapons[playerid][weaponLegal7] = db_get_field_assoc_int(db_result, "weapon7");
		playerWeapons[playerid][weaponLegal8] = db_get_field_assoc_int(db_result, "weapon8");
		playerWeapons[playerid][weaponLegal9] = db_get_field_assoc_int(db_result, "weapon9");
		playerWeapons[playerid][weaponLegal10] = db_get_field_assoc_int(db_result, "weapon10");
		playerWeapons[playerid][weaponLegal11] = db_get_field_assoc_int(db_result, "weapon11");
		playerWeapons[playerid][weaponLegal12] = db_get_field_assoc_int(db_result, "weapon12");
		playerWeapons[playerid][weaponLegal13] = db_get_field_assoc_int(db_result, "weapon13");
	} else {
		format(string, sizeof(string), "INSERT INTO `mru_legal` (`pID`,`weapon1`, `weapon2`, `weapon3`, `weapon4`, `weapon5`, `weapon6`, `weapon7`, `weapon8`, `weapon9`, `weapon10`, `weapon11`, `weapon12`, `weapon13`) VALUES (%d, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)", PlayerInfo[playerid][pUID]);
		db_free_result(db_query(db_handle, string));
	}
	//Wczytaj liderów
	format(string, sizeof(string), "SELECT `FracID`, `LiderValue` FROM `mru_liderzy` WHERE `UID`='%s'", PlayerInfo[playerid][pUID]);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result) && cache_num_rows())
	{
		cache_get_value_index_int(0, 0, PlayerInfo[playerid][pLider]);
		cache_get_value_index_int(0, 1, PlayerInfo[playerid][pLiderValue]);
	}
	cache_delete(result);

	//Wczytaj personalizacje
	format(string, sizeof(string), 
		"SELECT `KontoBankowe`, `Ogloszenia`, `LicznikPojazdu`, `OgloszeniaFrakcji`, `OgloszeniaRodzin`, `OldNick`, `CBRadio`, `Report`, `DeathWarning`, `KaryTXD`, `NewNick`, `newbie`, `BronieScroll`\
		FROM `mru_personalization` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);
	result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result) && cache_num_rows())
	{
		cache_get_value_index_int(0, 0, PlayerPersonalization[playerid][PERS_KB]);
		cache_get_value_index_int(0, 1, PlayerPersonalization[playerid][PERS_AD]);
		cache_get_value_index_int(0, 2, PlayerPersonalization[playerid][PERS_LICZNIK]);
		cache_get_value_index_int(0, 3, PlayerPersonalization[playerid][PERS_FINFO]);
		cache_get_value_index_int(0, 4, PlayerPersonalization[playerid][PERS_FAMINFO]);
		cache_get_value_index_int(0, 5, PlayerPersonalization[playerid][PERS_NICKNAMES]);
		cache_get_value_index_int(0, 6, PlayerPersonalization[playerid][PERS_CB]);
		cache_get_value_index_int(0, 7, PlayerPersonalization[playerid][PERS_REPORT]);
		cache_get_value_index_int(0, 8, PlayerPersonalization[playerid][WARNDEATH]);
		cache_get_value_index_int(0, 9, PlayerPersonalization[playerid][PERS_KARYTXD]);
		cache_get_value_index_int(0, 10, PlayerPersonalization[playerid][PERS_NEWNICK]);
		cache_get_value_index_int(0, 11, PlayerPersonalization[playerid][PERS_NEWBIE]);
		cache_get_value_index_int(0, 12, PlayerPersonalization[playerid][PERS_GUNSCROLL]);
	}
	cache_delete(result);

    MruMySQL_LoadAccess(playerid);
    //MruMySQL_WczytajOpis(playerid, PlayerInfo[playerid][pUID], 1);
	return fault;
}

//--------------------------------------------------------------<[ Konta ]>--------------------------------------------------------------
MruMySQL_CreateAccount(playerid, password[])
{	
	new query[256+WHIRLPOOL_LEN+SALT_LENGTH];
    new hash[WHIRLPOOL_LEN], salt[SALT_LENGTH];
	randomString(salt, sizeof(salt));
	WP_Hash(hash, sizeof(hash), sprintf("%s%s%s", ServerSecret, password, salt));
	format(query, sizeof(query), "INSERT INTO `mru_konta` (`Nick`, `Key`, `Salt`) VALUES ('%s', '%s', '%s')", GetNickEx(playerid), hash, salt);
	new Cache:result = mysql_query(mruMySQL_Connection, query, true);
	if(cache_is_valid(result))
	{
		PlayerInfo[playerid][pUID] = cache_insert_id();
		cache_delete(result);
	}
	return 1;
}

MruMySQL_WczytajOpis(handle, uid, typ)
{
    new string[128];
    format(string, sizeof(string), "SELECT `desc` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);

	if(cache_is_valid(result) && cache_num_rows())
    {
		cache_get_value_index(0, 0, string);
        if(typ == 1)
        {
            strpack(PlayerDesc[handle], string);
		}
		else
		{
            strpack(CarDesc[handle], string);
		}
	}
	cache_delete(result);
    return 1;
}

MruMySQL_UpdateOpis(handle, uid, typ)
{
    new lStr[256], packed[128], opis[128];
    strunpack(packed, (typ == 1) ? (PlayerDesc[handle]) : (CarDesc[handle]));
    mysql_escape_string(packed, opis);
    if(MruMySQL_CheckOpis(uid, typ))
        format(lStr, 256, "UPDATE `mru_opisy` SET `desc`='%s' WHERE `owner`='%d' AND `typ`=%d", opis, uid, typ);
    else
        format(lStr, 256, "INSERT INTO `mru_opisy` (`desc`, `owner`, `typ`) VALUES ('%s', %d, %d)", opis, uid, typ);
    mysql_tquery(mruMySQL_Connection, lStr);
}

MruMySQL_CheckOpis(uid, typ)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "SELECT `UID` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    new Cache:result = mysql_query(mruMySQL_Connection, lStr);
    new ret = cache_num_rows() > 0;
	cache_delete(result);
    return ret;
}

MruMySQL_DeleteOpis(uid, typ)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "DELETE FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_tquery(mruMySQL_Connection, lStr);
    return 0;
}

MruMySQL_LoadAccess(playerid)
{
	new query[128];
	format(query, sizeof(query), "SELECT `FLAGS` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);

	new Cache:result = mysql_query(mruMySQL_Connection, query, true);

	if(cache_is_valid(result) && cache_num_rows())
    {
		cache_get_value_index_int(0, 0, ACCESS[playerid]);
        OLD_ACCESS[playerid] = ACCESS[playerid];
	}
	cache_delete(result);
    return 1;
}

//returns 0 if not exists, account uid if exits
MruMySQL_DoesAccountExist(nick[])
{
	new string[128];
	mysql_format(mruMySQL_Connection, string, sizeof(string), "SELECT `UID` FROM `mru_konta` WHERE `Nick` = BINARY '%e'", nick);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result))
    {
		if(cache_num_rows() > 0)
		{
			new uid;
			cache_get_value_index_int(0, 0, uid);
			return uid;
		}
		cache_delete(result);
	}
	return 0;
}

MruMySQL_ReturnPassword(nick[], key[WHIRLPOOL_LEN], salt[SALT_LENGTH])
{
	new string[128];
	mysql_format(mruMySQL_Connection, string, sizeof(string), "SELECT `Key`, `Salt` FROM `mru_konta` WHERE `Nick` = '%e'", nick);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result) && cache_num_rows())
    {
		cache_get_value_index(0, 0, key, WHIRLPOOL_LEN);
		cache_get_value_index(0, 1, salt, SALT_LENGTH);
	}
	cache_delete(result);
	
	return key;
}

// MruMySQL_ReturnPassword(nick[], key[], salt[])
// {
// 	new string[128];
// 	new result[8+WHIRLPOOL_LEN+SALT_LENGTH];
	
// 	mysql_real_escape_string(nick, nick);
// 	format(string, sizeof(string), "SELECT `Key`, `Salt` FROM `mru_konta` WHERE `Nick` = '%s'", nick);

// 	mysql_query(string);
// 	mysql_store_result();
// 	if(mysql_num_rows() > 0)
// 	{
//         mysql_fetch_row_format(result, "|");
// 		sscanf(result, "p<|>s[129]s[" #SALT_LENGTH "]", key, salt);
// 	}
	
// 	mysql_free_result();
// 	return 1;
// }


//--------------------------------------------------------------<[ Kary ]>--------------------------------------------------------------
MruMySQL_Blockuj(nick[], admin, powod[])
{ 
    new validnick[MAX_PLAYER_NAME+1];
	new validpowod[128];

    mysql_escape_string(nick, validnick);
	mysql_escape_string(powod, validpowod);

	new query[256];
	format(query, sizeof(query), "UPDATE `mru_konta` SET `Block`=1 WHERE `Nick`='%s'", validnick);
	mysql_tquery(mruMySQL_Connection, query);

    if(admin != -1)
    {
        new admnick[32];
        GetPlayerName(admin, admnick, 32);
        format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`,`powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%s', '%d', '%s', '%d')", validnick, validpowod, PlayerInfo[admin][pUID], admnick,WARN_BLOCK);
    }
    else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `powod`, `typ`, `nadal`) VALUES ('%s', '%s', '%d', 'SYSTEM')", validnick, validpowod,WARN_BLOCK);
	mysql_tquery(mruMySQL_Connection, query);

	return 1;
}

MruMySQL_BanujOffline(nick[]="Brak", powod[]="Brak", admin=-1, ip[]="nieznane")
{
	new query[512];

    mysql_escape_string(nick, query);
    format(nick, 32, "%s", query);
    mysql_escape_string(ip, query);
    format(ip, 32, "%s", query);
	
	new validpowod[128];
	mysql_escape_string(powod, validpowod);

    new uid=-1;
    if(strcmp(nick, "Brak", false) != 0) uid = MruMySQL_GetAccInt("UID", nick);
	
	if(admin != -1) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d', '%s', '%d')", uid, nick, ip,validpowod, PlayerInfo[admin][pUID], GetNick(admin),WARN_BAN);
	else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d')", uid, nick,ip, validpowod,WARN_BAN);
	mysql_tquery(mruMySQL_Connection, query);
	
	return 1;
}

MruMySQL_Odbanuj(nick[]="Brak", ip[]="nieznane", admin)
{
	new query[256];
    mysql_escape_string(nick, query);
    format(nick, 32, "%s", query);
    mysql_escape_string(ip, query);
    format(ip, 16, "%s", query);

    new admnick[32];
    GetPlayerName(admin, admnick, 32);

    if(strcmp(ip, "nieznane") == 0)
    {
        format(query, 256, "SELECT `IP` FROM `mru_bany` WHERE `dostal`='%s' ORDER BY `czas` LIMIT 1", nick);
		new Cache:result = mysql_query(mruMySQL_Connection, query, true);
		if(cache_is_valid(result) && cache_num_rows())
    	{
			cache_get_value_index(0, 0, ip, 16);
		}
		cache_delete(result);
    }


	if(strcmp(nick, "Brak", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `nadal_uid`, `nadal`, `typ`, `IP`) VALUES ('%s', '%d', '%s', '%d', '%s')", nick, PlayerInfo[admin][pUID], admnick,WARN_UNBAN, ip);
    else if(strcmp(ip, "nieznane", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`IP`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%d', '%s', '%d')", ip, PlayerInfo[admin][pUID], admnick,WARN_UNBAN);
    if(strlen(query) < 30) return 0;
	mysql_tquery(mruMySQL_Connection, query);
	return 1;
}

MruMySQL_Unblock(nick[]="Brak", admin)
{
	new query[256];
    mysql_escape_string(nick, query);
    format(nick, 32, "%s", query);

    new admnick[32];
    GetPlayerName(admin, admnick, 32);

    format(query, 128, "UPDATE `mru_konta` SET `Block`=0, `CK`=0 WHERE `Nick`='%s'", nick);
    mysql_tquery(mruMySQL_Connection, query);
    query="\0";

	if(strcmp(nick, "Brak", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%d', '%s', '%d')", nick, PlayerInfo[admin][pUID], admnick,WARN_UNBLOCK);
    if(strlen(query) < 30) return 0;
	mysql_tquery(mruMySQL_Connection, query);
	return 1;
}

MruMySQL_Banuj(playerid, powod[]="Brak", admin=-1)
{	
	new query[512];
	new uid = PlayerInfo[playerid][pUID], ip[16];

	GetPlayerIp(playerid, ip, sizeof(ip));
	
	new validpowod[128];
	mysql_escape_string(powod, validpowod);
	
	if(admin != -1)
    {
        new admnick[32];
        GetPlayerName(admin, admnick, 32);
        format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d', '%s', '%d')", uid, GetNick(playerid), ip, validpowod, PlayerInfo[admin][pUID], admnick,WARN_BAN);
    }
    else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `typ`, `nadal`) VALUES ('%d', '%s', '%s', '%s', '%d', 'SYSTEM')", uid, GetNick(playerid), ip, validpowod,WARN_BAN);
	mysql_tquery(mruMySQL_Connection, query);
	return 1;
}

bool:MruMySQL_SprawdzBany(playerid)
{
	new ip[16], query[256];
	GetPlayerIp(playerid,ip,sizeof(ip));
	format(query, sizeof(query), "SELECT `typ`, `nadal_uid`, `nadal`, `powod`, `czas`, `dostal`, `dostal_uid`, `IP` FROM `mru_bany` WHERE `dostal`='%s' OR `IP` = '%s' ORDER BY `czas` DESC LIMIT 1", GetNick(playerid),ip);
	new Cache:result = mysql_query(mruMySQL_Connection, query, true);
	if(cache_is_valid(result))
	{
		if(cache_num_rows())
		{
			new string[256], powod[64], admin[32], id, typ, czas[32], nick[32], mip[16], pid;
			cache_get_value_index_int(0, 0, typ);
			cache_get_value_index_int(0, 1, id);
			cache_get_value_index(0, 2, admin);
			cache_get_value_index(0, 3, powod);
			cache_get_value_index(0, 4, czas);
			cache_get_value_index(0, 5, nick);
			cache_get_value_index_int(0, 6, pid);
			cache_get_value_index(0, 7, mip);

			if(typ == WARN_BAN)
			{
				if(strcmp(nick, "Brak", true) == 0) format(string, sizeof(string), "Twoje IP (%s) jest zbanowane.", ip);
				else format(string, sizeof(string), "Twoje konto {FF8C00}%s{FFA500} (%d) jest zbanowane.", nick, pid);

				SendClientMessage(playerid, COLOR_NEWS, string);
				format(string, sizeof(string), "{FFA500}Nadaj?cy: %s ({FF8C00}%d{FFA500}) | Powód: {FF8C00}%s{FFA500} | Data: %s", admin,id, powod,czas);
				SendClientMessage(playerid, COLOR_NEWS, string);
				return true;
			}
			else if(typ == WARN_BLOCK)
			{
				SendClientMessage(playerid, COLOR_WHITE, "{FF0000}To konto jest zablokowane, nie mo?esz na nim gra?.");
				SendClientMessage(playerid, COLOR_WHITE, "Je?li uwa?asz, ?e konto zosta?o zablokowane nies?usznie napisz apelacje na: {33CCFF}www.Mrucznik-RP.pl");

				format(string, sizeof(string), "{FFA500}Nadaj?cy: %s ({FF8C00}%d{FFA500}) | Powód: {FF8C00}%s{FFA500} | Data: %s", admin,id, powod,czas);
				SendClientMessage(playerid, COLOR_NEWS, string);
				return true;
			}
		}
		cache_delete(result);
	}
	return false;
}

//Pobieranie i zwracanie pojedynczych zmiennych:

MruMySQL_GetNameFromUID(uid) {
	new nick[MAX_PLAYER_NAME], string[128];
	format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `UID` = '%d'", uid);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result) && cache_num_rows())
	{
		cache_get_value_index(0, 0, nick);
	}
	cache_delete(result);
	return nick;
}

MruMySQL_SetAccString(kolumna[], nick[], wartosc[])
{
	new string[128];
	mysql_format(mruMySQL_Connection, string, sizeof(string), "UPDATE `mru_konta` SET `%e` = '%e' WHERE `Nick` = '%e'", kolumna, wartosc, nick);
	mysql_tquery(mruMySQL_Connection, string);
	return 1;
}

MruMySQL_GetAccInt(kolumna[], nick[])
{
	new string[128], wartosc;
	mysql_format(mruMySQL_Connection, string, sizeof(string), "SELECT `%e` FROM `mru_konta` WHERE `Nick` = '%e'", kolumna, nick);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result) && cache_num_rows())
	{
		cache_get_value_index_int(0, 0, wartosc);
	}
	cache_delete(result);
	return wartosc;
}

MruMySQL_SetAccInt(kolumna[], nick[], wartosc)
{
	new string[128];
	mysql_format(mruMySQL_Connection, string, sizeof(string), "UPDATE `mru_konta` SET `%e` = '%d' WHERE `Nick` = '%e'", kolumna, wartosc, nick);
	mysql_tquery(mruMySQL_Connection, string);
	return 1;
}

//--------------------------------------------------------------<[ Kontakty ]>--------------------------------------------------------------
MruMySQL_LoadPhoneContacts(playerid)
{
	new string[128];
	format(string, sizeof(string), "SELECT UID, Number, Name FROM mru_kontakty WHERE Owner='%d' LIMIT 10", PlayerInfo[playerid][pUID]); //MAX_KONTAKTY
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
        {
			if(i == MAX_KONTAKTY) 
				break;

			cache_get_value_index_int(0, 0, Kontakty[playerid][i][eUID]);
			cache_get_value_index_int(0, 1, Kontakty[playerid][i][eNumer]);
			cache_get_value_index(0, 2, Kontakty[playerid][i][eNazwa], 32);
		}
		cache_delete(result);
	}
	return 1;
}

MruMySQL_AddPhoneContact(playerid, nazwa[], numer)
{
	new string[128], escapedName[32];
	mysql_escape_string(nazwa, escapedName);
	format(string, sizeof(string), "INSERT INTO mru_kontakty (Owner, Number, Name) VALUES ('%d', '%d', '%s')", PlayerInfo[playerid][pUID], numer, escapedName);
	new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	new uid = -1;
	if(cache_is_valid(result))
	{
		uid = cache_insert_id();
		cache_delete(result);
	}
	
	return uid;
}

MruMySQL_EditPhoneContact(uid, nazwa[])
{
	new string[128], escapedName[32];
	mysql_escape_string(nazwa, escapedName);
	format(string, sizeof(string), "UPDATE mru_kontakty SET Name='%s' WHERE UID='%d'", escapedName, uid);
	mysql_tquery(mruMySQL_Connection, string);
	return 1;
}

MruMySQL_DeletePhoneContact(uid)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM mru_kontakty WHERE UID='%d'", uid);
	mysql_tquery(mruMySQL_Connection, string);
	return 1;
}

//--------------------------------------------------------------<[ Liderzy ]>--------------------------------------------------------------
Create_MySQL_Leader(playerid, frac, level)
{
	new query[256];
	mysql_format(mruMySQL_Connection, query, sizeof(query), "INSERT INTO `mru_liderzy` (`NICK`, `UID`, `FracID`, `LiderValue`) VALUES ('%s', '%d', '%d', '%d')", GetNickEx(playerid), PlayerInfo[playerid][pUID], frac, level);
	mysql_tquery(mruMySQL_Connection, query);
	AllLeaders++;
	LeadersValue[LEADER_FRAC][frac]++;   
	return 1;
}
Remove_MySQL_Leader(playerid)
{
	new query[256];
	mysql_format(mruMySQL_Connection, query, sizeof(query), "DELETE FROM `mru_liderzy` WHERE `NICK`='%s'", GetNickEx(playerid));
	mysql_tquery(mruMySQL_Connection, query);
	LeadersValue[LEADER_FRAC][GetPlayerFraction(playerid)]--; 
	AllLeaders--;
	return 1;
}
Remove_MySQL_Leaders(fracID)
{
	new query[126];
	mysql_format(mruMySQL_Connection, query, sizeof(query), "DELETE FROM `mru_liderzy` WHERE `FracID`='%d'", fracID);
	new i; while(i <= AllLeaders) { mysql_tquery(mruMySQL_Connection, query); i++; }
	return 1;
}
Save_MySQL_Leader(playerid)
{
	new query[256];
	mysql_format(mruMySQL_Connection, query, sizeof(query), "UPDATE `mru_liderzy` SET \
		`NICK`='%s', \
		`UID`='%d', \
		`FracID`='%d', \
		`LiderValue`='%d' \
		WHERE `NICK`='%s'",
		GetNickEx(playerid),
		PlayerInfo[playerid][pUID],
		PlayerInfo[playerid][pLider],
		PlayerInfo[playerid][pLiderValue],
		GetNickEx(playerid)); 
	mysql_tquery(mruMySQL_Connection, query);
	return 1;
}
Load_MySQL_Leader(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT `FracID`, `LiderValue` FROM `mru_liderzy` WHERE `NICK`='%s'", GetNickEx(playerid));
	new Cache:result = mysql_query(mruMySQL_Connection, query, true);
	if(cache_is_valid(result) && cache_num_rows())
	{
		cache_get_value_index_int(0, 0, PlayerInfo[playerid][pLider]);
		cache_get_value_index_int(0, 1, PlayerInfo[playerid][pLiderValue]);
	}
	cache_delete(result);
	return 1;
}
MruMySQL_IloscLiderowLoad()
{
	new Cache:result = mysql_query(mruMySQL_Connection, "SELECT FracID, COUNT(*) FROM `mru_liderzy` GROUP BY FracID", true);
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
		{
			new idx;
			cache_get_value_index_int(i, 0, idx);
			cache_get_value_index_int(i, 1, LeadersValue[LEADER_FRAC][idx]);
		}
		cache_delete(result);
	}
}

//EOF
