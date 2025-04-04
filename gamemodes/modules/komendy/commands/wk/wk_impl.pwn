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
command_wk_Impl(playerid)
{
    if(PlayerInfo[playerid][pKluczeAuta] != 0)
    {
        new uid = Car_GetIDXFromUID(PlayerInfo[playerid][pKluczeAuta]);
        if(uid != -1) 
		{
			CarData[uid][c_Keys] = 0;
			
		}
  		PlayerInfo[playerid][pKluczeAuta] = 0;
  		sendTipMessage(playerid, "Kluczyki wywalone (skr�t komendy: /wk)", COLOR_LIGHTBLUE);
		  
		//log
		Log(payLog, INFO, "%s wyrzuci� kluczyki do pojazdu %s",
			GetPlayerLogName(playerid),
			uid != -1 ? GetCarDataLogName(uid) : "{Vehicle: Brak[-1]}");

  	}
  	else
  	{
  	    sendErrorMessage(playerid, "Nie masz kluczy");
  	}
	return 1;
}

//end
