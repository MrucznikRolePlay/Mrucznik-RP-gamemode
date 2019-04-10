//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ adminduty ]-----------------------------------------------//
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

CMD:adminduty(playerid)
{
    new string[MAX_PLAYER_NAME];
	GetPlayerName(playerid, string, sizeof(string));
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
    	if(GetPVarInt(playerid, "adminduty") == 0)
    	{
    	    if((strfind(string, "Tom_Thompson", true) != -1))
        	{
            	SetPlayerName(playerid, "PECET");
            	SetPlayerColor(playerid, 0xFF0000FF);
        		SetPVarInt(playerid, "adminduty", 1);
        		SendClientMessage(playerid, -1, "Wszed³eœ na s³u¿bê Admina!");
			}
    	}
    	else
    	{
        	if((strfind(string, "PECET", true) != -1))
        	{
            	SetPlayerName(playerid, "Tom_Thompson");
            	SetPlayerColor(playerid,TEAM_HIT_COLOR);
        		SetPVarInt(playerid, "adminduty", 0);
        		SendClientMessage(playerid, -1, "Zszed³eœ ze s³u¿by Admina!");
			}
    	}
	}
    else
	{
        noAccessMessage(playerid);
    }
    return 1;
}

