//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                             player_attachments                                            //
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
// Data utworzenia: 10.08.2019
//Opis:
/*
	Modu³ odpowiedzialny za zarz¹dzanie obiektami przyczepialnymi do gracza.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerConnect(playerid)
{
	MAttachedItems[playerid] = map_new();
}

hook OnPlayerDisconnect(playerid, reason)
{
	map_delete(MAttachedItems[playerid]);
	return 1;
}

hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	//TODO: Move premium items here
	if(map_has_key(MAttachedItems[playerid], modelid))
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_GREEN, "Edytowa³eœ pozycjê swojego przedmiotu.");
	
			AttachedObjects[playerid][index][ao_x] = fOffsetX;
			AttachedObjects[playerid][index][ao_y] = fOffsetY;
			AttachedObjects[playerid][index][ao_z] = fOffsetZ;
			AttachedObjects[playerid][index][ao_rx] = fRotX;
			AttachedObjects[playerid][index][ao_ry] = fRotY;
			AttachedObjects[playerid][index][ao_rz] = fRotZ;
			AttachedObjects[playerid][index][ao_sx] = fScaleX;
			AttachedObjects[playerid][index][ao_sy] = fScaleY;
			AttachedObjects[playerid][index][ao_sz] = fScaleZ;

			SetPlayerAttachedObject(playerid, index, modelid, boneid, 
				fOffsetX, fOffsetY, fOffsetZ, 
				fRotX, fRotY, fRotZ, 
				fScaleX, fScaleY, fScaleZ
			);
			
			PlayerAttachments_UpdateItem(playerid, modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, boneid, true);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Anulowa³eœ edycjê pozycjê swojego przedmiotu.");
	
			SetPlayerAttachedObject(playerid, index, modelid, boneid, 
				AttachedObjects[playerid][index][ao_x], AttachedObjects[playerid][index][ao_y], AttachedObjects[playerid][index][ao_z], 
				AttachedObjects[playerid][index][ao_rx], AttachedObjects[playerid][index][ao_ry], AttachedObjects[playerid][index][ao_rz], 
				AttachedObjects[playerid][index][ao_sx], AttachedObjects[playerid][index][ao_sy], AttachedObjects[playerid][index][ao_sz]
			);
		}
	}
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_PRZEDMIOTYGRACZA)
	{
		if(response)
		{
			new item = DynamicGui_GetDataInt(playerid, listitem);
			new index = PlayerAttachments_LoadItem(playerid, item);
			PlayerAttachments_SetActive(playerid, item, true);

			//TODO: Pytanie, czy chcesz edytowaæ pozycjê obiektu 
			//TODO: Zdejmowanie obiektu
			EditAttachedObject(playerid, index);
		}
		return -2;
	}
	return 1;
}

//end