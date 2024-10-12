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
command_a_Impl(playerid, params[256])
{
    new string[256];
    if(IsPlayerConnected(playerid))
    {
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/a)dmin [admin chat]");
			return 1;
		}
		if(PlayerInfo[playerid][pAdmin] >= 5000) 
		{
			format(string, sizeof(string), "H@ [%d] %s - %s", PlayerInfo[playerid][pAdmin], GetNickEx(playerid), params);
		}
		else if(IsAScripter(playerid))
		{
			format(string, sizeof(string), "Skrypter %s - %s", GetNickEx(playerid), params);
		}
		else if(PlayerInfo[playerid][pAdmin] >= 1) 
		{
			format(string, sizeof(string), "Admin [%d] %s - %s", PlayerInfo[playerid][pAdmin], GetNickEx(playerid), params);
		}
		else if(PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 4)
		{
			format(string, sizeof(string), "Pó³-Admin [%d] %s - %s", PlayerInfo[playerid][pNewAP], GetNickEx(playerid), params);
		}
		else 
		{
			noAccessMessage(playerid);
			return 1;
		}
		SendAdminMessage(0xFFC0CB, string);
		SendDiscordMessage(DISCORD_ADMIN_CHAT, string);
		Log(chatLog, INFO, "%s admin chat: %s", GetPlayerLogName(playerid), params);

	}
	return 1;
}

//end
