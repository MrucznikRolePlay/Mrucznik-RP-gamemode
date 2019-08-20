//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                premiumskin                                                //
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
// Data utworzenia: 09.06.2019


//

//------------------<[ Implementacja: ]>-------------------
command_premiumskin_Impl(playerid, skin)
{
	if(!PlayerHasSkin(playerid, skin))
		return sendErrorMessage(playerid, "Nie masz tego skina.");

	if((OnDuty[playerid] == 1 && OnDutyCD[playerid] == 0) || SanDuty[playerid] == 1)
	{
		return sendErrorMessage(playerid, "Bêd¹c na s³u¿bie nie mo¿esz aktywowaæ unikatowego skina.");
	}

	if(IsPlayerInAnyVehicle(playerid))
	{
		return sendErrorMessage(playerid, "Nie mo¿esz przebraæ siê bêd¹c w pojeŸdzie.");
	}
	
	PlayerInfo[playerid][pModel] = skin;

	SetPlayerSkinEx(playerid, skin);

	_MruAdmin(playerid, sprintf("Aktywowa³eœ swój unikatowy skin [ID: %d]", skin));
	return 1;
}


//end