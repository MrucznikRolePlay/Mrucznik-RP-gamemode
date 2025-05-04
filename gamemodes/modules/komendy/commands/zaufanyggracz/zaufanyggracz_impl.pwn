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
command_zaufanyggracz_Impl(playerid, params[256])
{
    new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /zg [admin chat]");
			return 1;
		}
		if(IsAZasluzony(playerid)) 
		{
			format(string, sizeof(string), "* Zas³u¿ony %s: %s", sendername, params);
		}
		else if(PlayerInfo[playerid][pZG] > 0) 
		{
			format(string, sizeof(string), "* Zaufany %s: %s", sendername, params);
		}
		else if(PlayerInfo[playerid][pAdmin] >= 5000) 
		{
			format(string, sizeof(string), "* H@ %s: %s", sendername, params);
		}
		else if(PlayerInfo[playerid][pAdmin] >= 1) 
		{
			format(string, sizeof(string), "* Admin %s: %s", sendername, params);
		}
		else if(IsAScripter(playerid))
		{
			format(string, sizeof(string), "* Skrypter %s - %s", sendername, params);
		}
		else
		{
			noAccessMessage(playerid);
			return 1;
		}
		
		SendZGMessage(0xAAC0CB, string);
		Log(chatLog, INFO, "%s zaufani gracze chat: %s", GetPlayerLogName(playerid), params);
	}
	return 1;
}

//end
