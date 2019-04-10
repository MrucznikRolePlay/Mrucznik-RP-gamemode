//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ wtazer ]------------------------------------------------//
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

CMD:wtazer(playerid)
{
	new string[128];
	new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsACop(playerid) || IsABOR(playerid) )
    	{
    	    if(OnDuty[playerid] != 0)
    	    {
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "* %s wyci¹ga paralizator z kabury i w³¹cza.", sendername);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				SetPlayerAttachedObject(playerid, 9,18642, 6, 0.09, 0.05, 0.05, 0, 180, 90, 1.5, 1.5, 1.5);//paralizator
                SetPVarInt(playerid, "tazer", 1);
			}
			else
			{
			    sendErrorMessage(playerid, "Nie jesteœ na s³u¿bie !");
			}
		}
		return 1;
	}
	return 1;
}


