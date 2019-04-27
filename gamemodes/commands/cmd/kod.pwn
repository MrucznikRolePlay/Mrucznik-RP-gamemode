//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ kod ]--------------------------------------------------//
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

YCMD:kod(playerid,params[], help)
{
    if(PlayerInfo[playerid][pLider] == FRAC_NG)
    {
        new lKey;
        sscanf(params, "D(0)", lKey);
        if(lKey != 0)
        {
            if(!(0 < lKey < 6666)) return sendTipMessage(playerid, "U¿yj /kod [kod(od 0 do 6666)]");
            STANOWE_GATE_KEY = lKey;
            new lStr[64];
            format(lStr, 64, "UPDATE `mru_config` SET `stanowe_key`='%d'", lKey);
            mysql_query(lStr);
            SendClientMessage(playerid, COLOR_GRAD2, "Zmieniono");
        }
    }
    if(VAR_NGKeypad) return sendErrorMessage(playerid, "Ktoœ ju¿ wpisuje kod");
    if(GetPVarInt(playerid, "ng-gatekey") == 0)
    {
    	if(IsPlayerInRangeOfPoint(playerid,8.0, 2720.3491, -2509.8152, 13.8384))
    	{
    	    SelectTextDraw(playerid, 0x00FF00FF);
            TextDrawShowForPlayer(playerid,NG_GateTD[0]);
            TextDrawShowForPlayer(playerid,NG_GateTD[1]);
            TextDrawShowForPlayer(playerid,NG_GateTD[2]);
            TextDrawShowForPlayer(playerid,NG_GateTD[3]);
            TextDrawShowForPlayer(playerid,NG_GateTD[4]);
            TextDrawShowForPlayer(playerid,NG_GateTD[5]);
            TextDrawShowForPlayer(playerid,NG_GateTD[6]);
            TextDrawShowForPlayer(playerid,NG_GateTD[7]);
            SetPVarInt(playerid, "ng-gatekey", 1);
            VAR_NGKeypad = true;
    	}
    }
	return 1;
}
