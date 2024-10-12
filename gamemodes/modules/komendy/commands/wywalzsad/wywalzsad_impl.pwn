//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Autor: mrucznik
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_wywalzsad_Impl(playerid, params[256])
{
    if(GetPlayerFraction(playerid) == FRAC_BOR && PlayerInfo[playerid][pRank] > 2)
	{
	   if(IsPlayerInRangeOfPoint(playerid,5,1321.1561, -1322.0787, 40.2077)
	   || IsPlayerInRangeOfPoint(playerid,20,1309.6487, -1299.8835, 36.5567)
	   || IsPlayerInRangeOfPoint(playerid,10,1310.2283, -1343.9265, 38.5291))
	   {
		    new odbiorca;
		    if(sscanf(params,"k<fix>",odbiorca)) return sendTipMessage(playerid,"U퓓j /wywalzsad [ID-Gracza]");
            new str[128];
            format(str, 128, "Zostales wyrzucony z s퉐u przez %s", GetNick(playerid));
            SetPlayerVirtualWorld(odbiorca, 0);
			SendClientMessage(odbiorca,0xFFFFFFFF,str);
            format(str, 128, "* %s wyrzuca z s퉐u %s", GetNick(playerid), GetNick(odbiorca));
            ProxDetector(30.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
            SetPlayerPos(odbiorca,1309.9658, -1367.2878, 13.7324);
        }
        else
        {
        	sendTipMessageEx(playerid,0xFFFFFFFF,"Nie jestes w s퉐zie!");
        }
    }
	return 1;
}

//end
