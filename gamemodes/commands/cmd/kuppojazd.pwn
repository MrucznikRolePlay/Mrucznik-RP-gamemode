//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ kuppojazd ]-----------------------------------------------//
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

YCMD:kuppojazd(playerid, params[], help)
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		sendErrorMessage(playerid, "Aby tego u¿yæ musisz wyjœæ z pojazdu"); 
		return 1;
	}
    if(PlayerToPoint(10.0, playerid, 2132.0371,-1149.7332,24.2372))
    {
        ShowPlayerDialogEx(playerid, 440, DIALOG_STYLE_LIST, "Wybierz kategoriê kupowanego pojazdu", "Samochody sportowe\nSamochody osobowe\nSamochody luksusowe\nSamochody terenowe\nPick-up`y\nKabriolety\nLowridery\nNa ka¿d¹ kieszeñ\nMotory\nInne pojazdy", "Wybierz", "WyjdŸ");
	}
	else
	{
	    sendTipMessage(playerid, "Nie jesteœ przy salonie aut.");
	}
	return 1;
}
