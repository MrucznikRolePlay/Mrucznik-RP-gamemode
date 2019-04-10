//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ szpital ]------------------------------------------------//
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

CMD:szpital_info(playerid, params[]) return cmd_szpital(playerid, params);
CMD:szpital(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(!IsAMedyk(playerid))
		{
			sendErrorMessage(playerid, "Nie jesteœ lekarzem!");
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj (/szpital)-info [tekst]");
			return 1;
		}

		new string[128], sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
		{
			SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
			format(string, 128, "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
			ABroadCast(COLOR_LIGHTRED,string,1);
			CzitLog(string);
		}
		else
		{
			if(PlayerInfo[playerid][pBP] >= 1)
			{
				format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
				sendTipMessage(playerid, string);
				return 1;
			}
			if(PlayerInfo[playerid][pRank] < 3)
			{
                sendErrorMessage(playerid, "Komenda dostêpna od 3 rangi!");
			    return 1;
			}
			SendClientMessageToAll(COLOR_WHITE, "|___________ Medical Center ___________|");
			format(string, sizeof(string), "Lekarz %s: %s", sendername, params);
			SendClientMessageToAll(COLOR_LIGHTBLUE, string);
		}
	}
	return 1;
}

