//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ admini ]------------------------------------------------//
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

CMD:admins(playerid) return cmd_admini(playerid);
CMD:admini(playerid)
{
    new string[64];
    new sendername[MAX_PLAYER_NAME];
    SendClientMessage(playerid, COLOR_GRAD1, "Lista administratorów:");
    foreach(Player, i)
    {
        if(PlayerInfo[i][pAdmin] >= 1)
        {
            if(PlayerInfo[i][pAdmin] == 5555 || PlayerInfo[i][pAdmin] == 7)
            {
                if(PlayerInfo[playerid][pAdmin] != 5000 || PlayerInfo[playerid][pAdmin] != 5001) continue;
            }
            GetPlayerName(i, sendername, sizeof(sendername));
            if(PlayerInfo[playerid][pAdmin] >= 1)
            {
                format(string, sizeof(string), "Admin: %s (ID: %d) lvl %d", sendername, i, PlayerInfo[i][pAdmin]);
            }
            else
            {
                format(string, sizeof(string), "Admin: %s (ID: %d)", sendername, i);
            }
            SendClientMessage(playerid, COLOR_GRAD1, string);
        }
        else if(PlayerInfo[i][pNewAP] >=1 && PlayerInfo[i][pNewAP] <= 3)
        {
            GetPlayerName(i, sendername, sizeof(sendername));
            format(string, sizeof(string), "Pó³Admin: %s (ID: %d)", sendername, i);
            SendClientMessage(playerid, COLOR_GRAD2, string);
        }
        else if(PlayerInfo[i][pNewAP] == 5)
        {
            GetPlayerName(i, sendername, sizeof(sendername));
            format(string, sizeof(string), "Skrypter: %s (ID: %d)", sendername, i);
            SendClientMessage(playerid, COLOR_GRAD3, string);
        }
    }
    //SendClientMessage(playerid, COLOR_YELLOW, "Administrator nie ma czasu pomóc lub nie odpowiada na twoje pytanie? Jest na to sposób!");
    //SendClientMessage(playerid, COLOR_P@, "Wpisz /zaufani aby zobaczyæ listê Zaufanych Graczy. Oni te¿ pomog¹!");
    return 1;
}

/*CMD:zaufani(playerid)
{
	new string[64];
	new sendername[MAX_PLAYER_NAME];

	SendClientMessage(playerid, COLOR_GRAD1, "Lista ZG:");
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(PlayerInfo[i][pZG] == 1)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Opiekun IC: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 2)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Nowy Zaufany gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 3)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Zwyk³y zaufany gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 4)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 5)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Przyzwoity Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 6)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Dobry Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 7)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Bardzo Dobry Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 8)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Œwietny Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 9)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Znakomity Zaufany Gracz: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
			else if(PlayerInfo[i][pZG] == 10)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, sizeof(string), "Æwieræ Admin: %s ID: %d", sendername, i);
				SendClientMessage(playerid, COLOR_GRAD2, string);
			}
		}
	}
	return 1;
}*/


