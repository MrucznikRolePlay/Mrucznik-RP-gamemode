//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  bizinfo                                                  //
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
// Autor: Simeone
// Data utworzenia: 19.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_bizinfo_Impl(playerid)
{
    new businessID = GetNearestBusiness(playerid); 
	if(businessID == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie jesteœ obok biznesu!");
		return 1;
	}
	new string[256]; 
	format(string, sizeof(string), "{FFFFFF}Nazwa: {37AC45}%s\n{FFFFFF}W³aœciciel: {37AC45}%s [%d]\n{FFFFFF}ID: {37AC45}%d\n{FFFFFF}Cena: {37AC45}$%d\n{FFFFFF}Dochody: {37AC45}$%d\n{FFFFFF}Lokalizacja: {37AC45}%s",
		Business[businessID][b_Name],
		Business[businessID][b_Name_Owner], 
		Business[businessID][b_ownerUID],
		businessID,
		Business[businessID][b_cost],
		Business[businessID][b_maxMoney],
		Business[businessID][b_Location]
	); 
	ShowPlayerInfoDialog(playerid, "Mrucznik Role Play", string, false);     
    return 1;
}

//end