//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ antybh ]------------------------------------------------//
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

YCMD:antybh(playerid, params[], help)
{
	new string[64];

    if(IsPlayerConnected(playerid))
    {
		new bh;
		if( sscanf(params, "d", bh))
		{
			sendTipMessage(playerid, "U¿yj /antybh [0-off, 1-on]");
			return 1;
		}


		if (IsAHeadAdmin(playerid) || IsAScripter(playerid))
		{
	 		if(bh == 0 || bh == 1)
 			{
 			    if(bh != AntyBH)
 			    {
		            AntyBH = bh;
		            format(string, sizeof(string), "Anty BH = %d", bh);
    				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
				}
				else
				{
					new txtbh[20];
				    if(AntyBH == 0)
				    {
						txtbh = "wy³¹czony";
				    }
				    else if(AntyBH == 1)
				    {
				        txtbh = "w³¹czony";
				    }
				    format(string, sizeof(string), "Anty BH ju¿ jest %s!", txtbh);
    				SendClientMessage(playerid, COLOR_LIGHTGREEN, string);
    			}
			}
		}
		else
		{
			noAccessMessage(playerid);
		}
	}
	return 1;
}
