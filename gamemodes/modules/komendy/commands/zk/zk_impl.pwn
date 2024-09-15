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
command_zk_Impl(playerid, params[256])
{
    if(gPlayerLogged[playerid] == 1)
	{
        new numerp;
		if( sscanf(params, "d", numerp))
		{
			sendTipMessage(playerid, "U¿yj /zabierzkluczyki(/zk) [numer wozu]");
			return 1;
		}
        if(numerp < 1 || numerp > MAX_CAR_SLOT) return sendTipMessage(playerid, "Numer wozu od 1");
        numerp--;
        if(PlayerInfo[playerid][pCars][numerp] == 0) return sendTipMessage(playerid, "Nie masz wozu pod tym numerem");
        if(CarData[PlayerInfo[playerid][pCars][numerp]][c_Keys] == 0) return sendErrorMessage(playerid, "Nikomu nie dawa³eœ kluczyków od tego pojazdu.");

        CarData[PlayerInfo[playerid][pCars][numerp]][c_Keys] = 0;
  		sendTipMessage(playerid, "Kluczyki zabrane", COLOR_LIGHTBLUE);
        Car_Save(PlayerInfo[playerid][pCars][numerp], CAR_SAVE_OWNER);
	}
	return 1;
}

//end
