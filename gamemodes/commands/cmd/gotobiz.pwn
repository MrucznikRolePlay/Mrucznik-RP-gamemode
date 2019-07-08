//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ gotobiz ]------------------------------------------------//
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

YCMD:gotobiz(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pAdmin] >= 5)
		{
			new ID_BUSINESS;
			if(sscanf(params, "d<fix>", ID_BUSINESS))
			{
				sendTipMessage(playerid, "U¿yj /gotobiz [ID_BIZNESU]"); 
				return 1;
			}
			if(ID_BUSINESS > BusinessLoaded || ID_BUSINESS== -1)
			{
				sendErrorMessage(playerid, "Nie ma takiego biznesu!"); 
				return 1;
			}
			SetPlayerPos(playerid, Business[ID_BUSINESS][b_enX], Business[ID_BUSINESS][b_enY], Business[ID_BUSINESS][b_enZ]); 
			sendTipMessage(playerid, "Teleportowano Ciê do biznesu!"); 
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
