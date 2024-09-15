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
command_zmienhaslo_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            sendErrorMessage(playerid, "Nie zalogowa³eœ siê!");
            return 1;
        }
        new tmppass[64];
		if(sscanf(params, "s[64]", tmppass))
		{
			sendTipMessage(playerid, "U¿yj /zmienhaslo [nowehaslo]");
			return 1;
		}
		
		if(strfind(params, "%") != -1)
		{
            sendErrorMessage(playerid, "Has³o nie mo¿e zawieraæ znaku procenta!");
            return 1;
		}
		
		sendErrorMessage(playerid, "Twoje has³o do konta w grze zosta³o zmienione!!!!");
		sendErrorMessage(playerid, "Jeœli wpisa³eœ t¹ komendê przypadkowo, nie wychodŸ z serwera i zmieñ has³o ponownie za pomoc¹ tej komendy");
		sendErrorMessage(playerid, "Nowe has³o:");
		SendClientMessage(playerid, COLOR_PANICRED, tmppass);

		Log(serverLog, INFO, "Gracz %s zmieni³ sobie has³o.", GetPlayerLogName(playerid));
		MruMySQL_ChangePassword(GetNickEx(playerid), tmppass);
	}
	return 1;
}

//end
