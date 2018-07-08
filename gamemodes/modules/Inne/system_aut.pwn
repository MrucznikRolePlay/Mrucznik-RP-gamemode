//
new Car_SlotQueue[1024];

stock Car_AddSlotToQueue(id)
{
    if(strlen(Car_SlotQueue) < 1020)
    {
        new lStr[8];
        format(lStr, 8, "%d|", id);
        strcat(Car_SlotQueue, lStr);
    }
}

stock Car_GetFromQueue()
{
    new lID[8];
    new pos = strfind(Car_SlotQueue, "|");
    if(pos != -1)
    {
        strmid(lID, Car_SlotQueue, 0, pos);
        strdel(Car_SlotQueue, 0, pos+1);
        return strval(lID);
    }
    return -1;
}

stock ShowCarsForPlayer(playerid, forplayerid)
{
    new lStr[512], lSlots, lMaxCars = PlayerInfo[playerid][pCarSlots], lID;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
		lID = PlayerInfo[playerid][pCars][i];
        if( lID != 0)
        {
            if(CarData[lID][c_UID] == 0) continue;
            if(lSlots < lMaxCars)
            {
                format(lStr, 512, "%s{000000}%d\t{8FCB04}%s\n", lStr, lID, VehicleNames[CarData[lID][c_Model]-400]);
            }
            else
            {
                format(lStr, 512, "%s{000000}-%d\t{888888}%s\n", lStr, lID, VehicleNames[CarData[lID][c_Model]-400]);
            }
            lSlots++;
        }
    }
    if(lSlots > 0) ShowPlayerDialogEx(forplayerid, D_AUTO, DIALOG_STYLE_LIST, "Twoje pojazdy", lStr, "Wybierz", "Anuluj");
    else SendClientMessage(forplayerid, COLOR_GRAD2, "Brak jakichkolwiek pojazdów!");
}

stock Car_MakePlayerOwner(playerid, uid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0)
        {
            PlayerInfo[playerid][pCars][i] = uid;
            break;
        }
    }

    //Car_SortPlayerCars(playerid);

    if(uid >= MAX_CARS) return 0;
    CarData[uid][c_OwnerType] = CAR_OWNER_PLAYER;
    CarData[uid][c_Owner] = PlayerInfo[playerid][pUID];
    Car_Save(uid, CAR_SAVE_OWNER);
    return 1;
}

stock Car_RemovePlayerOwner(playerid, uid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == uid)
        {
            PlayerInfo[playerid][pCars][i] = 0;
            break;
        }
    }

    //Car_SortPlayerCars(playerid);
}

stock Car_Create(model, Float:x, Float:y, Float:z, Float:angle, color1, color2)
{
    new lUID, lStr[256], idx=-1;
    format(lStr, 256, "INSERT INTO `mru_cars` (`model`, `x`, `y`, `z`, `angle`, `color1`, `color2`) VALUES (%d, %.2f, %.2f, %.2f, %.1f, %d, %d)", model, x, y, z, angle, color1, color2);
    if(mysql_query(lStr))
    {
        lUID = mysql_insert_id();

        new bool:doadd=false;
        idx = Car_GetFromQueue();
        if(idx == -1) idx = gCars, doadd=true;

        CarData[idx][c_UID] = lUID;
        CarData[idx][c_ID] = CreateVehicle(model, x, y, z, angle, color1, color2, -1);
        CarData[idx][c_Owner] = 0;
        CarData[idx][c_OwnerType] = 0;
        CarData[idx][c_Model] = model;
        CarData[idx][c_Pos][0] = x;
        CarData[idx][c_Pos][1] = y;
        CarData[idx][c_Pos][2] = z;
        CarData[idx][c_Rot] = angle;
        CarData[idx][c_HP] = 1000.0;
        CarData[idx][c_Tires] = 0;
        CarData[idx][c_Color][0] = color1;
        CarData[idx][c_Color][1] = color2;
        CarData[idx][c_Nitro] = 0;
        CarData[idx][c_bHydraulika] = false;
        CarData[idx][c_Felgi] = 0;
        CarData[idx][c_Malunek] = 3;
        CarData[idx][c_Spoiler] = 0;
        CarData[idx][c_Bumper][0] = 0;
        CarData[idx][c_Bumper][1] = 0;
        CarData[idx][c_Keys] = 0;
        CarData[idx][c_Neon] = 0;
        CarData[idx][c_Rang] = 0;
        CarData[idx][c_Int] = -1;
        CarData[idx][c_VW] = -1;
		CarData[idx][c_Siren] = 0;

        SetVehicleParamsEx(CarData[idx][c_ID], 0, 0, 0, 0, 0, 0, 0);

        VehicleUID[CarData[idx][c_ID]][vUID] = idx;
        if(doadd)
        {
            gCars++;
            return gCars-1;
        }
    }
    return idx;
}

stock Car_Load()
{
    new lStr[512], lLoad=gCars, unused;
    mysql_query("SELECT * FROM `mru_cars` WHERE `ownertype` != 3 AND `ownertype` != 0");
    mysql_store_result();
    while(mysql_fetch_row_format(lStr, "|"))
    {
        sscanf(lStr, "p<|>ddddfffffddddldddddddddddds[32]",
        CarData[gCars][c_UID],
        CarData[gCars][c_OwnerType],
        CarData[gCars][c_Owner],
        CarData[gCars][c_Model],
        CarData[gCars][c_Pos][0],
        CarData[gCars][c_Pos][1],
        CarData[gCars][c_Pos][2],
        CarData[gCars][c_Rot],
        CarData[gCars][c_HP],
        CarData[gCars][c_Tires],
        CarData[gCars][c_Color][0],
        CarData[gCars][c_Color][1],
        CarData[gCars][c_Nitro],
        CarData[gCars][c_bHydraulika],
        CarData[gCars][c_Felgi],
        CarData[gCars][c_Malunek],
        CarData[gCars][c_Spoiler],
        CarData[gCars][c_Bumper][0],
        CarData[gCars][c_Bumper][1],
        CarData[gCars][c_Keys],
        CarData[gCars][c_Neon],
        CarData[gCars][c_Rang],
        CarData[gCars][c_Int],
        CarData[gCars][c_VW],
		unused,
		CarData[gCars][c_Siren],
		CarData[gCars][c_Rejestracja]);

        gCars++;
    }
    mysql_free_result();

    //SPAWN
    for(new i=lLoad;i<gCars;i++)
    {
        new vid = Car_Spawn(i, true, false);

		//Sultany PD:
		if(CarData[i][c_Siren] == 1)
		{
			if(CarData[i][c_Model] == 411)
				PDTuneInfernus(vid);
			else if(CarData[i][c_Model] == 560)
				PDTuneSultan(vid);
		}

        //Komunikacja miejska napis nad pojazdem
        if((CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_KT && (CarData[i][c_Model] == 431 || CarData[i][c_Model] == 437 || CarData[i][c_Model] == 418)) || (CarData[i][c_OwnerType] == CAR_OWNER_JOB && CarData[i][c_Owner] == JOB_BUSDRIVER))
        {
            if(gKMCounter < sizeof(Busnapisn))
            {
                KomunikacjaMiejsca[CarData[i][c_ID]] = gKMCounter;
                if(CarData[i][c_Model] == 431 || CarData[i][c_Model] == 437) Busnapisn[gKMCounter] = CreateDynamic3DTextLabel("° Komunikacja miejska °", COLOR_BLUE, 0.0,0.0,3.5, 30.0, INVALID_PLAYER_ID, CarData[i][c_ID]);
                else Busnapisn[gKMCounter] = CreateDynamic3DTextLabel("° Komunikacja miejska °", COLOR_BLUE, 0.0,0.0,1.5, 30.0, INVALID_PLAYER_ID, CarData[i][c_ID]);
                gKMCounter++;
            }
        }
        //Opis dla pojazdów z wypo¿yczalni
        if(CarData[i][c_OwnerType] == CAR_OWNER_SPECIAL && CarData[i][c_Owner] == RENT_CAR)
        {
            CarOpis[CarData[i][c_ID]] = CreateDynamic3DTextLabel("Wypo¿yczalnia pojazdów\nGROTTI", COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, CarData[i][c_ID]);
        }
        //Obiekty na dachach taxówek
        if(CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_KT)
        {
            if(CarData[i][c_Model] == 560) AttachDynamicObjectToVehicle(CreateDynamicObject(19310, 0, 0, 0, 0, 0, 0), CarData[i][c_ID], 0.000000, -0.424999, 0.919999, 0.000000, 0.000000, 0.000000); //sultan
            else if(CarData[i][c_Model] == 409) AttachDynamicObjectToVehicle(CreateDynamicObject(19310, 0, 0, 0, 0, 0, 0), CarData[i][c_ID], 0.000000, 0.349999, 0.929999, 0.000000, 0.000000, 0.000000); //lima
            else if(CarData[i][c_Model] == 487) AttachDynamicObjectToVehicle(CreateDynamicObject(19311, 0, 0, 0, 0, 0, 0), CarData[i][c_ID], 0.000000, 1.284999, 1.629998, 0.000000, -0.000001, 90.449951); //heli
        }
    }

	//ZBUGOWANE:
    /*new lText[128], lowner,ldesc[128];
    mysql_query("SELECT `owner`, `desc` FROM `mru_opisy` WHERE `typ`=2");
    mysql_store_result();
    while(mysql_fetch_row_format(lStr, "|"))
    {
        sscanf(lStr, "p<|>ds[128]", lowner, ldesc);
        for(new i=0;i<MAX_VEHICLES;i++)
        {
            if(VehicleUID[i][vUID] == 0) continue;
            if(CarData[VehicleUID[i][vUID]][c_UID] == lowner)
            {
                WordWrap(ldesc, true, lText);

                CarOpis[i] = CreateDynamic3DTextLabel(lText, COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, i);
                format(CarOpisCaller[i], MAX_PLAYER_NAME, "SYSTEM");

                strpack(CarDesc[i], ldesc);
            }
        }
    }*/
	//naprawione:
	new qText[128], lText[128], ldesc[128];
	for(new i=0;i<MAX_VEHICLES;i++)
	{
		if(VehicleUID[i][vUID] == 0) continue;
        if(CarData[VehicleUID[i][vUID]][c_UID] > 0)
		{
			
			format(qText, sizeof(qText), "SELECT `desc` FROM `mru_opisy` WHERE `typ`=2 AND `owner`=%d LIMIT 1", CarData[VehicleUID[i][vUID]][c_UID]);
			mysql_query(qText);
			mysql_store_result();
			if(mysql_num_rows())
			{
				mysql_fetch_row_format(lStr, "|");
				sscanf(lStr, "s[128]", ldesc);
				
				WordWrap(ldesc, true, lText);

				CarOpis[i] = CreateDynamic3DTextLabel(lText, COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, i);
				format(CarOpisCaller[i], MAX_PLAYER_NAME, "SYSTEM");

				strpack(CarDesc[i], ldesc);
			}
		}
	}
	
    mysql_free_result();
    printf("Wczytano %d pojazdów", gCars-1);
}

stock Car_LoadEx(lUID)
{
    new lStr[256];
    new lVehID = Car_GetFromQueue(), bool:doadd=false, unused;
    if(lVehID == -1) lVehID = gCars, doadd=true;
    format(lStr, 256, "SELECT * FROM `mru_cars` WHERE `UID`='%d'", lUID);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(lStr, "|");
        sscanf(lStr, "p<|>ddddfffffddddlddddddddddd",
        CarData[lVehID][c_UID],
        CarData[lVehID][c_OwnerType],
        CarData[lVehID][c_Owner],
        CarData[lVehID][c_Model],
        CarData[lVehID][c_Pos][0],
        CarData[lVehID][c_Pos][1],
        CarData[lVehID][c_Pos][2],
        CarData[lVehID][c_Rot],
        CarData[lVehID][c_HP],
        CarData[lVehID][c_Tires],
        CarData[lVehID][c_Color][0],
        CarData[lVehID][c_Color][1],
        CarData[lVehID][c_Nitro],
        CarData[lVehID][c_bHydraulika],
        CarData[lVehID][c_Felgi],
        CarData[lVehID][c_Malunek],
        CarData[lVehID][c_Spoiler],
        CarData[lVehID][c_Bumper][0],
        CarData[lVehID][c_Bumper][1],
        CarData[lVehID][c_Keys],
        CarData[lVehID][c_Neon],
        CarData[lVehID][c_Rang],
        CarData[lVehID][c_Int],
        CarData[lVehID][c_VW],
        unused);

        if(doadd) gCars++;

        mysql_free_result();
    }
    else return -1;
    return lVehID;
}

stock Car_LoadForPlayer(playerid)
{
    new lStr[256], lUsed = 0, lPUID = PlayerInfo[playerid][pUID], lList[64], lsID, lsSearch[8], unused;

    for(new i=0;i<MAX_VEHICLES;i++)
    {
        new lcar = VehicleUID[i][vUID];
        if(lcar == 0) continue;
        if(CarData[lcar][c_OwnerType] == CAR_OWNER_PLAYER && CarData[lcar][c_Owner] == lPUID)
        {
            format(lStr, 64, "%d|", CarData[lcar][c_UID]);
            strcat(lList, lStr);
            //Przypisanie auta, które ju¿ istenije w grze - brak potrzeby ponownego ³adowania do systemu, tylko pobranie z bazy.
            PlayerInfo[playerid][pCars][lUsed++] = lcar;
        }
    }

    new lVehID = Car_GetFromQueue();
    if(lVehID == -1) lVehID = gCars;

    format(lStr, 128, "SELECT * FROM `mru_cars` WHERE `ownertype`='%d' AND `owner`='%d'", CAR_OWNER_PLAYER, lPUID);
    mysql_query(lStr);
    mysql_store_result();
    while(mysql_fetch_row_format(lStr, "|"))
    {
        sscanf(lStr, "p<|>d", lsID);
        format(lsSearch, 8, "%d|", lsID);
        if(strfind(lList, lsSearch) == -1)
        {
            sscanf(lStr, "p<|>ddddfffffddddlddddddddddd",
            CarData[lVehID][c_UID],
            CarData[lVehID][c_OwnerType],
            CarData[lVehID][c_Owner],
            CarData[lVehID][c_Model],
            CarData[lVehID][c_Pos][0],
            CarData[lVehID][c_Pos][1],
            CarData[lVehID][c_Pos][2],
            CarData[lVehID][c_Rot],
            CarData[lVehID][c_HP],
            CarData[lVehID][c_Tires],
            CarData[lVehID][c_Color][0],
            CarData[lVehID][c_Color][1],
            CarData[lVehID][c_Nitro],
            CarData[lVehID][c_bHydraulika],
            CarData[lVehID][c_Felgi],
            CarData[lVehID][c_Malunek],
            CarData[lVehID][c_Spoiler],
            CarData[lVehID][c_Bumper][0],
            CarData[lVehID][c_Bumper][1],
            CarData[lVehID][c_Keys],
            CarData[lVehID][c_Neon],
            CarData[lVehID][c_Rang],
            CarData[lVehID][c_Int],
            CarData[lVehID][c_VW],
            unused);

            PlayerInfo[playerid][pCars][lUsed++] = lVehID;

            lVehID = Car_GetFromQueue();
            if(lVehID == -1) lVehID = ++gCars;
        }
    }
    mysql_free_result();

    new keys = PlayerInfo[playerid][pKluczeAuta];
    if(keys > 0)
    {
        //Wczytanie pojazdu z kluczyków
        new id = Car_GetIDXFromUID(keys);
        if(id == -1) Car_LoadEx(keys);
    }
}

stock Car_UnloadForPlayer(playerid)
{
    new lVehUID;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if((lVehUID = PlayerInfo[playerid][pCars][i]) == 0) continue;
        if(CarData[lVehUID][c_ID] != 0) continue;
        Car_ClearMem(lVehUID);
    }
}

stock Car_ReloadEx(lVehID)
{
    new lStr[256], unused;
    format(lStr, 64, "SELECT * FROM `mru_cars` WHERE `UID`='%d'", lVehID);
    mysql_query(lStr);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_fetch_row_format(lStr, "|");
        sscanf(lStr, "p<|>ddddfffffddddlddddddddddd",
        CarData[lVehID][c_UID],
        CarData[lVehID][c_OwnerType],
        CarData[lVehID][c_Owner],
        CarData[lVehID][c_Model],
        CarData[lVehID][c_Pos][0],
        CarData[lVehID][c_Pos][1],
        CarData[lVehID][c_Pos][2],
        CarData[lVehID][c_Rot],
        CarData[lVehID][c_HP],
        CarData[lVehID][c_Tires],
        CarData[lVehID][c_Color][0],
        CarData[lVehID][c_Color][1],
        CarData[lVehID][c_Nitro],
        CarData[lVehID][c_bHydraulika],
        CarData[lVehID][c_Felgi],
        CarData[lVehID][c_Malunek],
        CarData[lVehID][c_Spoiler],
        CarData[lVehID][c_Bumper][0],
        CarData[lVehID][c_Bumper][1],
        CarData[lVehID][c_Keys],
        CarData[lVehID][c_Neon],
        CarData[lVehID][c_Rang],
        CarData[lVehID][c_Int],
        CarData[lVehID][c_VW]);
    }
    mysql_free_result();
}

stock CountPlayerCars(playerid)
{
    new lCount;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0) continue;
        else lCount++;
    }
    return lCount;
}

stock Car_SortPlayerCars(playerid)
{
    new lArray[MAX_CAR_SLOT] = {0, ...}, lAI;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0) continue;
        else lArray[lAI++] = PlayerInfo[playerid][pCars][i];
    }

    if( lAI > 0)
    {
        new lSwap;
        new bool:bSwapped = true;
        new I;

        while(bSwapped)
        {
            bSwapped = false;
            for(I = lAI-1; I > 0; I--)
            {
                if(lArray[I] < lArray[I - 1]) {
                    lSwap = lArray[I - 1];
                    lArray[I - 1] = lArray[I];
                    lArray[I] = lSwap;
                    bSwapped = true;
                }
                if(lArray[lAI - I-1] > lArray[lAI - I]) {
                    lSwap = lArray[lAI - I];
                    lArray[lAI - I] = lArray[lAI - I-1];
                    lArray[lAI - I-1] = lSwap;
                    bSwapped = true;
                }
            }
        }

        for(new i=0;i<MAX_CAR_SLOT;i++)
        {
            PlayerInfo[playerid][pCars][i] = lArray[i];
        }
    }
    return lAI;
}

stock Car_AddTune(vehicleid)
{
    new uid = VehicleUID[vehicleid][vUID];
    if(CarData[uid][c_Nitro] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Nitro]);
    if(CarData[uid][c_bHydraulika]) AddVehicleComponent(vehicleid, 1087);
    if(CarData[uid][c_Spoiler] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Spoiler]);
    if(CarData[uid][c_Felgi] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Felgi]);
    if(CarData[uid][c_Bumper][0] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Bumper][0]);
    if(CarData[uid][c_Bumper][1] != 0) AddVehicleComponent(vehicleid, CarData[uid][c_Bumper][1]);
    ChangeVehiclePaintjob(vehicleid, CarData[uid][c_Malunek]);
    ChangeVehicleColor(vehicleid, CarData[uid][c_Color][0], CarData[uid][c_Color][1]);
}

stock IsCarOwner(playerid, vehicle, bool:kluczyki=false)
{
    new uid = VehicleUID[vehicle][vUID];
    if(uid == 0) return 0;
    if(kluczyki)
    {
        if(CarData[uid][c_UID] == PlayerInfo[playerid][pKluczeAuta]) return 1;
    }
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == uid)
        {
            return 1;
        }
    }
    return 0;
}

stock Car_IsValid(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return 1;
}

stock Car_GetOwnerType(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return CarData[VehicleUID[vehicleid][vUID]][c_OwnerType];
}

stock Car_GetOwner(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return CarData[VehicleUID[vehicleid][vUID]][c_Owner];
}

stock Car_Spawn(lUID, bool:onload=false, bool:loaddesc=true)
{
    if(GetVehicleModel(CarData[lUID][c_ID]) != 0) return 0;

    new vehicleid, expire=-1;

    if(CarData[lUID][c_OwnerType] == CAR_OWNER_JOB)
    {
        expire = 1200; //Respawn co 20 minut dla pojazdów nale¿¹cych do pracy dorywczej
        if(CarData[lUID][c_Owner] == JOB_TRUCKER)
            if(CarData[lUID][c_Model] == 530) expire = 30;
    }

    if(CarData[lUID][c_Model] == 537 || CarData[lUID][c_Model] == 538)
        vehicleid = AddStaticVehicleEx(CarData[lUID][c_Model], CarData[lUID][c_Pos][0],CarData[lUID][c_Pos][1],CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_Color][0], CarData[lUID][c_Color][1], expire, CarData[lUID][c_Siren]);
    else
       vehicleid = CreateVehicle(CarData[lUID][c_Model], CarData[lUID][c_Pos][0],CarData[lUID][c_Pos][1],CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_Color][0], CarData[lUID][c_Color][1], expire, CarData[lUID][c_Siren]);
    VehicleUID[vehicleid][vUID] = lUID;

    new rejestracja[32];
    if(isnull(CarData[lUID][c_Rejestracja]))
		format(rejestracja, sizeof(rejestracja), "LS%06d", CarData[lUID][c_UID]);
	else
		format(rejestracja, sizeof(rejestracja), "%s", CarData[lUID][c_Rejestracja]);

    SetVehicleNumberPlate(vehicleid, rejestracja);
	SetVehicleToRespawn(vehicleid);
	//
    Car_AddTune(vehicleid);
    CarData[lUID][c_ID] = vehicleid;

	if(!onload) printf("Pojazd nr %d zespawnowany!", vehicleid);

	SetVehicleHealth(vehicleid, CarData[lUID][c_HP]);

    UpdateVehicleDamageStatus(vehicleid, 0, 0, 0, CarData[lUID][c_Tires]);


    if(CarData[lUID][c_Int] == -1) CarData[lUID][c_Int] = 0;
    LinkVehicleToInterior(vehicleid, CarData[lUID][c_Int]);
    if(CarData[lUID][c_VW] == -1) CarData[lUID][c_VW] = 0;
    SetVehicleVirtualWorld(vehicleid, CarData[lUID][c_VW]);

    SetVehicleParamsEx(vehicleid, 0, 0, 0, 0, 0, 0, 0);

    if(loaddesc) MruMySQL_WczytajOpis(vehicleid, CarData[lUID][c_UID], 2);
    return vehicleid;
}

/*
    Czyszczenie pojazdu z pamiêci - OverLoad Protect
    Podczas unspawnowania pojazdu, sprawdzane jest, czy na serwerze obecnie jest
    w³asciciel pojazdu. Je¿eli jest, czyszczenie zostaje pominiête.
    W przeciwnym wypadku, pojazd ulega usuniêciu z pamiêci, do kolejki zostaje
    dodany wolny index.
*/

stock Car_ClearMem(lVehID)
{
    if(CarData[lVehID][c_ID] != 0) VehicleUID[CarData[lVehID][c_ID]][vUID] = 0;
    CarData[lVehID][c_UID]= 0;
    CarData[lVehID][c_ID]= 0;
    CarData[lVehID][c_OwnerType]= 0;
    CarData[lVehID][c_Owner]= 0;
    CarData[lVehID][c_Model]= 0;
    CarData[lVehID][c_Keys]= 0;
    //Uznajemy index za ponowny do u¿ycia.
    Car_AddSlotToQueue(lVehID);
}

stock Car_GetIDXFromUID(lUID)
{
    for(new i=0;i<MAX_CARS;i++)
    {
        if(CarData[i][c_UID] == lUID) return i;
    }
    return -1;
}

stock Car_IsMemSet(lUID)
{
    if(Car_GetIDXFromUID(lUID) != -1) return true;
    return false;
}

stock Car_Unspawn(v, bool:playercall=false)
{
    if(GetVehicleModel(v) == 0) return 0;
    GetVehicleHealth(v, CarData[VehicleUID[v][vUID]][c_HP]);
    new panels, doors, lights;
    GetVehicleDamageStatus(v, panels, doors, lights, CarData[VehicleUID[v][vUID]][c_Tires]);

    Car_Save(VehicleUID[v][vUID], CAR_SAVE_STATE);
    Car_Save(VehicleUID[v][vUID], CAR_SAVE_TUNE);

	if(VehicleUID[v][vNeon])
   	{
		DestroyDynamicObject(VehicleUID[v][vNeonObject][0]);
   		DestroyDynamicObject(VehicleUID[v][vNeonObject][1]);
		VehicleUID[v][vNeon] = false;
	}
	if(VehicleUID[v][vSiren] != 0)
    {
    	DestroyDynamicObject(VehicleUID[v][vSiren]);
	    VehicleUID[v][vSiren] = 0;
	}
    CarOpis_Usun(INVALID_PLAYER_ID, v);

    DestroyVehicle(v);

    //OverLoad Protect:
    if(CarData[VehicleUID[v][vUID]][c_OwnerType] == CAR_OWNER_PLAYER && !playercall)
    {
        new lOwner = CarData[VehicleUID[v][vUID]][c_Owner], bool:lExist=false;
        new keys = CarData[VehicleUID[v][vUID]][c_Keys];
        foreach(Player, i)
        {
            if(PlayerInfo[i][pUID] == 0) continue;
            if(PlayerInfo[i][pUID] == lOwner || PlayerInfo[i][pUID] == keys)
            {
                lExist=true;
                break;
            }
        }
        if(!lExist)
        {
            Car_ClearMem(VehicleUID[v][vUID]);
        }
    }
    CarData[VehicleUID[v][vUID]][c_ID] = 0;
    VehicleUID[v][vUID] = 0;
    return 1;
}

stock Car_Destroy(lV)
{
    if(CarData[lV][c_ID] != 0) Car_Unspawn(CarData[lV][c_ID], true);
    new lStr[64];
    format(lStr, 64, "DELETE FROM `mru_cars` WHERE `UID`='%d'", CarData[lV][c_UID]);
    mysql_query(lStr);

    Car_ClearMem(lV);
}

stock Car_Save(lUID, lType)
{
    new lStr[256];
    switch(lType)
    {
        case CAR_SAVE_OWNER:
        {
            format(lStr, 256, "UPDATE `mru_cars` SET `owner`='%d', `ownertype`='%d', `keys`='%d', `ranga`='%d' WHERE `UID`='%d'", CarData[lUID][c_Owner], CarData[lUID][c_OwnerType], CarData[lUID][c_Keys], CarData[lUID][c_Rang], CarData[lUID][c_UID]);
            mysql_query(lStr);
        }
        case CAR_SAVE_STATE:
        {
            format(lStr, 256, "UPDATE `mru_cars` SET `model`='%d', `x`='%f', `y`='%f', `z`='%f', `angle`='%.1f', `hp`='%.1f', `tires`='%d', `int`='%d', `vw`='%d' WHERE `UID`='%d'", CarData[lUID][c_Model], CarData[lUID][c_Pos][0], CarData[lUID][c_Pos][1], CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_HP], CarData[lUID][c_Tires], CarData[lUID][c_Int], CarData[lUID][c_VW], CarData[lUID][c_UID]);
            mysql_query(lStr);
        }
        case CAR_SAVE_TUNE:
        {
            format(lStr, 256, "UPDATE `mru_cars` SET `color1`='%d', `color2`='%d', `nitro`='%d', `hydraulika`='%d', `felgi`='%d', `malunek`='%d', `spoiler`='%d', `bumper1`='%d', `bumper2`='%d', `neon`='%d' WHERE `UID`='%d'", CarData[lUID][c_Color][0],CarData[lUID][c_Color][1],CarData[lUID][c_Nitro],CarData[lUID][c_bHydraulika],CarData[lUID][c_Felgi],CarData[lUID][c_Malunek],CarData[lUID][c_Spoiler], CarData[lUID][c_Bumper][0], CarData[lUID][c_Bumper][1], CarData[lUID][c_Neon], CarData[lUID][c_UID]);
            mysql_query(lStr);
        }
        default:
        {
            Car_Save(lUID, CAR_SAVE_OWNER);
            Car_Save(lUID, CAR_SAVE_STATE);
            Car_Save(lUID, CAR_SAVE_TUNE);
        }
    }
}

//standart
IsABoatModel(carid)
{
	if(carid == 472 || carid == 473 || carid == 493 || carid == 595 || carid == 484 || carid == 430 || carid == 453 || carid == 452 || carid == 446 || carid == 454)//³odzie
	{
		return 1;
	}
	return 0;
}

IsAPlaneModel(carid)
{
	if(carid == 592 || carid == 577 || carid == 511 || carid == 512 || carid == 593 || carid == 520 || carid == 553 || carid == 476 || carid == 519 || carid == 460 || carid == 513)//samoloty
	{
		return 1;
	}
	return 0;
}

IsAHeliModel(carid)
{
    if(carid == 548 || carid == 425 || carid == 417 || carid == 487 || carid == 488 || carid == 497 || carid == 563 || carid == 447 || carid == 469)//helikoptery
	{
		return 1;
	}
    return 0;
}

stock Car_PrintOwner(car)
{
    new lStr[64];
    new type = CarData[car][c_OwnerType];
    switch(type)
    {
        case INVALID_CAR_OWNER: lStr="Brak";
        case CAR_OWNER_FRACTION:
        {
            format(lStr, 64, "%s", FractionNames[CarData[car][c_Owner]]);
        }
        case CAR_OWNER_FAMILY:
        {
            format(lStr, 64, "%s", OrgInfo[orgID(CarData[car][c_Owner])][o_Name]);
        }
        case CAR_OWNER_PLAYER:
        {
            format(lStr, 64, "SELECT `Nick` FROM mru_konta WHERE `UID`='%d'", CarData[car][c_Owner]);
            mysql_query(lStr);
            mysql_store_result();
            if(mysql_num_rows())
            {
                mysql_fetch_row_format(lStr, "|");
                mysql_free_result();
            }
        }
        case CAR_OWNER_JOB:
        {
            format(lStr, 64, "%s", JobNames[CarData[car][c_Owner]]);
        }
        case CAR_OWNER_SPECIAL:
        {
            switch(CarData[car][c_Owner])
            {
                case 1: lStr="Wypo¿yczalnia";
                case 2: lStr="GoKart";
                case 3: lStr="¯u¿el";
                default: lStr="Brak";
            }
        }
        case CAR_OWNER_PUBLIC:
        {
            lStr = "Brak";
        }
        default: lStr="Brak";
    }
    return lStr;
}

stock ShowCarEditDialog(playerid)
{
    new lStr[512], car = GetPVarInt(playerid, "edit-car"), Float:lHP;
    if(CarData[car][c_ID] == 0) lHP = CarData[car][c_HP];
    else GetVehicleHealth(CarData[car][c_ID], lHP);
    new color1 = VehicleColoursTableRGBA[clamp(CarData[car][c_Color][0], 0, 255)], color2=VehicleColoursTableRGBA[clamp(CarData[car][c_Color][1], 0, 255)];
    format(lStr, 512, "{FFFFFF}Model:\t\t{8FCB04}%d{FFFFFF}\t[ {8FCB04}%s {FFFFFF}]\nW³aœciciel:\t{8FCB04}%s{FFFFFF} » {8FCB04}%s{FFFFFF} (UID: {8FCB04}%d{FFFFFF})\nRanga:\t\t{8FCB04}%d{FFFFFF}\nStan:\t\t{8FCB04}%.1f{FFFFFF}\%\nZaparkuj tutaj\nUsuñ kluczyki\n{%06x}Kolor I\n{%06x}Kolor II", CarData[car][c_Model], VehicleNames[CarData[car][c_Model]-400], CarOwnerNames[CarData[car][c_OwnerType]], Car_PrintOwner(car), CarData[car][c_Owner], CarData[car][c_Rang], lHP/10, RGBAtoRGB(color1), RGBAtoRGB(color2));
    ShowPlayerDialogEx(playerid, D_EDIT_CAR_MENU, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}pojazdów", lStr, "Wybierz", "Wróæ");
    return 1;
}

stock CONVERT_PlayerCar(playerid)
{
    new owner[32], str[512], nick[32], dopojazdu1[64], carlist[8], model, Float:x, Float:y, Float:z, Float:angle, color1, color2, bumper1, bumper2, neon, nitro, hydraulika, felgi, spoiler, malunek, lUsed=0;
    GetPlayerName(playerid, nick, 32);

    if(PlayerInfo[playerid][pAuto1] != 0) carlist[1] = PlayerInfo[playerid][pAuto1];
    if(PlayerInfo[playerid][pAuto2] != 0) carlist[2] = PlayerInfo[playerid][pAuto2];
    if(PlayerInfo[playerid][pAuto3] != 0) carlist[3] = PlayerInfo[playerid][pAuto3];
    if(PlayerInfo[playerid][pAuto4] != 0) carlist[4] = PlayerInfo[playerid][pAuto4];
    if(PlayerInfo[playerid][pLodz] != 0) carlist[5] = PlayerInfo[playerid][pLodz];
    if(PlayerInfo[playerid][pSamolot] != 0) carlist[6] = PlayerInfo[playerid][pSamolot];
    if(PlayerInfo[playerid][pGaraz] != 0) carlist[7] = PlayerInfo[playerid][pGaraz];

    for(new i=1;i<8;i++)
    {
        if(carlist[i] != 0)
        {
            format(dopojazdu1, sizeof(dopojazdu1), "System_Aut/Pojazd%d.ini", carlist[i]);
            if(!dini_Exists(dopojazdu1))
            {
                format(str, 128, "CAR.CONVERTER: B³¹d! Brak pliku pojazdu o ID %d slot: %d.", carlist[i], i);
                SendClientMessage(playerid, COLOR_YELLOW, str);
                format(str, 128, "[CAR.CONVERTER]: File not found [%d]. Caller %s", carlist[i], nick);
                EventLog(str);
                continue;
            }
            strcat(owner, dini_Get(dopojazdu1, "Posiadacz"), 32);
            if(strcmp(owner, nick) != 0)
            {
                format(str, 128, "SELECT `owner` FROM mru_cars WHERE `oldid`='%d'", carlist[i]);
                mysql_query(str);
                mysql_store_result();
                if(mysql_num_rows())
                {
                    mysql_fetch_row_format(str, "|");
                    mysql_free_result();
                    new ownuid = strval(str);

                    format(str, 128, "CAR.CONVERTER: Wygl¹da na to, ¿e nie jestes wlascicielem pojazdu %d, slot %d.", carlist[i], i);
                    SendClientMessage(playerid, COLOR_YELLOW, str);
                    format(str, 128, "CAR.CONVERTER: Pojazd ten przypisany ju¿ zosta³ do gracza o UID: %d", ownuid);
                    SendClientMessage(playerid, COLOR_YELLOW, str);

                    format(str, 128, "[CAR.CONVERTER]: Owner mismatch for CarID [%d] is [%d]. Caller %s", carlist[i], ownuid, nick);
                    EventLog(str);
                    continue;
                }
            }
            model = dini_Int(dopojazdu1, "Model");
            if(model < 400 || model > 611)
            {
                format(str, 128, "CAR.CONVERTER: Pojazd %d nie posiada modelu.", carlist[i]);
                SendClientMessage(playerid, COLOR_YELLOW, str);

                format(str, 128, "[CAR.CONVERTER]: Invalid model. CarID [%d] is [%d]. Caller %s", carlist[i], model, nick);
                EventLog(str);
                continue;
            }
            x = dini_Float(dopojazdu1, "Pozycja_X");
            y = dini_Float(dopojazdu1, "Pozycja_Y");
            z = dini_Float(dopojazdu1, "Pozycja_Z");
            angle = dini_Float(dopojazdu1, "Rotacja");
            color1 = dini_Int(dopojazdu1, "Kolor_1");
            color2 = dini_Int(dopojazdu1, "Kolor_2");
            bumper1 = dini_Int(dopojazdu1, "Zderzak_1");
            bumper2 = dini_Int(dopojazdu1, "Zderzak_2");
            neon = dini_Int(dopojazdu1, "Neon");
            nitro = dini_Int(dopojazdu1, "Nitro");
            hydraulika = dini_Int(dopojazdu1, "Hydraulika");
            felgi = dini_Int(dopojazdu1, "Felgi");
            spoiler = dini_Int(dopojazdu1, "Spojler");
            malunek = dini_Int(dopojazdu1, "Malunek");
            format(str, 512, "INSERT INTO `mru_cars` (`ownertype`, `owner`, `model`, `x`, `y`, `z`, `angle`, `color1`, `color2`, `nitro`, `hydraulika`, `felgi`, `malunek`, `spoiler`, `bumper1`, `bumper2`, `neon`, `oldid`) VALUES (%d, %d, %d, %.2f, %.2f, %.2f, %.1f, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)", CAR_OWNER_PLAYER, PlayerInfo[playerid][pUID], model, x, y, z, angle, color1, color2, nitro, hydraulika, felgi, malunek, spoiler, bumper1, bumper2, neon, carlist[i]);
            if(!mysql_query(str))
            {
                format(str, 128, "CAR.CONVERTER: Pojazd %d nie móg³ zostaæ stworzony w bazie.", carlist[i]);
                SendClientMessage(playerid, COLOR_YELLOW, str);

                format(str, 128, "[CAR.CONVERTER]: Can't query CarID [%d]. Caller %s", carlist[i], nick);
                EventLog(str);
                continue;
            }
            new lUID = mysql_insert_id();

            new bool:doadd=false;
            new idx = Car_GetFromQueue();
            if(idx == -1) idx = gCars, doadd=true;

            CarData[idx][c_UID] = lUID;
            CarData[idx][c_ID] = 0;
            CarData[idx][c_Owner] = PlayerInfo[playerid][pUID];
            CarData[idx][c_OwnerType] = CAR_OWNER_PLAYER;
            CarData[idx][c_Model] = model;
            CarData[idx][c_Pos][0] = x;
            CarData[idx][c_Pos][1] = y;
            CarData[idx][c_Pos][2] = z;
            CarData[idx][c_Rot] = angle;
            CarData[idx][c_HP] = 1000.0;
            CarData[idx][c_Tires] = 0;
            CarData[idx][c_Color][0] = color1;
            CarData[idx][c_Color][1] = color2;
            CarData[idx][c_Nitro] = nitro;
            CarData[idx][c_bHydraulika] = hydraulika == 0 ? false : true;
            CarData[idx][c_Felgi] = felgi;
            CarData[idx][c_Malunek] = malunek;
            CarData[idx][c_Spoiler] = spoiler;
            CarData[idx][c_Bumper][0] = bumper1;
            CarData[idx][c_Bumper][1] = bumper2;
            CarData[idx][c_Keys] = 0;
            CarData[idx][c_Neon] = neon;
            CarData[idx][c_Rang] = 0;
            CarData[idx][c_Int] = -1;
            CarData[idx][c_VW] = -1;

            if(doadd)
            {
                gCars++;
            }

            PlayerInfo[playerid][pCars][lUsed++] = idx;
            dini_Remove(dopojazdu1);
        }
    }
    PlayerInfo[playerid][pAuto1] = 0;
    PlayerInfo[playerid][pAuto2] = 0;
    PlayerInfo[playerid][pAuto3] = 0;
    PlayerInfo[playerid][pAuto4] = 0;
    PlayerInfo[playerid][pLodz] = 0;
    PlayerInfo[playerid][pSamolot] = 0;
    PlayerInfo[playerid][pGaraz] = 0;
    return 1;
}

//END
