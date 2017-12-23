//
// Admin netstats display
//
#include <a_samp>
#include <zcmd>

new MrucznikiON[MAX_PLAYERS];
new Text3D:PlayerLabel[MAX_PLAYERS];

#define COLOR 0xAA3333AA
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
	if(!strcmp(name, "Stewart_West", true, 12) && MrucznikiON[playerid] == 0)//1
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy administrator roku 2016", COLOR, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Toni_Forelli", true, 12) && MrucznikiON[playerid] == 0)//2
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy zaufany gracz roku 2016", COLOR, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
 	else if(!strcmp(name, "Frank_Morashi", true, 13) && MrucznikiON[playerid] == 0)//3
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy kierownik komisji roku 2016", COLOR, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Krystyna_White", true, 14) && MrucznikiON[playerid] == 0)//4
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy gracz roku 2016", COLOR, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Sven_Helvetica", true, 12) && MrucznikiON[playerid] == 0)//5
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy test roku 2016", 0xAA3333AA, 0.0, 0.0, 0.0, 20.0, 0, 0);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Philip_Honda", true, 12) && MrucznikiON[playerid] == 0)//6
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy Opiekun IC roku 2016", COLOR, 0.0, 0.0, 0.0, 20.0, 0, 1);
		Attach3DTextLabelToPlayer(PlayerLabel[playerid], playerid, 0.0, 0.0, 0.3);
		SetPlayerAttachedObject(playerid,1,1247,2,0.514999,-0.027999,0.044999,0.000000,-1.700000,-7.400016);
		MrucznikiON[playerid] = 1;
	}
	else if(!strcmp(name, "Rayan_Gardner", true, 13) && MrucznikiON[playerid] == 0)//7
	{
		PlayerLabel[playerid] = Create3DTextLabel("Najlepszy cz³onek zarz¹du roku 2016", COLOR, 0.0, 0.0, 0.0, 20.0, 0, 1);
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
