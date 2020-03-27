//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------[ kamera_wiezienie ]-------------------------------------------//
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

YCMD:kamera_wiezienie(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][Job] == 2)
        {
            if(PlayerToPoint(10.0,playerid,319.72470092773, -1548.3374023438, 13.845289230347) || PlayerToPoint(5.0,playerid,214.6996,121.2643,1008.2188))
            {
                new number;
                if( sscanf(params, "d", number))
                {
                    sendTipMessage(playerid, "U¿yj /kameraw [numer 1 - 6]  (6 = OFF)");
                    return 1;
                }

                if(number < 1 || number > 6) { sendTipMessage(playerid, "Numer kamery od 1 do 6 !"); return 1; }

                if(number >= 1 && number <= 5)
                {
                    if(GetPlayerInterior(playerid) != 10) //czy gracz nie jest na /kameraw
                    {
                        GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
                    }
                    TogglePlayerControllable(playerid, 0);
                    SetPlayerInterior(playerid, 10);
                    PlayerInfo[playerid][Mute] = 1;
                    SetPlayerPos(playerid, 214.6996,121.2643,1008.2188);
                }

                if(number == 1) { SetPlayerCameraPos(playerid, 214.8968,114.7074,999.0156); SetPlayerCameraLookAt(playerid, 215.8725,110.4934,999.0156); } else if(number == 2) { SetPlayerCameraPos(playerid, 218.4975,114.4323,999.0156); SetPlayerCameraLookAt(playerid, 218.4825,110.1900,999.0156); } else if(number == 3) { SetPlayerCameraPos(playerid, 222.6395,114.3951,999.0156); SetPlayerCameraLookAt(playerid, 223.1496,110.0053,999.0156); } else if(number == 4) { SetPlayerCameraPos(playerid, 227.0445,114.3556,999.0156); SetPlayerCameraLookAt(playerid, 227.0232,109.7559,999.0156); } else if(number == 5) { SetPlayerCameraPos(playerid, 217.9721,119.7951,999.0156); SetPlayerCameraLookAt(playerid, 215.8725,110.4934,999.0156); } else if(number == 6)
                {
                    if(GetPlayerInterior(playerid) != 10)
                    {
                        sendErrorMessage(playerid, "Nie ogl¹dasz kamer, wiêc nie potrzebujesz wy³¹czyæ widoku kamer.");
                        return 1;
                    }
                    MedicBill[playerid] = 0;
                    SetPlayerInterior(playerid, 0);
                    TogglePlayerControllable(playerid, 1);
                    SetCameraBehindPlayer(playerid);
                    PlayerInfo[playerid][Mute] = 0;
                    SetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
                    Wchodzenie(playerid);
                }
            } else
            {
                sendErrorMessage(playerid, "Nie jesteœ w kancelarii prawniczej !");
                return 1;
            }
        } else
        {
            sendErrorMessage(playerid, "Nie jesteœ Prawnikiem !");
            return 1;
        }
    }
    return 1;
}
