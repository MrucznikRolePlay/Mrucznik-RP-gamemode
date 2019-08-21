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
hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(VECTOR_find_val(VAttachedItems[playerid], modelid) != INVALID_VECTOR_INDEX)
	{
		if(response)
		{
			//TODO: Ograniczenia edycji

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
			PlayerAttachments_SetActive(playerid, item, true);
			new index = PlayerAttachments_LoadItem(playerid, item);
			if(index == INVALID_ATTACHED_OBJECT_INDEX)
			{
				sendErrorMessage(playerid, "Masz zbyt du¿o za³o¿onych przedmiotów. U¿yj komendy /zdejmij aby zdj¹æ jakiœ przedmiot.");
				return 1;
			}

			ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA_EDYCJA, DIALOG_STYLE_PREVIEW_MODEL, "Przedmioty - edycja", "Czy chcesz edytowaæ pozycjê przedmiotu?", "Tak", "Nie");
			SetPVarInt(playerid, "AttachedItem_EditIndex", index);
		}
		return -2;
	}
	else if(dialogid == DIALOG_PRZEDMIOTYGRACZA_EDYCJA)
	{
		if(response)
		{
			EditAttachedObject(playerid, GetPVarInt(playerid, "AttachedItem_EditIndex"));
		}
		return -2;
	}
	
	else if(dialogid == DIALOG_PRZEDMIOTYGRACZA_ZDEJMIJ)
	{
		if(response)
		{
			new index = DynamicGui_GetDataInt(playerid, listitem);
			DetachPlayerItem(playerid, index);
		}
		return -2;
	}
	return 1;
}

//end