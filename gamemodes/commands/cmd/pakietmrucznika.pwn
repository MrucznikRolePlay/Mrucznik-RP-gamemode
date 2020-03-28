//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ pakietmrucznika ]--------------------------------------------//
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

#if DEBUG_MODE == 1
YCMD:pakietmrucznika(playerid, params[], help)
{

    if(gettime() < GetPVarInt(playerid, "pakietl")) return sendTipMessage(playerid, "{dafc10}Mo¿esz u¿ywaæ tego co 60s");

    PlayerInfo[playerid][pLevel] = 22;
    PlayerInfo[playerid][pDowod] = 1;
    PlayerInfo[playerid][pCarLic] = 1;
    PlayerInfo[playerid][pFlyLic] = 1;
    PlayerInfo[playerid][pBoatLic] = 1;
    PlayerInfo[playerid][pFishLic] = 1;
    PlayerInfo[playerid][pGunLic] = 1;
    PlayerInfo[playerid][pCarSlots] = 10;
    PlayerInfo[playerid][pOnlineHours] = 2137;

    DajKase(playerid, 200000000);

    sendTipMessage(playerid, "[Dostajesz dowod, prawko, licke na latanie, lodke, rybolostwo i pozwolenie na bron]");
    sendTipMessage(playerid, "[Dostajesz 10 slotow na wozy oraz 200kk, jak wydasz kase uzyj ponownie zeby dostac znowu kase]");

    sendTipMessageEx(playerid, COLOR_PAPAYAWHIP, "[Nie spam t¹ komend¹ inaczej dostaniesz bana]");

    SetPVarInt(playerid, "pakietl", gettime() + 60);

    return 1;
}
#endif
