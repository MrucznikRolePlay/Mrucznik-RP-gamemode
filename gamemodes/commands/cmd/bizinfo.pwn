//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ bizinfo ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:bizinfo(playerid, params[], help)
{
	if(CheckIfPlayerInBiznesPoint(playerid) == 0)
	{
		sendErrorMessage(playerid, "Nie jesteœ obok biznesu!"); 
		return 1;
	}
	new ID_BUSINESS = GetPVarInt(playerid, "JestObokBiz"); 
	new string[256]; 
	if(Business[ID_BUSINESS][b_ownerUID] == 0)
	{
		format(string, sizeof(string), "{FFFFFF}Nazwa: {37AC45}%s\n{FFFFFF}ID: {37AC45}%d\n{FFFFFF}Cena: {37AC45}$%d\n{FFFFFF}Dochody: {37AC45}$%d\n{FFFFFF}Lokalizacja: {37AC45}%s",
		Business[ID_BUSINESS][b_Name],
		ID_BUSINESS,
		Business[ID_BUSINESS][b_cost],
		Business[ID_BUSINESS][b_maxMoney],
		Business[ID_BUSINESS][b_Location]); 
	}
	else if(Business[ID_BUSINESS][b_ownerUID] != 0)
	{
		format(string, sizeof(string), "{FFFFFF}Nazwa: {37AC45}%s\n{FFFFFF}W³aœciciel: {37AC45}%s\n{FFFFFF}ID: {37AC45}%d\n{FFFFFF}Cena: {37AC45}$%d\n{FFFFFF}Dochody: {37AC45}$%d\n{FFFFFF}Lokalizacja: {37AC45}%s",
		Business[ID_BUSINESS][b_Name],
		Biz_Owner(ID_BUSINESS), 
		ID_BUSINESS,
		Business[ID_BUSINESS][b_cost],
		Business[ID_BUSINESS][b_maxMoney],
		Business[ID_BUSINESS][b_Location]); 
	}
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string, false); 
	return 1;
}
