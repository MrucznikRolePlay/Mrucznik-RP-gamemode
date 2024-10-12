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
command_pozwolenie_Impl(playerid, params[256])
{
    if(!IsAPolicja(playerid)) return sendErrorMessage(playerid, "Nie jesteœ policjantem!");
    new komu;
    if(sscanf(params, "k<fix>", komu)) return sendTipMessage(playerid, "U¿yj /pozwolenie [id gracza / czêœæ nazwy]");
    if(!IsPlayerConnected(komu)) return sendErrorMessage(playerid, "Nie ma takiego gracza!");
    if(!ProxDetectorS(4.5, playerid, komu)) return sendErrorMessage(playerid, "Tego gracza nie ma w pobli¿u!");
    if(PlayerInfo[komu][pJob] != 2) return sendErrorMessage(playerid, "Gracz nie jest prawnikiem!");
    SetPVarInt(komu, "pozwolenie-oferuje", playerid);
    SetPVarInt(playerid, "pozwolenie-oferujeDla", komu);
    new string[128];
    format(string, sizeof(string), "Zaoferowa³eœ %s pozwolenie prawnicze za $"#CENA_POZWOLENIE, GetNick(komu));
    sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
    format(string, sizeof(string), "%s zaoferowa³ Ci pozwolenie prawnicze za $"#CENA_POZWOLENIE". Akceptuj za pomoc¹ /app", GetNick(playerid));
    sendTipMessage(komu, string, COLOR_LIGHTBLUE);
    return 1;
}

//end
