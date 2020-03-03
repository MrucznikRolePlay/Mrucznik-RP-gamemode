//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------[ scenadisallow ]---------------------------------------------//
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

YCMD:scenadisallow(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 200 ) return 1;
    new id;
    if(sscanf(params, "k<fix>", id)) return sendTipMessage(playerid, "U¿yj /scenadisallow [Nick/ID]");
    if(GetPVarInt(id, "scena-allow") != 1) return sendTipMessageEx(playerid, COLOR_GRAD2, "Ten gracz nie ma takiego pozwolenia.");
    new str[128];
    format(str, 128, "× Admin %s (ID: %d) zabra³ Ci pozwolenie na zarz¹dzanie scen¹.", GetNickEx(playerid), playerid);
    SendClientMessage(id, COLOR_LIGHTRED,  str);
    format(str, 128, "× Zabra³eœ %s (ID: %d) mo¿liwoœæ kontrolowania sceny.", GetNick(id), id);
    SendClientMessage(playerid, COLOR_LIGHTRED,  str);
    SetPVarInt(id, "scena-allow", 0);
    return 1;
}
