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

//WYLACZONY BO WARNINGI DAJE

/*
#include <YSI\y_hooks>
#include "graffiti_dialogs.pwn"
hook OnPlayerConnect(playerid)
{
    graffiti_ZerujZmienne(playerid);
}*/

/*forward OPEDO(playerid, objectid, response, x, y, z, rx, ry, rz);
public OPEDO(playerid, objectid, response, x, y, z, rx, ry, rz)
{
    CallRemoteFunction("OnPlayerEditDynamicObject", "iisffffff", playerid, objectid, response, x, y, z, rx, ry, rz);
} */ //mo¿e Ci sie przydac potem (chyba) ~ Creative
/*
//hook OPEDO(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) // opcjonalnie zamiast tego poni¿ej
hook OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
 	if( response == EDIT_RESPONSE_FINAL )
    {
        if( GetPVarInt(playerid, "GraffitiCreating") == 1 )
        {
			new f = graffiti_GetNewID(playerid);
			GraffitiInfo[f][Xpos] = x;
			GraffitiInfo[f][Ypos] = y;
			GraffitiInfo[f][Zpos] = z;
			GraffitiInfo[f][XYpos] = rx;
			GraffitiInfo[f][YYpos] = ry;
			GraffitiInfo[f][ZYpos] = rz;
            GameTextForPlayer(playerid, "~g~Stworzono.",2000, 5);
            //DestroyDynamicObject(pGraffiti[playerid]);
			DeletePVar(playerid,"GraffitiCreating");
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
stock graffiti_GetNewID(playerid)
{
	return 1;
}
stock graffiti_CreateGraffiti(playerid)
{
	new debug_string[144];
	SetPVarInt(playerid, "GraffitiCreating", 1);
	GetPlayerPos(playerid, PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2]);
	pGraffiti[playerid] = CreateDynamicObject(19482, PlayerPos[playerid][0], PlayerPos[playerid][1], PlayerPos[playerid][2], 0.0, 0.0, 0.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid, 200);
    SetDynamicObjectMaterialText(pGraffiti[playerid], 0, "Test", OBJECT_MATERIAL_SIZE_256x256, "Arial", 26, 0, 0xFFFFFFFF, 0, 1);
	sendTipMessage(playerid, Graffiti_Text[playerid]);
	sendTipMessage(playerid, Graffiti_Color[playerid]);
	sendTipMessage(playerid, pGraffiti[playerid]);
	format(debug_string, sizeof(debug_string), "ID: %d", graffiti_GetNewID(playerid));
	sendTipMessage(playerid, debug_string);
	EditDynamicObject(playerid, pGraffiti[playerid]);
	return 1;
}
graffiti_ZerujZmienne(playerid)
{
	pGraffiti[playerid] = -1;
	Graffiti_Color[playerid] = "";
	Graffiti_Text[playerid] = "";
}

stock graffiti_ShowCreationDialog(playerid)
{
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_ENTER_TEXT, DIALOG_STYLE_INPUT, "Graffiti", "WprowadŸ tekst(max 120 znaków)", "Dalej", "Anuluj");
}

graffiti_ShowColorMenu(playerid)
{
	ShowPlayerDialogEx(playerid, GRAFFITI_DIALOG_SELECT_COLOR, DIALOG_STYLE_LIST, "Graffiti", "{000000}Czarny\n{FFFFFF}Bia³y\n{F81414}Czerwony\n{00FF22}Zielony\n{00CED1}Niebieski\n{C3C3C3}Szary", "Wybierz", "Anuluj");
}
//end
*/