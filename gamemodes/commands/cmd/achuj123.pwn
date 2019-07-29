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
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:achuj123(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new value;
		if(sscanf(params, "d", value))
		{
			sendTipMessage(playerid, "B³êdny zwrot/ Prawod³owy to [1-3]");
			return 1;
		}
		if(value == 1)
		{
			sendTipMessage(playerid, "Spawn - start");
			SetPlayerSpawnPos(playerid);
			sendTipMessage(playerid, "Spawn - end");
		}
		else if(value == 2)
		{
			sendTipMessage(playerid, "Skin start");
			SetPlayerSpawnSkin(playerid);
			sendTipMessage(playerid, "Skin -- End");
		}
		else if(value == 3)
		{
			sendTipMessage(playerid, "Weapon - start");
			SetPlayerSpawnWeapon(playerid);
			sendTipMessage(playerid, "Weapon - end");
		}
		else
		{
			sendTipMessage(playerid, "b³êdne id");
			return 1;
		}
	}
	return 1;
}



