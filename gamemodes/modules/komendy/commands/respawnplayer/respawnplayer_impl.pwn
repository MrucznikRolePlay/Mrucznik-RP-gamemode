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
command_respawnplayer_Impl(playerid, params[256])
{
    //walidacja
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1 && !IsAZaufanyGracz(playerid)) return 1;
    new v;
    if(sscanf(params, "k<fix>", v)) return sendTipMessage(playerid, "U¿yj /respawnplayer [ID/Nick]");
    if(!IsPlayerConnected(v)) return sendErrorMessage(playerid, "Niepoprawne ID gracza.");

    //czynnosci
    if(IsPlayerInAnyVehicle(v))
    {
        new Float:shealth;
        new Float:slx, Float:sly, Float:slz;
        GetPlayerHealth(v, shealth);
        SetPlayerHealth(v, shealth-5);
        GetPlayerPos(v, slx, sly, slz);
        SetPlayerPos(v, slx, sly, slz+5);
    }
    if(Worek_MamWorek[playerid] != 0) // gdy osoba z workiem da /q
	{
		Worek_MamWorek[playerid] = 0;
		Worek_KomuZalozylem[Worek_KtoZalozyl[playerid]] = INVALID_PLAYER_ID;
		Worek_Uzyty[Worek_KtoZalozyl[playerid]] = 0;
		Worek_KtoZalozyl[playerid] = INVALID_PLAYER_ID;
		UnHave_Worek(playerid);
	}
    //wiadomosci
    new str[128];
    format(str, 128, "$System$ » Zosta³eœ zrespawnowany przez admina %s", GetNickEx(playerid));
    SendClientMessage(v, COLOR_LIGHTGREEN, str);
    format(str, 128, "$System$ » Zrespawnowa³eœ gracza o nicku %s", GetNick(v));
    SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
    
    SetPlayerSpawn(v);
    return 1;
}


YCMD:spawnplayer(playerid, params[], help)
{
    if(PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pNewAP] < 1) return 1;


    new giveplayerid;
    if(sscanf(params, "k<fix>", giveplayerid)) return sendTipMessage(playerid, "U¿yj /spawnplayer [ID/Nick]");

    SpawnPlayer(giveplayerid);
    return 1;
}

//end
