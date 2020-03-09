//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------------[  ]---------------------------------------------------//
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

YCMD:marcepan(playerid, params[], help)
{
	//komenda tymczasowo wy³¹czona
    /*
    if(PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid))
    {
        new id;
        if(sscanf(params, "k<fix>", id)) return SendClientMessage(playerid, -1, "(MARCEPAN) - Podaj Nick lub ID gracza.");
        if(!IsPlayerConnected(id)) return sendErrorMessage(playerid, "Nie ma takiego gracza");
        new string[128];
        SendClientMessage(playerid, COLOR_PAPAYAWHIP, "========================================");
        format(string, 128, "Symulacja Marcepan_Marks dla %s", GetNick(id, true));
        SendClientMessage(playerid, COLOR_P@, string);
        format(string, 128, "Zwi¹zany = %s", (PlayerTied[id] > 0) ? ("Tak") : ("Nie"));
        SendClientMessage(playerid, COLOR_YELLOW, string);
        format(string, 128, "Skuty w aucie = %s", (PlayerCuffed[id] > 0) ? ("Tak") : ("Nie"));
        SendClientMessage(playerid, COLOR_YELLOW, string);
        format(string, 128, "Skuty pieszo = %s", (Kajdanki_JestemSkuty[id] > 0) ? ("Tak") : ("Nie"));
        SendClientMessage(playerid, COLOR_YELLOW, string);
        format(string, 128, "Poœcig = %s", (poscig[id] > 0) ? ("Tak") : ("Nie"));
        SendClientMessage(playerid, COLOR_YELLOW, string);
        format(string, 128, "Pobity = %s", (pobity[id] > 0) ? ("Tak") : ("Nie"));
        SendClientMessage(playerid, COLOR_YELLOW, string);
        SendClientMessage(playerid, COLOR_PAPAYAWHIP, "");
        new bool:wyrok=false;
        if(PlayerTied[id] >= 1 || (PlayerCuffed[id] > 0 && pobity[id] == 0 && PlayerCuffed[id] < 3) || Kajdanki_JestemSkuty[id] >= 1 || poscig[id] == 1)
        {
            wyrok = true;
        }
        if(wyrok)
        {
            SendClientMessage(playerid, COLOR_PAPAYAWHIP, "Wyrok: AJ");
        }
        else
        {
            SendClientMessage(playerid, COLOR_PAPAYAWHIP, "Wyrok: Bez AJ");
        }
        SendClientMessage(playerid, COLOR_PAPAYAWHIP, "========================================");
    }
    else
    {
        return noAccessMessage(playerid);
    }*/
    return 1;
}


