//zombiescript.pwn

//-------------------------------------------<< Filterscript >>----------------------------------------------//
//---------------------------------------[ Modu³: zombiescript.pwn ]-----------------------------------------//
//Autor:
/*
    Simeone & KamilPolska
*/
//Opis:
/*
	Skrypt na 10 lecie Mrucznik Role Play
*/
//Adnotacje:
/*

*/
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

//
//
//-----------------<[ Includes: ]>-------------------
#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <foreach>
#include <streamer>
#include <crashdetect>

//-----------------<[ Define: ]>------------------
#define COLOR_WHITE -1
#define COLOR_GREEN 0x80FF00FF
#define COLOR_RED 0xFF2F2FFF
#define COLOR_GRAD 0xC0C0C0FF

#define INVALID_PZOMBIE 9999			//Wartoœæ, która definiuje czy jesteœmy uczestnikiem zabawy

//POZYCJE
#define POS_ENTER_X 1239.4888			//Pozycja wejœcia do zabawy [X]
#define POS_ENTER_Y 108.5179			//Pozycja wejœcia do zabawy [Y]
#define POS_ENTER_Z 20.7044				//Pozycja wejœcia do zabawy [Z]

//cfg
#define ZOMBIE_VW 666					//VW, w którym odbywa siê zabawa
#define DRAW_DIST_ANTIDOTE 10.0			//Odleg³oœæ w jakiej zobaczymy tekst [antidote]
#define CMD_DIST_ANTIDOTE 4.0			//Odleg³oœæ w jakiej bêdziemy mogli u¿yæ antidotum

//-----------------<[ Zmienne: ]>----------------------
new playerAccessToFS[MAX_PLAYERS];		//Ma dostêp do FS [Owner]
new PlayerZombieStatus[MAX_PLAYERS];	//Jest zombie/zara¿ony/zdrowy
new PlayerEventPoint[MAX_PLAYERS];		//Iloœæ punktów w zabawie
new AlivePlayers;						//Pozostali ¿ywi gracze
new ZarazonyTimer[MAX_PLAYERS];			//Timer zara¿enia
new zarazonyTime[MAX_PLAYERS];			//Czas, który mamy do przemiany w zombie
new togParty[MAX_PLAYERS];				//Wyciszenie komunikatów z zabawy
new zabawaStatus;						//Zabawa trwa - TAK/NIE
new dostalSkina[MAX_PLAYERS];			//Dosta³ skina zombie (?)
new memberTimer[MAX_PLAYERS];			//Timer cz³onka zabawy
new antidoteObject[4];					//Obiekty antidotum
new Text3D:antidoteText[4];				//3DTEXTY antidotum
new antidoteUse[4];						//Czy antidotum by³o u¿yte?
//new firstSkinID[MAX_PLAYERS];			//Skin ID
new zabawaON;

//
new TimerWIN;

//textdrawy
new PlayerText:background[MAX_PLAYERS];
//new PlayerText:skinTXD[MAX_PLAYERS];
new PlayerText:text1[MAX_PLAYERS];
new PlayerText:text2[MAX_PLAYERS];
new PlayerText:text3[MAX_PLAYERS];
new PlayerText:text4[MAX_PLAYERS];
new Float:randomPosX[] = {
    1253.9366,
    1292.8315,
    1235.9202,
    1201.6737,
    1364.3694
};
new Float:randomPosY[] = {
    243.5145,
    297.3273,
    307.8629,
    222.1593,
    181.1181
};
new Float:randomPosZ[] = {
    19.5547,
    27.5555,
    24.7578,
    19.5547,
    19.5547
};

//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
    print("\n--------------------------------------");
    print(" Fliterscript 'zombiescript' zaladowany");
    print("--------------------------------------\n");
    CreateDynamic3DTextLabel("Aby wejsc na event wpisz {FF00FF}/dolaczzombie", COLOR_WHITE, POS_ENTER_X, POS_ENTER_Y, POS_ENTER_Z, 10.0, INVALID_PLAYER_ID,  INVALID_VEHICLE_ID,  0, -1, -1, -1);
	StworzObiektyZombie(); 
    return 1;
}

public OnFilterScriptExit()
{
    print("\n--------------------------------------");
    print(" Fliterscript 'zombiescript' wylaczony");
    print("--------------------------------------\n");
    return 1;
}

public OnPlayerConnect(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "Na serwerze znajduje siê skrypt: ZOMBIE APOCALYPSE!");
    SendClientMessage(playerid, COLOR_GRAD, "Weso³ego 10-lecia serwera Mrucznik Role Play!");
    PlayerZombieStatus[playerid] = INVALID_PZOMBIE;
    playerAccessToFS[playerid] = 0;
    PlayerEventPoint[playerid] = 0;
    togParty[playerid] = 0;
    dostalSkina[playerid] = 0;

    //TABELA
    background[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 165.000000, "_");
    PlayerTextDrawFont(playerid, background[playerid], 1);
    PlayerTextDrawLetterSize(playerid, background[playerid], -0.554166, 6.849999);
    PlayerTextDrawTextSize(playerid, background[playerid], 105.000000, 7.000000);
    PlayerTextDrawSetOutline(playerid, background[playerid], 1);
    PlayerTextDrawSetShadow(playerid, background[playerid], 0);
    PlayerTextDrawAlignment(playerid, background[playerid], 1);
    PlayerTextDrawColor(playerid, background[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, background[playerid], 255);
    PlayerTextDrawBoxColor(playerid, background[playerid], 205);
    PlayerTextDrawUseBox(playerid, background[playerid], 1);
    PlayerTextDrawSetProportional(playerid, background[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, background[playerid], 0);

    /*skinTXD[playerid] = CreatePlayerTextDraw(playerid, 46.000000, 114.000000, "_");
    PlayerTextDrawFont(playerid, skinTXD[playerid], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawLetterSize(playerid, skinTXD[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, skinTXD[playerid], 102.000000, 87.000000);
    PlayerTextDrawSetOutline(playerid, skinTXD[playerid], 1);
    PlayerTextDrawSetShadow(playerid, skinTXD[playerid], 0);
    PlayerTextDrawAlignment(playerid, skinTXD[playerid], 1);
    PlayerTextDrawColor(playerid, skinTXD[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, skinTXD[playerid], 0);
    PlayerTextDrawBoxColor(playerid, skinTXD[playerid], 5);
    PlayerTextDrawUseBox(playerid, skinTXD[playerid], 1);
    PlayerTextDrawSetProportional(playerid, skinTXD[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, skinTXD[playerid], 0);
    PlayerTextDrawSetPreviewModel(playerid, skinTXD[playerid], 20004);
    PlayerTextDrawSetPreviewRot(playerid, skinTXD[playerid], -10.000000, 0.000000, -20.000000, 1.000000);
    PlayerTextDrawSetPreviewVehCol(playerid, skinTXD[playerid], 1, 1);*/

    text1[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 166.000000, "Mrucznik Role Play");
    PlayerTextDrawFont(playerid, text1[playerid], 1);
    PlayerTextDrawLetterSize(playerid, text1[playerid], 0.250000, 1.750000);
    PlayerTextDrawTextSize(playerid, text1[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, text1[playerid], 1);
    PlayerTextDrawSetShadow(playerid, text1[playerid], 0);
    PlayerTextDrawAlignment(playerid, text1[playerid], 1);
    PlayerTextDrawColor(playerid, text1[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, text1[playerid], 0);
    PlayerTextDrawBoxColor(playerid, text1[playerid], 0);
    PlayerTextDrawUseBox(playerid, text1[playerid], 1);
    PlayerTextDrawSetProportional(playerid, text1[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, text1[playerid], 0);

    text2[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 182.000000, "~g~Zdrowy");
    PlayerTextDrawFont(playerid, text2[playerid], 1);
    PlayerTextDrawLetterSize(playerid, text2[playerid], 0.250000, 1.750000);
    PlayerTextDrawTextSize(playerid, text2[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, text2[playerid], 1);
    PlayerTextDrawSetShadow(playerid, text2[playerid], 0);
    PlayerTextDrawAlignment(playerid, text2[playerid], 1);
    PlayerTextDrawColor(playerid, text2[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, text2[playerid], 0);
    PlayerTextDrawBoxColor(playerid, text2[playerid], 0);
    PlayerTextDrawUseBox(playerid, text2[playerid], 1);
    PlayerTextDrawSetProportional(playerid, text2[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, text2[playerid], 0);

    text3[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 197.000000, "~y~Score: ~w~69");
    PlayerTextDrawFont(playerid, text3[playerid], 1);
    PlayerTextDrawLetterSize(playerid, text3[playerid], 0.250000, 1.750000);
    PlayerTextDrawTextSize(playerid, text3[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, text3[playerid], 1);
    PlayerTextDrawSetShadow(playerid, text3[playerid], 0);
    PlayerTextDrawAlignment(playerid, text3[playerid], 1);
    PlayerTextDrawColor(playerid, text3[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, text3[playerid], 0);
    PlayerTextDrawBoxColor(playerid, text3[playerid], 0);
    PlayerTextDrawUseBox(playerid, text3[playerid], 1);
    PlayerTextDrawSetProportional(playerid, text3[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, text3[playerid], 0);

    text4[playerid] = CreatePlayerTextDraw(playerid, 6.000000, 210.000000, "~y~Pozostali: ~w~10");
    PlayerTextDrawFont(playerid, text4[playerid], 1);
    PlayerTextDrawLetterSize(playerid, text4[playerid], 0.250000, 1.750000);
    PlayerTextDrawTextSize(playerid, text4[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, text4[playerid], 1);
    PlayerTextDrawSetShadow(playerid, text4[playerid], 0);
    PlayerTextDrawAlignment(playerid, text4[playerid], 1);
    PlayerTextDrawColor(playerid, text4[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, text4[playerid], 0);
    PlayerTextDrawBoxColor(playerid, text4[playerid], 0);
    PlayerTextDrawUseBox(playerid, text4[playerid], 1);
    PlayerTextDrawSetProportional(playerid, text4[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, text4[playerid], 0);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(PlayerZombieStatus[playerid] == 0)
	{
		AlivePlayers--;
	}
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(PlayerZombieStatus[playerid] == 2)
	{
		if(damagedid != playerid)
		{
			if(weaponid != 0)
            {
                SendClientMessage(playerid, COLOR_WHITE, "Nie mo¿esz u¿ywaæ innej broni - TYLKO piêœci");
                new Float:pX, Float:pY, Float:pZ;
                GetPlayerPos(playerid, pX, pY, pZ);
                SetPlayerPos(playerid, pX, pY, pZ+5);
                return 1;
            }
			if(PlayerZombieStatus[damagedid] == INVALID_PZOMBIE)
			{
				SendClientMessage(playerid, COLOR_RED, "Ta osoba nie uczestniczy w zabawie!");
				return 1;
			}
			if(PlayerZombieStatus[damagedid] == 0 || PlayerZombieStatus[damagedid] == 1 || PlayerZombieStatus[damagedid] == 2)
			{
				SendClientMessage(playerid, COLOR_RED, "Nie mo¿esz biæ swojego, zostaje Ci odjêty punkt w zabawie!");
				GetPointsFromPlayer(playerid, 1);
				return 1;
			}
		}
	}
	return 0;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    new string[256];
    if(PlayerZombieStatus[issuerid] == 2)
    {
        if(issuerid != playerid)
        {
            if(PlayerZombieStatus[playerid] == 0)
            {
                PlayerZombieStatus[playerid] = 1;
                SendClientMessage(playerid, COLOR_GRAD, "Oberwa³eœ od Zombie! Stajesz siê zara¿ony, postaraj siê znaleŸæ odtrutkê!");
                SendClientMessage(playerid, COLOR_GRAD, "Masz na to 2 minuty!");

                UpdateTableForPlayer(playerid);

                format(string, sizeof(string), "Uda³o Ci siê zaraziæ %s, uderz go jeszcze raz aby sta³ siê Zombie!", GetName(playerid));
                SendClientMessage(issuerid, COLOR_GREEN, string);
                SendClientMessage(issuerid, COLOR_GRAD, "Otrzymujesz 1 punkt w zabawie!");
                AddPointsToPlayer(issuerid, 1);
                ZarazonyTimer[playerid] = SetTimerEx("TimerZarazony", 5000, true, "d", playerid);
            }
            else if(PlayerZombieStatus[playerid] == 1)
            {
                PlayerZombieStatus[playerid] = 2;
                SendClientMessage(playerid, COLOR_GRAD, "Oberwa³eœ drugi raz! Stajesz siê zombie!");
                SendClientMessage(playerid, COLOR_GRAD, "Biegaj i bij innych, aby zamieniæ ich w zombie");
                AlivePlayers--;

                UpdateTableForAll(playerid);

                SendClientMessage(issuerid, COLOR_GRAD, "Zamieni³eœ gracza w zombie, otrzymujesz 2 punkty w zabawie!");
                AddPointsToPlayer(issuerid, 2);
            }
        }
    }
    return 0;
}

//-----------------<[ Timery: ]>-------------------
forward partyMember(playerid);
public partyMember(playerid)
{
    if(dostalSkina[playerid] == 0)
    {
        if(PlayerZombieStatus[playerid] == 2)
        {
            new rand = random(3);
            new pDeathSkin = 20004+rand;
            SetPlayerSkin(playerid, pDeathSkin);
            dostalSkina[playerid] = 1;
        }
    }
    UpdateTableForAll(playerid);
}

forward TimerZarazony(playerid);
public TimerZarazony(playerid)
{
    zarazonyTime[playerid]++;
    if(zarazonyTime[playerid] == 36)
    {
        PlayerZombieStatus[playerid] = 2;
        SendClientMessage(playerid, COLOR_RED, "Nie znalaz³eœ odtrutki! Stajesz siê zombie");
        AlivePlayers--;
        UpdateTableForAll(playerid);
    }
}

//-----------------<[ Funkcje: ]>-------------------
/*stock GetPlayerSkinEx(playerid)
{
	new value = GetPlayerSkin(playerid);
	if(value == 0)
	{
		value = GetPlayerCustomSkin(playerid); 
	}
	return value; 
}*/ 

StworzObiektyZombie()
{
    new tmpobjid;
    tmpobjid = CreateDynamicObject(19445, 1161.118164, 111.840507, 34.716670, 0.000000, 0.000000, 50.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1159.992065, 127.624076, 33.441940, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1160.042968, 231.165390, 28.373409, 0.000000, 0.000000, 1.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1161.530883, 223.344329, 28.282117, 0.000000, 0.000000, 30.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(1683, 1356.918701, 218.608245, 23.246263, 0.000000, 43.600006, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 16644, "a51_detailstuff", "roucghstonebrtb", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1159.540161, 236.182296, 27.512144, 0.000000, 0.000000, 6.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1365.216552, 245.550476, 21.566932, 0.000000, 0.000000, 62.699993, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1362.957519, 249.939758, 21.516931, 0.000000, 0.000000, -20.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    tmpobjid = CreateDynamicObject(19445, 1366.108032, 253.704574, 21.105136, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 19297, "matlights", "invisible", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(987, 1232.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1244.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1256.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1268.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1280.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1292.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1304.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1316.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1328.015747, 111.353874, 19.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1328.015747, 123.353874, 19.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1328.015747, 135.353881, 19.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1328.015747, 147.353881, 19.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1328.015747, 159.353881, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1340.015747, 159.353881, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1352.015747, 159.353881, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1364.015747, 159.353881, 18.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1376.015747, 159.353881, 18.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1376.015747, 171.353881, 18.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1376.015747, 183.353881, 18.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1376.015747, 195.353881, 18.467983, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1376.015747, 207.353881, 18.467983, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1381.014160, 218.177291, 18.467983, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1386.038574, 228.953460, 18.467983, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1391.088623, 239.783950, 18.467983, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1396.112426, 250.560134, 18.467983, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1400.583984, 260.149108, 18.467983, 0.000000, 0.000000, 65.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1220.015747, 111.353874, 19.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 111.353874, 20.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1196.015747, 111.353874, 21.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1184.015747, 111.353874, 23.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1172.015747, 111.353874, 25.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 111.353874, 27.467983, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1257.247070, 204.304275, 17.927408, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 123.353874, 27.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 135.353881, 25.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 147.353881, 25.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 159.353881, 25.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 171.353881, 24.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 183.353881, 23.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 195.353881, 23.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1256.887207, 201.074249, 17.927408, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1256.206909, 200.014282, 17.927408, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1259.377075, 207.004302, 17.927408, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1260.167358, 208.484298, 17.927408, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 207.353881, 22.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 219.353881, 21.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 231.353881, 21.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1222.074829, 219.353805, 19.046247, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 243.353881, 20.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1217.624877, 213.213821, 19.046247, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 255.353881, 19.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 267.353881, 19.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 279.353881, 18.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 291.353881, 17.467983, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1189.340332, 282.300384, 18.794145, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1160.015747, 291.353881, 17.467983, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1172.015747, 291.353881, 17.467983, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1184.015747, 291.353881, 17.467983, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1196.015747, 291.353881, 17.467983, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 303.053863, 17.467983, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 315.053863, 17.467983, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 327.053863, 17.467983, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 339.053863, 17.467983, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 351.053863, 17.467983, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1208.015747, 363.053863, 17.467983, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1218.926025, 357.890686, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1229.739501, 352.848602, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1240.551635, 347.807006, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1251.409790, 342.743804, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1262.259155, 337.684936, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1273.044677, 332.655822, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1283.911254, 327.588684, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(10009, 1265.764526, 319.283172, 18.554687, 0.000000, 0.000000, -125.799957, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1294.651489, 322.580535, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1305.437133, 317.551422, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1316.276611, 312.496673, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1327.044311, 307.475952, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1337.893554, 302.417114, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1348.724609, 297.366729, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1359.546630, 292.320434, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1370.214355, 287.346038, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1381.099243, 282.270233, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1391.983764, 277.194641, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1310.220458, 305.800781, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1401.500488, 272.757019, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1314.094482, 288.904113, 18.826259, -0.100000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(987, 1405.912719, 270.699157, 17.467983, 0.000000, 0.000000, 875.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1296.977172, 270.339477, 18.666255, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1301.946044, 246.695571, 18.657602, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1277.599975, 236.535476, 18.814691, 0.800000, 0.699998, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1279.122314, 225.493637, 18.706253, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1279.015380, 226.538375, 18.676254, 0.399998, 0.000000, 55.799980, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1267.242553, 212.003341, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1267.608886, 186.747589, 18.414049, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1256.291870, 194.508544, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1252.783569, 196.786224, 19.152563, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1280.847534, 201.010559, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1275.374511, 209.729080, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1291.148193, 218.206573, 18.561449, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1277.570678, 231.720336, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1243.402099, 205.968322, 17.964687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1297.033203, 244.256332, 18.389692, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1284.439208, 251.267120, 18.411142, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1314.645751, 238.607559, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1325.834228, 222.283340, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1244.752929, 205.338348, 17.964687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1352.786499, 237.900375, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1357.489746, 251.024841, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1366.937011, 253.726119, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18688, 1246.752929, 204.618362, 17.964687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1375.217895, 270.377593, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1356.815185, 289.167236, 18.406530, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1344.400878, 282.466949, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1339.183105, 288.329010, 18.561452, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3593, 1342.627563, 281.017303, 18.929571, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1343.785644, 258.094146, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1334.014648, 252.488586, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2780, 1244.798828, 207.423110, 14.384680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1304.462890, 252.233840, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1303.940795, 265.473358, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1297.789184, 288.915191, 18.546890, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1315.838500, 302.999481, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3594, 1299.962768, 315.430419, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1306.744750, 301.998596, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1305.419433, 281.241271, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1296.087524, 265.696868, 18.411476, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2780, 1256.534179, 205.770126, 16.744037, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1284.991577, 255.687637, 18.404657, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1268.930786, 255.177093, 18.408695, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1268.432861, 266.973022, 18.546892, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1251.775756, 264.672149, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1238.544921, 264.116882, 18.408666, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1227.412841, 277.977752, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1225.324829, 278.833831, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1222.819824, 275.558959, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(851, 1236.237670, 258.376708, 18.405569, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1245.140747, 256.093475, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1250.105224, 273.567749, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1291.243041, 230.932785, 18.406997, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1255.925292, 181.995895, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1228.972412, 186.197540, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1271.273681, 198.954223, 18.714046, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1246.786254, 159.630294, 18.607542, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1253.166625, 145.472625, 18.593463, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1269.112304, 199.740859, 18.714046, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1266.706787, 200.616455, 18.714046, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1345.848266, 262.659698, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1361.327392, 257.116790, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1264.601562, 201.382553, 18.714046, 0.000000, 0.000000, 70.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1357.187133, 251.281707, 18.821680, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1362.676635, 278.713714, 18.407337, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1345.173583, 235.986968, 18.413076, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1323.799194, 237.091888, 18.546892, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1345.665893, 213.411560, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1361.497314, 221.607742, 18.924520, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1354.225341, 202.712677, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1360.733276, 218.641708, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1347.073608, 208.033309, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1351.705566, 218.918930, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1348.231933, 225.170135, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1343.523071, 231.184829, 18.406681, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1335.485351, 225.429351, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1333.735839, 234.703033, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1327.625000, 234.474929, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1326.242675, 234.558792, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1324.721557, 234.249816, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2671, 1324.553222, 227.602691, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1323.767822, 225.916412, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1335.410644, 222.980880, 19.003360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1342.045654, 232.104553, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1326.836914, 229.985794, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1307.160888, 237.534942, 18.926258, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1293.544799, 245.398300, 19.078153, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1301.455078, 264.587768, 19.077592, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1295.740600, 290.117736, 19.540624, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1296.847534, 283.365356, 18.989017, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1300.088623, 286.850097, 18.898227, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1317.846923, 305.433074, 18.907981, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1441, 1314.007690, 284.653747, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3887, 1181.258422, 246.381011, 26.366899, 0.000000, 0.000000, -26.900014, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1200.039306, 272.878234, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1194.543945, 264.369232, 18.552192, 0.000000, 0.000000, 8.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1184.126831, 253.270080, 18.342922, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1181.773437, 244.239974, 18.360403, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1184.125366, 236.708526, 18.510959, 0.000000, 0.000000, 4.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1187.886962, 248.410919, 18.490997, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1196.121337, 281.070953, 18.534589, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(888, 1184.607543, 277.653900, 18.277151, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18566, 1332.732666, 231.761199, 18.906248, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18566, 1263.851806, 257.148803, 19.027999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18566, 1237.737304, 276.264434, 18.996257, 3.199995, -2.200000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18248, 1230.523803, 205.526275, 26.456260, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18246, 1174.362548, 199.980895, 21.674982, 2.000000, 2.400000, 155.300033, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1213.113281, 206.344818, 19.164701, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1248.976440, 249.884246, 19.184696, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1275.444213, 233.499771, 18.872097, 0.000000, -93.199989, 34.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1341.047119, 245.864395, 18.835165, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1350.355834, 247.511505, 18.934696, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1350.162231, 266.460968, 18.816259, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1339.626098, 243.345275, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1345.860229, 244.514450, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1353.638183, 272.892669, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1349.028076, 251.867065, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1340.522705, 250.009552, 18.957044, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1343.730712, 294.549865, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1348.114013, 252.080810, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1329.439208, 303.806335, 18.921188, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1344.115844, 256.178283, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1325.266479, 297.810394, 19.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1336.488403, 237.298217, 18.953418, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1344.294433, 226.312988, 18.826259, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1311.586791, 297.502105, 19.317413, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1353.764038, 230.523468, 18.974697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1291.702636, 267.177093, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1295.403198, 255.699523, 18.406333, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1275.208251, 258.823120, 19.134529, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1254.168945, 249.875869, 19.402643, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1254.174926, 241.111923, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1314.255859, 228.178726, 18.546892, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(926, 1342.135742, 227.604568, 18.686252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1298.526000, 248.618927, 18.411123, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1237.657958, 245.832580, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(926, 1322.471191, 231.924468, 18.646253, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1226.011962, 268.964965, 19.453357, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1215.510498, 273.587158, 18.882276, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1207.619628, 270.163360, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1283.286010, 237.749511, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1352.234863, 225.503906, 18.866258, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1202.057617, 255.761993, 19.446317, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1202.291748, 246.699462, 19.143177, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1293.159179, 224.045227, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1342.481567, 221.693634, 18.756246, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1190.216308, 237.427246, 19.342416, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1192.963989, 248.180603, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1302.060913, 270.337768, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(926, 1283.966918, 245.050247, 18.659929, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1175.710937, 250.646316, 18.483762, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1338.514038, 294.120147, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1207.585571, 264.132232, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1192.412719, 285.382110, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1337.441650, 300.010162, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1177.453979, 287.328063, 18.726181, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1177.613281, 275.084960, 18.075124, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1364.911132, 225.251876, 18.974697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1161.389648, 290.052856, 17.978946, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1163.124023, 237.375610, 20.424911, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1162.932006, 251.735946, 21.031213, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1359.249389, 233.361267, 18.836938, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1176.925048, 257.831054, 18.497703, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1169.049072, 265.985626, 19.248216, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1367.287353, 209.434600, 18.846260, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1164.426513, 273.299438, 18.469505, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1209.194335, 290.370422, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1363.495483, 285.436187, 18.408149, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1219.815551, 285.969787, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1389.975097, 271.575683, 18.833263, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1284.206787, 222.334503, 18.408290, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1392.954223, 268.331787, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1229.532836, 288.624969, 19.459617, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1387.172607, 270.131225, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1388.330932, 266.846191, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1369.860473, 205.149093, 18.974695, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1234.284301, 301.119445, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1390.608276, 268.663360, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1229.402587, 307.120819, 18.642795, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1217.622436, 311.840698, 19.520772, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1358.143432, 257.992309, 19.494689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1212.000366, 330.776184, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(13591, 1237.952758, 193.974243, 18.408390, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1219.879150, 318.199340, 18.546892, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1353.953735, 243.803665, 18.856939, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1378.413085, 220.866073, 18.984697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1212.171997, 340.377929, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1213.761962, 357.983581, 19.325304, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1223.726684, 343.689880, 18.409597, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1353.998535, 242.076919, 19.226938, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1238.052734, 345.377624, 19.307567, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1360.606323, 263.452026, 18.844694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1237.127197, 335.130889, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1440, 1370.729370, 188.836425, 18.984697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1244.762329, 333.134552, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1252.310058, 333.346313, 19.350334, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1264.859130, 324.973510, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1358.736450, 238.553756, 18.986942, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1269.560302, 309.261962, 19.555511, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1338, 1354.977783, 233.978378, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1282.213256, 299.570007, 18.561403, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1365.713745, 228.962692, 18.866939, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1275.503540, 288.487731, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1370.631958, 197.101333, 18.584682, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1239.620361, 269.731018, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1348.906005, 230.372711, 18.634689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1348.906005, 230.372711, 18.654689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1372.420898, 225.734222, 18.856939, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1365.939819, 206.783462, 18.564687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1333.133789, 225.686431, 18.506252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2672, 1243.141845, 272.512084, 18.906251, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1381.744262, 226.094085, 18.864694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1308.466918, 233.052841, 18.654689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1383.245971, 228.706497, 18.824693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1372.645263, 217.052139, 18.526252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1382.675659, 231.380401, 18.874689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1382.804809, 233.767593, 18.874694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1386.687866, 235.094787, 18.884693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1386.036254, 240.011489, 18.874696, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1275.171142, 267.067657, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1388.835327, 242.389541, 18.844686, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1387.661376, 245.066177, 18.844694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2672, 1235.721313, 251.599822, 18.676250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1292.460083, 250.715744, 18.457887, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1292.460083, 250.715744, 18.457887, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1292.460083, 250.715744, 18.457887, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1292.460083, 250.715744, 18.457887, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1361.571533, 213.048355, 18.426250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1358, 1279.214233, 322.187713, 19.333978, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2672, 1232.349853, 233.733871, 18.746252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1230.031005, 273.185516, 18.516252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1328.414916, 299.354034, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1318.083374, 296.733856, 18.851800, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1307.216186, 288.851287, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1367.518432, 182.402496, 18.564687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2672, 1217.412719, 205.193984, 18.664047, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1204.554199, 282.829803, 18.506252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1307.855590, 273.799621, 18.840951, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2672, 1250.461181, 186.817581, 18.687175, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1196.008544, 238.959381, 18.664690, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1371.990112, 170.001876, 18.533376, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2672, 1271.332397, 213.698562, 18.716253, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1183.531982, 193.806076, 20.699853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1183.531982, 193.806076, 20.699853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1183.531982, 193.806076, 20.699853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1183.531982, 193.806076, 20.699853, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1372.229858, 212.796401, 18.686256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1368.231445, 215.765045, 18.686256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1356.867309, 178.526092, 18.798437, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1217.626586, 194.869354, 18.758583, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1294.356079, 280.641906, 18.854694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1372.941894, 200.408157, 18.834692, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1353.482543, 164.039932, 19.890768, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1372.903320, 195.510940, 18.824693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1369.868041, 192.244491, 18.844694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1372.083984, 185.498458, 18.854026, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1371.675903, 180.824386, 18.857112, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1363.197143, 179.047897, 18.892143, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(849, 1365.427124, 173.714218, 18.760765, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1263.629760, 194.739379, 18.526252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1347.255737, 186.075195, 19.212652, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2676, 1263.629760, 191.439620, 18.506252, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2674, 1343.684326, 176.639511, 19.195396, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1298.842773, 260.503753, 18.673267, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1436, 1343.954589, 183.100387, 20.458110, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2677, 1299.564941, 238.096038, 18.854694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1357, 1333.241699, 192.684020, 18.688228, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1296.487670, 241.560958, 18.402496, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1350.029418, 175.188339, 19.118806, -7.799996, -1.999999, -0.199999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1340.516601, 177.317214, 19.728132, 13.500000, 77.799995, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1347.574707, 166.941467, 19.699180, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1346.814331, 167.116424, 20.627994, 0.000000, 0.000000, 18.899999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1357, 1338.756835, 230.549713, 18.676256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1343.285888, 175.402709, 19.350540, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1346.051147, 167.616851, 19.659624, 0.000000, 4.500000, 7.899999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1339.931396, 168.628738, 19.721239, -2.000008, 4.000000, 22.999998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1331.904052, 169.403717, 20.804683, 0.000000, 93.100006, -16.199998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1330.009521, 170.384292, 20.640628, -0.599999, -90.299972, 74.899986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1337.508178, 187.491073, 18.758609, -1.399999, -39.900001, -7.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1334.796264, 234.569427, 18.597242, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1319.863891, 228.705429, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1313.721679, 243.478134, 18.706268, -84.699996, 0.000000, 23.199998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1314.457275, 233.052581, 19.446565, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1369.437866, 177.634643, 19.027383, 9.200000, 36.899993, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1335.783569, 227.003875, 18.966259, 0.000000, 91.399971, -72.299995, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1302.215576, 244.126800, 18.975259, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1349, 1304.556640, 236.158645, 19.105669, -22.800033, -24.000038, -5.299996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1347.318237, 168.897796, 20.036163, 23.500019, -24.299999, 39.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1343.864257, 183.088378, 19.065614, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1327.614624, 194.162353, 18.752431, -28.899999, 39.799995, 29.899999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1339.426391, 197.265899, 18.814693, 0.000000, 35.899993, 28.699996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1326.968505, 171.659957, 19.960929, -11.499995, 53.500000, 30.000003, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1352.200195, 170.452117, 19.684917, 24.299995, -47.999988, 41.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1345.855102, 188.538330, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1323.001708, 205.205413, 18.934694, -6.899999, -31.099996, 19.900001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1300.857910, 210.569549, 18.944688, 0.000000, -164.599975, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1345.849487, 188.559539, 19.534673, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1284.779785, 242.292907, 18.799745, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1284.779785, 243.812911, 18.859745, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1284.779785, 241.032928, 18.789743, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1285.950927, 241.032928, 18.689741, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1299.848876, 221.393905, 20.487070, 0.000000, 34.599998, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1345.914672, 188.990081, 20.524679, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1290.693115, 248.107818, 18.926258, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1278.787109, 208.162902, 18.854694, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1345.786987, 189.415267, 21.441789, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1307.003051, 236.872207, 18.406250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1266.251220, 252.121459, 19.054697, 0.000000, 0.000000, 76.500007, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1257.915527, 189.049682, 18.766256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1302.686523, 248.927474, 18.407375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1296.819824, 250.915939, 19.203441, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1261.911743, 188.287353, 18.606254, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1289.408081, 225.089584, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1298.280761, 222.273742, 18.954416, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1296.999511, 223.220962, 18.984697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1297.840087, 222.864471, 18.734691, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1261.989379, 269.753692, 19.056251, 0.000000, 0.000000, 35.599998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1301.378295, 217.350372, 18.554687, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1264, 1301.537841, 216.478790, 18.814693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1295.232910, 276.900421, 18.996891, 0.000000, 15.300000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1288.892456, 140.394546, 19.540939, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1288.972534, 139.104675, 19.620941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1287.034179, 138.412750, 19.720943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1288.887939, 135.171386, 19.630941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1345.901855, 190.616439, 18.564689, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1288.317260, 138.443313, 19.880945, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1289.748413, 137.571289, 19.460937, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(933, 1346.002685, 190.634872, 19.601455, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1265, 1289.808471, 135.941223, 19.600940, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1369, 1346.032836, 189.556365, 22.965490, 0.000000, -43.499996, 0.000000, -1, -1, -1, 300.00, 300.00);

    //ext
    CreateDynamicObject(1351, 1277.500000, 248.203002, 18.476600, 0.000000, 0.000000, -112.350852, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1308, 1260.540039, 251.492004, 18.820299, -0.817951, 2.412909, -19.820972, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1440, 1259.500000, 250.203002, 19.046899, 0.000000, 0.000000, -115.775955, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(13010, 1258.250000, 245.516006, 27.562500, 0.000000, 0.000000, 155.556015, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1690, 1270.479980, 240.460998, 30.773399, 0.000000, 0.000000, -23.695650, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1688, 1265.689941, 242.335998, 31.093799, 0.000000, 0.000000, 66.304290, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1687, 1253.989990, 231.438003, 26.343799, 0.000000, 0.000000, -23.695650, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(12905, 1251.589965, 218.085998, 18.468799, 0.000000, 0.000000, 0.000000, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1687, 1248.630004, 219.218994, 26.343799, 0.000000, 0.000000, -23.695650, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1351, 1244.689941, 257.515991, 18.476600, 0.000000, 0.000000, -22.350769, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1440, 1245.250000, 245.233993, 19.046899, 0.000000, 0.000000, 154.223983, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1440, 1247.040039, 245.022994, 19.046899, 0.000000, 0.000000, 123.723960, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(12850, 1246.380004, 231.367004, 18.515600, 0.000000, 0.000000, 155.556015, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1308, 1233.829956, 221.828002, 18.820299, -4.718946, 0.000000, -19.734790, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1438, 1240.589965, 217.695007, 18.531299, 0.000000, 0.000000, -29.500000, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1438, 1242.540039, 216.742004, 18.531299, 0.000000, 0.000000, 150.499984, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1688, 1251.010009, 213.453002, 23.046899, 0.000000, 0.000000, -23.695650, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1690, 1252.880004, 206.539001, 25.312500, 0.000000, 0.000000, 156.304336, 666, 0, -1, 300.00, 300.00); 
	CreateDynamicObject(1294, 1256.510009, 197.117004, 23.007799, 0.000000, 0.000000, 116.468582, 666, 0, -1, 300.00, 300.00); 
    return 1;
}

UpdateTableForPlayer(playerid)
{
    new string[64];
    if(PlayerZombieStatus[playerid] == 0)
    {
        format(string, sizeof(string), "~g~Zywy");
    }
    else if(PlayerZombieStatus[playerid] == 1)
    {
        format(string, sizeof(string), "~y~Zarazony");
    }
    else
    {
        format(string, sizeof(string), "~r~Zombie");
    }
    PlayerTextDrawSetString(playerid, text2[playerid], string);
    format(string, sizeof(string), "~y~Score: ~w~%d", PlayerEventPoint[playerid]);
    PlayerTextDrawSetString(playerid, text3[playerid], string);
    format(string, sizeof(string), "~y~Pozostali: ~w~%d", AlivePlayers);
    PlayerTextDrawSetString(playerid, text4[playerid], string);
   	//new pSkinID  = GetPlayerSkinEx(playerid);
   	//PlayerTextDrawSetPreviewModel(playerid, skinTXD[playerid], pSkinID);
  	//PlayerTextDrawShow(playerid, skinTXD[playerid]);
    return 1;
}

ShowTableForPlayer(playerid)
{
    PlayerTextDrawShow(playerid, background[playerid]);
   	//PlayerTextDrawShow(playerid, skinTXD[playerid]);
    PlayerTextDrawShow(playerid, text1[playerid]);
    PlayerTextDrawShow(playerid, text2[playerid]);
    PlayerTextDrawShow(playerid, text3[playerid]);
    PlayerTextDrawShow(playerid, text4[playerid]);
    //UpdateTableForPlayer(playerid);
    return 1;
}

HideTableForPlayer(playerid)
{
    PlayerTextDrawHide(playerid, background[playerid]);
    //PlayerTextDrawHide(playerid, skinTXD[playerid]);
    PlayerTextDrawHide(playerid, text1[playerid]);
    PlayerTextDrawHide(playerid, text2[playerid]);
    PlayerTextDrawHide(playerid, text3[playerid]);
    PlayerTextDrawHide(playerid, text4[playerid]);
    return 1;
}

GetPointsFromPlayer(playerid, value)
{
    PlayerEventPoint[playerid] = PlayerEventPoint[playerid]-value;
    UpdateTableForPlayer(playerid);
    return 1;
}

AddPointsToPlayer(playerid, value)
{
    PlayerEventPoint[playerid] = PlayerEventPoint[playerid]+value;
    UpdateTableForPlayer(playerid);
    return 1;
}

sendPartyMess(color, const text[])
{
    foreach(new i : Player)
    {
        if(togParty[i] == 0)
        {
            SendClientMessage(i, color, "======<[Zombie Apocalypse]>======");
            SendClientMessage(i, COLOR_WHITE, text);
            SendClientMessage(i, color, "======<[Mrucznik Role Play]>======");
        }
    }
    return 1;
}

CreateAntidote()
{
	antidoteObject[0] = CreateDynamicObject(2702, 1264.895019, 269.632385, 21.337291, 360.000000, 270.000000, 0.000000, -1, -1, -1, 50.00, 50.00);
	antidoteObject[1] = CreateDynamicObject(1582, 1326.590942, 285.373504, 19.045194, 0.000000, 0.000000, 0.000000, -1, -1, -1, 50.00, 50.00);
	antidoteObject[2] = CreateDynamicObject(1582, 1365.817260, 230.677383, 18.566932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 50.00, 50.00);
	antidoteObject[3] = CreateDynamicObject(1582, 1315.827148, 181.179000, 19.481203, 0.000000, 0.000000, 0.000000, -1, -1, -1, 50.00, 50.00);
	antidoteText[0] = CreateDynamic3DTextLabel("Antidotum\n{FF00FF}Aby u¿yæ wpisz /getantidote", COLOR_WHITE, 1264.895019, 269.632385, 21.337291, DRAW_DIST_ANTIDOTE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, ZOMBIE_VW, -1, -1,-1);
	antidoteText[1] = CreateDynamic3DTextLabel("Antidotum\n{FF00FF}Aby u¿yæ wpisz /getantidote", COLOR_WHITE, 1326.590942, 285.373504, 19.045194, DRAW_DIST_ANTIDOTE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, ZOMBIE_VW, -1, -1,-1);
	antidoteText[2] = CreateDynamic3DTextLabel("Antidotum\n{FF00FF}Aby u¿yæ wpisz /getantidote", COLOR_WHITE, 1365.817260, 230.677383, 18.566932, DRAW_DIST_ANTIDOTE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, ZOMBIE_VW, -1, -1,-1);
	antidoteText[3] = CreateDynamic3DTextLabel("Antidotum\n{FF00FF}Aby u¿yæ wpisz /getantidote", COLOR_WHITE, 1315.827148, 181.179000, 19.481203, DRAW_DIST_ANTIDOTE, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, ZOMBIE_VW, -1, -1,-1);
	return 1;
}

DestroyAntidote()
{
	DestroyDynamicObject(antidoteObject[0]);
	DestroyDynamicObject(antidoteObject[1]);
	DestroyDynamicObject(antidoteObject[2]);
	DestroyDynamicObject(antidoteObject[3]);
	DestroyDynamic3DTextLabel(antidoteText[0]);
	DestroyDynamic3DTextLabel(antidoteText[1]);
	DestroyDynamic3DTextLabel(antidoteText[2]);
	DestroyDynamic3DTextLabel(antidoteText[3]);
	antidoteUse[0] = 0;
	antidoteUse[1] = 0;
	antidoteUse[2] = 0;
	antidoteUse[3] = 0;
	return 1;
}

stock GetName(playerid, rp = false)
{
    new nick[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nick, sizeof(nick));
    if(rp)
    {
        //return nickRP[playerid];
    }
    return nick;
}

stock UprawnionyDoFS(playerid)
{
    if(playerAccessToFS[playerid] == 1)
    {
        return true;
    }
    return false;
}

RemovePlayerFromParty(playerid)
{
    HideTableForPlayer(playerid);
    PlayerZombieStatus[playerid] = INVALID_PZOMBIE;
    PlayerEventPoint[playerid] = 0;
    SetPlayerPos(playerid, POS_ENTER_X, POS_ENTER_Y, POS_ENTER_Z);
    SetPlayerVirtualWorld(playerid, 0);
    dostalSkina[playerid] = 0;
    KillTimer(memberTimer[playerid]);
}

stock CloseParty()
{
    foreach(new i : Player)
    {
        if(PlayerZombieStatus[i] != INVALID_PZOMBIE)
        {
            RemovePlayerFromParty(i);
        }
    }
    AlivePlayers = 0;
	DestroyAntidote();
    return 1;
}

//------------------<[ MySQL: ]>--------------------

//-----------------<[ Komendy: ]>-------------------
CMD:dolaczzombie(playerid)
{
    if(zabawaStatus == 1)
    {
        SendClientMessage(playerid, COLOR_RED, "Zabawa trwa!");
        return 1;
    }
    if(zabawaON == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Zabawa jest wy³¹czona!"); 
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 4.0, POS_ENTER_X, POS_ENTER_Y, POS_ENTER_Z))
    {
        new rand = random(4);
		
        SetPlayerPos(playerid, randomPosX[rand], randomPosY[rand], randomPosZ[rand]);
        ShowTableForPlayer(playerid);
        PlayerZombieStatus[playerid] = 0;
        PlayerEventPoint[playerid] = 0;
        AlivePlayers++;
        SetPlayerVirtualWorld(playerid, ZOMBIE_VW);
		//firstSkinID[playerid] = GetPlayerSkinEx(playerid); 
        memberTimer[playerid] = SetTimerEx("partyMember", 5000, false, "d", playerid);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD, "Nie jesteœ przy wejœciu do strefy!");
    }
    return 1;
}

CMD:wyjdzzombie(playerid)
{
    if(PlayerZombieStatus[playerid] == INVALID_PZOMBIE)
    {
        SendClientMessage(playerid, COLOR_RED, "Nie jesteœ w trakcie zabawy!");
        return 1;
    }
    SetPlayerPos(playerid, POS_ENTER_X, POS_ENTER_Y, POS_ENTER_Z);
    SetPlayerVirtualWorld(playerid, 0);
    HideTableForPlayer(playerid);
    PlayerZombieStatus[playerid] = INVALID_PZOMBIE;
    KillTimer(memberTimer[playerid]);
	//SetPlayerSkin(playerid, firstSkinID[playerid]);
    if(PlayerZombieStatus[playerid] >= 1)
    {
        AlivePlayers--;
    }
    UpdateTableForAll(playerid);
    return 1;
}

CMD:zabawastatus(playerid)
{
    new string[124], bool:found = false;

    if(playerAccessToFS[playerid] == 1)
    {
		foreach(new i : Player)
		{
		    if(PlayerZombieStatus[i] == 2)
		    {
		        found = true;
		        break;
		    }
		}

		if(found == true)
		{
	        if(zabawaStatus == 0)
	        {
	            zabawaStatus = 1;
	            format(string, sizeof(string), "%s wystartowa³(a) zabawê w Zombie!", GetName(playerid));
	            sendPartyMess(COLOR_RED, string);
				CreateAntidote();

	            TimerWIN = SetTimer("OstatniZywy", 1000, true);
	        }
	        else
	        {
	            zabawaStatus = 0;
	            format(string, sizeof(string), "%s zakoñczy³(a) zabawê w Zombie!", GetName(playerid));
	            sendPartyMess(COLOR_RED, string);
	            CloseParty();
	        }
	    }
	    else
	    {
	    	SendClientMessage(playerid, COLOR_RED, "Zombie musi byæ jeden!");
	    }
	}
	else
	{
	    SendClientMessage(playerid, COLOR_GRAD, "Nie masz uprawnieñ!");
	}
    return 1;
}

CMD:zabawaon(playerid)
{
    new string[124];
    if(playerAccessToFS[playerid] == 1)
    {
        if(zabawaON == 0)
        {
            zabawaON = 1;
            format(string, sizeof(string), "%s odpali³ przebieran¹ zabawê w zombie!", GetName(playerid));
            sendPartyMess(COLOR_GREEN, string);
        }
        else
        {
            zabawaON = 0;
            format(string, sizeof(string), "%s wy³¹czy³ przebieran¹ zabawê w zombie!", GetName(playerid));
            sendPartyMess(COLOR_GREEN, string);
        }
    }
    return 1;
}

CMD:giveaccessfs(playerid, params[])
{
    new string[124];
    if(IsPlayerConnected(playerid))
    {
        new giveplayerid;
        if(sscanf(params, "d", giveplayerid))
        {
            SendClientMessage(playerid, COLOR_WHITE, "U¿yj /giveaccessfs [ID]");
            return 1;
        }
        if(IsPlayerConnected(giveplayerid))
        {
            if(!IsPlayerAdmin(playerid))
            {
                SendClientMessage(playerid, COLOR_RED, "Nie jesteœ uprawniony do u¿ywania tej komendy!");
                return 1;
            }
            if(playerAccessToFS[giveplayerid] == 0)
            {
                format(string, sizeof(string), "Nada³eœ uprawnienia dla %s", GetName(giveplayerid));
                playerAccessToFS[giveplayerid] = 1;
                SendClientMessage(playerid, COLOR_GREEN, string);
                format(string, sizeof(string), "Dosta³eœ uprawnienia do u¿ywania FS'a [Zombie] od %s", GetName(playerid));
                SendClientMessage(giveplayerid, COLOR_GREEN, string);
            }
            else
            {
                format(string, sizeof(string), "Zabra³eœ uprawnienia dla %s", GetName(giveplayerid));
                playerAccessToFS[giveplayerid] = 0;
                SendClientMessage(playerid, COLOR_GREEN, string);
                format(string, sizeof(string), "Zosta³y Ci odebrane uprawnienia do u¿ywania FS'a [Zombie] przez %s", GetName(playerid));
                SendClientMessage(giveplayerid, COLOR_GREEN, string);
            }
        }
    }
    return 1;
}

CMD:setzombie(playerid, params[])
{
    new string[124];

    if(IsPlayerConnected(playerid))
    {
        new giveplayerid, value;
        if(sscanf(params, "dd", giveplayerid, value))
        {
            SendClientMessage(playerid, COLOR_WHITE, "U¿yj /setzombie [ID / Czêœæ nicku] [Wartosc]");
            SendClientMessage(playerid, COLOR_WHITE, "Wartoœci: 0 - zdrowy; 1 - zara¿ony; 2 - Zombie");
            return 1;
        }
		if(!UprawnionyDoFS(playerid))
		{
			SendClientMessage(playerid, COLOR_RED, "Nie jesteœ uprawniony do u¿ywania tej komendy!");
			return 1;
		}
		if(PlayerZombieStatus[giveplayerid] == INVALID_PZOMBIE)
        {
            SendClientMessage(playerid, COLOR_RED, "Ta osoba nie uczestniczy w zabawie!");
            return 1;
        }
        if(value < 0 || value > 2)
        {
        	SendClientMessage(playerid, COLOR_RED, "Wartoœci s¹ od 0 do 2!");
        	return 1;
        }
        if(IsPlayerConnected(giveplayerid))
        {
			format(string, sizeof(string), "Zmieni³eœ wartoœæ %s na %d", GetName(giveplayerid), value);
			SendClientMessage(playerid, COLOR_GREEN, string);
			PlayerZombieStatus[giveplayerid] = value;

			if(value == 2)
			{
				AlivePlayers--;
			}

            partyMember(giveplayerid);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, "Nie ma takiego gracza!");
            return 1;
        }
    }
    return 1;
}

CMD:zombieclear(playerid)
{
    new string[124];
    foreach(new i : Player)
    {
        PlayerZombieStatus[i] = 0;
    }
    format(string, sizeof(string), "%s uleczy³ wszystkich podaj¹c im cieplutk¹ hawajsk¹!", GetName(playerid));
    sendPartyMess(COLOR_GREEN, string);
    return 1;
}

//test cmd
CMD:togparty(playerid)
{
    if(togParty[playerid] == 0)
    {
        togParty[playerid] = 1;
        SendClientMessage(playerid, -1, "Wy³¹czy³eœ togparty!");
    }
    else
    {
        togParty[playerid] = 0;
        SendClientMessage(playerid, -1, "W³¹czy³eœ togparty!");
    }
    return 1;
}

CMD:getantidote(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, CMD_DIST_ANTIDOTE, 1264.895019, 269.632385, 21.337291))
	{
		if(antidoteUse[0] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Ups! Wygl¹da na to, ¿e ktoœ ju¿ ugryz³ ten kawa³ek pizzy!");
			return 1;
		}
		if(PlayerZombieStatus[playerid] != 1)
		{
			SendClientMessage(playerid, COLOR_RED, "Nie jesteœ zara¿ony!");
			return 1;
		}
		PlayerZombieStatus[playerid] = 0;
		antidoteUse[0] = 1;
		KillTimer(ZarazonyTimer[playerid]);
		SendClientMessage(playerid, COLOR_GRAD, "Zjadasz antidotum - czujesz siê lepiej.");
	}
	else if(IsPlayerInRangeOfPoint(playerid, CMD_DIST_ANTIDOTE,1326.590942, 285.373504, 19.045194))
	{
		if(antidoteUse[1] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Ups! Wygl¹da na to, ¿e ktoœ ju¿ ugryz³ ten kawa³ek pizzy!");
			return 1;
		}
		if(PlayerZombieStatus[playerid] != 1)
		{
			SendClientMessage(playerid, COLOR_RED, "Nie jesteœ zara¿ony!");
			return 1;
		}
		PlayerZombieStatus[playerid] = 0;
		antidoteUse[1] = 1;
		KillTimer(ZarazonyTimer[playerid]);
		SendClientMessage(playerid, COLOR_GRAD, "Zjadasz antidotum - czujesz siê lepiej.");
	}
	else if(IsPlayerInRangeOfPoint(playerid, CMD_DIST_ANTIDOTE, 1365.817260, 230.677383, 18.566932))
	{
		if(antidoteUse[2] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Ups! Wygl¹da na to, ¿e ktoœ ju¿ ugryz³ ten kawa³ek pizzy!");
			return 1;
		}
		if(PlayerZombieStatus[playerid] != 1)
		{
			SendClientMessage(playerid, COLOR_RED, "Nie jesteœ zara¿ony!");
			return 1;
		}
		PlayerZombieStatus[playerid] = 0;
		antidoteUse[2] = 1;
		KillTimer(ZarazonyTimer[playerid]);
		SendClientMessage(playerid, COLOR_GRAD, "Zjadasz antidotum - czujesz siê lepiej.");
	}
	else if(IsPlayerInRangeOfPoint(playerid, CMD_DIST_ANTIDOTE, 1315.827148, 181.179000, 19.481203))
	{
		if(antidoteUse[3] == 1)
		{
			SendClientMessage(playerid, COLOR_WHITE, "Ups! Wygl¹da na to, ¿e ktoœ ju¿ ugryz³ ten kawa³ek pizzy!");
			return 1;
		}
		if(PlayerZombieStatus[playerid] != 1)
		{
			SendClientMessage(playerid, COLOR_RED, "Nie jesteœ zara¿ony!");
			return 1;
		}
		PlayerZombieStatus[playerid] = 0;
		antidoteUse[3] = 1;
		KillTimer(ZarazonyTimer[playerid]);
		SendClientMessage(playerid, COLOR_GRAD, "Zjadasz antidotum - czujesz siê lepiej.");
	}
	else
	{
		SendClientMessage(playerid, COLOR_RED, "Nie jesteœ obok antidotum [pizzy]");
	}

    if(PlayerZombieStatus[playerid] == 1)
    {
        AlivePlayers++;
    }
    UpdateTableForAll(playerid);

	return 1;
}

CMD:strefa(playerid)
{
    SetPlayerPos(playerid, POS_ENTER_X, POS_ENTER_Y, POS_ENTER_Z);
    return 1;
}
CMD:and1(playerid)
{
    SetPlayerPos(playerid, 1365.817260, 230.677383, 18.566932);
    return 1;
}

UpdateTableForAll(id)
{
    foreach(id : Player)
    {
        if(PlayerZombieStatus[id] == 0 || PlayerZombieStatus[id] == 1 || PlayerZombieStatus[id] == 2)
        {
            UpdateTableForPlayer(id);
        }
    }
    return 1;
}

forward OstatniZywy();
public OstatniZywy()
{
    new alivecount;

    foreach(new i : Player)
    {
        if(PlayerZombieStatus[i] == 0)
        {
            alivecount++;
        }
    }
    
    if(alivecount == 1)
    {
        KillTimer(TimerWIN);

        foreach(new i : Player)
        {
            if(PlayerZombieStatus[i] == 0)
            {
                SendClientMessage(i, -1, "Wygra³eœ rundê!");
                break;
            }
        }
    
        foreach(new i : Player)
        {
            if(PlayerZombieStatus[i] == 2) SendClientMessage(i, -1, "Przegra³eœ!");
        }
    }
}
