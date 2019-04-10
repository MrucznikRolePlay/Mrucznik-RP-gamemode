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

CMD:gotobiz(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
		new plo;
		if(sscanf(params, "d", plo)) return sendTipMessage(playerid, "U¿yj /gototbiz [ID biznesu]");
		if(plo >= 1)
		{
		    if(plo <= 100)
		    {
				if(PlayerInfo[playerid][pAdmin] >= 1)
				{
				    if(BizData[plo][eBizWejX] == 0.0 && BizData[plo][eBizWejY] == 0.0 && BizData[plo][eBizWejZ] == 0.0) return _MruAdmin(playerid, sprintf("Nie mo¿na siê teleportowaæ. Biznes %s (ID %d) nie jest aktywny.", BizData[plo][eBizName], plo));
					SetPlayerPosEx(playerid, BizData[plo][eBizWejX],BizData[plo][eBizWejY],BizData[plo][eBizWejZ]);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
  					_MruAdmin(playerid, sprintf("Teleportowa³eœ siê do biznesu %s (ID %d)", BizData[plo][eBizName], plo));
				}
				else
				{
					noAccessMessage(playerid);
				}
			}
		}
	}
	return 1;
}
