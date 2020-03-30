//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ laptop ]------------------------------------------------//
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

YCMD:laptop(playerid, params[], help)
{
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
	    if(PlayerInfo[playerid][pMember] == 8 || PlayerInfo[playerid][pLider] == 8)
	    {
		    if(ConnectedToPC[playerid] == 255)
		    {
		        SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Wy³¹czy³eœ swój laptop i zerwa³eœ po³¹czenie z agencj¹.");
		        ConnectedToPC[playerid] = 0;
		        return 1;
		    }
		    GetPlayerName(playerid, sendername, sizeof(sendername));
		    SendClientMessage(playerid, COLOR_LIGHTBLUE, "* W³¹czy³eœ swój laptop i po³¹czy³eœ siê z agencj¹.");
		    SendClientMessage(playerid, COLOR_WHITE, "|___ Hitman Agency ___|");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - News");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Kontrakty");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Givehit");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Backup");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Order");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Rangi");
		    SendClientMessage(playerid, COLOR_YELLOW2, "| - Wyloguj");
			SendClientMessage(playerid, COLOR_WHITE, "|______________|00:00|");
			ConnectedToPC[playerid] = 255;
		}
		else
		{
			sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ pracownikiem Hitman Agency !");
	        return 1;
	    }
	}
    return 1;
}
