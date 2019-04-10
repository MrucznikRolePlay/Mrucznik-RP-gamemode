//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ setarmor ]-----------------------------------------------//
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

CMD:setarmor(playerid, params[])
{
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa, health;
		if( sscanf(params, "k<fix>d", playa, health))
		{
			sendTipMessage(playerid, "U¿yj /setarmor [playerid/CzêœæNicku] [armor]");
			return 1;
		}

		if (PlayerInfo[playerid][pAdmin] >= 5000 || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
		            GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new string[128];
					format(string, sizeof(string), "AdmCmd: %s da³ $d armora %s", sendername, health,  giveplayer);
					StatsLog(string);
					SetPlayerArmour(playa, health);
					if(GetPlayerAdminDutyStatus(playerid) == 1)
					{
						iloscInne[playerid] = iloscInne[playerid]+1;
					}
				}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
