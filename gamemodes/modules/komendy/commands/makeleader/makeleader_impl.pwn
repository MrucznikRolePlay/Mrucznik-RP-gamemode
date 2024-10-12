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
command_makeleader_Impl(playerid, params[256])
{
    new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1, level;
		if( sscanf(params, "k<fix>d", para1, level))
		{
			return sendTipMessage(playerid, "U¿yj /makeleader [playerid/CzêœæNicku] [Number(0-17)]");
		}

		if(level > 17 || level < 0) { return sendTipMessageEx(playerid, COLOR_GREY, "Numer lidera od 1 do 17!"); }
		if (!Uprawnienia(playerid, ACCESS_MAKELEADER) && !IsAScripter(playerid))
		{
			return noAccessMessage(playerid);
		}

		if(IsPlayerConnected(para1))
		{
			if(para1 == INVALID_PLAYER_ID)
			{
				return 1;
			}
		}
		else
		{
			return 1;
		}

		if(level == 0)
		{
			UnFrakcja(playerid, para1, false);
			return 1;
		}
		if(PlayerInfo[para1][pMember] > 0|| GetPlayerOrg(para1) != 0 )
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Ten gracz jest we frakcji lub w organizacji !");
			return 1;
		}
		/*if((LeadersValue[LEADER_FRAC][level]+1) > MAX_LEADERS_ON_FRAC)
		{
			format(string, sizeof(string), "Nie mo¿esz przyj¹æ kolejnego lidera! Limit to %d", MAX_LEADERS_ON_FRAC); 
			sendErrorMessage(playerid, string); 
			return 1;
		}*/
		GetPlayerName(para1, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		PlayerInfo[para1][pLider] = level;
		PlayerInfo[para1][pLiderValue] = 1; 
		PlayerInfo[para1][pMember] = level;
		MruMySQL_SetAccInt("Member", giveplayer, level);
		//MruMySQL_SetAccInt("Lider", giveplayer, level);
		Create_MySQL_Leader(para1, level, 1);//Tworzenie konta GLD
		Save_MySQL_Leader(para1);
		format(string, sizeof(string), "Zosta³eœ mianowany liderem [GLD] frakcji przez %s", sendername);
		SendClientMessage(para1, COLOR_LIGHTBLUE, string);
		format(string, sizeof(string), "Da³eœ graczowi %s kontrolê [GLD] nad frakcj¹ numer %d.", giveplayer,level);
		SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
		
		//logi
		Log(adminLog, INFO, "Admin %s da³ graczowi %s lidera [GLD] frakcji %s", GetPlayerLogName(playerid), GetPlayerLogName(para1), GetFractionLogName(level));
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			iloscInne[playerid] = iloscInne[playerid]+1;
		}
		
		SetDefaultUniform(para1);
		if(level != 0)
		{
			PlayerInfo[para1][pRank] = 6;
		}
	}
	return 1;
}

//end
