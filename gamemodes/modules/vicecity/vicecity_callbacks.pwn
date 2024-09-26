//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  vicecity                                                 //
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
// Autor: Roger Costa '[Ds]NikO', edited by mrucznik
// Data utworzenia: 13.04.2024
//Opis:
/*
	Vice City
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnGameModeInit()
{
	ViceCityInteriors();

    new totalModels, timedModels, normalModels;

    foreach(new i : Player) {
        ViewingMap[i] = false;
    }

    Streamer_VisibleItems(STREAMER_TYPE_OBJECT, STREAMER_VISIBLEITENS);
    
    // AddSimpleModel for Screen Map
    AddSimpleModel(-1, 19379, -3001, "vc4samp/fbi_logo_large.dff", "vc4samp/fbi_logo.txd");

    // Creating textdraws
    #if defined VICECITY_USE_MAP
		screenVCMap = TextDrawCreate(170.000000, 91.000000, "mdl-3001:fbi_logo1");
		TextDrawBackgroundColor(screenVCMap, -65281);
		TextDrawFont(screenVCMap, 4);
		TextDrawLetterSize(screenVCMap, 0.500000, 1.000000);
		TextDrawColor(screenVCMap, -1);
		TextDrawSetOutline(screenVCMap, 1);
		TextDrawSetProportional(screenVCMap, 1);
		TextDrawUseBox(screenVCMap, 1);
		TextDrawBoxColor(screenVCMap, -1);
		TextDrawTextSize(screenVCMap, 300.000000, 300.000000);
		TextDrawSetSelectable(screenVCMap, 0);

		screenVCPlaces[0] = TextDrawCreate(235.000000, 360.000000, "Escobar~n~International~n~Airport");
		TextDrawAlignment(screenVCPlaces[0], 2);
		TextDrawBackgroundColor(screenVCPlaces[0], 255);
		TextDrawFont(screenVCPlaces[0], 2);
		TextDrawLetterSize(screenVCPlaces[0], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[0], 128);
		TextDrawSetOutline(screenVCPlaces[0], 0);
		TextDrawSetProportional(screenVCPlaces[0], 1);
		TextDrawSetShadow(screenVCPlaces[0], 0);
		TextDrawSetSelectable(screenVCPlaces[0], 0);

		screenVCPlaces[1] = TextDrawCreate(235.000000, 135.000000, "Downtown");
		TextDrawAlignment(screenVCPlaces[1], 2);
		TextDrawBackgroundColor(screenVCPlaces[1], 255);
		TextDrawFont(screenVCPlaces[1], 2);
		TextDrawLetterSize(screenVCPlaces[1], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[1], 128);
		TextDrawSetOutline(screenVCPlaces[1], 0);
		TextDrawSetProportional(screenVCPlaces[1], 1);
		TextDrawSetShadow(screenVCPlaces[1], 0);
		TextDrawSetSelectable(screenVCPlaces[1], 0);

		screenVCPlaces[2] = TextDrawCreate(354.000000, 105.000000, "Prawn~n~Island");
		TextDrawAlignment(screenVCPlaces[2], 2);
		TextDrawBackgroundColor(screenVCPlaces[2], 255);
		TextDrawFont(screenVCPlaces[2], 2);
		TextDrawLetterSize(screenVCPlaces[2], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[2], 128);
		TextDrawSetOutline(screenVCPlaces[2], 0);
		TextDrawSetProportional(screenVCPlaces[2], 1);
		TextDrawSetShadow(screenVCPlaces[2], 0);
		TextDrawSetSelectable(screenVCPlaces[2], 0);

		screenVCPlaces[3] = TextDrawCreate(336.000000, 197.000000, "Leaf~n~Links");
		TextDrawAlignment(screenVCPlaces[3], 2);
		TextDrawBackgroundColor(screenVCPlaces[3], 255);
		TextDrawFont(screenVCPlaces[3], 2);
		TextDrawLetterSize(screenVCPlaces[3], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[3], 128);
		TextDrawSetOutline(screenVCPlaces[3], 0);
		TextDrawSetProportional(screenVCPlaces[3], 1);
		TextDrawSetShadow(screenVCPlaces[3], 0);
		TextDrawSetSelectable(screenVCPlaces[3], 0);

		screenVCPlaces[4] = TextDrawCreate(319.000000, 291.000000, "Starfish Island");
		TextDrawAlignment(screenVCPlaces[4], 2);
		TextDrawBackgroundColor(screenVCPlaces[4], 255);
		TextDrawFont(screenVCPlaces[4], 2);
		TextDrawLetterSize(screenVCPlaces[4], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[4], 128);
		TextDrawSetOutline(screenVCPlaces[4], 0);
		TextDrawSetProportional(screenVCPlaces[4], 1);
		TextDrawSetShadow(screenVCPlaces[4], 0);
		TextDrawSetSelectable(screenVCPlaces[4], 0);

		screenVCPlaces[5] = TextDrawCreate(347.000000, 380.000000, "Ocean Beach");
		TextDrawAlignment(screenVCPlaces[5], 2);
		TextDrawBackgroundColor(screenVCPlaces[5], 255);
		TextDrawFont(screenVCPlaces[5], 2);
		TextDrawLetterSize(screenVCPlaces[5], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[5], 128);
		TextDrawSetOutline(screenVCPlaces[5], 0);
		TextDrawSetProportional(screenVCPlaces[5], 1);
		TextDrawSetShadow(screenVCPlaces[5], 0);
		TextDrawSetSelectable(screenVCPlaces[5], 0);

		screenVCPlaces[6] = TextDrawCreate(434.000000, 295.000000, "Washington Beach");
		TextDrawAlignment(screenVCPlaces[6], 2);
		TextDrawBackgroundColor(screenVCPlaces[6], 255);
		TextDrawFont(screenVCPlaces[6], 2);
		TextDrawLetterSize(screenVCPlaces[6], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[6], 128);
		TextDrawSetOutline(screenVCPlaces[6], 0);
		TextDrawSetProportional(screenVCPlaces[6], 1);
		TextDrawSetShadow(screenVCPlaces[6], 0);
		TextDrawSetSelectable(screenVCPlaces[6], 0);

		screenVCPlaces[7] = TextDrawCreate(426.000000, 110.000000, "Vice Point");
		TextDrawAlignment(screenVCPlaces[7], 2);
		TextDrawBackgroundColor(screenVCPlaces[7], 255);
		TextDrawFont(screenVCPlaces[7], 2);
		TextDrawLetterSize(screenVCPlaces[7], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[7], 128);
		TextDrawSetOutline(screenVCPlaces[7], 0);
		TextDrawSetProportional(screenVCPlaces[7], 1);
		TextDrawSetShadow(screenVCPlaces[7], 0);
		TextDrawSetSelectable(screenVCPlaces[7], 0);

		screenVCPlaces[8] = TextDrawCreate(228.000000, 197.000000, "Little Haiti");
		TextDrawAlignment(screenVCPlaces[8], 2);
		TextDrawBackgroundColor(screenVCPlaces[8], 255);
		TextDrawFont(screenVCPlaces[8], 2);
		TextDrawLetterSize(screenVCPlaces[8], 0.169999, 1.000000);
		TextDrawColor(screenVCPlaces[8], 128);
		TextDrawSetOutline(screenVCPlaces[8], 0);
		TextDrawSetProportional(screenVCPlaces[8], 1);
		TextDrawSetShadow(screenVCPlaces[8], 0);
		TextDrawSetSelectable(screenVCPlaces[8], 0);
		
	#endif
	
    // Creating Areas
    areaViceCity = CreateDynamicRectangle(-6040.4917, 489.1467, -3026.3218, 3864.5580, -1, 0, -1);
	areaViceCityBeach = CreateDynamicRectangle(-3250.0000, 3535.0000, -4503.0000, 495.0000, -1, 0, -1);
	areaViceCityMainland = CreateDynamicRectangle(-4406.0000, 3774.0000, -5961.0000, 486.0000, -1, 0, -1);
    areaPrawnIsland = CreateDynamicRectangle(-4095.3281, 3482.4290, -4333.7354, 3088.3255, -1, 0, -1);
	areaStarfishIsland = CreateDynamicRectangle(-4379.9883, 2016.7452, -4923.1338, 1612.8026, -1, 0, -1);

    // Searching for IDE and creating objects and timed objects
    for(new i, k = sizeof(ide_infos); i < k; i++) {
        new unpackDFF[40], unpackTXD[40];

        strunpack(unpackDFF, ide_infos[i][dff_name]);
        strunpack(unpackTXD, ide_infos[i][txd_name]);
        strins(unpackDFF, DFF_PATH, 0);
        strins(unpackTXD, TXD_PATH, 0);

        // Timed Objects
        if(ide_infos[i][timeon] != 0) {
            AddSimpleModelTimed(VICECITY_VWORLD, 19379, ide_infos[i][modelID], unpackDFF, unpackTXD, ide_infos[i][timeon], ide_infos[i][timeoff]);
			CA_LoadFromDff(ide_infos[i][modelID], unpackDFF);
            timedModels++;
            totalModels++;
        // Non Timed Objects
        } else {
            if(strfind(ide_infos[i][dff_name], "lod", true) == -1 || ide_infos[i][modelID] == -9150
            || ide_infos[i][modelID] == -9151 || ide_infos[i][modelID] == -9152 || ide_infos[i][modelID] == -9153
            || ide_infos[i][modelID] == -9888 || ide_infos[i][modelID] == -9887 || ide_infos[i][modelID] == -9893
            || ide_infos[i][modelID] == -9889 || ide_infos[i][modelID] == -9892 || ide_infos[i][modelID] == -9894
            || ide_infos[i][modelID] == -9261 || ide_infos[i][modelID] == -9262 || ide_infos[i][modelID] == -9207
            || ide_infos[i][modelID] == -9175 || ide_infos[i][modelID] == -9176 || ide_infos[i][modelID] == -9177
            || ide_infos[i][modelID] == -9263) { // Don't create objects with "lod" in dff_name.
                AddSimpleModel(VICECITY_VWORLD, 19379, ide_infos[i][modelID], unpackDFF, unpackTXD);
				CA_LoadFromDff(ide_infos[i][modelID], unpackDFF);
                totalModels++;
                normalModels++;
            }
        }
    }

    new objectCreated, objectid;
    for(new i, k = sizeof(ipl_infos); i < k; i++) {
        new bool:isLOD = false;
        for(new j = 0, h = sizeof(LOD_IDs); j < h; j++) {
            if(ipl_infos[i][modelID] == LOD_IDs[j]) { // Checking if modelID is a LOD object.
                isLOD = true;
                break;
            }
        }

        if(!isLOD) { // If is not a LOD object, script allowed to create object.
            new Float:erx, Float:ery, Float:erz;
            QuatToEulerZXY(ipl_infos[i][ipl_rx], ipl_infos[i][ipl_ry], ipl_infos[i][ipl_rz], ipl_infos[i][ipl_rw], erx, ery, erz);

            if(ipl_infos[i][interiorID] != 0) {
                objectid = CA_auto_CreateDynamicObjectVC(ipl_infos[i][modelID], ipl_infos[i][ipl_x] + VICECITY_MOVE_X, ipl_infos[i][ipl_y] + VICECITY_MOVE_Y, ipl_infos[i][ipl_z] + VICECITY_MOVE_Z, erx, ery, erz, VICECITY_VWORLD, ipl_infos[i][interiorID], -1, 150.0, 150.0, -1, 0);    
            }
            else {
                objectid = CA_auto_CreateDynamicObjectVC(ipl_infos[i][modelID], ipl_infos[i][ipl_x] + VICECITY_MOVE_X, ipl_infos[i][ipl_y] + VICECITY_MOVE_Y, ipl_infos[i][ipl_z] + VICECITY_MOVE_Z, erx, ery, erz, VICECITY_VWORLD, ipl_infos[i][interiorID], -1, 1000.0, 1000.0, -1, 0);     
            }

			new ModelID = ipl_infos[i][modelID];
			/* Retexturized Objects (Optional) - For remove texture of model, remove "if" or "else if" */
			if(ModelID == -7732) { // Model: wshbuildws10.dff - Rafaels clothing store
				SetDynamicObjectMaterial(objectid, 1, 5819, "buildtestlawn", "lawshopwall4", 0xFF335F3F);
			}
			else if(ModelID == -8158) { // Model: wash_hardwares.dff - Tool building around VCPD

				SetDynamicObjectMaterial(objectid, 0, 12855, "cunte_cop", "sw_brick05", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 1, 6875, "vegasnbuild1", "brickvgn1_128", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 2, 3063, "col_wall1x", "ab_wood1", 0xFFFFFFFF);
			}
			else if(ModelID == -8725) { // Model: od_bighotpool.dff - Pool from back of building, aprox. beach and vcpd
				SetDynamicObjectMaterial(objectid, 0, 3781, "lan2office", "glass_office4", 0xFF105082);
				SetDynamicObjectMaterial(objectid, 1, 13003, "ce_racestart", "sa_wood07_128", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 2, 3741, "cehillhse14", "swimpoolside1_128", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 3, 14806, "bdupshifi", "Bdup2_wood", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 4, 11496, "des_nwstuff", "brdwalkwater_la", 0xFFA3ADC6);
			}
			// Marina Bay
			else if(ModelID == -7765) { // Model: wshbuildws36.dff - Marina Bay - Center Object
				SetDynamicObjectMaterial(objectid, 1, 2591, "ab_partition1", "ab_fabricCheck2", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 3, 8395, "pyramid", "luxorwindow01_128", 0xFF9F9D94);
				SetDynamicObjectMaterial(objectid, 5, 1557, "dave_door_2b", "miragedoor1_256", 0xFFD78E10);
			}
			else if(ModelID == -7819) { // Model: marina2.dff - Marina Bay
				SetDynamicObjectMaterial(objectid, 2, 2591, "ab_partition1", "ab_fabricCheck2", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 3, 8395, "pyramid", "luxorwindow01_128", 0xFF9F9D94);
			}
			else if(ModelID == -7818) { // Model: marina1.dff - Marina Bay
				SetDynamicObjectMaterial(objectid, 1, 2591, "ab_partition1", "ab_fabricCheck2", 0xFFFFFFFF);
				SetDynamicObjectMaterial(objectid, 3, 8395, "pyramid", "luxorwindow01_128", 0xFF9F9D94);
			}

            objectCreated++;
        }
    }

	
    printf("Vice City | Total Objects: %d - Total Models: %d - Timed Objects: %d - Normal Models: %d", Streamer_CountItems(STREAMER_TYPE_OBJECT, 0), totalModels, timedModels, normalModels);
    return 1;
}

ViceCity_AddCollisions()
{
    for(new i, k = sizeof(ide_infos); i < k; i++) {
        new unpackDFF[40];

        strunpack(unpackDFF, ide_infos[i][dff_name]);
        strins(unpackDFF, DFF_PATH, 0);

		if(strfind(ide_infos[i][dff_name], "lod", true) == -1 || ide_infos[i][modelID] == -9150
		|| ide_infos[i][modelID] == -9151 || ide_infos[i][modelID] == -9152 || ide_infos[i][modelID] == -9153
		|| ide_infos[i][modelID] == -9888 || ide_infos[i][modelID] == -9887 || ide_infos[i][modelID] == -9893
		|| ide_infos[i][modelID] == -9889 || ide_infos[i][modelID] == -9892 || ide_infos[i][modelID] == -9894
		|| ide_infos[i][modelID] == -9261 || ide_infos[i][modelID] == -9262 || ide_infos[i][modelID] == -9207
		|| ide_infos[i][modelID] == -9175 || ide_infos[i][modelID] == -9176 || ide_infos[i][modelID] == -9177
		|| ide_infos[i][modelID] == -9263) { // Don't add collisions to models with "lod" in dff_name.
			CA_LoadFromDff(ide_infos[i][modelID], unpackDFF);
		}
    }
}

hook OnGameModeExit() {
    foreach(new i : Player) {
        if(IsPlayerConnected(i)) {
            if(ViewingMap[i]) {
                ViewingMap[i] = false;
                PlayerTextDrawDestroy(i, screenArrow[i]);
            }
        }
    }    
    return true;
}

hook OnPlayerConnect(playerid) {
    ViewingMap[playerid] = false;
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(HOLDING(HOLDING_KEY) && IsPlayerInDynamicArea(playerid, areaViceCity, 0)) {
        TextDrawShowForPlayer(playerid, screenVCMap);
	    for(new i = 0, k = sizeof(screenVCPlaces); i < k; i++) {
			TextDrawShowForPlayer(playerid, screenVCPlaces[i]);
		}
        ViewingMap[playerid] = true;
	}
 	else if(RELEASED(HOLDING_KEY)) {
        TextDrawHideForPlayer(playerid, screenVCMap);
	    for(new i = 0, k = sizeof(screenVCPlaces); i < k; i++) {
			TextDrawHideForPlayer(playerid, screenVCPlaces[i]);
		}
        PlayerTextDrawHide(playerid, screenArrow[playerid]);
        PlayerTextDrawDestroy(playerid, screenArrow[playerid]);
        ViewingMap[playerid] = false;
    }
	return 1;
}

//end