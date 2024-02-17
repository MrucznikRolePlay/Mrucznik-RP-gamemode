//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ warn ]-------------------------------------------------//
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

YCMD:warn(playerid, params[], help)
{
	new string[256];
    if(IsPlayerConnected(playerid))
    {
    	new giveplayerid, result[64];
		if( sscanf(params, "k<fix>s[64]", giveplayerid, result))
		{
			sendTipMessage(playerid, "U¿yj /warn [playerid/CzêœæNicku] [reason]");
			return 1;
		}
		if(giveplayerid == 65535)
		{
			if(sscanf(params, "ds[64]", giveplayerid, result)) 
			{
				sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz ma zbugowane ID. Wpisz jego ID zamiast nicku aby go zbanowaæ.");
				return 1;
			}
		}

		if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pNewAP] >= 1 || IsAScripter(playerid))
		{
            if(AntySpam[playerid] == 1)
		    {
		        sendTipMessageEx(playerid, COLOR_GREY, "Odczekaj 5 sekund");
		        return 1;
		    }
		    if(IsPlayerConnected(giveplayerid))
		    {
		        if(giveplayerid != INVALID_PLAYER_ID)
		        {
		            if(PlayerInfo[giveplayerid][pAdmin] >= 1)
		            {
		                sendTipMessageEx(playerid, COLOR_WHITE, "Nie mozesz zwarnowaæ Admina !");
		                return 1;
		            }
                    if(gPlayerLogged[giveplayerid] == 0)
                    {
                        sendTipMessageEx(playerid, COLOR_WHITE, " Gracz nie jest zalogowany, u¿yj kicka.");
						return 1;
                    }
					SetTimerEx("AntySpamTimer",5000,0,"d",playerid);
					AntySpam[playerid] = 1;
					if(PlayerInfo[giveplayerid][pWarns] >= 2)
					{
						SetPVarInt(playerid, "PunishWarnPlayer", giveplayerid);
						SetPVarString(playerid, "PunishWarnPlayer_Reason", result);
						format(string, sizeof string, "{FFFFFF}Gracz {B7EB34}%s {FFFFFF}ma ju¿ 2 warny, otrzymanie kolejnego jest równoznaczne z {FFA217}BANEM{FFFFFF}.\n{f0d71f}Czy potwierdzasz nadanie bana graczowi?\n{FFFFFF}Je¿eli to mo¿liwe, mo¿esz ukaraæ gracza l¿ejsz¹ kar¹.", GetNick(giveplayerid));
						ShowPlayerDialogEx(playerid, 9521, DIALOG_STYLE_MSGBOX, "Nadawanie warna", string, "Nadaj warna", "Anuluj karê");
					}
					else
					{
						SetPVarInt(playerid, "PunishWarnPlayer", giveplayerid);
						SetPVarString(playerid, "PunishWarnPlayer_Reason", result);
						format(string, sizeof string, "{FFFFFF}Czy podj¹³eœ dialog z graczem {B7EB34}%s{FFFFFF}?\nJe¿eli to mo¿liwe, mo¿esz ukaraæ gracza l¿ejsz¹ kar¹.", GetNick(giveplayerid));
						ShowPlayerDialogEx(playerid, 9521, DIALOG_STYLE_MSGBOX, "Nadawanie warna", string, "Nadaj warna", "Anuluj karê");
					}
				}
			}//not connected
            else
            {
                format(string, sizeof(string), "Gracz o ID %d nie jest po³aczony.", giveplayerid);
			    sendErrorMessage(playerid, string);
            }
		}
        else {
            return noAccessMessage(playerid);
        }
	}
	return 1;
} 
