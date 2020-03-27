//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ newbie ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:newbie(playerid, params[], help)
{
	new string[128];
    if(IsPlayerConnected(playerid))
    {
        if(newbie == 1 && PlayerInfo[playerid][Admin] == 0 && !IsAScripter(playerid))
        {
            sendTipMessageEx(playerid, COLOR_GRAD2, "Chat newbie jest wy³¹czony!");
			return 1;
        }
        if(PlayerInfo[playerid][Mute] == 1)
		{
			sendTipMessageEx(playerid, TEAM_CYAN_COLOR, "Nie mo¿esz mówiæ gdy¿ zosta³eœ uciszony !");
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/n)ewbie [tekst]");
			return 1;
		}
		if(strlen(params) > 78)
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
			if(IsAScripter(playerid))
            {
                format(nobchat, sizeof(nobchat), "(({00FF8C} Skrypter %s: {8D8DFF}%s ))", GetNickEx(playerid), params);
            }
            else if(PlayerInfo[playerid][Admin] >= 1 && PlayerInfo[playerid][Admin] != 7 && PlayerInfo[playerid][Admin] != 5555)
		    {
				format(nobchat, sizeof(nobchat), "(({FF6347} Administrator [%d] %s: {8D8DFF}%s ))", PlayerInfo[playerid][Admin], GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][HalfAdmin] >= 1 && PlayerInfo[playerid][HalfAdmin] <= 3)
		    {
				format(nobchat, sizeof(nobchat), "(({AA3333} Pó³ Administrator [%d] %s: {8D8DFF}%s ))", PlayerInfo[playerid][Admin], GetNickEx(playerid), params);
			}
	 		else if(IsPlayerPremiumOld(playerid))
			{
			    format(nobchat, sizeof(nobchat), "(({FFD700} Sponsor [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
		 	else if(PlayerInfo[playerid][Level] == 1 || PlayerInfo[playerid][Level] == 2 || PlayerInfo[playerid][Level] == 3)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Newbie [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 4)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Pocz¹tkuj¹cy [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 5)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Przeciêtniak [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 6 || PlayerInfo[playerid][Level] == 7)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Kumaty [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 8 || PlayerInfo[playerid][Level] == 9)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Obeznany [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 10 || PlayerInfo[playerid][Level] == 11)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Doœwiadczony [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 12|| PlayerInfo[playerid][Level] == 13)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Specjalista [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 14 || PlayerInfo[playerid][Level] == 15)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Expert [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 16 || PlayerInfo[playerid][Level] == 17)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Weteran [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 18 || PlayerInfo[playerid][Level] == 19)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Stary wyjadacz [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 20 || PlayerInfo[playerid][Level] == 21)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Mistrz [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 22 || PlayerInfo[playerid][Level] == 23)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Pro [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 24 || PlayerInfo[playerid][Level] == 25)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Elita [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 26 || PlayerInfo[playerid][Level] == 27)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Król RP [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 28 || PlayerInfo[playerid][Level] == 29)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Nieomylny [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 30 || PlayerInfo[playerid][Level] == 31)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Wyrocznia [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 32 || PlayerInfo[playerid][Level] == 33)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Cesarz RP [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] == 34 || PlayerInfo[playerid][Level] == 35)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Legenda [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			else if(PlayerInfo[playerid][Level] >= 36)
			{
			    format(nobchat, sizeof(nobchat), "(({7B68EE} Wszechwiedz¹cy [%d] %s: {8D8DFF}%s ))", playerid, GetNickEx(playerid), params);
			}
			OOCNewbie(nobchat);
			if(!IsAScripter(playerid) && PlayerInfo[playerid][Admin] == 0 && PlayerInfo[playerid][HalfAdmin] == 0)
			{
				AntySpam[playerid] = 1;
				SetTimerEx("AntySpamTimer",30000,0,"d",playerid);
			}
			Log(chatLog, INFO, "%s newbie: %s", GetPlayerLogName(playerid), params);
		}
	}
	return 1;
}
