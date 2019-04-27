//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ app ]--------------------------------------------------//
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

CMD:app(playerid, params[]) {
    if(GetPVarInt(playerid, "pozwolenie-oferuje") == 999) return sendErrorMessage(playerid, "Nikt nie oferowa³ Ci pozwolenia prawniczego!");
    new ofertaod = GetPVarInt(playerid, "pozwolenie-oferuje");
    if(!IsPlayerConnected(ofertaod)) return sendErrorMessage(playerid, "Osoba, która oferowa³a Ci pozwolenie wysz³a z serwera!");
    if(GetPVarInt(ofertaod, "pozwolenie-oferujeDla") != playerid) return sendErrorMessage(playerid, "Osoba, która oferowa³a Ci pozwolenie wysz³a z serwera!");
    if(kaska[playerid] < 20000) return sendErrorMessage(playerid, "Nie staæ Cie na pozwolenie prawnicze");
    new string[128];
    format(string, sizeof(string), "%s akceptowa³ Twoj¹ ofertê pozwolenia prawiczego, otrzymujesz $10 000", GetNick(playerid, true));
    sendTipMessage(ofertaod, string, COLOR_LIGHTBLUE);
    format(string, sizeof(string), "Otrzymujesz pozwolenie prawnicze od %s", GetNick(ofertaod, true));
    sendTipMessage(playerid, string, COLOR_LIGHTBLUE);
    format(string, sizeof(string), "* %s da³ zgodê na uwolnienie wiêŸnia prawnikowi %s", GetNick(ofertaod, true), GetNick(playerid, true));
    SendRadioMessage(1, COLOR_PANICRED, string);
    SendRadioMessage(2, COLOR_PANICRED, string);
    SendRadioMessage(3, COLOR_PANICRED, string);
    DajKase(playerid, -20000);
    DajKase(ofertaod, 10000);
    SetPVarInt(playerid, "pozwolenie-oferuje", 999);
    Sejf_Add(PlayerInfo[ofertaod][pMember], 10000);
    ApprovedLawyer[playerid] = 1;
    format(string, sizeof(string), "%s dal zgode %s", GetNick(ofertaod), GetNick(playerid));
    PayLog(string);
    return 1;
}

/*
if(kaska[playerid] < 20000) return sendErrorMessage(playerid, "Koszt wydania pozwolenia prawniczego to $10 000. Nie masz tyle!");
                            GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            format(string, sizeof(string), "* Da³eœ zgodê %s na uwolnienie wiêŸnia z celi. Tracisz $10 000 z portfela", giveplayer);
                            SendClientMessage(playerid, COLOR_LIGHTBLUE,string);
                            format(string, sizeof(string), "* Policjant %s da³ ci zgodê na uwolnienie wiêŸnia z celi. (wpisz /uwolnij)", sendername);
                            SendClientMessage(giveplayerid, COLOR_LIGHTBLUE,string);
                            format(string, sizeof(string), "* %s da³ zgodê na uwolnienie wiêŸnia prawnikowi %s.", sendername, giveplayer);
                            SendRadioMessage(1, COLOR_PANICRED, string);
                            SendRadioMessage(2, COLOR_PANICRED, string);
                            SendRadioMessage(3, COLOR_PANICRED, string);
                            DajKase(playerid, -20000);
                            Sejf_Add(PlayerInfo[playerid][pMember], 10000);
                            ApprovedLawyer[giveplayerid] = 1;
*/
//-------------------------------------[NOWA KOMENDA WJED]------------------------------------
//by Simeone 25-11-2018
