//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_sprobuj_Impl(playerid, params[256])
{
    if(isnull(params)) return sendTipMessage(playerid, "U�yj /sprobuj [Akcja] np. trafi� do kosza");
	if(GetPlayerAdminDutyStatus(playerid) == 1)
	{
		sendErrorMessage(playerid, "Nie mo�esz u�y� tej komendy podczas s�u�by administratora!"); 
		return 1;
	}
    new string[256];
	//switch(random(4)+1) 
	new rand = random(2);
    switch(rand)
	{
		case 0: format(string, 256, "*** %s spr�bowa� %s i uda�o mu si� ***",GetNick(playerid), params);
		case 1: format(string, 256, "*** %s spr�bowa� %s i nie uda�o mu si� ***",GetNick(playerid), params);
	}
    ProxDetector(30.0, playerid, string, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO, COLOR_DO);
	Log(chatLog, INFO, "%s spr�buj: %s", GetPlayerLogName(playerid), params);
	return 1;
}

//end
