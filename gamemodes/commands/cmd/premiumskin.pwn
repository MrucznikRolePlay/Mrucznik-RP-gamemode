//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ premiumskin ]-----------------------------------------------//
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
// Data utworzenia: 2019-4-27

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/

YCMD:premiumskin(playerid, params[], help)
{
	return SendClientMessage(playerid, COLOR_GREEN, "Ju¿ wkrótce!");
/*	
	if(isnull(params))
		return sendTipMessage(playerid, "U¿yj /premiumskin [ID Skina]");

	new skin = strval(params);

	if(!PlayerHasSkin(playerid, skin))
		return sendErrorMessage(playerid, "Nie masz tego skina.");

	if((OnDuty[playerid] == 1 && OnDutyCD[playerid] == 0) || SanDuty[playerid] == 1)
	{
		return sendErrorMessage(playerid, "Bêd¹c na s³u¿bie nie mo¿esz aktywowaæ unikatowego skina.");
	}
	
	PlayerInfo[playerid][pModel] = skin;

	SetPlayerSkin(playerid, skin);

	_MruAdmin(playerid, sprintf("Aktywowa³eœ swój unikatowy skin [ID: %d]", skin));

	return 1;*/
}