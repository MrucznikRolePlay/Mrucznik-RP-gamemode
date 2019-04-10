//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ sasd ]-------------------------------------------------//
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

CMD:sasd(playerid, params[])
{
	new string[256];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		if(IsPlayerInFraction(playerid, FRAC_NG))
		{
			if(PlayerInfo[playerid][pRank] < 2)
			{
			    sendErrorMessage(playerid, "Musisz mieæ 2 range aby u¿ywaæ tej komendy !");
			    return 1;
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if(isnull(params))
			{
				sendTipMessage(playerid, "U¿yj /sasd [text]");
				return 1;
			}
			if(PlayerInfo[playerid][pBP] >= 1)
			{
			    format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
				sendTipMessage(playerid, string, TEAM_CYAN_COLOR);
				return 1;
			}
			if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , ",pl" , true)>=0  || strfind(params , " ip" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , "795" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
			{
				SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
				format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
				ABroadCast(COLOR_LIGHTRED,string,1);
				CzitLog(string);
			}
			else
			{
				SendClientMessageToAll(COLOR_WHITE, "|___________ Komunikat San Andreas Sherrif's Department ___________|");
				format(string, sizeof(string), "Funkcjonariusz %s: %s", sendername, params);
				SendClientMessageToAll(COLOR_GREEN, string);
			}
		}
		else
		{
			sendErrorMessage(playerid, "Nie jesteœ z SASD!");
		    return 1;
		}
	}
	return 1;
}

