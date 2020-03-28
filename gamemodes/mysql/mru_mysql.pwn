//mru_mysql.pwn

new bool:MYSQL_ON = true;
new bool:MYSQL_SAVING = true;

new MYSQL_HOST[32];
new MYSQL_USER[32];
new MYSQL_DATABASE[32];
new MYSQL_PASS[256];

public OnQueryError(errorid, error[], resultid, extraid, callback[], query[], connectionHandle)
{
	Log(mysqlLog, ERROR, "%s | resultid: %d | extraid: %d | callback: %s | query: %s", error, resultid, extraid, callback, query);
	return 1;
}

//Moje funkcje:

//--------------------------------------------------------------<[ Konta ]>--------------------------------------------------------------
LoadConnectionValues()
{
	new file[64];
	format(file, sizeof(file), "MySQL/connect.ini");
	if(dini_Exists(file)) 
	{
		strcat(MYSQL_HOST, dini_Get(file, "Host"));
		strcat(MYSQL_USER, dini_Get(file, "User"));
		strcat(MYSQL_DATABASE, dini_Get(file, "DB"));
		strcat(MYSQL_PASS, dini_Get(file, "Pass"));
		return 1;
	}
	return 0;
}

MruMySQL_Connect()
{
	if(!MYSQL_ON) return 0;
	if(!LoadConnectionValues())
	{
		print("MYSQL: Nieudane pobranie danych z MySQL/connect.ini");
		SendRconCommand("gamemodetext Brak polaczenia MySQL");
		SendRconCommand("exit");
	}

    mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DATABASE, MYSQL_PASS);
	print(" ");
	if(mysql_ping() == 1)
	{
		print("MYSQL: Polaczono sie z baza MySQL");
	}
	else
	{
		print("MYSQL: Nieudane polaczenie z baza MySQL");
		SendRconCommand("gamemodetext Brak polaczenia MySQL");
		SendRconCommand("exit");
		return 0;
	}
	#if DEBUG_MODE == 1
		mysql_debug(1);
	#else
		mysql_debug(0);
	#endif
	
	mysql_query("SET NAMES 'cp1250'");
	return 1;
}
Create_MySQL_Leader(playerid, frac, level)
{
	new query[256];
	format(query, sizeof(query), "INSERT INTO `mru_liderzy` (`NICK`, `UID`, `FracID`, `LiderValue`) VALUES ('%s', '%d', '%d', '%d')", GetNickEx(playerid), PlayerInfo[playerid][UID], frac, level);
	mysql_query(query);
	AllLeaders++;
	LeadersValue[LEADER_FRAC][frac]++;   
	return 1;
}
Remove_MySQL_Leader(playerid)
{
	new query[256];
	format(query, sizeof(query), "DELETE FROM `mru_liderzy` WHERE `NICK`='%s'", GetNickEx(playerid));
	mysql_query(query);
	LeadersValue[LEADER_FRAC][GetPlayerFraction(playerid)]--; 
	AllLeaders--;
	return 1;
}
Remove_MySQL_Leaders(fracID)
{
	new query[126];
	format(query, sizeof(query), "DELETE FROM `mru_liderzy` WHERE `FracID`='%d'", fracID);
	new i; while(i <= AllLeaders) { mysql_query(query); i++; }
	return 1;
}
Save_MySQL_Leader(playerid)
{
	new query[256];
	format(query, sizeof(query), "UPDATE `mru_liderzy` SET \
	`NICK`='%s', \
	`UID`='%d', \
	`FracID`='%d', \
	`LiderValue`='%d' \
	WHERE `NICK`='%s'",
	GetNickEx(playerid),
	PlayerInfo[playerid][UID],
	PlayerInfo[playerid][pLider],
	PlayerInfo[playerid][pLiderValue],
	GetNickEx(playerid)); 
	mysql_query(query);
	return 1;
}
Load_MySQL_Leader(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT `FracID`, `LiderValue` FROM `mru_liderzy` WHERE `NICK`='%s'", GetNickEx(playerid));
	mysql_query(query);
	mysql_store_result();
    if (mysql_num_rows())
	{
        mysql_fetch_row_format(query, "|");
		sscanf(query, "p<|>dd", 
		PlayerInfo[playerid][pLider],
		PlayerInfo[playerid][pLiderValue]);
	}
	mysql_free_result();
	return 1;
}
MruMySQL_IloscLiderowLoad()
{
    new lStr[64];
    format(lStr, sizeof(lStr), "SELECT COUNT(*) FROM `mru_liderzy`");
	mysql_query(lStr);
	mysql_store_result();
	new szmuleonetescik[24];
	mysql_fetch_row_format(szmuleonetescik,"|");
	AllLeaders = strval(szmuleonetescik);
	mysql_free_result();
	
	for(new i; i<MAX_FRAC; i++)
	{
		if(i != 0)
		{
			format(lStr, sizeof(lStr), "SELECT COUNT(*) FROM `mru_liderzy` WHERE `FracID`='%d'", i); 
			mysql_query(lStr); 
			mysql_store_result();
			mysql_fetch_row_format(szmuleonetescik,"|");
			LeadersValue[LEADER_FRAC][i] = strval(szmuleonetescik);
			mysql_free_result();
		}
	}
}
MruMySQL_CreateAccount(playerid, password[])
{
	if(!MYSQL_ON) return 0;
	
	new query[256+WHIRLPOOL_LEN+SALT_LENGTH];
    new hash[WHIRLPOOL_LEN], salt[SALT_LENGTH];
	randomString(salt, sizeof(salt));
	WP_Hash(hash, sizeof(hash), sprintf("%s%s%s", ServerSecret, password, salt));
	format(query, sizeof(query), "INSERT INTO `mru_konta` (`Nick`, `Key`, `Salt`) VALUES ('%s', '%s', '%s')", GetNickEx(playerid), hash, salt);
	mysql_query(query);
	return 1;
}

MruMySQL_SaveAccount(playerid, bool:forcegmx = false, bool:forcequit = false)
{
	if(!MYSQL_ON) return 0;
    if(GLOBAL_EXIT) return 0;
    if(gPlayerLogged[playerid] != 1) return 0;

    if(forcequit)
    {
        //Punkty karne
        if(PlayerInfo[playerid][pPK] > 0) PoziomPoszukiwania[playerid] += 10000+(PlayerInfo[playerid][pPK]*100);
        
    }

	new query[1024], bool:fault=true;

	if(forcegmx == false) GetPlayerHealth(playerid,PlayerInfo[playerid][pHealth]);

	PlayerInfo[playerid][BankMoney] = kaska[playerid];

    if(PlayerInfo[playerid][Level] == 0)
    {
        Log(mysqlLog, ERROR, "MySQL:: %s - b³¹d zapisu konta (zerowy level)!!!", GetPlayerLogName(playerid));
        return 0;
    }

	//wy³¹cz na chwilkê maskowanie nicku (pNick)
	new maska_nick[24];
	if(GetPVarString(playerid, "maska_nick", maska_nick, 24))
	{
		format(PlayerInfo[playerid][Nick], 24, "%s", maska_nick);
	}
	
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
	`Nick`='%s',\
	`Level`='%d',\
	`Admin`='%d',\
	`DonateRank`='%d',\
	`UpgradePoints`='%d',\
	`ConnectedTime`='%d',\
	`Registered`='%d',\
	`Sex`='%d',\
	`Age`='%d',\
	`Origin`='%d',\
	`CK`='%d',\
	`Muted`='%d',\
	`Respect`='%d',\
	`Money`='%d',\
	`Bank`='%d',\
	`Crimes`='%d',\
	`Kills`='%d',\
	`Deaths`='%d',\
	`Arrested`='%d',\
	`WantedDeaths`='%d',\
	`Phonebook`='%d',\
	`LottoNr`='%d',\
	`Fishes`='%d',",
	PlayerInfo[playerid][Nick],
	PlayerInfo[playerid][Level],
	PlayerInfo[playerid][pAdmin],
	PlayerInfo[playerid][OldDonateRank],
	PlayerInfo[playerid][UpgradeLvl],
	PlayerInfo[playerid][OnlineHours],
	PlayerInfo[playerid][Registered],
	PlayerInfo[playerid][Gender],
	PlayerInfo[playerid][Age],
	PlayerInfo[playerid][Origin],
	PlayerInfo[playerid][CK],
	PlayerInfo[playerid][Mute],
	PlayerInfo[playerid][Exp],
	PlayerInfo[playerid][BankMoney],
	PlayerInfo[playerid][BankMoney],
	PlayerInfo[playerid][Crimes],
	PlayerInfo[playerid][Kills],
	PlayerInfo[playerid][Deaths],
	PlayerInfo[playerid][Arrested],
	PlayerInfo[playerid][WantedDeaths],
	PlayerInfo[playerid][Item_PhoneBook],
	PlayerInfo[playerid][LottoNr],
	PlayerInfo[playerid][Fishes]);

    format(query, sizeof(query), "%s\
	`BiggestFish`='%d',\
	`Job`='%d',\
	`Paycheck`='%d',\
	`HeadValue`='%d',\
	`BlokadaPisania`='%d',\
	`Jailed`='%d',\
	`AJreason`='%s',\
	`JailTime`='%d',\
	`Materials`='%d',\
	`Drugs`='%d',\
	`Member`='%d',\
	`Group`='%d',\
	`FMember`='%d',\
	`Rank`='%d',\
	`Char`='%d',\
	`Skin`='%d',\
	`ContractTime`='%d',\
    `Auto1`='%d',\
	`Auto2`='%d',\
	`Auto3`='%d',\
	`Auto4`='%d',\
	`Lodz`='%d',\
	`Samolot`='%d',\
	`Garaz`='%d',\
	`KluczykiDoAuta`='%d',\
	`Spawn`='%d',\
	`BW`='%d',\
	`Injury`='%d',\
	`HealthPacks`='%d',\
	`Czystka`='%d',\
    `CarSlots`='%d'\
	WHERE `UID`='%d'", query,
	PlayerInfo[playerid][BiggestFish],
	PlayerInfo[playerid][Job],
	PlayerInfo[playerid][pPayCheck],
	PlayerInfo[playerid][pHeadValue],
	PlayerInfo[playerid][pBP],
	PlayerInfo[playerid][pJailed],
	PlayerInfo[playerid][pAJreason],
	PlayerInfo[playerid][pJailTime],
	PlayerInfo[playerid][pMats],
	PlayerInfo[playerid][pDrugs],
	PlayerInfo[playerid][pMember],
	PlayerInfo[playerid][pGroup],
	PlayerInfo[playerid][pOrg],
	(gPlayerOrgLeader[playerid]) ? (PlayerInfo[playerid][Rank]+1000) : (PlayerInfo[playerid][Rank]),
	PlayerInfo[playerid][pChar],
	PlayerInfo[playerid][pSkin],
	PlayerInfo[playerid][pContractTime],
    PlayerInfo[playerid][pAuto1],
	PlayerInfo[playerid][pAuto2],
	PlayerInfo[playerid][pAuto3],
	PlayerInfo[playerid][pAuto4],
	PlayerInfo[playerid][pLodz],
	PlayerInfo[playerid][pSamolot],
	PlayerInfo[playerid][pGaraz],
	PlayerInfo[playerid][pKluczeAuta],
	PlayerInfo[playerid][pSpawn],
	PlayerInfo[playerid][pBW],
	PlayerInfo[playerid][pInjury],
	PlayerInfo[playerid][pHealthPacks],
	PlayerInfo[playerid][pCzystka],
    PlayerInfo[playerid][pCarSlots],
	PlayerInfo[playerid][UID]);
    if(!mysql_query(query)) fault=false;
	
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
    `DetSkill`='%d', \
	`SexSkill`='%d', \
	`BoxSkill`='%d', \
	`LawSkill`='%d', \
	`MechSkill`='%d', \
	`JackSkill`='%d', \
	`CarSkill`='%d', \
	`NewsSkill`='%d', \
	`DrugsSkill`='%d', \
	`CookSkill`='%d', \
	`FishSkill`='%d', \
	`GunSkill`='%d', \
    `TruckSkill`='%d', \
	`pSHealth`='%f', \
	`pHealth`='%f', \
	`Int`='%d'", PlayerInfo[playerid][pDetSkill],
	PlayerInfo[playerid][pSexSkill],
	PlayerInfo[playerid][pBoxSkill],
	PlayerInfo[playerid][pLawSkill],
	PlayerInfo[playerid][pMechSkill],
	PlayerInfo[playerid][pJackSkill],
	PlayerInfo[playerid][pCarSkill],
	PlayerInfo[playerid][pNewsSkill],
	PlayerInfo[playerid][pDrugsSkill],
	PlayerInfo[playerid][pCookSkill],
	PlayerInfo[playerid][pFishSkill],
	PlayerInfo[playerid][pGunSkill],
    PlayerInfo[playerid][pTruckSkill],
	PlayerInfo[playerid][pSHealth],
	PlayerInfo[playerid][pHealth],
	PlayerInfo[playerid][pInt]);

    format(query, sizeof(query), "%s, \
    `Local`='%d', \
	`Team`='%d', \
	`JobSkin`='%d', \
	`PhoneNr`='%d', \
	`Dom`='%d', \
	`Bizz`='%d', \
	`BizzMember`='%d', \
	`Wynajem`='%d', \
	`Pos_x`='%f', \
	`Pos_y`='%f', \
	`Pos_z`='%f', \
	`CarLic`='%d', \
	`FlyLic`='%d', \
	`BoatLic`='%d', \
	`FishLic`='%d', \
	`GunLic`='%d', \
    `Hat`='%d' WHERE `UID`='%d'", query,
    PlayerInfo[playerid][pLocal],
	PlayerInfo[playerid][pTeam],
	PlayerInfo[playerid][pJobSkin],
	PlayerInfo[playerid][pPnumber],
	PlayerInfo[playerid][pDom],
	PlayerInfo[playerid][pBusinessOwner],
	PlayerInfo[playerid][pBusinessMember],
	PlayerInfo[playerid][pWynajem],
	PlayerInfo[playerid][pPos_x],
	PlayerInfo[playerid][pPos_y],
	PlayerInfo[playerid][pPos_z],
	PlayerInfo[playerid][pCarLic],
	PlayerInfo[playerid][pFlyLic],
	PlayerInfo[playerid][pBoatLic],
	PlayerInfo[playerid][pFishLic],
	PlayerInfo[playerid][pGunLic],
    PlayerInfo[playerid][pHat], PlayerInfo[playerid][UID]);

    if(!mysql_query(query)) fault=false;
	
	format(query, sizeof(query), "UPDATE `mru_konta` SET \
	`Gun0`='%d', \
	`Gun1`='%d', \
	`Gun2`='%d', \
	`Gun3`='%d', \
	`Gun4`='%d', \
	`Gun5`='%d', \
	`Gun6`='%d', \
	`Gun7`='%d', \
	`Gun8`='%d', \
	`Gun9`='%d', \
	`Gun10`='%d', \
	`Gun11`='%d', \
	`Gun12`='%d', \
	`Ammo0`='%d', \
	`Ammo1`='%d', \
	`Ammo2`='%d', \
	`Ammo3`='%d', \
	`Ammo4`='%d', \
	`Ammo5`='%d', \
	`Ammo6`='%d', \
	`Ammo7`='%d', \
	`Ammo8`='%d', \
	`Ammo9`='%d', \
	`Ammo10`='%d', \
	`Ammo11`='%d', \
	`Ammo12`='%d', ",
	PlayerInfo[playerid][pGun0],
	PlayerInfo[playerid][pGun1],
	PlayerInfo[playerid][pGun2],
	PlayerInfo[playerid][pGun3],
	PlayerInfo[playerid][pGun4],
	PlayerInfo[playerid][pGun5],
	PlayerInfo[playerid][pGun6],
	PlayerInfo[playerid][pGun7],
	PlayerInfo[playerid][pGun8],
	PlayerInfo[playerid][pGun9],
	PlayerInfo[playerid][pGun10],
	PlayerInfo[playerid][pGun11],
	PlayerInfo[playerid][pGun12],
	PlayerInfo[playerid][pAmmo0],
	PlayerInfo[playerid][pAmmo1],
	PlayerInfo[playerid][pAmmo2],
	PlayerInfo[playerid][pAmmo3],
	PlayerInfo[playerid][pAmmo4],
	PlayerInfo[playerid][pAmmo5],
	PlayerInfo[playerid][pAmmo6],
	PlayerInfo[playerid][pAmmo7],
	PlayerInfo[playerid][pAmmo8],
	PlayerInfo[playerid][pAmmo9],
	PlayerInfo[playerid][pAmmo10],
	PlayerInfo[playerid][pAmmo11],
	PlayerInfo[playerid][pAmmo12]);
	
	format(query, sizeof(query), "%s \
	`CarTime`='%d', \
	`PayDay`='%d', \
	`PayDayHad`='%d', \
	`CDPlayer`='%d', \
	`Wins`='%d', \
	`Loses`='%d', \
	`AlcoholPerk`='%d', \
	`DrugPerk`='%d', \
	`MiserPerk`='%d', \
	`PainPerk`='%d', \
	`TraderPerk`='%d', \
	`Tutorial`='%d', \
	`Mission`='%d', \
	`Warnings`='%d', \
    `Block`='%d', \
	`Fuel`='%d', \
	`Married`='%d', \
	`MarriedTo`='%s', ", query,
	PlayerInfo[playerid][pCarTime],
	PlayerInfo[playerid][pPayDay],
	PlayerInfo[playerid][pPayDayHad],
	PlayerInfo[playerid][pCDPlayer],
	PlayerInfo[playerid][pWins],
	PlayerInfo[playerid][pLoses],
	PlayerInfo[playerid][pAlcoholPerk],
	PlayerInfo[playerid][pDrugPerk],
	PlayerInfo[playerid][pMiserPerk],
	PlayerInfo[playerid][pPainPerk],
	PlayerInfo[playerid][pTraderPerk],
	PlayerInfo[playerid][pTut],
	PlayerInfo[playerid][pMissionNr],
	PlayerInfo[playerid][pWarns],
    PlayerInfo[playerid][BlockType],
	PlayerInfo[playerid][pFuel],
	PlayerInfo[playerid][pMarried],
	PlayerInfo[playerid][pMarriedTo]);

    format(query, sizeof(query), "%s \
    `CBRADIO`='%d', \
	`PoziomPoszukiwania`='%d', \
	`Dowod`='%d', \
	`PodszywanieSie`='%d', \
    `ZmienilNick`='%d', \
	`Wino`='%d', \
	`Piwo`='%d', \
	`Cygaro`='%d', \
	`Sprunk`='%d', \
	`PodgladWiadomosci`='%d', \
	`StylWalki`='%d', \
	`PAdmin`='%d', \
	`Uniform`='%d', \
	`CruiseController`='%d', \
	`FixKit`='%d', \
	`connected`='%d' \
	WHERE `UID`='%d'", query,
    PlayerInfo[playerid][pCB],
	PoziomPoszukiwania[playerid],
	PlayerInfo[playerid][pDowod],
	PlayerInfo[playerid][pTajniak],
    PlayerInfo[playerid][pZmienilNick],
	PlayerInfo[playerid][pWino],
	PlayerInfo[playerid][pPiwo],
	PlayerInfo[playerid][pCygaro],
	PlayerInfo[playerid][pSprunk],
	PlayerInfo[playerid][pPodPW],
	PlayerInfo[playerid][pStylWalki],
	PlayerInfo[playerid][pHalfAdmin],
	PlayerInfo[playerid][pUniform],
	PlayerInfo[playerid][pCruiseController],
	PlayerInfo[playerid][pFixKit],
	forcequit ? 0 : 2,
    PlayerInfo[playerid][UID]);

    if(!mysql_query(query)) fault=false;

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
	PlayerInfo[playerid][UID]); 

	//przywróæ maskowanie nicku (pNick)
	if(GetPVarString(playerid, "maska_nick", maska_nick, 24))
	{
		new playernickname[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playernickname, sizeof(playernickname));
		format(PlayerInfo[playerid][Nick], 24, "%s", playernickname);
	}

	if(!mysql_query(query)) fault=false;
	
    //Zapis MruCoinow
    MruMySQL_SaveMc(playerid);

    saveLegale(playerid);

    saveKevlarPos(playerid);

	return fault;
}

public MruMySQL_LoadAccount(playerid)
{
	if(!MYSQL_ON) return false;

	new lStr[1024], id=0;

    lStr = "`UID`, `Nick`, `Level`, `Admin`, `DonateRank`, `UpgradePoints`, `ConnectedTime`, `Registered`, `Sex`, `Age`, `Origin`, `CK`, `Muted`, `Respect`, `Money`, `Bank`, `Crimes`, `Kills`, `Deaths`, `Arrested`, `WantedDeaths`, `Phonebook`, `LottoNr`, `Fishes`, `BiggestFish`, `Job`, `Paycheck`, `HeadValue`, `BlokadaPisania`, `Jailed`, `AJreason`, `JailTime`, `Materials`,`Drugs`, `Member`, `Group`, `FMember`, `Rank`, `Char`, `Skin`, `ContractTime`";

    format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
	mysql_query(lStr);
	mysql_store_result();
    if (mysql_num_rows())
	{
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();
        id++;
		sscanf(lStr, "p<|>ds[24]dddddddddddddddddddddddddddds[64]dddddddddd",
		PlayerInfo[playerid][UID],
		PlayerInfo[playerid][Nick],
		PlayerInfo[playerid][Level], 
		PlayerInfo[playerid][pAdmin], 
		PlayerInfo[playerid][OldDonateRank], 
		PlayerInfo[playerid][UpgradeLvl], 
		PlayerInfo[playerid][OnlineHours], 
		PlayerInfo[playerid][Registered], 
		PlayerInfo[playerid][Gender], 
		PlayerInfo[playerid][Age], 
		PlayerInfo[playerid][Origin], 
		PlayerInfo[playerid][CK], 
		PlayerInfo[playerid][Mute], 
		PlayerInfo[playerid][Exp], 
		PlayerInfo[playerid][BankMoney], 
		PlayerInfo[playerid][BankMoney], 
		PlayerInfo[playerid][Crimes], 
		PlayerInfo[playerid][Kills], 
		PlayerInfo[playerid][Deaths], 
		PlayerInfo[playerid][Arrested], 
		PlayerInfo[playerid][WantedDeaths], 
		PlayerInfo[playerid][Item_PhoneBook], 
		PlayerInfo[playerid][LottoNr], 
		PlayerInfo[playerid][Fishes], 
		PlayerInfo[playerid][BiggestFish], 
		PlayerInfo[playerid][Job], 
		PlayerInfo[playerid][pPayCheck], 
		PlayerInfo[playerid][pHeadValue], 
		PlayerInfo[playerid][pBP], 
		PlayerInfo[playerid][pJailed], 
		PlayerInfo[playerid][pAJreason],
		PlayerInfo[playerid][pJailTime], 
		PlayerInfo[playerid][pMats], 
		PlayerInfo[playerid][pDrugs], 
		PlayerInfo[playerid][pMember], 
		PlayerInfo[playerid][pGroup], 
		PlayerInfo[playerid][pOrg],
		PlayerInfo[playerid][Rank], 
		PlayerInfo[playerid][pChar], 
		PlayerInfo[playerid][pSkin], 
		PlayerInfo[playerid][pContractTime]);

        lStr = "`DetSkill`, `SexSkill`, `BoxSkill`, `LawSkill`, `MechSkill`, `JackSkill`, `CarSkill`, `NewsSkill`, `DrugsSkill`, `CookSkill`, `FishSkill`, `GunSkill`, `TruckSkill`, `pSHealth`, `pHealth`, `Int`, `Local`, `Team`, `JobSkin`, `PhoneNr`, `Dom`, `Bizz`, `BizzMember`, `Wynajem`, `Pos_x`, `Pos_y`, `Pos_z`, `CarLic`, `FlyLic`, `BoatLic`, `FishLic`, `GunLic`";
        format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

        sscanf(lStr, "p<|>dddddddddddddffdddddddddfffddddd",
        PlayerInfo[playerid][pDetSkill],
		PlayerInfo[playerid][pSexSkill],
		PlayerInfo[playerid][pBoxSkill],
		PlayerInfo[playerid][pLawSkill],
		PlayerInfo[playerid][pMechSkill],
		PlayerInfo[playerid][pJackSkill],
		PlayerInfo[playerid][pCarSkill],
		PlayerInfo[playerid][pNewsSkill],
		PlayerInfo[playerid][pDrugsSkill],
		PlayerInfo[playerid][pCookSkill],
		PlayerInfo[playerid][pFishSkill],
		PlayerInfo[playerid][pGunSkill],
        PlayerInfo[playerid][pTruckSkill],
		PlayerInfo[playerid][pSHealth],
		PlayerInfo[playerid][pHealth],
		PlayerInfo[playerid][pInt],
		PlayerInfo[playerid][pLocal],
		PlayerInfo[playerid][pTeam],
		PlayerInfo[playerid][pJobSkin],
		PlayerInfo[playerid][pPnumber],
		PlayerInfo[playerid][pDom],
		PlayerInfo[playerid][pBusinessOwner],
		PlayerInfo[playerid][pBusinessMember],
		PlayerInfo[playerid][pWynajem],
		PlayerInfo[playerid][pPos_x],
		PlayerInfo[playerid][pPos_y],
		PlayerInfo[playerid][pPos_z],
		PlayerInfo[playerid][pCarLic],
		PlayerInfo[playerid][pFlyLic],
		PlayerInfo[playerid][pBoatLic],
		PlayerInfo[playerid][pFishLic],
		PlayerInfo[playerid][pGunLic]);


        lStr = "`Gun0`, `Gun1`, `Gun2`, `Gun3`, `Gun4`, `Gun5`, `Gun6`, `Gun7`, `Gun8`, `Gun9`, `Gun10`, `Gun11`, `Gun12`, `Ammo0`, `Ammo1`, `Ammo2`, `Ammo3`, `Ammo4`, `Ammo5`, `Ammo6`, `Ammo7`, `Ammo8`, `Ammo9`, `Ammo10`, `Ammo11`, `Ammo12`, `CarTime`, `PayDay`, `PayDayHad`, `CDPlayer`, `Wins`, `Loses`, `AlcoholPerk`, `DrugPerk`, `MiserPerk`, `PainPerk`, `TraderPerk`, `Tutorial`, `Mission`, `Warnings`, `Block`, `Fuel`, `Married`";

        format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

		sscanf(lStr, "p<|>ddddddddddddddddddddddddddddddddddddddddddd",
		PlayerInfo[playerid][pGun0], 
		PlayerInfo[playerid][pGun1], 
		PlayerInfo[playerid][pGun2], 
		PlayerInfo[playerid][pGun3], 
		PlayerInfo[playerid][pGun4], 
		PlayerInfo[playerid][pGun5], 
		PlayerInfo[playerid][pGun6], 
		PlayerInfo[playerid][pGun7], 
		PlayerInfo[playerid][pGun8], 
		PlayerInfo[playerid][pGun9], 
		PlayerInfo[playerid][pGun10], 
		PlayerInfo[playerid][pGun11], 
		PlayerInfo[playerid][pGun12], 
		PlayerInfo[playerid][pAmmo0], 
		PlayerInfo[playerid][pAmmo1], 
		PlayerInfo[playerid][pAmmo2], 
		PlayerInfo[playerid][pAmmo3], 
		PlayerInfo[playerid][pAmmo4], 
		PlayerInfo[playerid][pAmmo5], 
		PlayerInfo[playerid][pAmmo6], 
		PlayerInfo[playerid][pAmmo7], 
		PlayerInfo[playerid][pAmmo8], 
		PlayerInfo[playerid][pAmmo9], 
		PlayerInfo[playerid][pAmmo10], 
		PlayerInfo[playerid][pAmmo11], 
		PlayerInfo[playerid][pAmmo12], 
		PlayerInfo[playerid][pCarTime], 
		PlayerInfo[playerid][pPayDay], 
		PlayerInfo[playerid][pPayDayHad], 
		PlayerInfo[playerid][pCDPlayer], 
		PlayerInfo[playerid][pWins], 
		PlayerInfo[playerid][pLoses], 
		PlayerInfo[playerid][pAlcoholPerk], 
		PlayerInfo[playerid][pDrugPerk], 
		PlayerInfo[playerid][pMiserPerk], 
		PlayerInfo[playerid][pPainPerk], 
		PlayerInfo[playerid][pTraderPerk], 
		PlayerInfo[playerid][pTut], 
		PlayerInfo[playerid][pMissionNr], 
		PlayerInfo[playerid][pWarns], 
		PlayerInfo[playerid][BlockType], 
		PlayerInfo[playerid][pFuel], 
		PlayerInfo[playerid][pMarried]);

        lStr = "`MarriedTo`, `CBRADIO`, `PoziomPoszukiwania`, `Dowod`, `PodszywanieSie`, `ZmienilNick`, `Wino`, `Piwo`, `Cygaro`, `Sprunk`, `PodgladWiadomosci`, `StylWalki`, `PAdmin`, `Uniform`, `CruiseController`, `FixKit`, `Auto1`, `Auto2`, `Auto3`, `Auto4`, `Lodz`, `Samolot`, `Garaz`, `KluczykiDoAuta`, `Spawn`, `BW`, `Injury`, `HealthPacks`, `Czystka`, `CarSlots`";

        format(lStr, sizeof(lStr), "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNickEx(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

        sscanf(lStr, "p<|>s[24]ddddddddddddddddddddddddddddd",
        PlayerInfo[playerid][pMarriedTo],
		PlayerInfo[playerid][pCB],
		PlayerInfo[playerid][pWL],
		PlayerInfo[playerid][pDowod],
		PlayerInfo[playerid][pTajniak],
		PlayerInfo[playerid][pZmienilNick],
		PlayerInfo[playerid][pWino],
		PlayerInfo[playerid][pPiwo],
		PlayerInfo[playerid][pCygaro],
		PlayerInfo[playerid][pSprunk],
		PlayerInfo[playerid][pPodPW],
		PlayerInfo[playerid][pStylWalki],
		PlayerInfo[playerid][pHalfAdmin],
		PlayerInfo[playerid][pUniform],
		PlayerInfo[playerid][pCruiseController],
		PlayerInfo[playerid][pFixKit],
		PlayerInfo[playerid][pAuto1],
		PlayerInfo[playerid][pAuto2],
		PlayerInfo[playerid][pAuto3],
		PlayerInfo[playerid][pAuto4],
		PlayerInfo[playerid][pLodz],
		PlayerInfo[playerid][pSamolot],
		PlayerInfo[playerid][pGaraz],
		PlayerInfo[playerid][pKluczeAuta],
		PlayerInfo[playerid][pSpawn],
		PlayerInfo[playerid][pBW],
		PlayerInfo[playerid][pInjury],
		PlayerInfo[playerid][pHealthPacks],
		PlayerInfo[playerid][pCzystka],
        PlayerInfo[playerid][pCarSlots]);

		format(lStr, sizeof(lStr), "UPDATE `mru_konta` SET `connected`='1' WHERE `UID`='%d'", PlayerInfo[playerid][UID]);
		mysql_query(lStr);
	}

	// Pozycje kamizelki

	loadKamiPos(playerid);

	//Wczytaj liderów
	lStr = "`NICK`, `UID`, `FracID`, `LiderValue`";
	format(lStr, 1024, "SELECT %s FROM `mru_liderzy` WHERE `NICK`='%s'", lStr, GetNickEx(playerid));
	mysql_query(lStr);
	mysql_store_result(); 
	if(mysql_num_rows())
	{
		mysql_fetch_row_format(lStr, "|"); 
		sscanf(lStr, "p<|>s[24]ddd",
		GetNickEx(playerid),
		PlayerInfo[playerid][UID],
		PlayerInfo[playerid][pLider],
		PlayerInfo[playerid][pLiderValue]); 
	} 
	mysql_free_result();
	//Wczytaj personalizacje
	lStr = "`KontoBankowe`, `Ogloszenia`, `LicznikPojazdu`, `OgloszeniaFrakcji`, `OgloszeniaRodzin`, `OldNick`, `CBRadio`, `Report`, `DeathWarning`, `KaryTXD`, `NewNick`, `newbie`, `BronieScroll`";
	format(lStr, 1024, "SELECT %s FROM `mru_personalization` WHERE `UID`=%d", lStr, PlayerInfo[playerid][UID]);
	mysql_query(lStr); 
	mysql_store_result(); 
	if(mysql_num_rows())
	{
		mysql_fetch_row_format(lStr, "|"); 
		sscanf(lStr, "p<|>ddddddddddddd", 
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
		PlayerPersonalization[playerid][PERS_GUNSCROLL]); 
	}
	mysql_free_result();
	
	//legal
	format(lStr, sizeof lStr, "SELECT * FROM `mru_legal` WHERE `pID`=%d", PlayerInfo[playerid][UID]);
	new DBResult:db_result;
	db_result = db_query(db_handle, lStr);

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
		format(lStr, sizeof lStr, "INSERT INTO `mru_legal` (`pID`,`weapon1`, `weapon2`, `weapon3`, `weapon4`, `weapon5`, `weapon6`, `weapon7`, `weapon8`, `weapon9`, `weapon10`, `weapon11`, `weapon12`, `weapon13`) VALUES (%d, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1)", PlayerInfo[playerid][UID]);
		db_free_result(db_query(db_handle, lStr));
	}


    MruMySQL_LoadAccess(playerid);
    //MruMySQL_WczytajOpis(playerid, PlayerInfo[playerid][UID], 1);
	if(id != 4) return false;
	return true;
}

MruMySQL_WczytajOpis(handle, uid, typ)
{
    new lStr[128], lText[128];
    format(lStr, 128, "SELECT `desc` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        if(typ == 1)
        {
            mysql_fetch_row_format(lText, "|");
            strpack(PlayerDesc[handle], lText);
        }
        else
        {
            mysql_fetch_row_format(lText, "|");
            strpack(CarDesc[handle], lText);
        }
    }
	mysql_free_result();
    return 1;
}

MruMySQL_UpdateOpis(handle, uid, typ)
{
    new lStr[256], packed[128], opis[128];
    strunpack(packed, (typ == 1) ? (PlayerDesc[handle]) : (CarDesc[handle]));
    mysql_real_escape_string(packed, opis);
    if(MruMySQL_CheckOpis(uid, typ))
        format(lStr, 256, "UPDATE `mru_opisy` SET `desc`='%s' WHERE `owner`='%d' AND `typ`=%d", opis, uid, typ);
    else
        format(lStr, 256, "INSERT INTO `mru_opisy` (`desc`, `owner`, `typ`) VALUES ('%s', %d, %d)", opis, uid, typ);
    mysql_query(lStr);
}

MruMySQL_CheckOpis(uid, typ)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "SELECT `UID` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_free_result();
        return 1;
    }
	mysql_free_result();
    return 0;
}

MruMySQL_DeleteOpis(uid, typ)
{
    new lStr[128];
    format(lStr, sizeof(lStr), "DELETE FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    return 0;
}

MruMySQL_LoadAccess(playerid)
{
    if(!MYSQL_ON) return false;

	new query[128];
	format(query, sizeof(query), "SELECT CAST(`FLAGS` AS UNSIGNED) AS `FLAGS` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][UID]);

	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        ACCESS[playerid] = mysql_fetch_int();
        OLD_ACCESS[playerid] = ACCESS[playerid];
    }
    mysql_free_result();
    return 1;
}

MruMySQL_DoesAccountExist(nick[])
{
	new string[128];
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `Nick` = BINARY '%s'", nick);
	mysql_query(string);
	mysql_store_result();
	new result = mysql_num_rows();
	mysql_free_result();

	if(result > 0)
	{
		return -1;
	}
    else
    {
        format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `Nick` = '%s'", nick);
    	mysql_query(string);
    	mysql_store_result();
    	result = mysql_num_rows();
    	mysql_free_result();
        if(result > 0) return -999;
    }
    format(string, 128, "%s.ini", nick);

	if(dini_Exists(string)) return 1;
	return 0;
}

MruMySQL_ReturnPassword(nick[], key[], salt[])
{
	new string[128];
	new result[8+WHIRLPOOL_LEN+SALT_LENGTH];
	
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `Key`, `Salt` FROM `mru_konta` WHERE `Nick` = '%s'", nick);

	mysql_query(string);
	mysql_store_result();
	if(mysql_num_rows() > 0)
	{
        mysql_fetch_row_format(result, "|");
		sscanf(result, "p<|>s[129]s[" #SALT_LENGTH "]", key, salt);
	}
	
	mysql_free_result();
	return 1;
}


//--------------------------------------------------------------<[ Kary ]>--------------------------------------------------------------

MruMySQL_Blockuj(nick[], admin, powod[])
{ 
	if(!MYSQL_ON) return 0;
    new validnick[MAX_PLAYER_NAME+1];
	new validpowod[128];

    mysql_real_escape_string(nick, validnick);
	mysql_real_escape_string(powod, validpowod);

	new query[256];
	format(query, sizeof(query), "UPDATE `mru_konta` SET `Block`=1 WHERE `Nick`='%s'", validnick);
	mysql_query(query);

    if(admin != -1)
    {
        new admnick[32];
        GetPlayerName(admin, admnick, 32);
        format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`,`powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%s', '%d', '%s', '%d')", validnick, validpowod, PlayerInfo[pAdmin][UID], admnick,WARN_BLOCK);
    }
    else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `powod`, `typ`, `nadal`) VALUES ('%s', '%s', '%d', 'SYSTEM')", validnick, validpowod,WARN_BLOCK);
	mysql_query(query);

	return 1;
}

MruMySQL_BanujOffline(nick[]="Brak", powod[]="Brak", admin=-1, ip[]="nieznane")
{
	if(!MYSQL_ON) return 0;
	new query[512];

    mysql_real_escape_string(nick, query);
    format(nick, 32, "%s", query);
    mysql_real_escape_string(ip, query);
    format(ip, 32, "%s", query);
	
	new validpowod[128];
	mysql_real_escape_string(powod, validpowod);

    new uid=-1;
    if(strcmp(nick, "Brak", false) != 0) uid = MruMySQL_GetAccInt("UID", nick);
	
	if(admin != -1) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d', '%s', '%d')", uid, nick, ip,validpowod, PlayerInfo[pAdmin][UID], GetNick(admin),WARN_BAN);
	else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d')", uid, nick,ip, validpowod,WARN_BAN);
	mysql_query(query);
	
	return 1;
}

MruMySQL_Odbanuj(nick[]="Brak", ip[]="nieznane", admin)
{
	if(!MYSQL_ON) return 0;
	new query[256];
    mysql_real_escape_string(nick, query);
    format(nick, 32, "%s", query);
    mysql_real_escape_string(ip, query);
    format(ip, 32, "%s", query);

    new admnick[32];
    GetPlayerName(admin, admnick, 32);

    if(strcmp(ip, "nieznane") == 0)
    {
        format(query, 256, "SELECT `IP` FROM `mru_bany` WHERE `dostal`='%s' ORDER BY `czas` LIMIT 1", nick);
        mysql_query(query);
        mysql_store_result();
        if(mysql_num_rows())
        {
            mysql_fetch_row_format(ip, "|");
        }
		mysql_free_result();
    }


	if(strcmp(nick, "Brak", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `nadal_uid`, `nadal`, `typ`, `IP`) VALUES ('%s', '%d', '%s', '%d', '%s')", nick, PlayerInfo[pAdmin][UID], admnick,WARN_UNBAN, ip);
    else if(strcmp(ip, "nieznane", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`IP`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%d', '%s', '%d')", ip, PlayerInfo[pAdmin][UID], admnick,WARN_UNBAN);
    if(strlen(query) < 30) return 0;
    if(!mysql_query(query)) return 0;
	return 1;
}

MruMySQL_Unblock(nick[]="Brak", admin)
{
	if(!MYSQL_ON) return 0;
	new query[256];
    mysql_real_escape_string(nick, query);
    format(nick, 32, "%s", query);

    new admnick[32];
    GetPlayerName(admin, admnick, 32);

    format(query, 128, "UPDATE `mru_konta` SET `Block`=0, `CK`=0 WHERE `Nick`='%s'", nick);
    mysql_query(query);
    query="\0";

	if(strcmp(nick, "Brak", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%d', '%s', '%d')", nick, PlayerInfo[pAdmin][UID], admnick,WARN_UNBLOCK);
    if(strlen(query) < 30) return 0;
    if(!mysql_query(query)) return 0;
	return 1;
}

MruMySQL_Banuj(playerid, powod[]="Brak", admin=-1)
{ 
	if(!MYSQL_ON) return 0;
	
	new query[512];
	new uid = PlayerInfo[playerid][UID], ip[16];

	GetPlayerIp(playerid, ip, sizeof(ip));
	
	new validpowod[128];
	mysql_real_escape_string(powod, validpowod);
	
	if(admin != -1)
    {
        new admnick[32];
        GetPlayerName(admin, admnick, 32);
        format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d', '%s', '%d')", uid, GetNickEx(playerid), ip, validpowod, PlayerInfo[pAdmin][UID], admnick,WARN_BAN);
    }
    else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `typ`, `nadal`) VALUES ('%d', '%s', '%s', '%s', '%d', 'SYSTEM')", uid, GetNickEx(playerid), ip, validpowod,WARN_BAN);
	mysql_query(query);
	return 1;
}

bool:MruMySQL_SprawdzBany(playerid)
{
	if(!MYSQL_ON) return false;

	new ip[16], query[256];
	GetPlayerIp(playerid,ip,sizeof(ip));
	format(query, sizeof(query), "SELECT `typ`, `nadal_uid`, `nadal`, `powod`, `czas`, `dostal`, `dostal_uid`, `IP` FROM `mru_bany` WHERE `dostal`='%s' OR `IP` = '%s' ORDER BY `czas` DESC LIMIT 1", GetNickEx(playerid),ip);
	mysql_query(query);
	mysql_store_result();

	if (mysql_num_rows())
	{
        mysql_fetch_row_format(query, "|");
        mysql_free_result();
		new string[256], powod[64], admin[32], id, typ, czas[32], nick[32], mip[16], pid;
		sscanf(query, "p<|>dds[32]s[64]s[32]s[32]ds[16]", typ, id, admin, powod, czas,nick, pid, mip);

        if(typ == WARN_BAN)
        {
            if(strcmp(nick, "Brak", true) == 0) format(string, sizeof(string), "Twoje IP (%s) jest zbanowane.", ip);
            else format(string, sizeof(string), "Twoje konto {FF8C00}%s{FFA500} (%d) jest zbanowane.", nick, pid);

    		SendClientMessage(playerid, COLOR_NEWS, string);
    		format(string, sizeof(string), "{FFA500}Nadaj¹cy: %s ({FF8C00}%d{FFA500}) | Powód: {FF8C00}%s{FFA500} | Data: %s", admin,id, powod,czas);
    		SendClientMessage(playerid, COLOR_NEWS, string);
            return true;
        }
        else if(typ == WARN_BLOCK)
        {
            SendClientMessage(playerid, COLOR_WHITE, "{FF0000}To konto jest zablokowane, nie mo¿esz na nim graæ.");
			SendClientMessage(playerid, COLOR_WHITE, "Jeœli uwa¿asz, ¿e konto zosta³o zablokowane nies³usznie napisz apelacje na: {33CCFF}www.Mrucznik-RP.pl");

    		format(string, sizeof(string), "{FFA500}Nadaj¹cy: %s ({FF8C00}%d{FFA500}) | Powód: {FF8C00}%s{FFA500} | Data: %s", admin,id, powod,czas);
    		SendClientMessage(playerid, COLOR_NEWS, string);
            return true;
        }
        else if(typ > 20) //Zwracanie KP, je¿eli ma
        {
            SetPVarInt(playerid, "kp_readd", 1);
            return false;
        }
	}
	else 
	{
		mysql_free_result();
	}
	return false;
}

//Pobieranie i zwracanie pojedynczych zmiennych:

stock MruMySQL_GetNameFromUID(uid) {
	new wartosc[MAX_PLAYER_NAME], string[128];
	format(string, sizeof(string), "SELECT `Nick` FROM `mru_konta` WHERE `UID` = '%d'", uid);
	mysql_query(string);
	mysql_store_result();
		
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(wartosc, "Nick");
	}
	strunpack(wartosc, wartosc);
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetAccString(kolumna[], nick[])
{
	new string[128], wartosc[256];
	mysql_real_escape_string(kolumna, kolumna);
	mysql_real_escape_string(nick, nick);
	
	format(string, sizeof(string), "SELECT `%s` FROM `mru_konta` WHERE `Nick` = '%s'", kolumna, nick);
	mysql_query(string);
	mysql_store_result();
		
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(wartosc, kolumna);
	}
	strunpack(wartosc, wartosc);
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetAccInt(kolumna[], nick[])
{
	new string[128], wartosc;
	mysql_real_escape_string(kolumna, kolumna);
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `%s` FROM `mru_konta` WHERE `Nick` = '%s'", kolumna, nick);
	mysql_query(string);
	mysql_store_result();
    if(mysql_num_rows())
    {
	   wartosc = mysql_fetch_int();
    }
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_GetAccFloat(kolumna[], nick[])
{
	new string[128], Float:wartosc;
	mysql_real_escape_string(kolumna, kolumna);
	mysql_real_escape_string(nick, nick);
	format(string, sizeof(string), "SELECT `%s` FROM `mru_konta` WHERE `Nick` = '%s'", kolumna, nick);
	mysql_query(string);
	mysql_store_result();
	wartosc = mysql_fetch_float();	
	mysql_free_result();
	return wartosc;
}

stock MruMySQL_SetAccString(kolumna[], nick[], wartosc[])
{
	new string[128];
	mysql_real_escape_string(wartosc, wartosc);
	mysql_real_escape_string(nick, nick);
	mysql_real_escape_string(kolumna, kolumna);
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%s' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 1;
}

stock MruMySQL_SetAccInt(kolumna[], nick[], wartosc)
{
	new string[128];
	mysql_real_escape_string(nick, nick);
	mysql_real_escape_string(kolumna, kolumna);
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%d' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 1;
}

stock MruMySQL_SetAccFloat(kolumna[], nick[], Float:wartosc)
{
	new string[128];
	mysql_real_escape_string(nick, nick);
	mysql_real_escape_string(kolumna, kolumna);
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%f' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 0;
}

stock MruMySQL_LoadPhoneContacts(playerid)
{
	new string[128];
	format(string, sizeof(string), "SELECT UID, Number, Name FROM mru_kontakty WHERE Owner='%d' LIMIT 10", PlayerInfo[playerid][UID]); //MAX_KONTAKTY
	mysql_query(string);
	mysql_store_result();
	if(mysql_num_rows()>0)
	{
		new i;
		while(mysql_fetch_row_format(string, "|"))
		{
			sscanf(string, "p<|>dds[32]", 
				Kontakty[playerid][i][eUID], 
				Kontakty[playerid][i][eNumer], 
				Kontakty[playerid][i][eNazwa]
			);
			i++;
			if(i == MAX_KONTAKTY) 
				break;
		}
	}
	mysql_free_result();
	return 1;
}

stock MruMySQL_AddPhoneContact(playerid, nazwa[], numer)
{
	new string[128], escapedName[32];
	mysql_real_escape_string(nazwa, escapedName);
	format(string, sizeof(string), "INSERT INTO mru_kontakty (Owner, Number, Name) VALUES ('%d', '%d', '%s')", PlayerInfo[playerid][UID], numer, escapedName);
	mysql_query(string);
	
	new uid = mysql_insert_id();
	return uid;
}

stock MruMySQL_EditPhoneContact(uid, nazwa[])
{
	new string[128], escapedName[32];
	mysql_real_escape_string(nazwa, escapedName);
	format(string, sizeof(string), "UPDATE mru_kontakty SET Name='%s' WHERE UID='%d'", escapedName, uid);
	mysql_query(string);
	return 1;
}

stock MruMySQL_DeletePhoneContact(uid)
{
	new string[128];
	format(string, sizeof(string), "DELETE FROM mru_kontakty WHERE UID='%d'", uid);
	mysql_query(string);
	return 1;
}

new bool:MySQL_timeout=false;
public MySQL_Refresh()
{
    if(mysql_ping() == 1)
    {
        if(MySQL_timeout)
        {
            new str[64];
            format(str, 64, "gamemodetext Mrucznik-RP %s", VERSION);
            SendRconCommand(str);
            MySQL_timeout = false;
        }
    }
    else
	{
		print("MySQL: Connection time-out");
        mysql_reconnect();
        MySQL_timeout= true;
		SendRconCommand("gamemodetext M-RP: MySQL timeout");
	}
}

//EOF
