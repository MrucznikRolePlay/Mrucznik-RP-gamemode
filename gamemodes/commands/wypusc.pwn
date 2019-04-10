//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wypusc ]------------------------------------------------//
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

CMD:free(playerid, params[]) return cmd_wypusc(playerid, params);
CMD:uwolnij(playerid, params[]) return cmd_wypusc(playerid, params);
CMD:wypusc(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(PlayerInfo[playerid][pJob] != 2)
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ prawnikiem!");
        return 1;
    }
	new giveplayerid;
	if( sscanf(params, "k<fix>", giveplayerid))
	{
		sendTipMessage(playerid, "U¿yj /uwolnij [playerid/CzêœæNicku]");
		return 1;
	}

    if(IsPlayerConnected(giveplayerid))
    {
        if(giveplayerid != INVALID_PLAYER_ID)
        {
            if(giveplayerid == playerid) { sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz uwalniaæ samego siebie!"); return 1; }
			if(PlayerInfo[giveplayerid][pJailed] == 1 && ApprovedLawyer[playerid] == 1 || PlayerInfo[giveplayerid][pJailed] == 2 && ApprovedLawyer[playerid] == 1)
			{
				if(ProxDetectorS(10.0, playerid, giveplayerid))
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* Uwolni³eœ %s z wiêzienia.", giveplayer);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* Zosta³eœ uwolniony przez prawnika %s.", sendername);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					ApprovedLawyer[playerid] = 0;
					WantLawyer[giveplayerid] = 0;
					CallLawyer[giveplayerid] = 0;
					JailPrice[giveplayerid] = 0;
					PlayerInfo[giveplayerid][pJailTime] = 1;
					PlayerInfo[playerid][pLawSkill] +=2;
					SendClientMessage(playerid, COLOR_GRAD2, "Skill +2");
					//SetPlayerWorldBounds(playerid,20000.0000,-20000.0000,20000.0000,-20000.0000); //Reset world to player
					if(PlayerInfo[playerid][pLawSkill] == 50)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 2, Mo¿esz taniej zbijaæ WL."); }
					else if(PlayerInfo[playerid][pLawSkill] == 100)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 3, Mo¿esz taniej zbijaæ WL."); }
					else if(PlayerInfo[playerid][pLawSkill] == 200)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 4, Mo¿esz taniej zbijaæ WL."); }
					else if(PlayerInfo[playerid][pLawSkill] == 400)
					{ SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiejêtnoœci prawnika wynosz¹ teraz 5, Mo¿esz taniej zbijaæ WL."); }
				}
				else
				{
					sendTipMessageEx(playerid, COLOR_GRAD1, "Nie jesteœ obok tego gracza, nie mo¿esz go uwolniæ");
				}
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GRAD1, "Gracz nie nie jest w wiêzieniu / nie posiadasz zgody od policjanta (poproœ o /akceptuj prawnik) !");
			}
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie ma takiego gracza!");
	}//not connected
	return 1;
}


