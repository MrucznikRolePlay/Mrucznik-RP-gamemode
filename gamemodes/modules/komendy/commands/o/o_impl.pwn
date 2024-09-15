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
command_o_Impl(playerid, params[256])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            return 1;
        }
		if ((noooc) && PlayerInfo[playerid][pAdmin] < 1)
		{
		    if(PlayerInfo[playerid][pNewAP] < 1)
		    {
		        if(PlayerInfo[playerid][pZG] < 5)
		        {
				    if(!IsPlayerPremiumOld(playerid))
				    {
						sendErrorMessage(playerid, "Kana³ OOC zosta³ zablokowany przez administratora !");
						return 1;
					}
				}
			}
		}
		if(PlayerInfo[playerid][pMuted] == 1)
		{
			sendTipMessage(playerid, "Nie mo¿esz mówiæ gdy¿ zosta³eœ uciszony!", TEAM_CYAN_COLOR);
			return 1;
		}
		if(PlayerInfo[playerid][pBP] >= 1)
		{
		    format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
			sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/o)oc [ooc chat]");
			return 1;
		}
		if (strfind(params , "ip:" , true)>=0 ||strfind(params , "-roleplay" , true)>=0 || strfind(params , "Nicolson" , true)>=0 || strfind(params , "roleplay." , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , "794" , true)>=0 || strfind(params , "772" , true)>=0 || strfind(params , "797" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , "775" , true)>=0 || strfind(params , "91." , true)>=0 || strfind(params , "91," , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			Log(warningLog, INFO, "%s reklamuje na globalnym chacie OOC: %s", GetPlayerLogName(playerid), params);
		}
		else if (strfind(params , "kurwa" , true)>=0 ||strfind(params , "huj" , true)>=0 || strfind(params , "pizda" , true)>=0 || strfind(params , "cipa" , true)>=0  || strfind(params , "n00b" , true)>=0 || strfind(params , "noob" , true)>=0 || strfind(params , "pierdole" , true)>=0 || strfind(params , "debil" , true)>=0 || strfind(params , "fiut" , true)>=0 || strfind(params , "kutas" , true)>=0 || strfind(params , "jeb" , true)>=0 || strfind(params , "ssij" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "Oka¿ trochê kultury na kanale OOC! Nie przeklinaj.");
			format(string, sizeof(string), "AdmWarning: [%d] %s Przeklina: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			Log(warningLog, INFO, "%s przeklina na globalnym chacie OOC: %s", GetPlayerLogName(playerid), params);
		}
		else if (strfind(params , ":1" , true)>=0 || strfind(params , ":2" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0 || strfind(params , ":9" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			Log(warningLog, INFO, "%s przeklina na globalnym chacie OOC: %s", GetPlayerLogName(playerid), params);
		}
		else
		{

			format(string, sizeof(string), "(( %s [%d]: %s ))", sendername, playerid, params);
			OOCOff(COLOR_OOC,string);
            Log(chatLog, INFO, "%s globalny chat OOC: %s", GetPlayerLogName(playerid), params);
		}
	}
	return 1;
}

//end
