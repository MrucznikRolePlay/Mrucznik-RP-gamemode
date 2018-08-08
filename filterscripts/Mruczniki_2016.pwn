//
// Admin netstats display
//
#include <a_samp>
#include <zcmd>

new MrucznikiON[MAX_PLAYERS];
new Text3D:PlayerLabel[MAX_PLAYERS];

#define COLOR 0xAA3333AA
#define COLOR_DARKRED 0x8B0000FF
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BLUE 0x33CCFFAA
#define COLOR_ORANGE 0xFF9900A
#define COLOR_PINK 0xFFC0CBAA
//------------------------------------------------

public OnFilterScriptInit()
{
	print("\n--Mruczniki 2016 loaded\n");
	return 1;
}
//------------------------------------------------
CMD:mruczniki(playerid, params[])
{
    new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	if(!strcmp(name, "Eliza_Verwest", true) && MrucznikiON[playerid] == 0)//1
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepiej prowadzona postaæ 2017 roku!", COLOR_YELLOW, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Kenyon_Carrington", true) && MrucznikiON[playerid] == 0)//2
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy Administrator 2017 roku!", COLOR_RED, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
 	else if(!strcmp(name, "Nadia_Russell", true) && MrucznikiON[playerid] == 0)//3
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy lider organizacji 2017 roku!", COLOR_PINK, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Richard_Parker", true) && MrucznikiON[playerid] == 0)//4
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy organizator rozgrywki 2017 roku!", COLOR_ORANGE, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Sven_Helvetica", true) && MrucznikiON[playerid] == 0)//5
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najpopularniejszy u¿ytkownik forum 2017 roku!", COLOR_DARKRED, 0.0, 0.0, 0.0, 20.0, 0, 0);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Laetitia_Colombo", true) && MrucznikiON[playerid] == 0)//6
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy Projekt IC 2017 roku!", COLOR_BLUE, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Krzysztof_Golder", true) && MrucznikiON[playerid] == 0)//7
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy profil forum 2017 roku!", COLOR_WHITE, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Tom_McCartney", true) && MrucznikiON[playerid] == 0)//8
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy profil forum 2017 roku!", COLOR_WHITE, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Vittorio_Squillaci", true) && MrucznikiON[playerid] == 0)//9
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy grafik 2017 roku!", COLOR_GREEN, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(MrucznikiON[playerid] == 1)
	{
		RemovePlayerAttachedObject(playerid,1);
		Delete3DTextLabel(PlayerLabel[playerid]);
		MrucznikiON[playerid] = 0;
	}
	else return SendClientMessage(playerid,0xAA3333AA,"Nie dla psa Whiskas!");
	return 1;
}
//------------------------------------------------
public OnPlayerDisconnect(playerid, reason)
{
    if(MrucznikiON[playerid] == 1)
    {
        RemovePlayerAttachedObject(playerid,1);
		Delete3DTextLabel(PlayerLabel[playerid]);
		MrucznikiON[playerid] = 0;
	}
    return 1;
}
