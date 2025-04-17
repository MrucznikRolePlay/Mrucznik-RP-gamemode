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
command_bandana_Impl(playerid)
{
    if(IsAKidnapper(playerid) || (IsAFBI(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
		new string[64];
		new nick[24], sendername[MAX_PLAYER_NAME];
		if(GetPVarString(playerid, "maska_nick", nick, 24))
		{
			SendClientMessage(playerid, COLOR_GREY, " Musisz œci¹gn¹æ maskê z twarzy! (/maska).");
			return 1;
		}
		
		if(IsPlayerAttachedObjectSlotUsed(playerid, 2))
		{
			SetPlayerColor(playerid, TEAM_HIT_COLOR);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s sci¹ga bandane z twarzy.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			RemovePlayerAttachedObject(playerid,2);
		}
		else
		{
			SetPlayerColor(playerid, COLOR_BLACK);
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s zak³ada bandane na twarz.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			SetPlayerAttachedObject(playerid, 2, 18896, 2, 0.122467, 0.007340, 0.003190, 274.433288, 0.248657, 262.665466, 1.000000, 1.000000, 1.000000 );//bandana - czarna
		}
	}
	return 1;
}

//end
