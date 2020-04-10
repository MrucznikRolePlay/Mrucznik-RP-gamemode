//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  pojazdy                                                  //
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
// Data utworzenia: 04.05.2019
//Opis:
/*
	System pojazdów.
*/

//

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if(newstate == PLAYER_STATE_DRIVER)
    {
        new newcar = GetPlayerVehicleID(playerid);
        if(PlayerInfo[playerid][pCarLic] == 0 && !IsARower(newcar))
		{
			CruiseControl_Static_TurnOn(playerid, 0);
		}
		if(IsARower(newcar))
		{
  			CruiseControl_Static_TurnOn(playerid, 1);
		}
    }
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if(GetPVarInt(playerid, "timer_StaticCruiseControl")) CruiseControl_Static_TurnOff(playerid);
    if(GetPVarInt(playerid, "timer_CruiseControl")) CruiseControl_TurnOff(playerid);
    pCruiseCanChange[playerid] = 1;
}

hook OnPlayerDisconnect(playerid)
{
    CruiseControl_Static_TurnOff(playerid);
    CruiseControl_TurnOff(playerid);
    pCruiseCanChange[playerid] = 1;
}

hook OnPlayerConnect(playerid)
{
    if(GetPVarInt(playerid, "timer_StaticCruiseControl")) CruiseControl_Static_TurnOff(playerid);
    if(GetPVarInt(playerid, "timer_CruiseControl")) CruiseControl_TurnOff(playerid);
    pCruiseSpeed[playerid] = DEFAULT_CRUISESPEED;
    pCruiseCanChange[playerid] = 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerVehicleSeat(playerid) == 0)
	{
        if(PRESSED(KEY_LOOK_BEHIND) && !GetPVarInt(playerid, "timer_StaticCruiseControl")  && PlayerInfo[playerid][pCruiseController] == 1)
        {
            new carid;
            carid = GetPlayerVehicleID(playerid);
            if(!IsARower(carid) && !IsABoat(carid) && !IsAPlane(carid))
            {
                if(GetPVarInt(playerid, "timer_CruiseControl"))
                {
                    CruiseControl_TurnOff(playerid);
                }
                else
                {
                    CruiseControl_TurnOn(playerid);
                }
            }
        }
	}
}
//-----------------<[ Funkcje: ]>------------------

CruiseControl_HideTXD(playerid)
{
    PlayerTextDrawHide(playerid, CRUISECONTROL_AMOUNT[playerid]);
}

CruiseControl_SetSpeed(playerid, speed, bool:positive)
{
    if(pCruiseCanChange[playerid] == 1)
    {
        if(pCruiseSpeed[playerid] < 140 && positive)
        {
            pCruiseSpeed[playerid] += speed;
            pCruiseCanChange[playerid] = 0;
            SetTimerEx("CruiseControl_ChangedKeyBool", 400, false, "i", playerid);
        }
        else if(pCruiseSpeed[playerid] > 30 && !positive)
        {
            pCruiseSpeed[playerid] -= speed;
            pCruiseCanChange[playerid] = 0;
            SetTimerEx("CruiseControl_ChangedKeyBool", 400, false, "i", playerid);
        } 
        CruiseControl_UpdateTXD(playerid);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
    }
}

CruiseControl_UpdateTXD(playerid)
{
    new updatedMaxSpeed = pCruiseSpeed[playerid];
    new string[128];
    format(string, sizeof(string), "~r~MAX: ~w~%dKM", updatedMaxSpeed);
    PlayerTextDrawSetString(playerid, CRUISECONTROL_AMOUNT[playerid], string);
    PlayerTextDrawShow(playerid, CRUISECONTROL_AMOUNT[playerid]);
}

CruiseControl_ShowTXD(playerid)
{   
    PlayerTextDrawSetString(playerid, CRUISECONTROL_AMOUNT[playerid], "_");
    PlayerTextDrawShow(playerid, CRUISECONTROL_AMOUNT[playerid]);
    CruiseControl_UpdateTXD(playerid);
}

CruiseControl_Static_TurnOff(playerid)
{
    CruiseControl_HideTXD(playerid);
    KillTimer(GetPVarInt(playerid, "timer_StaticCruiseControl"));
    DeletePVar(playerid, "timer_StaticCruiseControl");
    pCruiseCanChange[playerid] = 1;
}


CruiseControl_TurnOff(playerid)
{
    CruiseControl_HideTXD(playerid);
    KillTimer(GetPVarInt(playerid, "timer_CruiseControl"));
    pCruiseSpeed[playerid] = DEFAULT_CRUISESPEED;
    pCruiseTXD[playerid] = 0;
    DeletePVar(playerid, "timer_CruiseControl");
    pCruiseCanChange[playerid] = 1;
}

CruiseControl_TurnOn(playerid)
{
    CruiseControl_ShowTXD(playerid);
    new timer = SetTimerEx("CruiseControl", 200, true, "i", playerid);
    SetPVarInt(playerid, "timer_CruiseControl", timer);
}
Car_AddSlotToQueue(id)
{
    if(strlen(Car_SlotQueue) < 1020)
    {
        new string[8];
        format(string, 8, "%d|", id);
        strcat(Car_SlotQueue, string);
    }
}

Car_GetFromQueue()
{
    new id[8];
    new pos = strfind(Car_SlotQueue, "|");
    if(pos != -1)
    {
        strmid(id, Car_SlotQueue, 0, pos);
        strdel(Car_SlotQueue, 0, pos+1);
        return strval(id);
    }
    return -1;
}

ShowCarsForPlayer(playerid, forplayerid)
{
    new string[512], lSlots, lMaxCars = PlayerInfo[playerid][pCarSlots], id;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
		id = PlayerInfo[playerid][pCars][i];
        if( id != 0)
        {
            if(CarData[id][c_UID] == 0) continue;
            if(lSlots < lMaxCars)
            {
                format(string, sizeof(string), "%s{000000}%d\t{8FCB04}%s\n", string, id, VehicleNames[CarData[id][c_Model]-400]);
            }
            else
            {
                format(string, sizeof(string), "%s{000000}-%d\t{888888}%s\n", string, id, VehicleNames[CarData[id][c_Model]-400]);
            }
            lSlots++;
        }
    }
    if(lSlots > 0) ShowPlayerDialogEx(forplayerid, D_AUTO, DIALOG_STYLE_LIST, "Twoje pojazdy", string, "Wybierz", "Anuluj");
    else SendClientMessage(forplayerid, COLOR_GRAD2, "Brak jakichkolwiek pojazdów!");
}

Car_MakePlayerOwner(playerid, uid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0)
        {
            PlayerInfo[playerid][pCars][i] = uid;
            break;
        }
    }

    if(uid >= MAX_CARS) return 0;
    CarData[uid][c_OwnerType] = CAR_OWNER_PLAYER;
    CarData[uid][c_Owner] = PlayerInfo[playerid][pUID];
    CarData[uid][c_Keys] = 0;
    Car_Save(uid, CAR_SAVE_OWNER);
    return 1;
}

Car_RemovePlayerOwner(playerid, uid)
{
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == uid)
        {
            PlayerInfo[playerid][pCars][i] = 0;
            break;
        }
    }
}

Car_Create(model, Float:x, Float:y, Float:z, Float:angle, color1, color2)
{
    new uid, string[256], idx=-1;
    format(string, 256, "INSERT INTO `mru_cars` (`model`, `x`, `y`, `z`, `angle`, `color1`, `color2`) \
        VALUES (%d, %.2f, %.2f, %.2f, %.1f, %d, %d)", 
        model, x, y, z, angle, color1, color2
    );
    new Cache:result = mysql_query(mruMySQL_Connection, string, true);
    if(cache_is_valid(result) && cache_insert_id() != -1)
    {
        uid = cache_insert_id();

        new bool:doadd=false;
        idx = Car_GetFromQueue();
        if(idx == -1) idx = gCars, doadd=true;

        CarData[idx][c_UID] = uid;
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
        strcat(CarData[idx][c_Rejestracja], "0"); 

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

Car_Load()
{
    new lLoad=gCars;
    new Cache:result = mysql_query(mruMySQL_Connection, "SELECT * FROM `mru_cars` WHERE `ownertype` != 3 AND `ownertype` != 0", true);
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
        {
            cache_get_value_index_int(i, 0, CarData[gCars][c_UID]);
            cache_get_value_index_int(i, 1, CarData[gCars][c_OwnerType]);
            cache_get_value_index_int(i, 2, CarData[gCars][c_Owner]);
            cache_get_value_index_int(i, 3, CarData[gCars][c_Model]);
            cache_get_value_index_float(i, 4, CarData[gCars][c_Pos][0]);
            cache_get_value_index_float(i, 5, CarData[gCars][c_Pos][1]);
            cache_get_value_index_float(i, 6, CarData[gCars][c_Pos][2]);
            cache_get_value_index_float(i, 7, CarData[gCars][c_Rot]);
            cache_get_value_index_float(i, 8, CarData[gCars][c_HP]);
            cache_get_value_index_int(i, 9, CarData[gCars][c_Tires]);
            cache_get_value_index_int(i, 10, CarData[gCars][c_Color][0]);
            cache_get_value_index_int(i, 11, CarData[gCars][c_Color][1]);
            cache_get_value_index_int(i, 12, CarData[gCars][c_Nitro]);
            cache_get_value_index_int(i, 13, CarData[gCars][c_bHydraulika]);
            cache_get_value_index_int(i, 14, CarData[gCars][c_Felgi]);
            cache_get_value_index_int(i, 15, CarData[gCars][c_Malunek]);
            cache_get_value_index_int(i, 16, CarData[gCars][c_Spoiler]);
            cache_get_value_index_int(i, 17, CarData[gCars][c_Bumper][0]);
            cache_get_value_index_int(i, 18, CarData[gCars][c_Bumper][1]);
            cache_get_value_index_int(i, 19, CarData[gCars][c_Keys]);
            cache_get_value_index_int(i, 20, CarData[gCars][c_Neon]);
            cache_get_value_index_int(i, 21, CarData[gCars][c_Rang]);
            cache_get_value_index_int(i, 22, CarData[gCars][c_Int]);
            cache_get_value_index_int(i, 23, CarData[gCars][c_VW]);
            //24 unused
            cache_get_value_index_int(i, 25, CarData[gCars][c_Siren]);
            cache_get_value_index(i, 26, CarData[gCars][c_Rejestracja]);

            gCars++;
        }
        cache_delete(result);
    }

    //SPAWN
    for(new i=lLoad;i<gCars;i++)
    {
        new vid = Car_Spawn(i, false);

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
        //Obiekty na dachach pojazdów DMV
        if(CarData[i][c_OwnerType] == CAR_OWNER_FRACTION && CarData[i][c_Owner] == FRAC_GOV)
        {
            new elkaDMV;
            if(CarData[i][c_Model] == 496)
            {
                elkaDMV = CreateDynamicObject(2363,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "L", 90, "Ariel", 24, 1, -1, 255, 0);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], 0.170, -0.230, 0.550, 0.000, 0.000, 0.000);
                elkaDMV = CreateDynamicObject(19326,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "Urz¹d Miasta\nLos Santos", 90, "Ariel", 32, 1, -1, 0, 1);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], -0.020, 1.670, 0.270, 83.800, 0.000, 0.000);
                elkaDMV = CreateDynamicObject(19326,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "L", 90, "Ariel", 92, 1, -1, 0, 1);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], 0.000, -0.265, 1.147, 17.899, 0.000, 0.000);
                elkaDMV = CreateDynamicObject(19326,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
                SetDynamicObjectMaterialText(elkaDMV, 0, "L", 90, "Ariel", 92, 1, -1, 0, 1);
                AttachDynamicObjectToVehicle(elkaDMV, CarData[i][c_ID], 0.000, -0.535, 1.186, -16.400, 0.000, 0.000);
            }
        }
    }

	//naprawione:
	new qText[128], lText[128], ldesc[128];
	for(new i=0;i<MAX_VEHICLES;i++)
	{
		if(VehicleUID[i][vUID] == 0) continue;
        if(CarData[VehicleUID[i][vUID]][c_UID] > 0)
		{
			
			format(qText, sizeof(qText), "SELECT `desc` FROM `mru_opisy` WHERE `typ`=2 AND `owner`=%d LIMIT 1", CarData[VehicleUID[i][vUID]][c_UID]);
			result = mysql_query(mruMySQL_Connection, qText, true);
            if(cache_is_valid(result))
            {
                if(cache_num_rows())
                {
                    cache_get_value_index(0, 0, ldesc);
                }
                cache_delete(result);
            }
            WordWrap(ldesc, true, lText);

            CarOpis[i] = CreateDynamic3DTextLabel(lText, COLOR_PURPLE, 0.0, 0.0, -0.2, 5.0, INVALID_PLAYER_ID, i);
            format(CarOpisCaller[i], MAX_PLAYER_NAME, "SYSTEM");

            strpack(CarDesc[i], ldesc);
		}
	}
	
    printf("Wczytano %d pojazdów", gCars-1);
}

Car_LoadEx(lUID)
{
    new string[256];
    new lVehID = Car_GetFromQueue(), bool:doadd=false;
    if(lVehID == -1) lVehID = gCars, doadd=true;
    format(string, 256, "SELECT * FROM `mru_cars` WHERE `UID`='%d'", lUID);
    new Cache:result = mysql_query(mruMySQL_Connection, string, true);
    if(cache_is_valid(result))
    {
        if(cache_num_rows())
        {
            cache_get_value_index_int(0, 0, CarData[gCars][c_UID]);
            cache_get_value_index_int(0, 1, CarData[gCars][c_OwnerType]);
            cache_get_value_index_int(0, 2, CarData[gCars][c_Owner]);
            cache_get_value_index_int(0, 3, CarData[gCars][c_Model]);
            cache_get_value_index_float(0, 4, CarData[gCars][c_Pos][0]);
            cache_get_value_index_float(0, 5, CarData[gCars][c_Pos][1]);
            cache_get_value_index_float(0, 6, CarData[gCars][c_Pos][2]);
            cache_get_value_index_float(0, 7, CarData[gCars][c_Rot]);
            cache_get_value_index_float(0, 8, CarData[gCars][c_HP]);
            cache_get_value_index_int(0, 9, CarData[gCars][c_Tires]);
            cache_get_value_index_int(0, 10, CarData[gCars][c_Color][0]);
            cache_get_value_index_int(0, 11, CarData[gCars][c_Color][1]);
            cache_get_value_index_int(0, 12, CarData[gCars][c_Nitro]);
            cache_get_value_index_int(0, 13, CarData[gCars][c_bHydraulika]);
            cache_get_value_index_int(0, 14, CarData[gCars][c_Felgi]);
            cache_get_value_index_int(0, 15, CarData[gCars][c_Malunek]);
            cache_get_value_index_int(0, 16, CarData[gCars][c_Spoiler]);
            cache_get_value_index_int(0, 17, CarData[gCars][c_Bumper][0]);
            cache_get_value_index_int(0, 18, CarData[gCars][c_Bumper][1]);
            cache_get_value_index_int(0, 19, CarData[gCars][c_Keys]);
            cache_get_value_index_int(0, 20, CarData[gCars][c_Neon]);
            cache_get_value_index_int(0, 21, CarData[gCars][c_Rang]);
            cache_get_value_index_int(0, 22, CarData[gCars][c_Int]);
            cache_get_value_index_int(0, 23, CarData[gCars][c_VW]);
            //24 unused
            cache_get_value_index_int(0, 25, CarData[gCars][c_Siren]);
            cache_get_value_index(0, 26, CarData[gCars][c_Rejestracja]);

            if(doadd) gCars++;
        }
        else
        {
            lVehID = -1;
        }
        cache_delete(result);
    }
    return lVehID;
}

Car_LoadForPlayer(playerid)
{
    new string[256], lUsed = 0, lPUID = PlayerInfo[playerid][pUID], lList[64], lsID, lsSearch[8];

    for(new i=0;i<MAX_VEHICLES;i++)
    {
        new lcar = VehicleUID[i][vUID];
        if(lcar == 0) continue;
        if(CarData[lcar][c_OwnerType] == CAR_OWNER_PLAYER && CarData[lcar][c_Owner] == lPUID)
        {
            format(string, 64, "%d|", CarData[lcar][c_UID]);
            strcat(lList, string);
            //Przypisanie auta, które ju¿ istenije w grze - brak potrzeby ponownego ³adowania do systemu, tylko pobranie z bazy.
            PlayerInfo[playerid][pCars][lUsed++] = lcar;
        }
    }

    new lVehID = Car_GetFromQueue();
    if(lVehID == -1) lVehID = gCars;

    format(string, sizeof(string), "SELECT * FROM `mru_cars` WHERE `ownertype`='%d' AND `owner`='%d'", CAR_OWNER_PLAYER, lPUID);
    new Cache:result = mysql_query(mruMySQL_Connection, string, true);
	if(cache_is_valid(result))
	{
		for(new i; i < cache_num_rows(); i++)
        {
            cache_get_value_index_int(i, 0, lsID);
            if(strfind(lList, lsSearch) == -1)
            {
                cache_get_value_index_int(i, 0, CarData[gCars][c_UID]);
                cache_get_value_index_int(i, 1, CarData[gCars][c_OwnerType]);
                cache_get_value_index_int(i, 2, CarData[gCars][c_Owner]);
                cache_get_value_index_int(i, 3, CarData[gCars][c_Model]);
                cache_get_value_index_float(i, 4, CarData[gCars][c_Pos][0]);
                cache_get_value_index_float(i, 5, CarData[gCars][c_Pos][1]);
                cache_get_value_index_float(i, 6, CarData[gCars][c_Pos][2]);
                cache_get_value_index_float(i, 7, CarData[gCars][c_Rot]);
                cache_get_value_index_float(i, 8, CarData[gCars][c_HP]);
                cache_get_value_index_int(i, 9, CarData[gCars][c_Tires]);
                cache_get_value_index_int(i, 10, CarData[gCars][c_Color][0]);
                cache_get_value_index_int(i, 11, CarData[gCars][c_Color][1]);
                cache_get_value_index_int(i, 12, CarData[gCars][c_Nitro]);
                cache_get_value_index_int(i, 13, CarData[gCars][c_bHydraulika]);
                cache_get_value_index_int(i, 14, CarData[gCars][c_Felgi]);
                cache_get_value_index_int(i, 15, CarData[gCars][c_Malunek]);
                cache_get_value_index_int(i, 16, CarData[gCars][c_Spoiler]);
                cache_get_value_index_int(i, 17, CarData[gCars][c_Bumper][0]);
                cache_get_value_index_int(i, 18, CarData[gCars][c_Bumper][1]);
                cache_get_value_index_int(i, 19, CarData[gCars][c_Keys]);
                cache_get_value_index_int(i, 20, CarData[gCars][c_Neon]);
                cache_get_value_index_int(i, 21, CarData[gCars][c_Rang]);
                cache_get_value_index_int(i, 22, CarData[gCars][c_Int]);
                cache_get_value_index_int(i, 23, CarData[gCars][c_VW]);
                //24 unused
                cache_get_value_index_int(i, 25, CarData[gCars][c_Siren]);
                cache_get_value_index(i, 26, CarData[gCars][c_Rejestracja]);

                PlayerInfo[playerid][pCars][lUsed++] = lVehID;

                lVehID = Car_GetFromQueue();
                if(lVehID == -1) lVehID = ++gCars;
            }
        }
        cache_delete(result);
    }

    new keys = PlayerInfo[playerid][pKluczeAuta];
    if(keys > 0)
    {
        //Wczytanie pojazdu z kluczyków
        new id = Car_GetIDXFromUID(keys);
        if(id == -1) Car_LoadEx(keys);
    }
}

Car_UnloadForPlayer(playerid)
{
    new lVehUID;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
		lVehUID = PlayerInfo[playerid][pCars][i];
        if(lVehUID <= 0 || lVehUID >= MAX_CARS) continue;
        if(CarData[lVehUID][c_ID] != 0) continue;
        Car_ClearMem(lVehUID);
    }
}

CountPlayerCars(playerid)
{
    new lCount;
    for(new i=0;i<MAX_CAR_SLOT;i++)
    {
        if(PlayerInfo[playerid][pCars][i] == 0) continue;
        else lCount++;
    }
    return lCount;
}

Car_AddTune(vehicleid)
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

IsCarOwner(playerid, vehicle, bool:kluczyki=false)
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

Car_IsValid(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return 1;
}

Car_GetOwnerType(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return CarData[VehicleUID[vehicleid][vUID]][c_OwnerType];
}

Car_GetOwner(vehicleid)
{
    if(VehicleUID[vehicleid][vUID] == 0) return 0;
    return CarData[VehicleUID[vehicleid][vUID]][c_Owner];
}

Car_Spawn(lUID, bool:loaddesc=true)
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
		format(rejestracja, sizeof(rejestracja), "DMV %d", CarData[lUID][c_UID]);
	else
		format(rejestracja, sizeof(rejestracja), "%s", CarData[lUID][c_Rejestracja]);

    SetVehicleNumberPlate(vehicleid, rejestracja);
	RespawnVehicleEx(vehicleid);
	//
    Car_AddTune(vehicleid);
    CarData[lUID][c_ID] = vehicleid;

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

Car_ClearMem(lVehID)
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

Car_GetIDXFromUID(lUID)
{
    for(new i=0;i<MAX_CARS;i++)
    {
        if(CarData[i][c_UID] == lUID) return i;
    }
    return -1;
}

Car_Unspawn(v, bool:playercall=false)
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
        foreach(new i : Player)
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

Car_Destroy(lV)
{
    if(CarData[lV][c_ID] != 0) Car_Unspawn(CarData[lV][c_ID], true);
    new string[64];
    format(string, 64, "DELETE FROM `mru_cars` WHERE `UID`='%d'", CarData[lV][c_UID]);
    mysql_tquery(mruMySQL_Connection, string);

    Car_ClearMem(lV);
}

Car_Save(lUID, lType)
{
    new string[256];
    switch(lType)
    {
        case CAR_SAVE_OWNER:
        {
            format(string, sizeof(string), "UPDATE `mru_cars` SET `owner`='%d', `ownertype`='%d', `keys`='%d', `ranga`='%d' WHERE `UID`='%d'", CarData[lUID][c_Owner], CarData[lUID][c_OwnerType], CarData[lUID][c_Keys], CarData[lUID][c_Rang], CarData[lUID][c_UID]);
            mysql_tquery(mruMySQL_Connection, string);
        }
        case CAR_SAVE_STATE:
        {
            format(string, sizeof(string), "UPDATE `mru_cars` SET `model`='%d', `x`='%f', `y`='%f', `z`='%f', `angle`='%.1f', `hp`='%.1f', `tires`='%d', `int`='%d', `vw`='%d' WHERE `UID`='%d'", CarData[lUID][c_Model], CarData[lUID][c_Pos][0], CarData[lUID][c_Pos][1], CarData[lUID][c_Pos][2], CarData[lUID][c_Rot], CarData[lUID][c_HP], CarData[lUID][c_Tires], CarData[lUID][c_Int], CarData[lUID][c_VW], CarData[lUID][c_UID]);
            mysql_tquery(mruMySQL_Connection, string);
        }
        case CAR_SAVE_TUNE:
        {
            format(string, sizeof(string), "UPDATE `mru_cars` SET `color1`='%d', `color2`='%d', `nitro`='%d', `hydraulika`='%d', `felgi`='%d', `malunek`='%d', `spoiler`='%d', `bumper1`='%d', `bumper2`='%d', `neon`='%d' WHERE `UID`='%d'", CarData[lUID][c_Color][0],CarData[lUID][c_Color][1],CarData[lUID][c_Nitro],CarData[lUID][c_bHydraulika],CarData[lUID][c_Felgi],CarData[lUID][c_Malunek],CarData[lUID][c_Spoiler], CarData[lUID][c_Bumper][0], CarData[lUID][c_Bumper][1], CarData[lUID][c_Neon], CarData[lUID][c_UID]);
            mysql_tquery(mruMySQL_Connection, string);
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

Car_PrintOwner(car)
{
    new string[64];
    new type = CarData[car][c_OwnerType];
    switch(type)
    {
        case INVALID_CAR_OWNER: string="Brak";
        case CAR_OWNER_FRACTION:
        {
            format(string, sizeof(string), "%s", FractionNames[CarData[car][c_Owner]]);
        }
        case CAR_OWNER_FAMILY:
        {
            format(string, sizeof(string), "%s", OrgInfo[orgID(CarData[car][c_Owner])][o_Name]);
        }
        case CAR_OWNER_PLAYER:
        {
            format(string, sizeof(string), "SELECT `Nick` FROM mru_konta WHERE `UID`='%d'", CarData[car][c_Owner]);
            new Cache:result = mysql_query(mruMySQL_Connection, string, true);
            if(cache_is_valid(result))
            {
                if(cache_num_rows())
                {
                    format(string, sizeof(string), "Nieistniej¹cy");
                }
                cache_delete(result);
            }
        }
        case CAR_OWNER_JOB:
        {
            format(string, sizeof(string), "%s", JobNames[CarData[car][c_Owner]]);
        }
        case CAR_OWNER_SPECIAL:
        {
            switch(CarData[car][c_Owner])
            {
                case 1: string="Wypo¿yczalnia";
                case 2: string="GoKart";
                case 3: string="¯u¿el";
                default: string="Brak";
            }
        }
        case CAR_OWNER_PUBLIC:
        {
            string = "Brak";
        }
        default: string="Brak";
    }
    return string;
}

ShowCarEditDialog(playerid)
{
    new string[512], car = GetPVarInt(playerid, "edit-car"), Float:lHP;
    if(CarData[car][c_ID] == 0) lHP = CarData[car][c_HP];
    else GetVehicleHealth(CarData[car][c_ID], lHP);
    new color1 = VehicleColoursTableRGBA[clamp(CarData[car][c_Color][0], 0, 255)], color2=VehicleColoursTableRGBA[clamp(CarData[car][c_Color][1], 0, 255)];
    format(string, sizeof(string), "{FFFFFF}Model:\t\t{8FCB04}%d{FFFFFF}\t[ {8FCB04}%s {FFFFFF}]\nW³aœciciel:\t{8FCB04}%s{FFFFFF} » {8FCB04}%s{FFFFFF} (UID: {8FCB04}%d{FFFFFF})\nRanga:\t\t{8FCB04}%d{FFFFFF}\nOpis Pojazdu\nStan:\t\t{8FCB04}%.1f{FFFFFF}\%\nZaparkuj tutaj\nUsuñ kluczyki\n{%06x}Kolor I\n{%06x}Kolor II", CarData[car][c_Model], VehicleNames[CarData[car][c_Model]-400], CarOwnerNames[CarData[car][c_OwnerType]], Car_PrintOwner(car), CarData[car][c_Owner], CarData[car][c_Rang], lHP/10, RGBAtoRGB(color1), RGBAtoRGB(color2));
    ShowPlayerDialogEx(playerid, D_EDIT_CAR_MENU, DIALOG_STYLE_LIST, "{8FCB04}Edycja {FFFFFF}pojazdów", string, "Wybierz", "Wróæ");
    return 1;
}

stock GetVehicleSpeed(carid)
{
    new Float:x,Float:y,Float:z,Float:speed,final_speed;
    GetVehicleVelocity(carid,x,y,z);
    speed = VectorSize(x, y, z) * 166.666666;
    final_speed = floatround(speed,floatround_round);
    return final_speed;
}


//-----------------<[ Timery: ]>--------------------
/*

*/
//------------------<[ MySQL: ]>--------------------

//end