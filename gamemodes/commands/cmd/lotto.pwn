//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ lotto ]-------------------------------------------------//
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

YCMD:lotto(playerid, params[], help)
{
	new string[64];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pLottoNr] > 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Posiadasz ju¿ los loteryjny !");
            return 1;
        }
        if(kaska[playerid] < 5000)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Potrzebujesz 5000$ aby kupiæ los lotto !");
            return 1;
        }
        new lottonr;
		if( sscanf(params, "d", lottonr))
		{
			sendTipMessage(playerid,"U¿yj /lotto [number]");
			return 1;
		}

		if(lottonr < 1 || lottonr > 80) { sendTipMessageEx(playerid, COLOR_GREY, "Numer lotto od 1 do 80 !"); return 1; }
		format(string, sizeof(string), "* Kupi³eœ los lotto z numerem: %d.", lottonr);
		sendTipMessageEx(playerid, COLOR_LIGHTBLUE, string);
		ZabierzKase(playerid, 5000);
		PlayerInfo[playerid][pLottoNr] = lottonr;
        Jackpot = Jackpot+4500; //500 podatku od hazadru
    }
    return 1;
}
