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
	// WARNING: modelid can be edited by cheaters, so don't rely on it

	if(AttachedObjects[playerid][index][ao_active] == true && AttachedObjects[playerid][index][ao_model] == modelid)
	{
		if(response)
		{
			if(!CheckEditionBoundaries(playerid, fOffsetX, fOffsetY, fOffsetZ, fScaleX, fScaleY, fScaleZ))
			{
				EditAttachedObject(playerid, index);
				//TODO: je¿eli gracz kliknie wyjdz 2 razy w krótkim czasie, nie w³aczy mu siê edycja
				return -2;
			}

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
			
			if(VECTOR_find_val(VAttachedItems[playerid], modelid) != INVALID_VECTOR_INDEX)
			{
				PlayerAttachments_UpdateItem(playerid, modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, boneid, true);
			}
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
		return -2;
	}
	return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	for(new index; index<MAX_PLAYER_ATTACHED_OBJECTS; index++)
	{
		AttachedObjects[playerid][index][ao_active] = false;
	}
	VECTOR_clear(VAttachedItems[playerid]);
	return 1;
}

hook OnPlayerSpawn(playerid)
{
	for(new index; index<MAX_PLAYER_ATTACHED_OBJECTS; index++)
	{
		if(AttachedObjects[playerid][index][ao_active])
		{
			SetPlayerAttachedObject(playerid, index, 
				AttachedObjects[playerid][index][ao_model],
				 AttachedObjects[playerid][index][ao_bone], 
				AttachedObjects[playerid][index][ao_x], AttachedObjects[playerid][index][ao_y], AttachedObjects[playerid][index][ao_z], 
				AttachedObjects[playerid][index][ao_rx], AttachedObjects[playerid][index][ao_ry], AttachedObjects[playerid][index][ao_rz], 
				AttachedObjects[playerid][index][ao_sx], AttachedObjects[playerid][index][ao_sy], AttachedObjects[playerid][index][ao_sz]
			);
		}
	}
}

attachemnts_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	#pragma unused inputtext
	if(dialogid == DIALOG_PRZEDMIOTYGRACZA)
	{
		if(response)
		{
			new item = DynamicGui_GetDataInt(playerid, listitem);
			
			if(HasPlayerActiveAttachedObject(playerid, item))
			{
				DialogPlayerAttachedItems(playerid);
				sendErrorMessage(playerid, "Masz ju¿ przyczepiony ten obiekt.");
				return 1;
			}

			if(GetFreeAttachedObjectSlot(playerid) == INVALID_ATTACHED_OBJECT_INDEX)
			{
				sendErrorMessage(playerid, "Masz zbyt du¿o za³o¿onych przedmiotów. U¿yj komendy /zdejmij aby zdj¹æ jakiœ przedmiot.");
				return 1;
			}

			PlayerAttachments_SetActive(playerid, item, true);
			new index = PlayerAttachments_LoadItem(playerid, item);
			if(index == INVALID_ATTACHED_OBJECT_INDEX)
			{
				sendErrorMessage(playerid, "B³¹d systemu doczepianych obiektów! Zg³oœ okolicznoœci na forum");
				return 1;
			}

			ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA_EDYCJA, DIALOG_STYLE_MSGBOX, "Przedmioty - edycja", "Czy chcesz edytowaæ pozycjê przedmiotu?", "Tak", "Nie");
			SetPVarInt(playerid, "AttachedItem_EditIndex", index);
		}
		return 1;
	}
	if(dialogid == DIALOG_PRZEDMIOTYGRACZA_EDYCJA)
	{
		if(response)
		{
			new index = GetPVarInt(playerid, "AttachedItem_EditIndex");
			DialogBoneSelect(playerid, AttachedObjects[playerid][index][ao_bone]);
		}
		return 1;
	}
	if(dialogid == DIALOG_PRZEDMIOTYGRACZA_KOSC)
	{
		if(response)
		{
			new index = GetPVarInt(playerid, "AttachedItem_EditIndex");
			new bone = listitem+1;
			if(bone < 1 || bone > 18) return 1;

			SetPlayerAttachedObject(playerid, index, AttachedObjects[playerid][index][ao_model], bone, 
				AttachedObjects[playerid][index][ao_x], AttachedObjects[playerid][index][ao_y], AttachedObjects[playerid][index][ao_z], 
				AttachedObjects[playerid][index][ao_rx], AttachedObjects[playerid][index][ao_ry], AttachedObjects[playerid][index][ao_rz], 
				AttachedObjects[playerid][index][ao_sx], AttachedObjects[playerid][index][ao_sy], AttachedObjects[playerid][index][ao_sz]
			);

			EditAttachedObject(playerid, index);
			sendTipMessage(playerid, "Wybierz pozycjê obiektu.");
		}
		return 1;
	}
	if(dialogid == DIALOG_PRZEDMIOTYGRACZA_ZDEJMIJ)
	{
		if(response)
		{
			new index = DynamicGui_GetDataInt(playerid, listitem);
			DetachPlayerItem(playerid, index);
		}
		return 1;
	}
	if(dialogid == DIALOG_PRZEDMIOTYGRACZA_ZDEJMIJ_ADMIN)
	{
		if(response)
		{
			new index = DynamicGui_GetDataInt(playerid, listitem);
			new giveplayerid = GetPVarInt(playerid, "ZdejmijGiveplayerid");
			DetachPlayerItem(giveplayerid, index);

			SendClientMessage(giveplayerid, COLOR_RED, sprintf("Administrator %s zdj¹³ twój obiekt, popraw jego u³o¿enie, inaczej mo¿esz otrzymaæ karê.", GetNickEx(playerid)));
			sendTipMessage(playerid, sprintf("Zdj¹³eœ obiekt graczowi %s", GetNick(giveplayerid)));
		}
		return 1;
	}
	return 0;
}

//end