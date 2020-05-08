//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ makeircadmin ]---------------------------------------------//
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

YCMD:makeircadmin(playerid, params[], help)
{
	new string[128];
	new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
		new giveplayerid, channel;
		if( sscanf(params, "k<fix>d", giveplayerid, channel))
		{
			sendTipMessage(playerid, "U¿yj /makeircadmin [playerid/CzêœæNicku] [NrKana³u]");
			return 1;
		}

		if(channel > 10 || channel < 0) { sendTipMessage(playerid, "Numer nie mo¿e wynosiæ 0, albo wiêcej ni¿ 10!"); return 1; }
		if(IsAScripter(playerid) || Uprawnienia(playerid, ACCESS_MAKELEADER))
		{
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					format(string, sizeof(string), "* Da³eœ %s admina kana³u IRC nr %d.", giveplayer, channel);
					SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "* %s Mianowa³ ciê administratorem kana³u IRC nr %d.", GetNickEx(playerid), channel);
					SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, string);
					format(string, sizeof(string), "%s", giveplayer);
					switch(channel)
					{
					    case 1:
					    {
					        strmid(IRCInfo[0][iAdmin], string, 0, strlen(string));
					        IRCInfo[0][iNeedPass] = 0; IRCInfo[0][iLock] = 0;
					    }
					    case 2:
					    {
					        strmid(IRCInfo[1][iAdmin], string, 0, strlen(string));
					        IRCInfo[1][iNeedPass] = 0; IRCInfo[1][iLock] = 0;
					    }
					    case 3:
					    {
					        strmid(IRCInfo[2][iAdmin], string, 0, strlen(string));
					        IRCInfo[2][iNeedPass] = 0; IRCInfo[2][iLock] = 0;
					    }
					    case 4:
					    {
					        strmid(IRCInfo[3][iAdmin], string, 0, strlen(string));
					        IRCInfo[3][iNeedPass] = 0; IRCInfo[3][iLock] = 0;
					    }
					    case 5:
					    {
					        strmid(IRCInfo[4][iAdmin], string, 0, strlen(string));
					        IRCInfo[4][iNeedPass] = 0; IRCInfo[4][iLock] = 0;
					    }
					    case 6:
					    {
					        strmid(IRCInfo[5][iAdmin], string, 0, strlen(string));
					        IRCInfo[5][iNeedPass] = 0; IRCInfo[5][iLock] = 0;
					    }
					    case 7:
					    {
					        strmid(IRCInfo[6][iAdmin], string, 0, strlen(string));
					        IRCInfo[6][iNeedPass] = 0; IRCInfo[6][iLock] = 0;
					    }
					    case 8:
					    {
					        strmid(IRCInfo[7][iAdmin], string, 0, strlen(string));
					        IRCInfo[7][iNeedPass] = 0; IRCInfo[7][iLock] = 0;
					    }
					    case 9:
					    {
					        strmid(IRCInfo[8][iAdmin], string, 0, strlen(string));
					        IRCInfo[8][iNeedPass] = 0; IRCInfo[8][iLock] = 0;
					    }
					    case 10:
					    {
					        strmid(IRCInfo[9][iAdmin], string, 0, strlen(string));
					        IRCInfo[9][iNeedPass] = 0; IRCInfo[9][iLock] = 0;
					    }
					}
					SaveIRC();
				}
			}
			else
			{
			    sendErrorMessage(playerid, "Nie ma takiego gracza !");
			    return 1;
			}
		}
		else
		{
		    noAccessMessage(playerid);
		    return 1;
		}
	}
	return 1;
}
