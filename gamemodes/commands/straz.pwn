//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ straz ]-------------------------------------------------//
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

CMD:straz(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(GetPlayerFraction(playerid) != FRAC_LSFD)
		{
			sendTipMessage(playerid, "Nie jesteœ stra¿akiem!");
			return 1;
		}
		if(isnull(params))
		{
			sendTipMessage(playerid, "U¿yj /straz [tekst]");
			return 1;
		}
        if(PlayerInfo[playerid][pRank] < 2) return sendErrorMessage(playerid, "Potrzebujesz conajmniej 2 rangi.");
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
			SendClientMessageToAll(COLOR_WHITE, "|___________ Fire Department ___________|");
			format(string, sizeof(string), "Stra¿ak %s: %s", sendername, params);
			SendClientMessageToAll(COLOR_LIGHTRED, string);
		}
	}
	return 1;
}

