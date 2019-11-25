//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ stazer ]------------------------------------------------//
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

/*YCMD:stazer(playerid, params[], help)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsACop(playerid) || IsABOR(playerid))
    	{
    	    if(OnDuty[playerid] != 0 && GetPVarInt(playerid, "tazer") == 1)
    	    {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "* %s wy³¹cza i chowa paralizator do kabury.", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				RemovePlayerAttachedObject(playerid,9);
                SetPVarInt(playerid, "tazer", 0);
			}
			else
			{
			    sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie!");
			}
		}
		return 1;
	}
	return 1;
}
*/