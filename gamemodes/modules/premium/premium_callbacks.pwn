//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                  premium                                                  //
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
// Data utworzenia: 04.05.2019
//Opis:
/*
	Monetyzacja, us³ugi premium.
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
hook OnPlayerEditAttachedObj(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(VECTOR_find_val(VPremiumItems[playerid], modelid))
	{
		if(response)
		{
			SendClientMessage(playerid, COLOR_GREEN, "Edytowa³eœ pozycjê swojego przedmiotu.");
	
			ao[playerid][index][ao_x] = fOffsetX;
			ao[playerid][index][ao_y] = fOffsetY;
			ao[playerid][index][ao_z] = fOffsetZ;
			ao[playerid][index][ao_rx] = fRotX;
			ao[playerid][index][ao_ry] = fRotY;
			ao[playerid][index][ao_rz] = fRotZ;
			ao[playerid][index][ao_sx] = fScaleX;
			ao[playerid][index][ao_sy] = fScaleY;
			ao[playerid][index][ao_sz] = fScaleZ;

			MruMySQL_UpdatePremiumItem(playerid, modelid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, boneid, true);
			SetPlayerAttachedObject(playerid, index, modelid, boneid, 
				fOffsetX, fOffsetY, fOffsetZ, 
				fRotX, fRotY, fRotZ, 
				1, 1, 1 //scale always 1
			);
		}
		else
		{
			SendClientMessage(playerid, COLOR_RED, "Anulowa³eœ edycjê pozycjê swojego przedmiotu.");
	
			SetPlayerAttachedObject(playerid, index, modelid, boneid, 
				ao[playerid][index][ao_x], ao[playerid][index][ao_y], ao[playerid][index][ao_z], 
				ao[playerid][index][ao_rx], ao[playerid][index][ao_ry], ao[playerid][index][ao_rz], 
				ao[playerid][index][ao_sx], ao[playerid][index][ao_sy], ao[playerid][index][ao_sz]
			);
		}
	}
    return 0;
}

//end