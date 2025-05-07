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
command_newbie_Impl(playerid, params[256])
{
    new string[128];
    if(IsPlayerConnected(playerid))
    {
        if(newbie == 1 && PlayerInfo[playerid][pAdmin] == 0 && !IsAScripter(playerid))
        {
            sendTipMessageEx(playerid, COLOR_GRAD2, "Chat newbie jest wy³¹czony!");
			return 1;
        }
        if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ gdy¿ zosta³eœ uciszony !");
			return 1;
		}
		if(PlayerInfo[playerid][pConnectTime] == 0)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Musisz przegraæ minimum 1h aby pisaæ na czacie newbie!");
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/n)ewbie [tekst]");
			return 1;
		}
		if(strlen(params) > 105)
		{
			sendErrorMessage(playerid, "Twoja wiadomoœæ by³a zbyt d³uga, skróæ j¹!"); 
			return 1;
		}
		if (strfind(params , "ip:" , true)>=0 ||strfind(params , "-roleplay" , true)>=0 || strfind(params , "Nicolson" , true)>=0 || strfind(params , "roleplay." , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , "794" , true)>=0 || strfind(params , "772" , true)>=0 || strfind(params , "797" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , "775" , true)>=0 || strfind(params , "91." , true)>=0 || strfind(params , "91," , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,GetNick(playerid),params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			Log(warningLog, INFO, "%s reklamuje na chacie newbie: %s", GetPlayerLogName(playerid), params);
		}
		else if (strfind(params , "kurwa" , true)>=0 ||strfind(params , "huj" , true)>=0 || strfind(params , "pizda" , true)>=0 || strfind(params , "cipa" , true)>=0  || strfind(params , "n00b" , true)>=0 || strfind(params , "noob" , true)>=0 || strfind(params , "pierdole" , true)>=0 || strfind(params , "debil" , true)>=0 || strfind(params , "fiut" , true)>=0 || strfind(params , "kutas" , true)>=0 || strfind(params , "jeb" , true)>=0 || strfind(params , "ssij" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Oka¿ trochê kultury na kanale OOC! Nie przeklinaj.");
			format(string, sizeof(string), "AdmWarning: [%d] %s Przeklina: %s.",playerid,GetNick(playerid),params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			
			Log(warningLog, INFO, "%s przeklina na chacie newbie: %s", GetPlayerLogName(playerid), params);
		}
		else if (strfind(params , ":1" , true)>=0 || strfind(params , ":2" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0 || strfind(params , ":9" , true)>=0 || strfind(params , "s-rp" , true)>=0 || strfind(params , "s - rp" , true || strfind(params , "s- rp" , true)>=0)>=0 || strfind(params , "s -rp" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,GetNick(playerid),params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			Log(warningLog, INFO, "%s reklamuje na chacie newbie: %s", GetPlayerLogName(playerid), params);
		}
		else
		{
			if(AntySpam[playerid] == 1)
			{
			    sendTipMessageEx(playerid, COLOR_GRAD3, "Odczekaj 30 sekund zanim napiszesz now¹ wiadomoœæ");
			    return 1;
			}
			if(PlayerInfo[playerid][pBP] >= 1)
			{
			    format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
				sendTipMessageEx(playerid, TEAM_CYAN_COLOR, string);
				return 1;
			}
			new nobchat[512];
			if(IsAHeadAdmin(playerid))
		    {
				format(nobchat, sizeof(nobchat), "(({FF6347} H@ %s: {8D8DFF}%s ))", GetNickEx(playerid), params);
			}
			else if(IsAScripter(playerid))
            {
                format(nobchat, sizeof(nobchat), "(({00FF8C} Skrypter %s: {8D8DFF}%s ))", GetNickEx(playerid), params);
            }
            else if(PlayerInfo[playerid][pAdmin] >= 1)
		    {
				format(nobchat, sizeof(nobchat), "(({FF6347} Administrator [%d] %s: {8D8DFF}%s ))", PlayerInfo[playerid][pAdmin], GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3)
		    {
				format(nobchat, sizeof(nobchat), "(({AA3333} Pó³ Administrator [%d] %s: {8D8DFF}%s ))", PlayerInfo[playerid][pAdmin], GetNickEx(playerid), params);
			}
	 		else if(IsPlayerPremiumOld(playerid))
			{
			    format(nobchat, sizeof(nobchat), "(({FFD700} Sponsor [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
		 	else if(PlayerInfo[playerid][pLevel] == 1 || PlayerInfo[playerid][pLevel] == 2 || PlayerInfo[playerid][pLevel] == 3)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Newbie [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 4)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Pocz¹tkuj¹cy [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 5)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Przeciêtniak [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 6 || PlayerInfo[playerid][pLevel] == 7)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Kumaty [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 8 || PlayerInfo[playerid][pLevel] == 9)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Obeznany [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 10 || PlayerInfo[playerid][pLevel] == 11)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Doœwiadczony [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 12|| PlayerInfo[playerid][pLevel] == 13)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Specjalista [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 14 || PlayerInfo[playerid][pLevel] == 15)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Expert [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 16 || PlayerInfo[playerid][pLevel] == 17)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Weteran [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 18 || PlayerInfo[playerid][pLevel] == 19)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Stary wyjadacz [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 20 || PlayerInfo[playerid][pLevel] == 21)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Mistrz [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 22 || PlayerInfo[playerid][pLevel] == 23)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Pro [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 24 || PlayerInfo[playerid][pLevel] == 25)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Elita [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 26 || PlayerInfo[playerid][pLevel] == 27)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Król RP [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 28 || PlayerInfo[playerid][pLevel] == 29)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Nieomylny [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 30 || PlayerInfo[playerid][pLevel] == 31)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Wyrocznia [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 32 || PlayerInfo[playerid][pLevel] == 33)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Cesarz RP [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] == 34 || PlayerInfo[playerid][pLevel] == 35)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Legenda [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][pLevel] >= 36)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Wszechwiedz¹cy [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			OOCNewbie(nobchat);
			if(!IsAScripter(playerid) && PlayerInfo[playerid][pAdmin] == 0 && PlayerInfo[playerid][pNewAP] == 0)
			{
				AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
			}
			Log(chatLog, INFO, "%s newbie: %s", GetPlayerLogName(playerid), params);
		}
	}
	return 1;
}

//end
