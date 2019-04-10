//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ cela2 ]-------------------------------------------------//
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

CMD:cela2(playerid, params[])
{
	if(IsPlayerConnected(playerid))
	{
		if(IsACop(playerid) || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			new level;
			if( sscanf(params, "d", level))
			{
				sendTipMessage(playerid, "U¿yj /cela [numer celi (1-3)]");
				return 1;
			}

			if(PlayerToPoint(500.0, playerid, 211.4559,1809.8687,21.8672))//stanowe
			{
				if(level == 1)
				{
					if(StanoweCelaS == 1)
					{
						MoveDynamicObject(StanoweCela, 127.07069396973, 1827.5402832031, 15.80, 1.0);
						StanoweCelaS = 0;
					}
					else
					{
						MoveDynamicObject(StanoweCela, 127.07069396973, 1827.5402832031, 24.872304916382, 3.0);
						StanoweCelaS = 1;
					}
				}
				else if(level == 2)
				{
					if(StanoweCelaS2 == 1)
					{
						MoveDynamicObject(StanoweCela2, 118.17332458496, 1827.5469970703, 15.80, 1.0);
						StanoweCelaS2 = 0;
					}
					else
					{
						MoveDynamicObject(StanoweCela2, 118.17332458496, 1827.5469970703, 25.667268753052, 3.0);
						StanoweCelaS2 = 1;
					}
				}
				else if(level == 3)
				{
					if(StanoweCelaS3 == 1)
					{
						MoveDynamicObject(StanoweCela3, 109.23249816895, 1827.5198974609, 15.80, 1.0);
						StanoweCelaS3 = 0;
					}
					else
					{
						MoveDynamicObject(StanoweCela3, 109.23249816895, 1827.5198974609, 25.113931655884, 3.0);
						StanoweCelaS3 = 1;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD2, "Z³y numer celi (od 1 do 3)");
				}
			}
			else if(PlayerInfo[playerid][pLocal] == 212)
			{
				if(level == 1)
				{
					if(CelaMove[0] == 0)
					{
						MoveDynamicObject(Celaki[0],640.9521, -1486.8907, 90.8949,5,0,0,90);
						CelaMove[0] = 1;
					}
					else
					{
						MoveDynamicObject(Celaki[0],640.95209, -1488.60669, 90.89490,5,0,0,90);
						CelaMove[0] = 0;
					}
				}
				else if(level == 2)
				{
					if(CelaMove[1] == 0)
					{
						MoveDynamicObject(Celaki[1],640.9521, -1482.7025, 90.8949,5,0,0,90);
						CelaMove[1] = 1;
					}
					else
					{
						MoveDynamicObject(Celaki[1],640.95209, -1484.39648, 90.89490,5,0,0,90);
						CelaMove[1] = 0;
					}
				}
				else if(level == 3)
				{
					if(CelaMove[2] == 0)
					{
						MoveDynamicObject(Celaki[2],640.9521, -1478.4886, 90.8949,5,0,0,90);
						CelaMove[2] = 1;
					}
					else
					{
						MoveDynamicObject(Celaki[2],640.95209, -1480.18262, 90.89490,5,0,0,90);
						CelaMove[2] = 0;
					}
				}
				else
				{
					SendClientMessage(playerid, COLOR_GRAD2, "Z³y numer celi (od 1 do 3)");
				}
			}
			else
			{
			    SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ w wiêzieniu stanowym/bazie FBI");
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ policjantem ani agentem FBI");
		}
	}
	return 1;
}
*/

