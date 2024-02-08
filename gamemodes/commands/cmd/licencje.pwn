//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ licencje ]-----------------------------------------------//
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

YCMD:licencje(playerid, params[], help)
{
	new string[128];

    if(IsPlayerConnected(playerid))
    {
        new text1[20];
        new text2[20];
        new text3[20];
        new text4[20];
        new text5[20];
        if(PlayerInfo[playerid][pCarLic] == 1) text1 = "Tak";
        else
        {
            if(PlayerInfo[playerid][pCarLic] > 1000)
            {
                new lTime = PlayerInfo[playerid][pCarLic]-gettime();
                new hh, mm;
                hh = floatround(floatround(floatdiv(lTime, 3600), floatround_floor)%24,floatround_floor);
                mm = floatround(floatround(floatdiv(lTime, 60), floatround_floor)%60,floatround_floor);
                format(text1, 20, "Blokada %dh %dmin", hh, mm);
            }
            else text1 = "Nie posiadasz";
        }
        if(PlayerInfo[playerid][pFlyLic]) { text4 = "Tak"; } else { text4 = "Nie posiadasz"; }
		if(PlayerInfo[playerid][pBoatLic]) { text2 = "Tak"; } else { text2 = "Nie posiadasz"; }
        if(PlayerInfo[playerid][pFishLic]) { text3 = "Tak"; } else { text3 = "Nie posiadasz"; }
        if(PlayerInfo[playerid][pGunLic]) { text5 = "Tak"; } else { text5 = "Nie posiadasz"; }
        SendClientMessage(playerid, COLOR_WHITE, "|__________________ Licencje __________________|");
        format(string, sizeof(string), "** Prawo jazdy: %s.", text1);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** Latanie: %s.", text4);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** P³ywanie ³odziami: %s.", text2);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** Karta wêdkarska: %s.", text3);
		SendClientMessage(playerid, COLOR_GREY, string);
		format(string, sizeof(string), "** Licencja na broñ: %s.", text5);
		SendClientMessage(playerid, COLOR_GREY, string);
		SendClientMessage(playerid, COLOR_WHITE, "|______________________________________________|");
	}
    return 1;
}
