//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------
AttachPlayerItem(playerid, modelid, bone, Float:fOffsetX = 0.0, Float:fOffsetY = 0.0, Float:fOffsetZ = 0.0, Float:fRotX = 0.0, Float:fRotY = 0.0, Float:fRotZ = 0.0, Float:fScaleX = 1.0, Float:fScaleY = 1.0, Float:fScaleZ = 1.0, materialcolor1 = 0, materialcolor2 = 0)
{
	new index = GetFreeAttachedObjectSlot(playerid);
	if(index == INVALID_ATTACHED_OBJECT_INDEX) return INVALID_ATTACHED_OBJECT_INDEX;
	
	AttachedObjects[playerid][index][ao_model] = modelid;
	AttachedObjects[playerid][index][ao_bone] = bone;
	AttachedObjects[playerid][index][ao_x] = fOffsetX;
	AttachedObjects[playerid][index][ao_y] = fOffsetY;
	AttachedObjects[playerid][index][ao_z] = fOffsetZ;
	AttachedObjects[playerid][index][ao_rx] = fRotX;
	AttachedObjects[playerid][index][ao_ry] = fRotY;
	AttachedObjects[playerid][index][ao_rz] = fRotZ;
	AttachedObjects[playerid][index][ao_sx] = fScaleX;
	AttachedObjects[playerid][index][ao_sy] = fScaleY;
	AttachedObjects[playerid][index][ao_sz] = fScaleZ;
	AttachedObjects[playerid][index][ao_active] = true;

	SetPlayerAttachedObject(playerid, index, modelid, bone, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, materialcolor1, materialcolor2); 
	return index;
}

DetachPlayerItem(playerid, index)
{
	AttachedObjects[playerid][index][ao_active] = false;
	PlayerAttachments_SetActive(playerid, AttachedObjects[playerid][index][ao_model], false);
	RemovePlayerAttachedObject(playerid, index);
	return 1;
}

GetFreeAttachedObjectSlot(playerid)
{
	for(new i; i<MAX_PLAYER_ATTACHED_OBJECTS; i++) 
	{
		if(!IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			return i;
		}
	}
	return INVALID_ATTACHED_OBJECT_INDEX; 
}

PlayerHasAttachedObject(playerid, model)
{
	return VECTOR_find_val(VAttachedItems[playerid], model) != INVALID_VECTOR_INDEX;
}

HasPlayerActiveAttachedObject(playerid, model)
{
	for(new i; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
		if(AttachedObjects[playerid][i][ao_active] && AttachedObjects[playerid][i][ao_model] == model)
		{
			return true;
		}
	}
	return false;
}

CheckEditionBoundaries(playerid, Float:x, Float:y, Float:z, Float:sx, Float:sy, Float:sz)
{
	if(-0.5 > x || x > 0.5) 
	{ 
		sendErrorMessage(playerid, "Ten obiekt wykracza poza granice w osi X!");
		return 0;
	}
	if(-0.5 > y || y > 0.5) 
	{ 
		sendErrorMessage(playerid, "Ten obiekt wykracza poza granice w osi Y!");
		return 0;
	}
	if(-0.5 > z || z > 0.5) 
	{ 
		sendErrorMessage(playerid, "Ten obiekt wykracza poza granice w osi Z!");
		return 0;
	}

	if(0.5 > sx || sx > 1.5) 
	{
		sendErrorMessage(playerid, "Ten obiekt jest za du¿y w skali X!");
		return 0;
	} 
	if(0.5 > sy || sy > 1.5) 
	{
		sendErrorMessage(playerid, "Ten obiekt jest za du¿y w skali Y!");
		return 0;
	} 
	if(0.5 > sz || sz > 1.5) 
	{
		sendErrorMessage(playerid, "Ten obiekt jest za du¿y w skali Z!");
		return 0;
	} 
	return 1;
}

//-----------------<[ Dialogi: ]>-------------------
DialogPlayerAttachedItems(playerid)
{
	DynamicGui_Init(playerid);

	new count, list[7*MAX_PREMIUM_ITEMS];
	VECTOR_foreach(i : VAttachedItems[playerid])
	{
		new item = MEM_get_val(i);
		strcat(list, sprintf("%d\n", item));
		count++;
		DynamicGui_AddRow(playerid, 1, item);
	}

	if(count==0) return sendErrorMessage(playerid, "Nie masz ¿adnych zak³adalnych przedmiotów.");

	ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA, DIALOG_STYLE_PREVIEW_MODEL, "Twoje przedmioty", list, "Ustaw", "Wyjdz");
	return 1;
}

DialogRemovePlayerAttachedItems(playerid)
{
	DynamicGui_Init(playerid);

	new count, list[7*MAX_PLAYER_ATTACHED_OBJECTS];
	for(new i; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, i) && AttachedObjects[playerid][i][ao_active])
		{
			new item = AttachedObjects[playerid][i][ao_model];
			strcat(list, sprintf("%d\n", item));
			count++;
			DynamicGui_AddRow(playerid, 1, i);
		}
	}

	if(count==0) return sendErrorMessage(playerid, "Nie masz za³o¿onych przedmiotów.");

	ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA_ZDEJMIJ, DIALOG_STYLE_PREVIEW_MODEL, "Twoje przedmioty", list, "Zdejmij", "Wyjdz");
	return 1;
}

DialogAdminRemoveAttachedItems(playerid, giveplayerid)
{
	DynamicGui_Init(playerid);

	new count, list[7*MAX_PLAYER_ATTACHED_OBJECTS];
	for(new i; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
	{
		if(IsPlayerAttachedObjectSlotUsed(giveplayerid, i) && AttachedObjects[giveplayerid][i][ao_active])
		{
			new item = AttachedObjects[giveplayerid][i][ao_model];
			strcat(list, sprintf("%d\n", item));
			count++;
			DynamicGui_AddRow(playerid, 1, i);
		}
	}

	if(count==0) return sendErrorMessage(playerid, "Ten gracz nie ma za³o¿onych przedmiotów.");

	SetPVarInt(playerid, "ZdejmijGiveplayerid", giveplayerid);
	ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA_ZDEJMIJ_ADMIN, DIALOG_STYLE_PREVIEW_MODEL, "Przedmioty gracza", list, "Zdejmij", "Wyjdz");
	return 1;
}

DialogBoneSelect(playerid, bone=0)
{
	new string[256];
	for(new i=0; i<18; i++)
	{
		if(i == (bone-1))
		{
			strcat(string, sprintf(INCOLOR_GREEN"%s\n"INCOLOR_WHITE, BoneNames[i]));
		}
		else
		{
			strcat(string, sprintf("%s\n", BoneNames[i]));
		}
	}
	ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA_KOSC, DIALOG_STYLE_LIST, "Wybierz gdzie przyczepiæ przedmiot.", 
		string, 
		"Przyczep",
		"WyjdŸ"
	);
}

//end