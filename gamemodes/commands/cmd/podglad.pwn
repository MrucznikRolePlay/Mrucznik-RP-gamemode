//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ podglad ]------------------------------------------------//
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

YCMD:podglad(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, reason[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, reason))
		{
			sendTipMessage(playerid, "U¿yj /podglad [playerid/CzêœæNicku] [powód]");
			return 1;
		}

		if (PlayerInfo[playerid][Admin] >= 1)
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
				ShowPlayerSentMessages(giveplayerid, playerid);
				Log(adminLog, INFO, "Admin %s podejrza³ wiadomoœci gracza %s, powód: %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), reason);
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
