//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ a ]---------------------------------------------------//
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
	SZYBKA KOMENDA DO SPRAWDZENIA OCB z /wejdz do biz 
*/


// Notatki skryptera:
/*
	
*/

YCMD:achuj(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		new bbID;
		if(sscanf(params, "d<fix>", bbID))
		{
			sendTipMessage(playerid, "Chujowy jestes"); 
			return 1;
		}
		new string[124]; 
		format(string, sizeof(string), "X dla BIZ [%d] to: %f", bbID, Business[bbID][b_enX]);
		sendTipMessage(playerid, string); 
		format(string, sizeof(string), "Y dla BIZ [%d] to %f", bbID, Business[bbID][b_enY]);
		sendTipMessage(playerid, string); 
		format(string, sizeof(string), "Z dla BIZ [%d] to %f", bbID, Business[bbID][b_enZ]); 
		sendTipMessage(playerid, string); 
		format(string, sizeof(string), "BIZ_NAME: %s", Business[bbID][b_Name]); 
		sendTipMessage(playerid, string); 
	}
	return 1;
}



