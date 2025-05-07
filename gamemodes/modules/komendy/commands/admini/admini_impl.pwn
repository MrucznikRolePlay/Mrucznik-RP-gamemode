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
command_admini_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
	{
		new string[128], activeAdmins;
		SendClientMessage(playerid, -1, "Lista administratorów na s³u¿bie:"); 
		foreach(new i : Player)
		{
			if(GetPlayerAdminDutyStatus(i) == 1)
			{
				//GetPVarString(i, "pAdminDutyNickOff", FirstNickname, sizeof(FirstNickname));
				if(PlayerInfo[i][pAdmin] == 5000)
				{
					format(string, sizeof(string), "{FFFFFF}H@: {FF6A6A}%s {FFFFFF}[ID: %d]", GetNickEx(i), i);
				}
				else if(IsAScripter(i)) 
				{
					format(string, sizeof(string), "{FFFFFF}Skrypter: {747b41}%s {FFFFFF}[ID: %d]", GetNickEx(i), i);
				}
				else if(PlayerInfo[i][pAdmin] >= 1)
				{
					format(string, sizeof(string), "{FFFFFF}Administrator: {FF6A6A}%s {FFFFFF}[ID: %d] [@LVL: %d]", GetNickEx(i), i, PlayerInfo[i][pAdmin]); 
				}
				else if(PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] <= 4)
				{
					format(string, sizeof(string), "{FFFFFF}Pó³-Admin: {00C0FF}%s {FFFFFF}[ID: %d] [P@LVL: %d]", GetNickEx(i), i, PlayerInfo[i][pNewAP]); 
				}
				sendTipMessage(playerid, string); 
				activeAdmins = true;
			}
		}
		if(!activeAdmins) 
		{
			SendClientMessage(playerid, -1, "--- Brak ---"); 
			SendClientMessage(playerid, -1, "Lista administratorów na serwerze:"); 
			foreach(new i : Player)
			{
				if(PlayerInfo[i][pAdmin] == 5000)
				{
					format(string, sizeof(string), "{888888}H@: {FF6A6A}%s {888888}[ID: %d]", GetNickEx(i), i);
					sendTipMessage(playerid, string); 
				}
				else if(IsAScripter(i)) 
				{
					format(string, sizeof(string), "{888888}Skrypter: {747b41}%s {888888}[ID: %d]", GetNickEx(i), i);
					sendTipMessage(playerid, string); 
				} 
				else if(PlayerInfo[i][pAdmin] >= 1)
				{
					format(string, sizeof(string), "{888888}Administrator: {FF6A6A}%s {888888}[ID: %d] [@LVL: %d]", GetNickEx(i), i, PlayerInfo[i][pAdmin]); 
					sendTipMessage(playerid, string); 
				}
				else if(PlayerInfo[i][pNewAP] >= 1 && PlayerInfo[i][pNewAP] <= 4)
				{
					format(string, sizeof(string), "{888888}Pó³-Admin: {00C0FF}%s {888888}[ID: %d] [P@LVL: %d]", GetNickEx(i), i, PlayerInfo[i][pNewAP]); 
					sendTipMessage(playerid, string); 
				}
			}
		}
		SendClientMessage(playerid, -1, "Lista ZG:");
		foreach (new i: Player)
		{
			if (IsAZasluzony(i))
			{
				format(string, sizeof(string), "{FFFFFF}Zas³u¿ony: {FFC0CB}%s {FFFFFF}[ID: %d]", GetNickEx(i), i);
				sendTipMessage(playerid, string);
			}
			else if(IsAZaufanyGracz(i))
			{
				format(string, sizeof(string), "{FFFFFF}Zaufany Gracz: {00FFFF}%s {FFFFFF}[ID: %d]", GetNickEx(i), i);
				sendTipMessage(playerid, string);
			}
		}
	}
	return 1;
}

//end
