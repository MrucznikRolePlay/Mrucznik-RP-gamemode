//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ pozwolenie ]----------------------------------------------//
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

YCMD:pozwolenie(playerid, params[], help) {
    if(!IsACop(playerid)) return sendErrorMessage(playerid, "Nie jesteœ policjantem!");
    new komu;
    if(sscanf(params, "k<fix>", komu)) return sendTipMessage(playerid, "U¿yj /pozwolenie [id gracza / czêœæ nazwy]");
    if(!IsPlayerConnected(komu)) return sendErrorMessage(playerid, "Nie ma takiego gracza!");
    if(!ProxDetectorS(4.5, playerid, komu)) return sendErrorMessage(playerid, "Tego gracza nie ma w pobli¿u!");
    if(PlayerInfo[komu][pJob] != 2) return sendErrorMessage(playerid, "Gracz nie jest prawnikiem!");
    SetPVarInt(komu, "pozwolenie-oferuje", playerid);
    SetPVarInt(playerid, "pozwolenie-oferujeDla", komu);
    new string[128];
    format(string, sizeof(string), "Zaoferowa³eœ %s pozwolenie prawnicze za $20 000", GetNick(komu, true));
    sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
    format(string, sizeof(string), "%s zaoferowa³ Ci pozwolenie prawnicze za $20 000. Akceptuj za pomoc¹ /app", GetNick(playerid, true));
    sendTipMessage(komu, string, COLOR_LIGHTBLUE);
    return 1;
}
