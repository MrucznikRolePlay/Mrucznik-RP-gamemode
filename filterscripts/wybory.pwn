//wybory.pwn

//-------------------------------------------<< Filterscript >>----------------------------------------------//
//------------------------------------------[ Modu³: wybory.pwn ]---------------------------------------------//
//Autor:
/*
	Mrucznik
*/
//Opis:
/*

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

#include <a_samp>
#include <sscanf2>
#include <zcmd>
#include <foreach>
#include <dini2>
#include <streamer>

#define COLOR_GRAD2 		0xBFC0C2FF
#define MAX_CANDIDATES 		20
#define LOKAL_WYBORCZY_POS 1483.9551,-1759.6519,13.7169
#define LOKAL_WYBORCZY_VW 49

#define WYBORY_WYNIKI_PLIK "wybory_wyniki.ini"
#define WYBORY_GLOSY_PLIK "wybory_glosy.ini"

//-----------------<[ Zmienne: ]>-------------------
new kandydaci[MAX_CANDIDATES][MAX_PLAYER_NAME];
new wyniki[MAX_CANDIDATES];
new iloscKandydatow;
new dzienWyborow, godzinaPoczatek, godzinaKoniec;

new PlayerText:statyczneTxd[MAX_PLAYERS][4];
new PlayerText:numeryTxd[MAX_PLAYERS][MAX_CANDIDATES];
new PlayerText:nickiTxd[MAX_PLAYERS][MAX_CANDIDATES];
new PlayerText:akceptujTxd[MAX_PLAYERS];

new wyborKandydata[MAX_PLAYERS];
new votingInProgress[MAX_PLAYERS];

new zaglosowaliNicki[1000][MAX_PLAYER_NAME];
new zaglosowali;

new pickup;

//-----------------<[ Callback'i: ]>-------------------
public OnFilterScriptInit()
{
	LoadConfig();
	LoadVotes();
	LoadPlayerVotes();
	
	foreach(Player, i)
	{
		CreateTextdraws(i);
	}
	
	pickup = CreateDynamicPickup(1239, 2, LOKAL_WYBORCZY_POS, 49);

	print("\n--------------------------------------");
	print(" Fliterscript 'wybory' zaladowany");
	print("--------------------------------------\n");
	return 1;
}

public OnFilterScriptExit()
{
	foreach(Player, i)
	{
		DestroyTextdraws(i);
	}

	DestroyDynamicPickup(pickup);
	
	for(new i=0; i<iloscKandydatow; i++)
	{
		printf("Wynik kandydata %s: %d", kandydaci[i], wyniki[i]);
	}

	SavePlayerVotes();
	
	print("\n--------------------------------------");
	print(" Fliterscript 'wybory' wylaczony");
	print("--------------------------------------\n");
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(CanPlayerVote(playerid))
	{
<<<<<<< HEAD
=======
		CreateTextdraws(playerid);
>>>>>>> master
		ShowElectionTextdraws(playerid);
	}
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW && votingInProgress[playerid])
    {
		HideElectionTextdraws(playerid);
<<<<<<< HEAD
=======
		DestroyTextdraws(playerid);
>>>>>>> master
		return 1;
    }
    return 0;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(playertextid == akceptujTxd[playerid] && wyborKandydata[playerid] != -1)
	{
		if(CzyZaglosowal(playerid)) {
			return 1;
		}
		new string[128];
		format(string, sizeof(string), "Odda³eœ g³os na kandydata nr %d - %s\nDziêkujemy za udzia³ w wyborach!", wyborKandydata[playerid]+1, kandydaci[wyborKandydata[playerid]]);
		SendClientMessage(playerid, 0xFFFFFFFF, string);
		wyniki[wyborKandydata[playerid]] += 1;
		dini_IntSet(WYBORY_WYNIKI_PLIK, kandydaci[wyborKandydata[playerid]], wyniki[wyborKandydata[playerid]]);
		
		new nick[MAX_PLAYER_NAME];
		GetPlayerName(playerid, nick, sizeof(nick));
		strcat(zaglosowaliNicki[zaglosowali], nick, sizeof(nick));
		zaglosowali++;
		
		HideElectionTextdraws(playerid);
		DestroyTextdraws(playerid);
		ShowPlayerDialog(playerid, -1, DIALOG_STYLE_MSGBOX, "G³osowanie", string, "OK", "");
		CancelSelectTextDraw(playerid);
		printf("%s oddal glos na %s", nick, kandydaci[wyborKandydata[playerid]]);
		return 1;
	}
	else
	{
		for(new i=0; i<iloscKandydatow; i++)
		{
			if(playertextid == nickiTxd[playerid][i])
			{
				if(wyborKandydata[playerid] != -1)
				{
					new j = wyborKandydata[playerid];
					PlayerTextDrawHide(playerid, nickiTxd[playerid][j]);
					PlayerTextDrawHide(playerid, numeryTxd[playerid][j]);
					PlayerTextDrawColor(playerid, nickiTxd[playerid][j], -76);
					PlayerTextDrawColor(playerid, numeryTxd[playerid][j], -76);
					PlayerTextDrawShow(playerid, nickiTxd[playerid][j]);
					PlayerTextDrawShow(playerid, numeryTxd[playerid][j]);
				}
				
				wyborKandydata[playerid] = i;
				
				PlayerTextDrawHide(playerid, nickiTxd[playerid][i]);
				PlayerTextDrawHide(playerid, numeryTxd[playerid][i]);
				PlayerTextDrawColor(playerid, nickiTxd[playerid][i], 0x00FF00FF);
				PlayerTextDrawColor(playerid, numeryTxd[playerid][i], 0x00FF00FF);
				PlayerTextDrawShow(playerid, nickiTxd[playerid][i]);
				PlayerTextDrawShow(playerid, numeryTxd[playerid][i]);
				return 1;
			}
		}
	}
	return 0;
}

//-----------------<[ Funkcje: ]>-------------------
LoadConfig()
{
	new File:configFile;
	configFile = fopen("wybory.cfg", io_read);
	if(configFile)
	{
		new line[128];
		fread(configFile, line); dzienWyborow = strval(line);
		fread(configFile, line); godzinaPoczatek = strval(line);
		fread(configFile, line); godzinaKoniec = strval(line);
		fread(configFile, line); iloscKandydatow = strval(line);
		printf("Odczytano: %d %d %d %d", dzienWyborow, godzinaPoczatek, godzinaKoniec, iloscKandydatow);
		if(iloscKandydatow < MAX_CANDIDATES)
		{
			for(new i=0; i<iloscKandydatow; i++)
			{
				fread(configFile, line);
				strmid(kandydaci[i], line, 0, strfind(line, "\r") == -1 ? (strfind(line, "\n") == -1 ? strlen(line) : strfind(line, "\n")) : strfind(line, "\r")); //spaghetti code xd
			}
		}
		else
		{
			Error("-WYBORY ERROR- zbyt duzo kandydatow (max "#MAX_CANDIDATES")");
		}
		fclose(configFile);
	}
	else
	{
		Error("-WYBORY ERROR- Brak pliku wybory.cfg");
	}
}

LoadVotes()
{
	if(!dini_Exists(WYBORY_WYNIKI_PLIK))
	{
		dini_Create(WYBORY_WYNIKI_PLIK);
		for(new i=0; i<iloscKandydatow; i++)
		{
			dini_IntSet(WYBORY_WYNIKI_PLIK, kandydaci[i], 0);
		}
	}
	else
	{
		for(new i=0; i<iloscKandydatow; i++)
		{
			wyniki[i] = dini_Int(WYBORY_WYNIKI_PLIK, kandydaci[i]);
		}
	}
}

LoadPlayerVotes()
{
	new File:file;
	file = fopen(WYBORY_GLOSY_PLIK, io_read);
	if(file)
	{
		new buf[64];
		zaglosowali=0;
		while(fread(file, buf))
		{
			new newLinePos = strfind(buf, "\n");
			if(newLinePos != -1) 
			{
				strmid(zaglosowaliNicki[zaglosowali++], buf, 0, newLinePos);
			}
		}
		fclose(file);
	}
}

SavePlayerVotes()
{
	new File:file;
	file = fopen(WYBORY_GLOSY_PLIK);
	if(file)
	{
		for(new i; i<zaglosowali; i++)
		{
			new buf[64];
			format(buf, sizeof(buf), "%s\n", zaglosowaliNicki[i]);
			fwrite(file, buf);
		}
		fclose(file);
	}
}

Error(const string[])
{
	print(string);
}

CreateTextdraws(playerid)
{
	statyczneTxd[playerid][0] = CreatePlayerTextDraw(playerid, 200.000000, 90.000000, "~n~");
	PlayerTextDrawLetterSize(playerid, statyczneTxd[playerid][0], 0.000000, 7.0 + iloscKandydatow * 1.6);
	PlayerTextDrawTextSize(playerid, statyczneTxd[playerid][0], 450.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, statyczneTxd[playerid][0], 1);
	PlayerTextDrawColor(playerid, statyczneTxd[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, statyczneTxd[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, statyczneTxd[playerid][0], 150);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, statyczneTxd[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, statyczneTxd[playerid][0], 255);
	PlayerTextDrawFont(playerid, statyczneTxd[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, statyczneTxd[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][0], 0);

	statyczneTxd[playerid][1] = CreatePlayerTextDraw(playerid, 237.500000, 98.500000, "Numer");
	PlayerTextDrawLetterSize(playerid, statyczneTxd[playerid][1], 0.400332, 1.600000);
	PlayerTextDrawAlignment(playerid, statyczneTxd[playerid][1], 2);
	PlayerTextDrawColor(playerid, statyczneTxd[playerid][1], 263520180);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, statyczneTxd[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, statyczneTxd[playerid][1], 0);
	PlayerTextDrawFont(playerid, statyczneTxd[playerid][1], 3);
	PlayerTextDrawSetProportional(playerid, statyczneTxd[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][1], 0);

	statyczneTxd[playerid][2] = CreatePlayerTextDraw(playerid, 360.002105, 98.500000, "Kandydat");
	PlayerTextDrawLetterSize(playerid, statyczneTxd[playerid][2], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, statyczneTxd[playerid][2], 2);
	PlayerTextDrawColor(playerid, statyczneTxd[playerid][2], 263520180);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, statyczneTxd[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, statyczneTxd[playerid][2], 0);
	PlayerTextDrawFont(playerid, statyczneTxd[playerid][2], 3);
	PlayerTextDrawSetProportional(playerid, statyczneTxd[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][2], 0);

	statyczneTxd[playerid][3] = CreatePlayerTextDraw(playerid, 324.983306, 69.485153, "Karta_wyborcza");
	PlayerTextDrawLetterSize(playerid, statyczneTxd[playerid][3], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, statyczneTxd[playerid][3], 0.000000, 249.999511);
	PlayerTextDrawAlignment(playerid, statyczneTxd[playerid][3], 2);
	PlayerTextDrawColor(playerid, statyczneTxd[playerid][3], 263520180);
	PlayerTextDrawUseBox(playerid, statyczneTxd[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, statyczneTxd[playerid][3], 150);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, statyczneTxd[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, statyczneTxd[playerid][3], 0);
	PlayerTextDrawFont(playerid, statyczneTxd[playerid][3], 3);
	PlayerTextDrawSetProportional(playerid, statyczneTxd[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, statyczneTxd[playerid][3], 0);
	
	//dynamicznie generowane
	for(new i=0; i<iloscKandydatow; i++)
	{
		new str[3];
		valstr(str, i+1);
		numeryTxd[playerid][i] = CreatePlayerTextDraw(playerid, 237.500000, 120.500000+(16.0*i), str);
		PlayerTextDrawLetterSize(playerid, numeryTxd[playerid][i], 0.400000, 1.600000);
		PlayerTextDrawAlignment(playerid, numeryTxd[playerid][i], 2);
		PlayerTextDrawColor(playerid, numeryTxd[playerid][i], -76);
		PlayerTextDrawSetShadow(playerid, numeryTxd[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, numeryTxd[playerid][i], 1);
		PlayerTextDrawBackgroundColor(playerid, numeryTxd[playerid][i], 0);
		PlayerTextDrawFont(playerid, numeryTxd[playerid][i], 3);
		PlayerTextDrawSetProportional(playerid, numeryTxd[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, numeryTxd[playerid][i], 0);

		nickiTxd[playerid][i] = CreatePlayerTextDraw(playerid, 360.002105, 120.500000+(16.0*i), kandydaci[i]);
		PlayerTextDrawLetterSize(playerid, nickiTxd[playerid][i], 0.400000, 1.600000);
		PlayerTextDrawTextSize(playerid, nickiTxd[playerid][i], 13.0, 250.0);
		PlayerTextDrawAlignment(playerid, nickiTxd[playerid][i], 2);
		PlayerTextDrawColor(playerid, nickiTxd[playerid][i], -76);
		PlayerTextDrawSetShadow(playerid, nickiTxd[playerid][i], 0);
		PlayerTextDrawSetOutline(playerid, nickiTxd[playerid][i], 0);
		PlayerTextDrawBackgroundColor(playerid, nickiTxd[playerid][i], 0);
		PlayerTextDrawFont(playerid, nickiTxd[playerid][i], 1);
		PlayerTextDrawSetProportional(playerid, nickiTxd[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, nickiTxd[playerid][i], 0);
		PlayerTextDrawSetSelectable(playerid, nickiTxd[playerid][i], true);
	}

	//akceptuj
	akceptujTxd[playerid] = CreatePlayerTextDraw(playerid, 325.0, 140+iloscKandydatow*16, "akceptuj");
	PlayerTextDrawLetterSize(playerid, akceptujTxd[playerid], 0.400000, 1.600000);
	PlayerTextDrawTextSize(playerid, akceptujTxd[playerid], 20.000000, 249.999511);
	PlayerTextDrawAlignment(playerid, akceptujTxd[playerid], 2);
	PlayerTextDrawColor(playerid, akceptujTxd[playerid], 263520180);
	PlayerTextDrawUseBox(playerid, akceptujTxd[playerid], 1);
	PlayerTextDrawBoxColor(playerid, akceptujTxd[playerid], 150);
	PlayerTextDrawSetShadow(playerid, akceptujTxd[playerid], 0);
	PlayerTextDrawSetOutline(playerid, akceptujTxd[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, akceptujTxd[playerid], 0);
	PlayerTextDrawFont(playerid, akceptujTxd[playerid], 3);
	PlayerTextDrawSetProportional(playerid, akceptujTxd[playerid], 1);
	PlayerTextDrawSetShadow(playerid, akceptujTxd[playerid], 0);
	PlayerTextDrawSetSelectable(playerid, akceptujTxd[playerid], true);
}

DestroyTextdraws(playerid)
{
	for(new i=0; i<4; i++)
	{
		PlayerTextDrawDestroy(playerid, statyczneTxd[playerid][i]);
	}
	for(new i=0; i<iloscKandydatow; i++)
	{
		PlayerTextDrawDestroy(playerid, numeryTxd[playerid][i]);
		PlayerTextDrawDestroy(playerid, nickiTxd[playerid][i]);
	}
	PlayerTextDrawDestroy(playerid, akceptujTxd[playerid]);
	wyborKandydata[playerid] = -1;
}

ShowElectionTextdraws(playerid)
{
	for(new i=0; i<4; i++)
	{
		PlayerTextDrawShow(playerid, statyczneTxd[playerid][i]);
	}
	for(new i=0; i<iloscKandydatow; i++)
	{
		PlayerTextDrawShow(playerid, numeryTxd[playerid][i]);
		PlayerTextDrawShow(playerid, nickiTxd[playerid][i]);
	}
	PlayerTextDrawShow(playerid, akceptujTxd[playerid]);
	SelectTextDraw(playerid, 0xFF0000FF);
	votingInProgress[playerid] = 1;
}

HideElectionTextdraws(playerid)
{
	for(new i=0; i<4; i++)
	{
		PlayerTextDrawHide(playerid, statyczneTxd[playerid][i]);
	}
	for(new i=0; i<iloscKandydatow; i++)
	{
		PlayerTextDrawHide(playerid, numeryTxd[playerid][i]);
		PlayerTextDrawHide(playerid, nickiTxd[playerid][i]);
	}
	PlayerTextDrawHide(playerid, akceptujTxd[playerid]);
	votingInProgress[playerid] = 0;
}

CzyZaglosowal(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	for(new i; i<zaglosowali; i++)
	{	
		if(strcmp(zaglosowaliNicki[i], nick, true) == 0)
		{	
			return true;
		}
	}
	return false;
}

CanPlayerVote(playerid)
{
	if(
		GetPlayerScore(playerid) < 3 ||
		GetPlayerVirtualWorld(playerid) != LOKAL_WYBORCZY_VW ||
		!IsPlayerInRangeOfPoint(playerid, 5.0, LOKAL_WYBORCZY_POS)
	) {
		return 0;
	}

	new unused, dzien, godzina;
	getdate(unused, unused, dzien);
	gettime(godzina, unused, unused);

	if(
		dzien != dzienWyborow ||
		godzina < godzinaPoczatek ||
		godzina > godzinaKoniec ||
		CzyZaglosowal(playerid)
	) {
		return 0;
	}
	return 1;
}

PlayerCantVoteMessage(playerid)
{
	if(GetPlayerScore(playerid) < 3) {
		SendClientMessage(playerid, COLOR_GRAD2, "Nie masz 3 lvl.");
		return 1;
	}
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, LOKAL_WYBORCZY_POS)) {
		SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ w lokalu wyborczym.");
		return 1;
	}
	if(GetPlayerVirtualWorld(playerid) != LOKAL_WYBORCZY_VW)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ w lokalu wyborczym.");
		return 1;	
	}
	new unused, dzien, godzina;
	getdate(unused, unused, dzien);
	gettime(godzina, unused, unused);
	if(dzien != dzienWyborow) {
		SendClientMessage(playerid, COLOR_GRAD2, "Dzisiaj nie odbywaj¹ siê wybory.");
		return 1;
	}
	if(godzina < godzinaPoczatek) {
		SendClientMessage(playerid, COLOR_GRAD2, "Wybory jeszcze siê nie zaczê³y/ju¿ siê skoñczy³y.");
		return 1;
	}
	if(godzina > godzinaKoniec) {
		SendClientMessage(playerid, COLOR_GRAD2, "Wybory ju¿ siê skoñczy³y.");
		return 1;
	}
	if(CzyZaglosowal(playerid)) {
		SendClientMessage(playerid, COLOR_GRAD2, "Ju¿ odda³eœ g³os w tych wyborach!");
		return 1;
	}
	return 1;
}

//------------------<[ MySQL: ]>--------------------
//-----------------<[ Komendy: ]>-------------------
<<<<<<< HEAD
=======
CMD:reloadwybory(playerid)
{
	new nick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nick, sizeof(nick));
	if(!strcmp(nick, "Tom_Russell") || IsPlayerAdmin(playerid))
	{
		SendClientMessage(playerid, -1, "RELOADFS WYBORY");
		SendRconCommand("reloadfs wybory");
	}
	return 1;
}
>>>>>>> master

CMD:gotowybory(playerid)
{
	if(IsPlayerAdmin(playerid))
	{
		SetPlayerPos(playerid, LOKAL_WYBORCZY_POS);
		SetPlayerVirtualWorld(playerid, LOKAL_WYBORCZY_VW);
	}
<<<<<<< HEAD
=======
	return 1;
>>>>>>> master
}

CMD:glosuj(playerid)
{
	if(CanPlayerVote(playerid))
	{
<<<<<<< HEAD
=======
		CreateTextdraws(playerid);
>>>>>>> master
		ShowElectionTextdraws(playerid);
	}
	else
	{
		PlayerCantVoteMessage(playerid);
	}
	return 1;
}