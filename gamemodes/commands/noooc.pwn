//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ noooc ]-------------------------------------------------//
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

CMD:noooc(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        new string[128];
		if (PlayerInfo[playerid][pAdmin] >= 20 && (!noooc))
		{
			noooc = 1;
			BroadCast(COLOR_GRAD2, "»» Czat OOC Zosta³ zablokowany przez Administratora !");

            format(string, 128, "CMD_Info: /noooc u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
		}
		else if (PlayerInfo[playerid][pAdmin] >= 20 && (noooc))
		{
			noooc = 0;
			BroadCast(COLOR_GRAD2, "»» Czat OOC Zosta³ odblokowany przez Administratora !");
            format(string, 128, "CMD_Info: /noooc u¿yte przez %s [%d]", GetNick(playerid), playerid);
            SendCommandLogMessage(string);
            CMDLog(string);
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}



