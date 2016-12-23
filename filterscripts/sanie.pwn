#include <a_samp>
#include <zcmd>
#include <crashdetect>
#include <streamer>
#include <double-o-files2>
#include <sscanf2>
#include <code-parse>
#include <YSI\YSI\y_dialog>
#include <YSI\YSI\y_inline>
#undef USER_FILE_PATH
#define USER_FILE_PATH  "Swieta/%s.ini"
#define COLOR_LAWNGREEN 0x7CFC00AA
new vehicleid;
new dostalPrezent[MAX_PLAYERS][2];
new dodatek[MAX_PLAYERS];
new sanie = false;
new gift_real[1750];
new MAX_GIFTS = 1749;
new gifts = 0;
new obj[31];
new SantaPickupModel[][1] = {
        {19054},
        {19055},
        {19056},
        {19057},
        {19058}
};
            /*
            19064   SantaHat1
19065   SantaHat2
19066   SantaHat3
            */
new dodatki[][1] = {
    {19064},
    {19065},
    {19066}
};
public OnFilterScriptExit() {
    for(new i=0, j=sizeof(obj); i<j; i++) {
        DestroyDynamicObject(obj[i]);
    }
    DestroyVehicle(vehicleid);
    return 1;
}
public OnFilterScriptInit()
{
        obj[0] = CreateDynamicObject(1251, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[1] = CreateDynamicObject(19315, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[2] = CreateDynamicObject(19315, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[3] = CreateDynamicObject(19315, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[4] = CreateDynamicObject(19315, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[5] = CreateDynamicObject(1736, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[6] = CreateDynamicObject(1736, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[7] = CreateDynamicObject(1736, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[8] = CreateDynamicObject(1736, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[9] = CreateDynamicObject(19439, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[10] = CreateDynamicObject(1408, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[11] = CreateDynamicObject(1408, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[12] = CreateDynamicObject(1724, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[13] = CreateDynamicObject(2745, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[14] = CreateDynamicObject(19439, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[15] = CreateDynamicObject(19439, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[16] = CreateDynamicObject(19439, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[17] = CreateDynamicObject(19439, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[18] = CreateDynamicObject(19054, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[19] = CreateDynamicObject(19055, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[20] = CreateDynamicObject(19058, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[21] = CreateDynamicObject(19056, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[22] = CreateDynamicObject(19065, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[23] = CreateDynamicObject(1251, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[24] = CreateDynamicObject(1251, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[25] = CreateDynamicObject(1319, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[26] = CreateDynamicObject(1319, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[27] = CreateDynamicObject(1319, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[28] = CreateDynamicObject(1319, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[29] = CreateDynamicObject(1319, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        obj[30] = CreateDynamicObject(1319, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
        vehicleid = 578;
        for(new i=0; i<MAX_PLAYERS; i++) {
            OnPlayerConnect(i);
        }
        return 1;
}
CMD:sanie(playerid,params[])
{
    // zabezpieczenie komendy mozesz zrobic inne, w/e
    if(strval(params) != 19613) return 1;
    if(sanie) {
        for(new i=0, j=sizeof(obj); i<j; i++) {
            DestroyDynamicObject(obj[i]);
        }
        DestroyVehicle(vehicleid);
        sanie = false;
        return 1;
    } else {
        new Float:x, Float:y, Float:z, Float:a;
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        vehicleid = CreateVehicle(578, x +2, y, z+4, a, -1, -1, 60);
        AttachDynamicObjectToVehicle(obj[0], vehicleid, 0.000000, 1.699998, 0.634999, 0.000000, 0.000000, 0.000000); //Object Model: 1251 |
        AttachDynamicObjectToVehicle(obj[1], vehicleid, 0.374999, 4.085045, 0.344999, -1.004999, 1.005000, 88.439956); //Object Model: 19315 |
        AttachDynamicObjectToVehicle(obj[2], vehicleid, -0.389999, 4.085045, 0.344999, -1.004999, 1.005000, 88.439956); //Object Model: 19315 |
        AttachDynamicObjectToVehicle(obj[3], vehicleid, -0.389999, 2.195002, 0.344999, -1.004999, 1.005000, 88.439956); //Object Model: 19315 |
        AttachDynamicObjectToVehicle(obj[4], vehicleid, 0.359999, 2.195002, 0.344999, -1.004999, 1.005000, 88.439956); //Object Model: 19315 |
        AttachDynamicObjectToVehicle(obj[5], vehicleid, 0.359999, 2.590011, 0.704999, -1.004999, 1.005000, 175.875076); //Object Model: 1736 |
        AttachDynamicObjectToVehicle(obj[6], vehicleid, -0.344999, 2.590011, 0.704999, -1.004999, 1.005000, 175.875076); //Object Model: 1736 |
        AttachDynamicObjectToVehicle(obj[7], vehicleid, -0.344999, 4.440053, 0.704999, -1.004999, 1.005000, 175.875076); //Object Model: 1736 |
        AttachDynamicObjectToVehicle(obj[8], vehicleid, 0.399999, 4.440053, 0.704999, -1.004999, 1.005000, 175.875076); //Object Model: 1736 |
        AttachDynamicObjectToVehicle(obj[9], vehicleid, 0.000000, 0.014999, 0.624999, 24.119993, 91.454948, 0.000000); //Object Model: 19439 |
        AttachDynamicObjectToVehicle(obj[10], vehicleid, 1.459998, -1.769998, 0.869999, -152.759963, 0.000000, 90.824928); //Object Model: 1408 |
        AttachDynamicObjectToVehicle(obj[11], vehicleid, -1.429998, -1.769998, 0.869999, -205.020217, 0.000000, 90.824928); //Object Model: 1408 |
        AttachDynamicObjectToVehicle(obj[12], vehicleid, 0.549999, -0.584999, 0.329999, -358.785949, 0.000000, 178.260070); //Object Model: 1724 |
        AttachDynamicObjectToVehicle(obj[13], vehicleid, 0.029999, -0.050000, 0.789999, -404.011169, 4.019999, 190.320129); //Object Model: 2745 |
        AttachDynamicObjectToVehicle(obj[14], vehicleid, -0.509999, -1.389998, 0.454999, -359.790954, 91.454948, 450.616394); //Object Model: 19439 |
        AttachDynamicObjectToVehicle(obj[15], vehicleid, -0.509999, -2.640012, 0.454999, -359.790954, 91.454948, 450.616394); //Object Model: 19439 |
        AttachDynamicObjectToVehicle(obj[16], vehicleid, 0.519999, -2.640012, 0.454999, -359.790954, 91.454948, 450.616394); //Object Model: 19439 |
        AttachDynamicObjectToVehicle(obj[17], vehicleid, 0.519999, -1.369999, 0.454999, -359.790954, 91.454948, 450.616394); //Object Model: 19439 |
        AttachDynamicObjectToVehicle(obj[18], vehicleid, 0.519999, -1.369999, 1.104999, -361.800964, -2.009999, 358.155944); //Object Model: 19054 |
        AttachDynamicObjectToVehicle(obj[19], vehicleid, -0.754999, -1.369999, 1.104999, -361.800964, -2.009999, 358.155944); //Object Model: 19055 |
        AttachDynamicObjectToVehicle(obj[20], vehicleid, -0.714999, -3.770038, 1.104999, -361.800964, -2.009999, 358.155944); //Object Model: 19058 |
        AttachDynamicObjectToVehicle(obj[21], vehicleid, 0.734999, -3.770038, 1.104999, -361.800964, -2.009999, 358.155944); //Object Model: 19056 |
        AttachDynamicObjectToVehicle(obj[22], vehicleid, 0.085000, -0.659999, 1.769998, 1.004999, 17.084999, 94.469940); //Object Model: 19065 |
        AttachDynamicObjectToVehicle(obj[23], vehicleid, -1.149999, -1.889998, -0.439999, 1.004999, 17.084999, 1.005000); //Object Model: 1251 |
        AttachDynamicObjectToVehicle(obj[24], vehicleid, 1.119999, -1.889998, -0.439999, 1.004999, 17.084999, 1.005000); //Object Model: 1251 |
        AttachDynamicObjectToVehicle(obj[25], vehicleid, -1.224999, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000); //Object Model: 1319 |
        AttachDynamicObjectToVehicle(obj[26], vehicleid, 1.079999, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000); //Object Model: 1319 |
        AttachDynamicObjectToVehicle(obj[27], vehicleid, 1.079999, -3.960043, 0.000000, 0.000000, 0.000000, 0.000000); //Object Model: 1319 |
        AttachDynamicObjectToVehicle(obj[28], vehicleid, -1.164999, -3.960043, 0.000000, 0.000000, 0.000000, 0.000000); //Object Model: 1319 |
        AttachDynamicObjectToVehicle(obj[29], vehicleid, 0.994999, 1.904998, -0.129999, -53.265010, -1.004999, 6.030002); //Object Model: 1319 |
        AttachDynamicObjectToVehicle(obj[30], vehicleid, -1.279998, 1.904998, -0.129999, -53.265010, -1.004999, 6.030002); //Object Model: 1319 |
        LinkVehicleToInterior(vehicleid, 6);
        PutPlayerInVehicle(playerid, vehicleid, 0);
        sanie = true;
        return 1;
    }
}
CMD:prezent(playerid, params[]) {
    if(strval(params) != 19613) return 1;
    new smodel = random(sizeof(SantaPickupModel)), Float:piox, Float:pioy, Float:pioz;
    GetPlayerPos(playerid, piox, pioy, pioz);
    gift_real[gifts] = CreateDynamicPickup(SantaPickupModel[smodel][0],8,piox,pioy-4,pioz,0,0);
    gifts++;
    return 1;
}
public OnPlayerPickUpDynamicPickup(playerid,pickupid){
    new string[60];
    for(new i=0; i<=MAX_GIFTS; i++) {
        if(pickupid == gift_real[i]) {
            new nagroda = random(13);
            if(nagroda >= 0 && nagroda <= 2) {
                if(dostalPrezent[playerid][0]) return SendClientMessage(playerid, COLOR_LAWNGREEN, "Dosta³eœ ju¿ pieni¹dze, daj spróbowaæ innym!");
                format(string, sizeof(string), "Otwierasz prezent... widaæ tam coœ super!");
                // callRemoteFunction("swieta_dajKase"
                DOF2_SetBool( USER_FILE ( playerid ), "Kasa", true); 
                CallRemoteFunction("swieta_dajKase", "i", playerid);
                dostalPrezent[playerid][0] = true;
            }
            if(nagroda >= 3 && nagroda <= 8) {
                // dostal dodatek
                if(dostalPrezent[playerid][1]) return SendClientMessage(playerid, COLOR_LAWNGREEN, "Dosta³eœ ju¿ dodatek, daj spróbowaæ innym!");
                format(string, sizeof(string), "Na okres œwi¹t dostajesz czapkê Miko³aja! U¿yj /swieta");
                new smodel = random(sizeof(dodatki));
                dodatek[playerid] = SetPlayerAttachedObject(playerid, 9, dodatki[smodel][0], 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
                DOF2_SetBool( USER_FILE ( playerid ), "Dodatek", true); 
                DOF2_SetInt( USER_FILE ( playerid ), "DodatekModel", dodatki[smodel][0]); 
                dostalPrezent[playerid][1] = true;
            }
            if(nagroda >= 9 && nagroda <= 13) {
                format(string, sizeof(string), "Niestety, nie uda³o Ci siê niczego zdobyæ!");
            }
            DOF2_SaveFile();
            SendClientMessage(playerid, COLOR_LAWNGREEN, string);
            DestroyDynamicPickup(pickupid);
        }    
    }
    return 1;
}
stock USER_FILE(playerid)
{
    new 
        STR[ 128 ], 
        P_NAME[ MAX_PLAYER_NAME ]; 
        
    GetPlayerName( playerid, P_NAME,  sizeof ( P_NAME ) ); 
    format( STR, sizeof ( STR ), USER_FILE_PATH, P_NAME); 
    return
        STR;
}
public OnPlayerConnect(playerid)
{
    dostalPrezent[playerid][0] = false;
    dostalPrezent[playerid][1] = false;
    if( DOF2_FileExists ( USER_FILE ( playerid ) ) ) 
    {
        dostalPrezent[playerid][1] = DOF2_GetBool( USER_FILE( playerid ),"Dodatek");
        dostalPrezent[playerid][0] = DOF2_GetBool( USER_FILE( playerid ),"Kasa");
    }   
    else 
    {
        DOF2_CreateFile( USER_FILE ( playerid ) );
        DOF2_SetBool( USER_FILE ( playerid ), "Kasa", false); 
        DOF2_SetBool( USER_FILE ( playerid ), "Dodatek", false); 
        DOF2_SetInt( USER_FILE ( playerid ), "DodatekModel", 0); 
        DOF2_SetString( USER_FILE ( playerid ), "offsetXyz", "0.12|0.04|-0.0035"); 
        DOF2_SetString( USER_FILE ( playerid ), "rotXyz", "0|100|100"); 
        DOF2_SetString( USER_FILE ( playerid ), "scaleXyz", "1.4|1.4|1.4"); 
        DOF2_SaveFile();
    }
    DOF2_Exit();
    return true;
}
zaladujObiekt(playerid) {
    new model = DOF2_GetInt( USER_FILE( playerid ),"DodatekModel");
    new offsetXyz[32], rotXyz[32], scaleXyz[32];
    format(offsetXyz, sizeof(offsetXyz), "%s", DOF2_GetString(USER_FILE( playerid ), "offsetXyz"));
    format(rotXyz, sizeof(rotXyz), "%s", DOF2_GetString(USER_FILE( playerid ), "rotXyz"));
    format(scaleXyz, sizeof(scaleXyz), "%s", DOF2_GetString(USER_FILE( playerid ), "scaleXyz"));
    new Float:offset[3];
    new Float:rot[3];
    new Float:scale[3];
    sscanf(offsetXyz, "p<|>fff", offset[0], offset[1], offset[2]); 
    sscanf(rotXyz, "p<|>fff", rot[0], rot[1], rot[2]); 
    sscanf(scaleXyz, "p<|>fff", scale[0], scale[1], scale[2]); 
    SetPlayerAttachedObject(playerid, 9, model, 2, offset[0], offset[1], offset[2], rot[0], rot[1], rot[2], scale[0], scale[1], scale[2]);
}
CMD:swieta(playerid, params[]) {
    //ShowPlayerDialog(playerid, 4591, DIALOG_STYLE_LIST, "Menu ÅšwiÄ…teczne", "Co chcesz zrobiÄ‡?\n\n1. Ubierz Å›wiÄ…teczny dodatek\n2. Zdejmij Å›wiÄ…teczny dodatek\n3. Edytuj Å›wiÄ…teczny dodatek", "Dalej", "Anuluj");
    inline DLG_SWIETA_RESPONSE(pid, dialogid, response, listitem, string:inputtext[]) {
        #pragma unused pid, dialogid, inputtext
        if(!response) return 1;
        if(!dostalPrezent[playerid][1]) return SendClientMessage(playerid, COLOR_LAWNGREEN, "Niestety, nie uda³o Ci siê zdobyæ œwi¹tecznego prezentu");
        switch(listitem) {
            case 0: return Dialog_ShowCallback(playerid, using inline DLG_SWIETA_RESPONSE, DIALOG_STYLE_LIST, "Menu œwi¹teczne", "Co chcesz zrobiæ?\n1. Ubierz œwi¹teczny dodatek\n2. Zdejmij œwi¹teczny dodatek\n3. Edytuj œwi¹teczny dodatek", "Dalej", "Anuluj");
            case 1: {
                // ubierz dod
                if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) return SendClientMessage(playerid, COLOR_LAWNGREEN, "Posiadasz ju¿ na sobie œwi¹teczny dodatek!");
                zaladujObiekt(playerid);
            }
            case 2: {
                // usun dod
                if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) return 1;
                RemovePlayerAttachedObject(playerid, 9);
            }
            case 3: {
                // edytuj dod
                if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) return 1;
                EditAttachedObject(playerid, 9);
            }
        }
    }
    Dialog_ShowCallback(playerid, using inline DLG_SWIETA_RESPONSE, DIALOG_STYLE_LIST, "Menu œwi¹teczne", "Co chcesz zrobiæ?\n\t1. Ubierz œwi¹teczny dodatek\n\t2. Zdejmij œwi¹teczny dodatek\n\t3. Edytuj œwi¹teczny dodatek", "Dalej", "Anuluj");
    return 1;
}
public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(response)
    {
        if(fScaleX > 1.66 || fScaleY > 1.66 || fScaleZ > 1.66 || fScaleX < 1 || fScaleY < 1 || fScaleZ < 1) {
            RemovePlayerAttachedObject(playerid, 9);
            zaladujObiekt(playerid);
            return SendClientMessage(playerid, COLOR_LAWNGREEN, "Zmiany nie zosta³y zapisane, dodatek by³ zbyt du¿y lub zbyt ma³y!");
        }
        if(fOffsetX > 0.249998 || fOffsetY > 0.247999 || fOffsetZ > 0.216497 || fOffsetX < -0.029003 || fOffsetY < -0.163003 || fOffsetZ < -0.140502) {
            RemovePlayerAttachedObject(playerid, 9);
            zaladujObiekt(playerid);
            return SendClientMessage(playerid, COLOR_LAWNGREEN, "Zmiany nie zosta³y zapisane, dodatek by³ zbyt oddalony od gracza!");
        }
        new offsetXyz[32], rotXyz[32], scaleXyz[32];
        format(offsetXyz, sizeof(offsetXyz), "%f|%f|%f", fOffsetX, fOffsetY, fOffsetZ);
        format(rotXyz, sizeof(rotXyz), "%f|%f|%f", fRotX, fRotY, fRotZ);
        format(scaleXyz, sizeof(scaleXyz), "%f|%f|%f", fScaleX, fScaleY, fScaleZ);
        DOF2_SetString( USER_FILE ( playerid ), "offsetXyz", offsetXyz); 
        DOF2_SetString( USER_FILE ( playerid ), "rotXyz", rotXyz); 
        DOF2_SetString( USER_FILE ( playerid ), "scaleXyz", scaleXyz); 
        DOF2_SaveFile();
        RemovePlayerAttachedObject(playerid, 9);
        zaladujObiekt(playerid);
    }
    else
    {
        zaladujObiekt(playerid);
    }
    return 1;
}