//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  graffiti                                                 //
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
// Autor: Sanda³
// Data utworzenia: 01.02.2020
//Opis:
/*
	System graffiti
*/


#include <YSI\y_hooks>
#include "graffiti_dialogs.pwn"
hook OnPlayerConnect(playerid)
{
    graffiti_ZerujZmienne(playerid);
}


public OPEDO(playerid, objectid, response, x, y, z, rx, ry, rz)
{
    CallRemoteFunction("OnPlayerEditDynamicObject", "iisffffff", playerid, objectid, response, x, y, z, rx, ry, rz);
}

hook OPEDO(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
 	if( response == EDIT_RESPONSE_FINAL )
    {
        if( GetPVarInt(playerid, "GraffitiCreating") == 1 )
        {
			// new f = graffiti_GetNewID();
			// GraffitiInfo[f][Xpos] = x;
			// GraffitiInfo[f][Ypos] = y;
			// GraffitiInfo[f][Zpos] = z;
			// GraffitiInfo[f][XYpos] = rx;
			// GraffitiInfo[f][YYpos] = ry;
			// GraffitiInfo[f][ZYpos] = rz;
            GameTextForPlayer(playerid, "~g~Stworzono.",2000, 5);
			//graffiti_SaveMySQL(f);
			//graffiti_ReloadForPlayers(f);
			DeletePVar(playerid,"GraffitiCreating");
			graffiti_ZerujZmienne(playerid);
        }
    }
    if( response == EDIT_RESPONSE_CANCEL )
    {
        if( GetPVarInt(playerid, "GraffitiCreating") == 1 )
        {
            DestroyDynamicObject(pGraffiti[playerid]);
			GameTextForPlayer(playerid, "~r~Anulowano!",2000, 5);
			DeletePVar(playerid,"GraffitiCreating");
        }
    }
    return 1;
}
//-----------------<[ Funkcje: ]>-------------------
graffiti_ReloadForPlayers(id)
{
	//delete id graffiti
	//graffiti_LoadMySQL(id);
	return 1;
}

graffiti_SaveMySQL(id)
{
	return 1;
}

graffiti_GetNewID()
{
	return 1;
}
graffiti_CreateGraffiti(playerid)
{
	new debug_string[144];
	SetPVarInt(playerid, "GraffitiCreating", 1);
	GetPlayerPos(playerid, PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2]);
	pGraffiti[playerid] = CreateDynamicObject(19482, PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 200);
    SetDynamicObjectMaterialText(pGraffiti[playerid], 0, "Testowanie\nTesty", OBJECT_MATERIAL_SIZE_256x256, "Arial", 24, 0, Graffiti_Color[playerid], 0, 1);
	sendTipMessage(playerid, Graffiti_Text[playerid]);
	sendTipMessage(playerid, Graffiti_Color[playerid]);
	sendTipMessage(playerid, pGraffiti[playerid]);
	format(debug_string, sizeof(debug_string), "ID: %d", graffiti_GetNewID());
	sendTipMessage(playerid, debug_string);
	EditDynamicObject(playerid, pGraffiti[playerid]);
	return 1;
}
graffiti_ZerujZmienne(playerid)
{
	pGraffiti[playerid] = -1;
	Graffiti_Color[playerid] = 0;
	Graffiti_Text[playerid] = "";
}
//end
