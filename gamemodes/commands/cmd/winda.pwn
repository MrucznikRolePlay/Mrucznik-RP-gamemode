//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ winda ]-------------------------------------------------//
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

YCMD:winda(playerid, params[], help)
{
	if(IsPlayerConnected(playerid))
	{
		if(PlayerInfo[playerid][pLider] == 6 || PlayerInfo[playerid][pMember] == 6 || PlayerInfo[playerid][pAdmin] >= 1000)
		{
			if(PlayerToPoint(10.0, playerid, 2808.0749511719, -1080.8464355469, 31.582866668701) || PlayerToPoint(10.0, playerid, 2808.07421875, -1080.845703125, 38.98286819458))
			{
				if(WindaYKZ2 == 1)
				{
					MoveDynamicObject(WindaYKZ, 2806.7307128906, -1089.2893066406, 29.75, 1.5);
					SetDynamicObjectRot(WindaYKZ, 90, 0, 0);
					WindaYKZ2 = 0;
				}
				else
				{
					MoveDynamicObject(WindaYKZ, 2806.73046875, -1089.2890625, 42.100128173828, 1.5);
					SetDynamicObjectRot(WindaYKZ, 90, 0, 0);
					WindaYKZ2 = 1;
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid,3,507.63, -1493.10, 46.57) && GetPlayerOrg(playerid) == 16 || IsPlayerInRangeOfPoint(playerid,3,507.63, -1493.10, 49.87) && GetPlayerOrg(playerid) == 16)
		{
		    if(movegate[0] == 0)
		    {
			    MoveDynamicObject(bramka[1],507.63, -1493.10, 46.57,3);
			    MoveDynamicObject(bramka[2],507.63, -1493.10, 46.57,3);
			    MoveDynamicObject(bramka[3],509.63, -1493.10, 49.87,3);
			    MoveDynamicObject(bramka[4],505.63, -1493.10, 49.87,3);
			    MoveDynamicObject(windka,507.6500, -1493.0300, 49.9200,3);
			    movegate[0] = 1;
		    }
		    else
		    {
			    MoveDynamicObject(bramka[1],509.63, -1493.10, 46.57,3);
			    MoveDynamicObject(bramka[2],505.63, -1493.10, 46.57,3);
			    MoveDynamicObject(bramka[3],507.63, -1493.10, 49.87,3);
			    MoveDynamicObject(bramka[4],507.63, -1493.10, 49.87,3);
			    MoveDynamicObject(windka,507.6500, -1493.0300, 46.5800,3);
			    movegate[0] = 0;
		    }
		}
	}
	return 1;
}
