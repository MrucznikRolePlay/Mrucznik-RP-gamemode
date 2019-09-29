//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   names                                                   //
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
// Autor: Simeone
// Data utworzenia: 13.09.2019
//Opis:
/*
	Nicki nad g³owami postaci
*/

//

//-----------------<[ Funkcje: ]>-------------------
/*
stock Generate3DNickName(playerid)
{

	return 1;
}
stock SetNickNamesForPlayer(playerid, stan)
{
	if(stan == 1)
	{
		foreach(new i : Player)
		{
			new pNam[MAX_PLAYER_NAME+30]; 
			format(pNam, sizeof(pNam), "%s [%d]\n((%s))", GetNick(i), i, GetPlayerDepiction(i));
			ShowPlayerNameTagForPlayer(playerid, i, 0);
			PlayerName3D[playerid] = Create3DTextLabel(pNam, COLOR_WHITE, 0.0, 0.0, 0.0, 20.0, 0, 1);
			PlayerName3D[i] = CreateDynamic3DTextLabel(pNam, COLOR_WHITE, 0.0, 0.0, 0.0, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID,  0,  GetPlayerVirtualWorld(i), GetPlayerInterior(i), playerid, 5.0);  
			Attach3DTextLabelToPlayer(PlayerName3D[playerid], playerid, 0.0, 0.0, 0.3);
		}
	}
}*/
//end