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
            sendErrorMessage(playerid, "Nie zalogowa�e� si�!");
            return 1;
        }
        new tmppass[64];
		if(sscanf(params, "s[64]", tmppass))
		{
			sendTipMessage(playerid, "U�yj /zmienhaslo [nowehaslo]");
			return 1;
		}
		
		if(strfind(params, "%") != -1)
		{
            sendErrorMessage(playerid, "Has�o nie mo�e zawiera� znaku procenta!");
            return 1;
		}
		
		sendErrorMessage(playerid, "Twoje has�o do konta w grze zosta�o zmienione!!!!");
		sendErrorMessage(playerid, "Je�li wpisa�e� t� komend� przypadkowo, nie wychod� z serwera i zmie� has�o ponownie za pomoc� tej komendy");
		sendErrorMessage(playerid, "Nowe has�o:");
		SendClientMessage(playerid, COLOR_PANICRED, tmppass);

		Log(serverLog, INFO, "%s zmieni� sobie has�o.", GetPlayerLogName(playerid));
		MruMySQL_ChangePassword(GetNickEx(playerid), tmppass);
	}
	return 1;
}

//end
