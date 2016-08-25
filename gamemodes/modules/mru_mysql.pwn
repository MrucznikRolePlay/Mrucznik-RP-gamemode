//mru_mysql.pwn

new bool:MYSQL_ON = true;
new bool:MYSQL_SAVING = true;

new MYSQL_HOST[32];
new MYSQL_USER[32];
new MYSQL_DATABASE[32];
new MYSQL_PASS[256];
	
forward MruMySQL_Error(error[]);

public OnQueryError(errorid, error[], resultid, extraid, callback[], query[], connectionHandle)
{
	MruMySQL_Error(error);
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
    mysql_debug(0); //DISABLE!!!
    mysql_query("SET NAMES 'cp1250'");
	return 1;
}

MruMySQL_CreateAccount(playerid, pass[])
{
	if(!MYSQL_ON) return 0;
	
	new query[256];
    new password[64];
    format(password, 64, "%s", MD5_Hash(pass));
	format(query, sizeof(query), "INSERT INTO `mru_konta` (`Nick`, `Key`) VALUES ('%s', '%s')", GetNick(playerid), password);
	mysql_query(query);
	return 1;
}

stock MruMySQL_SaveAccount(playerid, bool:forcegmx = false, bool:forcequit = false)
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

	PlayerInfo[playerid][pCash] = kaska[playerid];

    if(PlayerInfo[playerid][pLevel] == 0)
    {
        printf("MySQL:: %s - blad zapisu!!!", GetNick(playerid));
        return 0;
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
	PlayerInfo[playerid][pNick],
	PlayerInfo[playerid][pLevel],
	PlayerInfo[playerid][pAdmin],
	PlayerInfo[playerid][pDonateRank],
	PlayerInfo[playerid][gPupgrade],
	PlayerInfo[playerid][pConnectTime],
	PlayerInfo[playerid][pReg],
	PlayerInfo[playerid][pSex],
	PlayerInfo[playerid][pAge],
	PlayerInfo[playerid][pOrigin],
	PlayerInfo[playerid][pCK],
	PlayerInfo[playerid][pMuted],
	PlayerInfo[playerid][pExp],
	PlayerInfo[playerid][pCash],
	PlayerInfo[playerid][pAccount],
	PlayerInfo[playerid][pCrimes],
	PlayerInfo[playerid][pKills],
	PlayerInfo[playerid][pDeaths],
	PlayerInfo[playerid][pArrested],
	PlayerInfo[playerid][pWantedDeaths],
	PlayerInfo[playerid][pPhoneBook],
	PlayerInfo[playerid][pLottoNr],
	PlayerInfo[playerid][pFishes]);

    format(query, sizeof(query), "%s\
	`BiggestFish`='%d',\
	`Job`='%d',\
	`Paycheck`='%d',\
	`HeadValue`='%d',\
	`BlokadaPisania`='%d',\
	`Jailed`='%d',\
	`JailTime`='%d',\
	`Materials`='%d',\
	`Drugs`='%d',\
	`Lider`='%d',\
	`Member`='%d',\
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
	`Czystka`='%d',\
    `CarSlots`='%d'\
	WHERE `UID`='%d'", query,
	PlayerInfo[playerid][pBiggestFish],
	PlayerInfo[playerid][pJob],
	PlayerInfo[playerid][pPayCheck],
	PlayerInfo[playerid][pHeadValue],
	PlayerInfo[playerid][pBP],
	PlayerInfo[playerid][pJailed],
	PlayerInfo[playerid][pJailTime],
	PlayerInfo[playerid][pMats],
	PlayerInfo[playerid][pDrugs],
	PlayerInfo[playerid][pLider],
	PlayerInfo[playerid][pMember],
	PlayerInfo[playerid][pOrg],
	(gPlayerOrgLeader[playerid]) ? (PlayerInfo[playerid][pRank]+1000) : (PlayerInfo[playerid][pRank]),
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
	PlayerInfo[playerid][pCzystka],
    PlayerInfo[playerid][pCarSlots],
	PlayerInfo[playerid][pUID]);
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
	`Int`='%d',", PlayerInfo[playerid][pDetSkill],
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

    format(query, sizeof(query), "%s \
    `Local`='%d', \
	`Team`='%d', \
	`Model`='%d', \
	`PhoneNr`='%d', \
	`Dom`='%d', \
	`Bizz`='%d', \
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
	PlayerInfo[playerid][pModel],
	PlayerInfo[playerid][pPnumber],
	PlayerInfo[playerid][pDom],
	PlayerInfo[playerid][pPbiskey],
	PlayerInfo[playerid][pWynajem],
	PlayerInfo[playerid][pPos_x],
	PlayerInfo[playerid][pPos_y],
	PlayerInfo[playerid][pPos_z],
	PlayerInfo[playerid][pCarLic],
	PlayerInfo[playerid][pFlyLic],
	PlayerInfo[playerid][pBoatLic],
	PlayerInfo[playerid][pFishLic],
	PlayerInfo[playerid][pGunLic],
    PlayerInfo[playerid][pHat], PlayerInfo[playerid][pUID]);

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
    PlayerInfo[playerid][pBlock],
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
	`ZaufanyGracz`='%d' \
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
	PlayerInfo[playerid][pNewAP],
	PlayerInfo[playerid][pZG],
    PlayerInfo[playerid][pUID]);

    if(!mysql_query(query)) fault=false;

    //Zapis MruCoinow
    MRP_SaveMC(playerid);

	return fault;
}

public MruMySQL_LoadAcocount(playerid)
{
	if(!MYSQL_ON) return false;

	new lStr[1024], id=0;

    lStr = "`UID`, `Nick`, `Level`, `Admin`, `DonateRank`, `UpgradePoints`, `ConnectedTime`, `Registered`, `Sex`, `Age`, `Origin`, `CK`, `Muted`, `Respect`, `Money`, `Bank`, `Crimes`, `Kills`, `Deaths`, `Arrested`, `WantedDeaths`, `Phonebook`, `LottoNr`, `Fishes`, `BiggestFish`, `Job`, `Paycheck`, `HeadValue`, `BlokadaPisania`, `Jailed`, `JailTime`, `Materials`,`Drugs`, `Lider`, `Member`, `FMember`, `Rank`, `Char`, `Skin`, `ContractTime`";

    format(lStr, 1024, "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNick(playerid));
	mysql_query(lStr);
	mysql_store_result();
    if (mysql_num_rows())
	{
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();
        id++;
		sscanf(lStr, "p<|>ds[24]dddddddddddddddddddddddddddddddddddddd",
		PlayerInfo[playerid][pUID],
		PlayerInfo[playerid][pNick],
		PlayerInfo[playerid][pLevel], 
		PlayerInfo[playerid][pAdmin], 
		PlayerInfo[playerid][pDonateRank], 
		PlayerInfo[playerid][gPupgrade], 
		PlayerInfo[playerid][pConnectTime], 
		PlayerInfo[playerid][pReg], 
		PlayerInfo[playerid][pSex], 
		PlayerInfo[playerid][pAge], 
		PlayerInfo[playerid][pOrigin], 
		PlayerInfo[playerid][pCK], 
		PlayerInfo[playerid][pMuted], 
		PlayerInfo[playerid][pExp], 
		PlayerInfo[playerid][pCash], 
		PlayerInfo[playerid][pAccount], 
		PlayerInfo[playerid][pCrimes], 
		PlayerInfo[playerid][pKills], 
		PlayerInfo[playerid][pDeaths], 
		PlayerInfo[playerid][pArrested], 
		PlayerInfo[playerid][pWantedDeaths], 
		PlayerInfo[playerid][pPhoneBook], 
		PlayerInfo[playerid][pLottoNr], 
		PlayerInfo[playerid][pFishes], 
		PlayerInfo[playerid][pBiggestFish], 
		PlayerInfo[playerid][pJob], 
		PlayerInfo[playerid][pPayCheck], 
		PlayerInfo[playerid][pHeadValue], 
		PlayerInfo[playerid][pBP], 
		PlayerInfo[playerid][pJailed], 
		PlayerInfo[playerid][pJailTime], 
		PlayerInfo[playerid][pMats], 
		PlayerInfo[playerid][pDrugs], 
		PlayerInfo[playerid][pLider], 
		PlayerInfo[playerid][pMember], 
		PlayerInfo[playerid][pOrg],
		PlayerInfo[playerid][pRank], 
		PlayerInfo[playerid][pChar], 
		PlayerInfo[playerid][pSkin], 
		PlayerInfo[playerid][pContractTime]);

        lStr = "`DetSkill`, `SexSkill`, `BoxSkill`, `LawSkill`, `MechSkill`, `JackSkill`, `CarSkill`, `NewsSkill`, `DrugsSkill`, `CookSkill`, `FishSkill`, `GunSkill`, `TruckSkill`, `pSHealth`, `pHealth`, `Int`, `Local`, `Team`, `Model`, `PhoneNr`, `Dom`, `Bizz`, `Wynajem`, `Pos_x`, `Pos_y`, `Pos_z`, `CarLic`, `FlyLic`, `BoatLic`, `FishLic`, `GunLic`";
        format(lStr, 1024, "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNick(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

        sscanf(lStr, "p<|>dddddddddddddffddddddddfffddddd",
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
		PlayerInfo[playerid][pModel],
		PlayerInfo[playerid][pPnumber],
		PlayerInfo[playerid][pDom],
		PlayerInfo[playerid][pPbiskey],
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

        format(lStr, 1024, "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNick(playerid));
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
		PlayerInfo[playerid][pBlock], 
		PlayerInfo[playerid][pFuel], 
		PlayerInfo[playerid][pMarried]);

        lStr = "`MarriedTo`, `CBRADIO`, `PoziomPoszukiwania`, `Dowod`, `PodszywanieSie`, `ZmienilNick`, `Wino`, `Piwo`, `Cygaro`, `Sprunk`, `PodgladWiadomosci`, `StylWalki`, `PAdmin`, `ZaufanyGracz`, `Auto1`, `Auto2`, `Auto3`, `Auto4`, `Lodz`, `Samolot`, `Garaz`, `KluczykiDoAuta`, `Spawn`, `BW`, `Czystka`, `CarSlots`";

        format(lStr, 1024, "SELECT %s FROM `mru_konta` WHERE `Nick`='%s'", lStr, GetNick(playerid));
    	mysql_query(lStr);
    	mysql_store_result();
        if(mysql_num_rows()) id++;
        mysql_fetch_row_format(lStr, "|");
        mysql_free_result();

        sscanf(lStr, "p<|>s[24]ddddddddddddddddddddddddd",
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
		PlayerInfo[playerid][pNewAP],
		PlayerInfo[playerid][pZG],
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
		PlayerInfo[playerid][pCzystka],
        PlayerInfo[playerid][pCarSlots]);
	}

    MruMySQL_LoadAccess(playerid);
    MruMySQL_WczytajOpis(playerid, PlayerInfo[playerid][pUID], 1);
	if(id != 4) return false;
	return true;
}

stock MruMySQL_WczytajOpis(handle, uid, typ)
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
        mysql_free_result();
    }
    return 1;
}

stock MruMySQL_UpdateOpis(handle, uid, typ)
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

stock MruMySQL_CheckOpis(uid, typ)
{
    new lStr[64];
    format(lStr, 128, "SELECT `UID` FROM `mru_opisy` WHERE `owner`='%d' AND `typ`=%d", uid, typ);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_free_result();
        return 1;
    }
    return 0;
}

MruMySQL_LoadAccess(playerid)
{
    if(!MYSQL_ON) return false;

	new query[128];
	format(query, sizeof(query), "SELECT CAST(`FLAGS` AS UNSIGNED) AS `FLAGS` FROM `mru_uprawnienia` WHERE `UID`=%d", PlayerInfo[playerid][pUID]);

	mysql_query(query);
	mysql_store_result();
    if(mysql_num_rows())
    {
        ACCESS[playerid] = mysql_fetch_int();
        OLD_ACCESS[playerid] = ACCESS[playerid];
        printf("(PERM) -> Player %d (%d) access flags is %b", playerid, PlayerInfo[playerid][pUID], ACCESS[playerid]);
    }
    mysql_free_result();
    return 1;
}

MruMySQL_DoesAccountExist(nick[])
{
	new string[128];
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

stock MruMySQL_ReturnPassword(nick[])
{
	new string[128], key[64];
	
	format(string, sizeof(string), "SELECT `Key` FROM `mru_konta` WHERE `Nick` = '%s'", nick);
	mysql_query(string);
	mysql_store_result();
	
	if(mysql_retrieve_row())
	{
		mysql_fetch_field_row(key, "Key");
	}
	
	mysql_free_result();
	
	return key;
}

StripNewLine(string[])
{
  new len = strlen(string);
  if (string[0]==0) return;
  if ((string[len - 1] == '\n') || (string[len - 1] == '\r'))
    {
      string[len - 1] = 0;
      if (string[0]==0) return ;
      if ((string[len - 2] == '\n') || (string[len - 2] == '\r')) string[len - 2] = 0;
    }
}

MruMySQL_ConvertAccount(playerid)
{
	if(!MYSQL_ON) return 0;

	new string[128], nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));

    new result = MruMySQL_DoesAccountExist(nick);
    if(result == -1)
	{
		return -1;
	}
    else if(result == -999)
    {
        return -999;
    }
    else
    {
        format(string, sizeof(string), "%s.ini", nick);
		new File: Profile = fopen(string, io_read);
		if(Profile)
		{
			new key[256], val[256], Data[256], Query[1024];
			
			format(string, sizeof(string), "INSERT INTO `mru_konta` (`Nick`) VALUES ('%s')", nick);
			mysql_query(string);
			
			format(Query, sizeof(Query), "UPDATE `mru_konta` SET");
			while(fread(Profile, Data, sizeof(Data)))
			{
				key = ini_GetKey(Data);
				val = ini_GetValue(Data);
				StripNewLine(val);
				if(strlen(key) > 1)
                {
    				if(strcmp("UID", key, true) != 0)
    				{
    					if(strcmp("Adjustable", key, true) == 0) format(Query, sizeof(Query), "%s `Block`='0',", Query);
                        else if(strfind(key, "Key", true) != -1)
                        {
                            if(strcmp("Key", key, true) != 0) strdel(key, 0, 1); //dziwny znak na pocz¹tku fread.
                            format(Query, sizeof(Query), "%s `Key`='%s',", Query, PlayerInfo[playerid][pKey]);
                        }
    					else format(Query, sizeof(Query), "%s `%s`='%s',", Query, key, val);
    				}
				}
				if(strlen(Query) >= 768)
				{
                    strdel(Query, strlen(Query)-1, strlen(Query));
					format(Query, sizeof(Query), "%s WHERE `Nick`='%s'", Query, nick);
					mysql_query(Query);
					format(Query, sizeof(Query), "UPDATE `mru_konta` SET ");
				}
			}
			fclose(Profile);
			
            strdel(Query, strlen(Query)-1, strlen(Query));
			format(Query, sizeof(Query), "%s WHERE `Nick`='%s'", Query, nick);
			mysql_query(Query);
				
			printf("[MySQL] Konto gracza %s zostalo przeniesione do MYSQL!", nick);

            format(string, sizeof(string), "%s.ini", nick);
            dini_Remove(string);
			return 1;
		}
	}
	return 1;
}

//--------------------------------------------------------------<[ Kary ]>--------------------------------------------------------------

stock MruMySQL_KonwertujBana(playerid)
{ 
	new plik[128];
	format(plik, sizeof(plik), "Bany/%s.ini", GetNick(playerid));
	
	if(dini_Exists(plik))
	{
		new powod[256], admin[MAX_PLAYER_NAME], typ;
		strcat(powod, dini_Get(powod, "Powod"));
		strcat(admin, dini_Get(admin, "Admin"));
		if(isnull(powod)) strcat(powod, "Konwersja banów");
		else format(powod, sizeof(powod), "%s (%s)", powod, admin);
		typ = dini_Int(plik, "Typ");
		if(typ == 1)
		{
			MruMySQL_Blockuj(GetNick(playerid), -1, powod);
		}
		else if(typ == 2)
		{
			MruMySQL_Banuj(playerid, powod);	
		}
		dini_Remove(plik);
	}
	else
	{
		return 0;
	}
	
	return 1;
}

MruMySQL_Blockuj(nick[], admin, powod[])
{ 
	if(!MYSQL_ON) return 0;
    new validnick[MAX_PLAYER_NAME+1];

    mysql_real_escape_string(nick, validnick);

	new query[256];
	format(query, sizeof(query), "UPDATE `mru_konta` SET `Block`=1 WHERE `Nick`='%s'", validnick);
	mysql_query(query);

    if(admin != -1)
    {
        new admnick[32];
        GetPlayerName(admin, admnick, 32);
        format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`,`powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%s', '%d', '%s', '%d')", validnick, powod, PlayerInfo[admin][pUID], admnick,WARN_BLOCK);
    }
    else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `powod`, `typ`, `nadal`) VALUES ('%s', '%s', '%d', 'SYSTEM')", validnick, powod,WARN_BLOCK);
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

    new uid=-1;
    if(strcmp(nick, "Brak", false) != 0) uid = MruMySQL_GetAccInt("UID", nick);
	
	if(admin != -1) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d', '%s', '%d')", uid, nick, ip,powod, PlayerInfo[admin][pUID], GetNick(admin),WARN_BAN);
	else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d')", uid, nick,ip, powod,WARN_BAN);
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
            mysql_free_result();
        }
    }


	if(strcmp(nick, "Brak", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `nadal_uid`, `nadal`, `typ`, `IP`) VALUES ('%s', '%d', '%s', '%d', '%s')", nick, PlayerInfo[admin][pUID], admnick,WARN_UNBAN, ip);
    else if(strcmp(ip, "nieznane", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`IP`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%d', '%s', '%d')", ip, PlayerInfo[admin][pUID], admnick,WARN_UNBAN);
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

    format(query, 128, "UPDATE `mru_konta` SET `Block`=0 WHERE `Nick`='%s'", nick);
    mysql_query(query);
    query="\0";

	if(strcmp(nick, "Brak", false) != 0) format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal`, `nadal_uid`, `nadal`, `typ`) VALUES ('%s', '%d', '%s', '%d')", nick, PlayerInfo[admin][pUID], admnick,WARN_UNBLOCK);
    if(strlen(query) < 30) return 0;
    if(!mysql_query(query)) return 0;
	return 1;
}

MruMySQL_Banuj(playerid, powod[]="Brak", admin=-1)
{ 
	if(!MYSQL_ON) return 0;
	
	new query[512];
	new uid = PlayerInfo[playerid][pUID], ip[16];

	GetPlayerIp(playerid, ip, sizeof(ip));
	
	if(admin != -1)
    {
        new admnick[32];
        GetPlayerName(admin, admnick, 32);
        format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `nadal_uid`, `nadal`, `typ`) VALUES ('%d', '%s', '%s', '%s', '%d', '%s', '%d')", uid, GetNick(playerid), ip, powod, PlayerInfo[admin][pUID], admnick,WARN_BAN);
    }
    else format(query, sizeof(query), "INSERT INTO `mru_bany` (`dostal_uid`, `dostal`, `IP`, `powod`, `typ`, `nadal`) VALUES ('%d', '%s', '%s', '%s', '%d', 'SYSTEM')", uid, GetNick(playerid), ip, powod,WARN_BAN);
	mysql_query(query);
	return 1;
}

bool:MruMySQL_SprawdzBany(playerid)
{
	if(!MYSQL_ON) return false;

	new ip[16], query[256];
	GetPlayerIp(playerid,ip,sizeof(ip));
	format(query, sizeof(query), "SELECT `typ`, `nadal_uid`, `nadal`, `powod`, `czas`, `dostal`, `dostal_uid`, `IP` FROM `mru_bany` WHERE `dostal`='%s' OR `IP` = '%s' ORDER BY `czas` DESC LIMIT 1", GetNick(playerid),ip);
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
	return false;
}

//Pobieranie i zwracanie pojedynczych zmiennych:
stock MruMySQL_GetAccString(kolumna[], nick[])
{
	new string[128], wartosc[256];
	
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
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%s' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 1;
}

stock MruMySQL_SetAccInt(kolumna[], nick[], wartosc)
{
	new string[128];
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%d' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 1;
}

stock MruMySQL_SetAccFloat(kolumna[], nick[], Float:wartosc)
{
	new string[128];
	format(string, sizeof(string), "UPDATE `mru_konta` SET `%s` = '%f' WHERE `Nick` = '%s'", kolumna, wartosc, nick);
	mysql_query(string);
	return 0;
}

public MruMySQL_Error(error[])
{
    new str[256];
    format(str, sizeof(str), "MySQL/error.log");
    new File:f, h,m,s,dd,mm,yy;
    gettime(h,m,s);
    getdate(yy,mm,dd);
    f = fopen(str, io_append);
    if(f)
    {
        format(str, 256, "[%02d/%02d/%d - %02d:%02d:%02d] %s\r\n", dd,mm,yy,h,m,s,error);
        fwrite(f, str);
        fclose(f);
    } else printf("File handle error at error.log [%s]", error);
    return 1;
}

stock IsDialogProtected(dialogid)
{
    switch(dialogid)
    {
        case D_PANEL_KAR_NADAJ..D_PANEL_KAR_ZNAJDZ_INFO, D_PERM, D_CREATE_ORG_NAME, D_CREATE_ORG_UID, D_PANEL_CHECKPLAYER, D_EDIT_RANG_NAME, D_OPIS_UPDATE, D_VEHOPIS_UPDATE: return true;
    }
    return false; //dodac dialogi z mysql
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
