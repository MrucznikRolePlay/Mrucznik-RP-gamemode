//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ wk ]--------------------------------------------------//
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

CMD:wyrzuckluczyki(playerid) return cmd_wk(playerid);
CMD:wywalklucze(playerid) return cmd_wk(playerid);
CMD:wywalkluczyki(playerid) return cmd_wk(playerid);
CMD:wyrzucklucze(playerid) return cmd_wk(playerid);
CMD:wk(playerid)
{
    if(PlayerInfo[playerid][pKluczeAuta] != 0)
    {
        new uid = Car_GetIDXFromUID(PlayerInfo[playerid][pKluczeAuta]);
        if(uid != -1) 
		{
			CarData[uid][c_Keys] = 0;
		}
  		PlayerInfo[playerid][pKluczeAuta] = 0;
  		sendTipMessage(playerid, "Kluczyki wywalone (skrót komendy: /wk)", COLOR_LIGHTBLUE);
  	}
  	else
  	{
  	    sendErrorMessage(playerid, "Nie masz kluczy");
  	}
	return 1;
}
