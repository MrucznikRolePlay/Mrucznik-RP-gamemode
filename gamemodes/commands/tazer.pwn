//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ tazer ]-------------------------------------------------//
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

CMD:tazer(playerid, params[])
{
    new string[128];
	new sendername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, sendername, sizeof(sendername));
    if(IsPlayerConnected(playerid))
    {
		if((gTeam[playerid] == 2 || IsACop(playerid) || IsABOR(playerid)) && OnDuty[playerid] == 1)
		{
    		if((GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24) && MaTazer[playerid] == 0)
			{
                if(GetPVarInt(playerid, "wytazerowany") > 0) return sendErrorMessage(playerid, "Tazer mo¿esz u¿yæ 15s po u¿yciu!");
 				MaTazer[playerid] = 1;
 				//PlayerInfo[playerid][pGun2] = 23;
				//GivePlayerWeapon(playerid, 23, PlayerInfo[playerid][pAmmo2]);
				//SetPlayerAttachedObject(playerid, 9,18642, 6, 0.09, 0.05, 0.05, 0, 180, 90, 2, 2, 2);
       			format(string, sizeof(string), "* %s odbezpiecza, ³aduje nabój i aktywuje tazer.", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
 			}
  			else if((GetPlayerWeapon(playerid) == 23 || GetPlayerWeapon(playerid) == 24) && MaTazer[playerid] == 1)
			{
				MaTazer[playerid] = 0;
				//PlayerInfo[playerid][pGun2] = 24;
				//GivePlayerWeapon(playerid, 24, PlayerInfo[playerid][pAmmo2]);
				//RemovePlayerAttachedObject(playerid, 9);
				format(string, sizeof(string), "* %s zabezpiecza i dezaktywuje tazer.", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
			else
			{
				sendTipMessageEx(playerid, COLOR_GREY, "Nie masz wyci¹gniêtej odpowiedniej broni!");
				return 1;
			}
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ z LSPD/FBI/SASD/GSA lub nie jesteœ na s³u¿bie!");
			return 1;
		}
	}
    return 1;
}
//CMD:tazer22(playerid, params[]) return cmd_paralizuj(playerid, params);
