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
	AttachedObjects[playerid][index][ao_x] = fOffsetX;
	AttachedObjects[playerid][index][ao_y] = fOffsetY;
	AttachedObjects[playerid][index][ao_z] = fOffsetZ;
	AttachedObjects[playerid][index][ao_rx] = fRotX;
	AttachedObjects[playerid][index][ao_ry] = fRotY;
	AttachedObjects[playerid][index][ao_rz] = fRotZ;
	AttachedObjects[playerid][index][ao_sx] = fScaleX;
	AttachedObjects[playerid][index][ao_sy] = fScaleY;
	AttachedObjects[playerid][index][ao_sz] = fScaleZ;

	SetPlayerAttachedObject(playerid, index, modelid, bone, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ, materialcolor1, materialcolor2); 
	return index;
}

UnattachPlayerItem(playerid, index)
{
	RemovePlayerAttachedObject(playerid, index);
}

GetFreeAttachedObjectSlot(playerid)
{
	for(new i; i<MAX_PLAYER_ATTACHED_OBJECTS; i++) 
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, i))
		{
			return i;
		}
	}
	return INVALID_ATTACHED_OBJECT_INDEX; 
}

PlayerHasAttachedObject(playerid, model)
{
	return map_has_key(MAttachedItems[playerid], model);
}
//-----------------<[ Dialogi: ]>-------------------
DialogPlayerAttachedItems(playerid)
{
	DynamicGui_Init(playerid);

	new count, list[7*MAX_PREMIUM_ITEMS];
	for(new Iter:i = map_iter(MAttachedItems[playerid]); iter_inside(i); iter_move_next(i))
	{
		new item;
		iter_get_key_safe(i, item);
		strcat(list, sprintf("%d\n", item));
		count++;
		DynamicGui_AddRow(playerid, 1, item);
	}

	if(count==0) return sendErrorMessage(playerid, "Nie masz ¿adnych przedmiotów premium.");

	ShowPlayerDialogEx(playerid, DIALOG_PRZEDMIOTYGRACZA, DIALOG_STYLE_PREVIEW_MODEL, "Premium - Twoje przedmioty", list, "Ustaw", "Wyjdz");
	return 1;
}

//end