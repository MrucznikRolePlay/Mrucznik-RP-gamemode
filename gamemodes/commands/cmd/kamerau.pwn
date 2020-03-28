//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ kamerau ]------------------------------------------------//
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

YCMD:kamerau(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsABOR(playerid) || PlayerInfo[playerid][pRank] >= 2 )
        {
            new kamid;
            if( sscanf(params, "d", kamid))
            {
                sendTipMessage(playerid, "U¿yj /kamerau [1-4]");
                sendTipMessage(playerid, "[5] = Wy³¹czenie podgl¹du");
                return 1;
            }
            if(IsPlayerInRangeOfPoint(playerid, 3.0, 1456.8298,-1782.6688,77.9502) || IsPlayerInRangeOfPoint(playerid, 3.0, 1453.1586,-1785.0184,82.3912) || IsPlayerInRangeOfPoint(playerid, 3.0, 1449.4949,-1805.1057,82.3912) || IsPlayerInRangeOfPoint(playerid, 3.0, 1450.6265,-1818.7275,85.7253))
            {

                if(kamid == 1)
                {
                    SetPlayerPos(playerid, 1453.1586,-1785.0184,82.3912);
                    SetPlayerCameraPos(playerid, 1447.6902, -1783.1970, 80.2107);
                    SetPlayerCameraLookAt(playerid, 1448.0886, -1782.2822, 79.7908);
                    sendTipMessage(playerid, "[KAMERA 1][Urz¹d Miasta Los Santos] Hol wejœciowy");
                    TogglePlayerControllable(playerid, 0);
                } else if(kamid == 2)
                {
                    SetPlayerPos(playerid, 1449.4949,-1805.1057,82.3912);
                    SetPlayerCameraPos(playerid, 1448.9839, -1806.7433, 80.1729);
                    SetPlayerCameraLookAt(playerid, 1448.8718, -1805.7517, 79.8730);
                    sendTipMessage(playerid, "[KAMERA 2][Urz¹d Miasta Los Santos] Okienka 5-8");
                    TogglePlayerControllable(playerid, 0);

                } else if(kamid == 3)
                {
                    SetPlayerPos(playerid, 1449.4949,-1805.1057,82.3912);
                    SetPlayerCameraPos(playerid, 1454.0310, -1806.6051, 80.1729);
                    SetPlayerCameraLookAt(playerid, 1453.9332, -1805.6119, 79.8480);
                    sendTipMessage(playerid, "[KAMERA 3][Urz¹d Miasta Los Santos] Okienka 1-4");
                    TogglePlayerControllable(playerid, 0);
                } else if(kamid == 4)
                {
                    SetPlayerPos(playerid, 1450.6265,-1818.7275,85.7253);
                    SetPlayerCameraPos(playerid, 1455.9574, -1821.9583, 83.3474);
                    SetPlayerCameraLookAt(playerid, 1455.3961, -1821.1326, 82.9175);
                    sendTipMessage(playerid, "[KAMERA 4][Urz¹d Miasta Los Santos] Du¿y hol");
                    TogglePlayerControllable(playerid, 0);
                } else if(kamid == 5)
                {
                    SetPlayerPos(playerid, 1456.8298,-1782.6688,77.9502);
                    TogglePlayerControllable(playerid, 1);
                    SetCameraBehindPlayer(playerid);
                    PlayerInfo[playerid][pMute] = 0;
                    sendTipMessage(playerid, "Wy³¹czy³eœ podgl¹d kamer");
                }

            } else
            {
                sendErrorMessage(playerid, "Nie jesteœ w odpowiednim miejscu!");
            }
        } else
        {
            sendErrorMessage(playerid, "Nie posiadasz dostêpu do tej komendy!");
        }


    }

    return 1;
}
