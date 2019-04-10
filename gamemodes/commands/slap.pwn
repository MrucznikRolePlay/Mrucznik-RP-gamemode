//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ slap ]-------------------------------------------------//
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

CMD:slap(playerid, params[])
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new playa;
		if( sscanf(params, "k<fix>", playa))
		{
			sendTipMessage(playerid, "U¿yj /slap [playerid/CzêœæNicku]");
			return 1;
		}

		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;

		if (PlayerInfo[playerid][pAdmin] >=1 || PlayerInfo[playerid][pNewAP] >= 1 && PlayerInfo[playerid][pNewAP] <= 3 || PlayerInfo[playerid][pZG] >= 2
            || IsAScripter(playerid))
		{
		    if(IsPlayerConnected(playa))
		    {
		        if(playa != INVALID_PLAYER_ID)
		        {
			        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					GetPlayerHealth(playa, shealth);
					SetPlayerHealth(playa, shealth-5);
					GetPlayerPos(playa, slx, sly, slz);
					SetPlayerPosEx(playa, slx, sly, slz+5);
					PlayerPlaySound(playa, 1130, slx, sly, slz+5);
					printf("AdmCmd: %s da³ klaspa w dupsko %s",sendername,  giveplayer);
					format(string, sizeof(string), "AdmCmd: %s da³ klapsa w dupsko %s",sendername, giveplayer);
					ABroadCast(COLOR_LIGHTRED,string,1);
					format(string, sizeof(string), "Dosta³eœ klapsa w dupsko od administratora %s, widocznie zrobi³eœ coœ z³ego :)", sendername);
					SendClientMessage(playa, COLOR_PANICRED, string);
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
