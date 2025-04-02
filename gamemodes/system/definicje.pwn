//definicje.pwn

//#pragma tabsize 0 // <------------------------------------------nope

//wy³¹czenie sampowych metod obiektów
#define CreateObject(%0) ERROR_CREATE_OBJECT(%0)
#define DestroyObject(%0) ERROR_OBJECT
#undef IsValidObject
#define IsValidObject(%0) ERROR_OBJECT
#define MoveObject(%0) ERROR_OBJECT
#define StopObject(%0) ERROR_OBJECT
#define SetObjectPos(%0) ERROR_OBJECT
#define SetObjectRot(%0) ERROR_OBJECT
#define GetObjectPos(%0) ERROR_OBJECT
#define GetObjectRot(%0) ERROR_OBJECT
#define AttachObjectToPlayer(%0) ERROR_OBJECT
#undef  SetObjectMaterialText
#define SetObjectMaterialText(%0) ERROR_OBJECT
#undef  SetObjectMaterial
#define SetObjectMaterial(%0) ERROR_OBJECT

//------------------------------------------------------------------------------
//                              PVARS
//------------------------------------------------------------------------------
#define PVAR_PRZELEW_ID "przelej_id"

#define chrtoupper(%1) \
        (((%1) > 0x60 && (%1) <= 0x7A) ? ((%1) ^ 0x20) : (%1))

#define         MAX_VEHICLE_ID_CHANGES          3

//------------------------------------------------------------------------------
//                              MARKA
//------------------------------------------------------------------------------
#define PreloadAnimLib(%1,%2)   ApplyAnimation(%1,%2,"null",0.0,0,0,0,0,0)
#define Distance3D(%1,%2,%3,%4,%5,%6) (VectorSize(%1-%4,%2-%5,%3-%6))/100)
#define Distance3D2(%1,%2,%3,%4,%5,%6) (VectorSize(%1-%4,%2-%5,%3-%6))*1000.0)
//Keys
#define PRESSING(%0,%1) \
	(%0 & (%1))
#define PRESSED(%0) \
        (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define HOLDING(%0) \
    ((newkeys & (%0)) == (%0))

#define sendTipMessageFormat(%0,%1,%2) \
	(format(scm_buf, sizeof scm_buf, %1,%2), sendTipMessage(%0,scm_buf))
#define sendTipMessageFormatEx(%0,%1,%2,%3) \
	(format(scm_buf, sizeof scm_buf, %2,%3), sendTipMessageEx(%0,%1,scm_buf))	

//podgl¹d PW
#define MAX_SENT_MESSAGES 25

//salt
#define MAX_SERVER_SECRET_LENGTH 16
#define MAX_PASSWORD_LENGTH 64
#define SALT_LENGTH 16

//Œwiat anty czita ¿eby da³ porz¹dny desync graczowi aby ju¿ nic nie zjeba³ :D
#define AC_WORLD	50005


#define OSTATNIE_ZGLOSZENIA 10
#define OSTATNIE_ZGLOSZENIASASP 10

#define MOVE_SZPITAL_Z_NETA -12.0

#define MAX_MESSAGE_LENGTH 			144 		//maksymalna liczba znaków jaka mo¿e zostaæ wyœwietlona na ekranie
#define MAX_STREAM_LENGTH 			128			//maksymalna d³ugoœæ linku dla PlayAudioStreamForPlayer
#define BYTES_PER_CELL 				4 			//u¿ywane w SendClientMessageF
#define SPAM_PROTECTION_VALUE 		3 			//iloœæ dzia³añ które mo¿na wykonaæ przed w³¹czeniem ochrony antyspamowej 
#define COLOR_STRING_LENGTH			6			//d³ugoœæ ci¹gu znaków odpowiedzialna za kolor
#define NOT_FOUND					-1			//u¿ywane do strfind

#define BIKE_COST 30000
#define SANDKING_COST 250000
#define HOTRING_COST 500000
#define WODOLOT_COST 500000
//KB
#define MAX_MONEY_IN_BANK 100000000

//SKLEP
#define MRP_PREMIUM_TIME  2592000 // 30 dni
#define MRP_PREM_HOURS    15      //Ilosc godzin potrzebnych do przegrania

//Blink system by Kubi
#define BLINK_DISABLE_ON_EXIT_VEHICLE   1   // 0 - 1 = IF 1, blinks will be disabled when player exits his car with enabled, but still work for emergency blinks.
#define BLINK_ALLOW_EMERGENCY           1   // 0 - 1, allow player to enable emergency lights.
#define BLINK_TURN_ANGLE 55.0

//specshow
#define INVALID_SPECTATE_ID 9999

//adminjail
#define AJ_POSX 1481.1666259766
#define AJ_POSY -1790.2204589844
#define AJ_POSZ 156.7875213623
#define AJ_MAXRANGE 5.0

//sn
#define COST_SN_SMS_0 0
#define COST_SN_SMS_1 2500
#define COST_SN_SMS_2 5000
#define COST_SN_SMS_3 7500
#define COST_SN_SMS_4 10000
#define COST_SN_SMS_5 12500
#define MAX_LEVELINT 12

//sprunki i snacki
#define SPRUNK_COST 2000
//Inne:
#define TEAM_CYAN 1
#define TEAM_BLUE 2
#define TEAM_GREEN 3
#define TEAM_ORANGE 4
#define TEAM_COR 5
#define TEAM_BAR 6
#define TEAM_TAT 7
#define TEAM_CUN 8
#define TEAM_STR 9
#define TEAM_HIT 10
#define TEAM_ADMIN 11
#define MAX_ZONE_NAME 28
#define MAX_GF_LAG 124

//Limity:
#define MAX_ORG     50
#define MAX_STRING2 255
//#define MAX_CHATBUBBLE_LENGTH 144
#define MAX_3DTEXT 1024
#define MAX_DOM 3000
#define MAX_NrDOM 53
#define MAX_REMOVED_OBJECTS 100
#define GasMax 100
#define RunOutTime 15000
#define RefuelWait 5000
#define CAR_AMOUNT 2000 //Maksymalna iloœæ wozów
#define ILOSC_AUT 483
#define MAX_CHECKPOINTS 51

//
#define LEADERS_TYPES 3
#define LEADER_FRAC 1
#define LEADER_FAM 2
#define CENA_POZWOLENIE 35000
#define CENA_POZWOLENIE_ZYSK 15000
#define CENA_POZWOLENIE_SEJF 20000
//Kary:
#define KARA_BAN 1
#define KARA_BLOCK 2
#define KARA_WARN 3
#define KARA_AJ 4

#define SCENA_NEON_OFFSET_X -2.55
#define SCENA_NEON_OFFSET_Y 8.0
#define SCENA_NEON_OFFSET_Z 0.12630

//system barierek by Kubi
#define TOTAL_ITEMS         12
#define SELECTION_ITEMS     4
#define ITEMS_PER_LINE      2

#define HEADER_TEXT "Barierki"
#define NEXT_TEXT   ">"
#define PREV_TEXT   "<"

#define DIALOG_BASE_X   	235.0
#define DIALOG_BASE_Y   	100.0
#define DIALOG_WIDTH    	405.0
#define DIALOG_HEIGHT   	180.0
#define SPRITE_DIM_X    	60.0
#define SPRITE_DIM_Y    	60.0

//Stanowe Dywan
#define NG_BOUNDS_minX 2681.5181
#define NG_BOUNDS_minY -2714.9104
#define NG_BOUNDS_maxX 2809.2007
#define NG_BOUNDS_maxY -2330.6167

#define MAX_DOORS   20 //tymczasowe

//13.06.2014
#define FRAC_NONE   0
#define FRAC_LSPD   1
#define FRAC_FBI    2
#define FRAC_NG     3
#define FRAC_ERS    4
#define FRAC_LCN    5 // usuniête, zosta³o dla bram
//#define FRAC_YKZ  6 // usuniête
#define FRAC_BOR    7
#define FRAC_HA     8
#define FRAC_SN     9
#define FRAC_KT     10
#define FRAC_GOV    11
#define SPOILER_D   200000
#define ZDERZAK_D   250000
#define FELGA_D     250000
#define NITRO_D     500000
#define HYDRA_D     250000

//2015.09.12
#define TAJNIAK_FBI		0
#define TAJNIAK_GROOVE	1
#define TAJNIAK_BALLAS	2
#define TAJNIAK_LCN		3
#define TAJNIAK_YKZ		4
#define TAJNIAK_VAGOS	5
#define TAJNIAK_CYWIL	6

//15.06
#define WARN_UNBAN          21
#define WARN_UNBLOCK        22
#define WARN_BAN            2
#define WARN_BLOCK          1

//-----------------------------------------------------------------------------
//                              PLOCAL
//-----------------------------------------------------------------------------
//Spis wszystkich pLocali.

//=======[FRAKCJE]===========
#define PLOCAL_FRAC_DMV 108
#define PLOCAL_FRAC_FBI 212
#define PLOCAL_FRAC_LSPD 254
#define PLOCAL_FRAC_LSMC 253

//======[RODZINNE]==========
#define PLOCAL_ORG_BONEHEAD 240
#define PLOCAL_ORG_SN 241

//======[INNE]=============
#define PLOCAL_INNE_BANK 103
#define PLOCAL_DEFAULT 255
//------------------------------------------------------------------------------
//                              UPRAWNIENIA
//------------------------------------------------------------------------------
//18.06 uprawniania do panelu kar
#define ACCESS_PANEL            0b1 //G³ówny panel administracji
#define ACCESS_KARY             0b10 //G³owny panel kar

#define ACCESS_KARY_ZNAJDZ      0b100 //Search
#define ACCESS_KARY_UNBAN       0b1000 //Unban
#define ACCESS_KARY_BAN         0b10000 //Ban
#define ACCESS_ZG               0b100000
#define ACCESS_MAKEFAMILY       0b1000000
#define ACCESS_MAKELEADER       0b10000000
#define ACCESS_EDITPERM         0b100000000
#define ACCESS_EDITCAR          0b1000000000
#define ACCESS_EDITRANG         0b10000000000
#define ACCESS_GIVEHALF         0b100000000000
#define ACCESS_DELETEORG        0b1000000000000
#define ACCESS_SKRYPTER         0b10000000000000 //14 bit

#define ACCESS_OWNER            0b111111111111111

//------------------------------------------------------------------------------
//                              DIALOGI
//------------------------------------------------------------------------------
#define DIALOG_EMPTY_SC 1142
#define DIALOG_LIST 1
#define DIALOG_MSGBOX 2
#define DIALOG_PASSWORD 3
#define DIALOG_INPUT 4
#define DIALOG_HELP 5
/* 6-9 oraz 11-12 puste */
#define DIALOG_FLYMODEHELP 10
#define DIALOG_INFOTYPE 13
#define DIALOG_INFOVEHICLE 14
#define D_PJTEST    251
#define D_ANIMLIST  15621
#define D_LOGIN     230
#define D_REGISTER  231

#define D_ELEVATOR_USSS         179
#define D_ELEVATOR_LSMC         180
#define D_OPIS                  181
#define D_OPIS_UPDATE           182
#define D_VEHOPIS               183
#define D_VEHOPIS_UPDATE        184
#define WINDA_SAN               120
#define WINDA_LSPD              300

#define D_AUTO                  499
#define D_AUTO_ACTION           500
#define D_AUTO_RESPAWN          7780
#define D_AUTO_UNSPAWN          7781
#define D_AUTO_REJESTRACJA      7783
#define D_AUTO_RESPRAY          33
#define D_AUTO_RESPRAY2         34
#define D_AUTO_RESPRAY_OWN      37
#define D_AUTO_RESPRAY_OWN2     38
#define D_AUTO_DESTROY          303
#define D_AUTO_ACTION_TUNING    304

#define D_INFO      712
#define D_PERM      713
#define D_SERVERINFO 715

#define D_PANEL_ADMINA          1000
#define D_PANEL_KAR             1100

#define D_PANEL_KAR_NADAJ       1101
#define D_PANEL_KAR_BANIP       1102
#define D_PANEL_KAR_BANNICK     1103
#define D_PANEL_KARY_POWOD      1104
#define D_PANEL_KAR_ZNAJDZ      1105
#define D_PANEL_KAR_UNBANIP     1106
#define D_PANEL_KAR_UNBANNICK   1107
#define D_PANEL_KAR_ZNAJDZIP    1108
#define D_PANEL_KAR_ZNAJDZNICK  1109
#define D_PANEL_KAR_ZDEJMIJ     1110
#define D_PANEL_KAR_ZNAJDZ_INFO 1111

#define D_DODATKI_TYP           1120

#define D_PANEL_CHECKPLAYER     1211

#define D_WINDA_LSFD        1212
#define D_SUPPORT_LIST      1214

#define D_ORGS              1255

#define D_CREATE            1260
#define D_EDIT              1261

#define D_EDIT_CAR          1309
#define D_EDIT_CAR_MENU     1310
#define D_EDIT_CAR_MODEL    1311
#define D_EDIT_CAR_OWNER    1312
#define D_EDIT_CAR_RANG     1313
#define D_EDIT_CAR_OWNER_SET 1314
#define D_EDIT_CAR_OWNER_APPLY 1315
#define D_EDIT_RANG         1316
#define D_EDIT_RANG_2       1317
#define D_EDIT_RANG_SET     1318
#define D_EDIT_RANG_NAME    1319
#define D_EDIT_CAR_COLOR    1320
#define D_ASK_DODATKI       1321
#define DIALOG_LIDER01 3001
#define DIALOG_LIDER02 3002

#define DIALOGID_MUZYKA		3240
#define DIALOGID_MUZYKA_URL	3241
#define DIALOGID_MUZYKA_VC	3242

#define DIALOG_HA_ZMIENSKIN(%0)			3345+%0
#define DIALOGID_UNIFORM_FRAKCJA        3445
#define DIALOGID_UNIFORM_FAMILY         3446

#define D_F_PANEL			5000+1

#define DIALOG_KONSOLA_VINYL    5230
#define DIALOG_EOSWIETLENIE     5232
#define DIALOG_ELEVATOR_SAD     5234
#define DIALOG_PATROL           5236
#define DIALOG_PATROL_NAME      5237
#define DIALOG_PATROL_PARTNER   5238
#define D_PRZEBIERZ_FDU         5241

#define MAX_LEADERS_ON_FRAC 10


#define D_HASLO_INFO 5245
#define D_HASLO_ZMIEN 5246

#define D_TRANSPORT         5439
#define D_TRANSPORT_FAST    5440
#define D_TRANSPORT_LIST    5441
#define D_TRANSPORT_ACCEPT  5442

#define D_PERSONALIZE 5511
#define D_PERS_ADMIN 5513
#define D_PERS_CHAT 5514
#define D_PERS_VEH 5512
#define D_PERS_INNE 5515

#define D_BIZ_WRITE 5516

#define D_VINYL_B 5520
#define D_VINYL 5521
#define D_VINYL_K 5522
#define D_VINYL_TEKST 5523
#define D_VINYL_NEON 5524
#define D_VINYL_J 5525
#define D_VINYL_CAM 5526


#define SCENA_DIALOG_MAIN       5998
#define SCENA_DIALOG_CREATE     5999
#define SCENA_DIALOG_EFEKTY     6000
#define SCENA_DIALOG_EFEKTY_TYP 6001
#define SCENA_DIALOG_EFEKTY_COUNT 6002
#define SCENA_DIALOG_EFEKTY_DELAY 6003
#define SCENA_DIALOG_EKRAN      6010
#define SCENA_DIALOG_EKRAN_TYP  6011
#define SCENA_DIALOG_EKRAN_EFEKT    6012
#define SCENA_DIALOG_EKRAN_EXTRA    6013
#define SCENA_DIALOG_NEONY      6020
#define SCENA_DIALOG_NEON_EFEKT 6021
#define SCENA_DIALOG_NEON_DELAY 6022
#define SCENA_DIALOG_NEON_COUNT 6023
#define SCENA_DIALOG_NEON_KOLORY    6024
#define SCENA_DIALOG_AUDIO      6030
#define SCENA_DIALOG_GETMONEY 6031
#define DIALOG_UNFRAKCJA 6032
#define DIALOG_KUPSKIN 6033

#define D_UNIFORM_LCN   7005
#define D_UNIFORM_RSC   7114

#define D_PREMIUM       10001
#define D_P_SALES 10002
#define D_PREMIUM_BUY   10003
#define D_P_CARS        10004

#define D_KONTAKTY_DZWON				10100
#define D_KONTAKTY_SMS					10101
#define D_KONTAKTY_SMS_WIADOMOSC		10102
#define D_KONTAKTY_EDYTUJ				10103
#define D_KONTAKTY_EDYTUJ_NOWA_NAZWA	10104
#define D_KONTAKTY_USUN					10105
#define D_KONTAKTY_LISTA				10106

#define D_ERS_SPRZEDAZ_APTECZKI			10107
#define D_UZYCIE_APTECZKI			    10108
#define D_PRZEDMIOTY_BRONIE			    10109

#define D_ORGMEMBER                     10111
#define D_ORGMEMBER_RANK                10112

//------------------------------------------------------------------------------
//                              INNE
//------------------------------------------------------------------------------

#define HTTP_SEND_LOGS  600

#define TEXT_D_PANEL_KARY "Nadaj karê\nZdejmij karê\nWyszukiwanie danych gracza"
#define TEXT_D_PANEL_LOGOW "-------------[IC]-------------\nCK.log\nNICK.log\nPAY.log\n-------------[STATS]-------------\nSETSTATS.log\n-------------[ADMIN]-------------\nBAN.log\nCZIT.log\nKICK.log\nWARN.log\nWARNING.log\n-------------[Special]-------------\nMySQL"

//bugozord
#define MAX_KONTAKTY	10
#define MAX_KONTAKT_NAME 32
#define MAX_KONTAKT_NAME_1 33 //MAX_KONTAKT_NAME+1

//22.06
#define MAX_FRAC        20
#define MAX_RANG        10
#define MAX_RANG_LEN    25

//13.07
#define MAX_SKIN_SELECT     100
#define JOB_SKIN_HOVERCOLOR 0x07B5EBFF    //Kolor zaznaczenia skinów
//22.07

//25.07
#define MAX_ZONES   65
#define ZONE_COLOR_GROOVE 0x00B90000
#define ZONE_COLOR_BALLAZ 0xC2000000
#define ZONE_COLOR_VAGOS 0xDFD32800
#define ZONE_COLOR_WPS 0x5BCFE600
//13.08 fly data
// Players Move Speed
#define MOVE_SPEED              100.0
#define ACCEL_RATE              0.03

// Players Mode
#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

// Key state definitions
#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8
//23.08 poprawki LSPD oraz kolczatki z aut
#define MAX_KOLCZATEK   100
#define KOLCZATKA_CZAS  60 //sek
//24.08 poprawki lspd i dodatki
#define MAX_PATROLS     22
//19.09
#define MAX_OILS        100
#define OIL_MAX_HEALTH  80
//30.10 nowa praca
#define TJD_PLACE_X (0.89105)
#define TJD_PLACE_MAX_Y (1.2)
#define TJD_PLACE_MIN_Y (-6.0)
#define TJD_PLACE_Z (0.48040)
#define TJD_LOADUNLOAD_TIME 1000

#define MAX_BOOMBOX         15
#define MAX_BBD_DISTANCE    25.0

//14.11
#define MAX_CARS        100000
#define MAX_CAR_SLOT    10
#define INVALID_CAR_OWNER   0
#define CAR_OWNER_FRACTION  1
#define CAR_OWNER_FAMILY    2
#define CAR_OWNER_PLAYER    3
#define CAR_OWNER_JOB       4
#define CAR_OWNER_SPECIAL   5
#define CAR_OWNER_PUBLIC    6
#define CAR_OWNER_STEAL     7

//Czêœci cia³a
#define BONE_HEAD 2
#define BONE_RIGHT_ARM 4
#define BONE_LEFT_ARM 3
#define BONE_LEFT_HAND 5
#define BONE_RIGHT_HAND 6
#define BONE_SPINE 1
#define BONE_NECK 17
#define BONE_LEFT_FOREARM 13
#define BONE_RIGHT_FOREARM 14

//Auta specjalne
#define RENT_CAR        1
#define GO_KART         2
#define CAR_ZUZEL       3
#define CAR_SMUGGLING   4

#define CAR_SAVE_OWNER      1
#define CAR_SAVE_STATE      2
#define CAR_SAVE_TUNE       3
#define CAR_SAVE_ALL        0

//23.12
#define MAX_TICKETS     50

//Telefon
#define EMERGENCY_NUMBERS -900 
#define POLICE_NUMBER -901 //old 912
#define SHERIFF_NUMBER -917 //old 928
#define LSMC_NUMBER -904 //old 914
#define LSFD_NUMBER -903 //old 916

#define CALL_NONE 0
#define CALL_EMERGENCY 1
#define CALL_PLAYER 2
#define CALL_LIVE 3

//Okienka
#define OKIENKO_DMV_RANGE 2

//AJ powód
#define MAX_AJ_REASON 64

#define NICK_REGEX "^[A-Z][a-z]+([A-Z][a-z]+)?(_[A-Z][a-z]+([A-Z][a-z]+)?){1,2}$"

// Y_SAFERETURN ! ! !
forward _SafeReturnCode_(dest[], src[], bytes);
public _SafeReturnCode_(dest[], src[], bytes)
{
    memcpy(dest, src, 0, bytes, bytes);
}

SafeReturnCode(const src[], const bytes = sizeof (src))
{
    // Push the lengths for the memcpy (needs "pri", so done first).
    #emit LOAD.S.pri    bytes
    #emit SHL.C.pri     2
    #emit PUSH.pri
    #emit PUSH.pri
   
    // Get the parameter count.
    #emit LOAD.S.pri    0
    #emit MOVE.alt
    #emit ADD.C         8
    #emit LOAD.I
   
    // Get the desination pointer.
    #emit ADD
    #emit ADD.C         12
    #emit LOAD.I
   
    // Do a raw memcpy (pointer to pointer, not array to array).
    #emit PUSH.C        0
    #emit PUSH.S        src
    #emit PUSH.pri
    #emit PUSH.C        20
    #emit SYSREQ.C      memcpy
   
    // Return to the caller's caller.
    #emit MOVE.pri
    #emit SCTRL         5
    #emit SCTRL         4
    #emit RETN
   
    // Compiler cleanup.
    return 0;
}

#define safe_return%0; return SafeReturnCode(%0),(%0);
//EOF
