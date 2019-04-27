//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ wezwijwoz ]-----------------------------------------------//
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

YCMD:wezwijwoz(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
	    if(CarCalls[playerid] > 0)
	    {
	        new Float:plocx,Float:plocy,Float:plocz;
            GetPlayerPos(playerid, plocx, plocy, plocz);
			SetVehiclePos(CarID[playerid],plocx,plocy+4, plocz);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, "* Kupiony wóz przywo³any.");
			CarCalls[playerid] -= 1;
			format(string, sizeof(string), "* Mo¿esz wezwaæ swój wóz jeszcze %d razy.", CarCalls[playerid]);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	    }
	    else
	    {
	        sendTipMessageEx(playerid, COLOR_GREY, "Nie masz wozu !");
	    }
	}
    return 1;
}
