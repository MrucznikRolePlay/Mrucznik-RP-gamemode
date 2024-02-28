//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ dajkm ]-------------------------------------------------//
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

YCMD:dajkm(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new para1;
		if( sscanf(params, "k<fix>", para1))
		{
			sendTipMessage(playerid, "U¿yj /dajkm [playerid/CzêœæNicku]");
			return 1;
		}

		GetPlayerName(playerid, sendername, sizeof(sendername));

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pMember] == 9 && PlayerInfo[playerid][pRank] >= 2 || strcmp(sendername,"Gonzalo_DiNorscio", false) == 0)
		{
		    if(IsPlayerConnected(para1))
		    {
		        if(para1 != INVALID_PLAYER_ID)
		        {
		            if(komentator[para1] != 1)
		            {
						GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						Log(adminLog, INFO, "Admin %s da³ %s komentatora ¿u¿lowego", GetPlayerLogName(playerid), GetPlayerLogName(para1));   
						SendClientMessage(para1, COLOR_LIGHTBLUE, "   Jesteœ teraz komentatorem ¿u¿lowym, bierz mikrofon");
						format(string, sizeof(string), "   Gracz %s jest teraz komentator ¿u¿lowym.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						komentator[para1] = 1;
						format(string, sizeof(string), "Komentator: Witam! Tu %s ! Bêdê komentowa³ ten wyœcig.", giveplayer);
						ProxDetectorW(500, -1106.9854, -966.4719, 129.1807, COLOR_WHITE, string);
					}
					else
					{
					    GetPlayerName(para1, giveplayer, sizeof(giveplayer));
						GetPlayerName(playerid, sendername, sizeof(sendername));
						Log(adminLog, INFO, "Admin %s zabra³ %s komentatora ¿u¿lowego", GetPlayerLogName(playerid), GetPlayerLogName(para1));   
						SendClientMessage(para1, COLOR_LIGHTBLUE, "   Ju¿ nie jestes komentatorem ¿u¿lowym");
						format(string, sizeof(string), "   Zabra³eœ graczowi %s komentatora ¿u¿lowego.", giveplayer);
						SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
						komentator[para1] = 0;
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
