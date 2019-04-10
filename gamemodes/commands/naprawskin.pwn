//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ naprawskin ]----------------------------------------------//
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

CMD:naprawskin(playerid, params[])
{
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /naprawskin [playerid/CzêœæNicku]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 10)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
					if(GetPlayerState(para1) != PLAYER_STATE_ONFOOT) return sendTipMessage(playerid, "Aby naprawiæ skin gracz musi byæ pieszo!");
					GetPlayerName(para1, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					printf("AdmCmd: %s naprawi³ skin gracza %s.", sendername, giveplayer);
					
					new level = PlayerInfo[para1][pModel];
					SetPlayerSkin(para1, level);
					PlayerInfo[para1][pSkin] = level;

					_MruAdmin(playerid, sprintf("Naprawi³eœ skin graczowi %s [%d] za pomoc¹ komendy.", GetNick(para1, true), para1));
                    _MruAdmin(para1, sprintf("Twój skin zosta³ naprawiony przez %s [%d].", GetNick(playerid, true), playerid));
					SendCommandLogMessage(sprintf("Admin %s [%d] naprawi³ skin graczowi %s [%d].", GetNick(playerid, true), playerid, GetNick(para1, true), para1));
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
