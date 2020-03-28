//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ dajneony ]-----------------------------------------------//
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

YCMD:dajneony(playerid, params[], help)
{
    new string[256];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsANoA(playerid) && PlayerInfo[playerid][Rank] >= 3 || GetPlayerOrg(playerid) == 15)
        {
            if(IsPlayerInRangeOfPoint(playerid, 25.0, 2333.9292,-1245.2999,22.5000) || IsPlayerInRangeOfPoint(playerid, 25.0, 1805.0804,-1711.9927,13.7336))
            {

                new playa;
                if( sscanf(params, "k<fix>", playa))
                {
                    SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /dajneon [Nick/ID]");
                    SendClientMessage(playerid, COLOR_RED, "UWAGA: Koszt zamontowania neonów to 3 000 000$. Automatycznie ponosi je kupuj¹cy. Ty zarabiasz na tym 25 000$");
                    return 1;
                }


                //
                if(ProxDetectorS(10.0, playerid, playa))
                {
                    if(IsPlayerInAnyVehicle(playa))
                    {
                        new pojazd = GetPlayerVehicleID(playa);
                        if(IsCarOwner(playa, pojazd))
                        {
                            if(IsABoat(pojazd) || IsAPlane(pojazd) || IsABike(pojazd))
                            {
                                SendClientMessage(playerid, COLOR_GREY, "W helikoptrze/samolocie/³odzi/motorze nie mo¿na zamontowaæ neonów.");
                                return  1;
                            }
                            GetPlayerName(playerid, sendername, sizeof(sendername));
                            GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                            format(string, sizeof(string), "%s oferuje ci kupno neonów za 3 000 000$. Jeœli chcesz zakupiæ neony do swojego %s wpisz /akceptuj neon.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                            SendClientMessage(playa, 0xFFC0CB, string);
                            format(string, sizeof(string), "Oferujesz %s kupno neonów", giveplayer);
                            SendClientMessage(playerid, 0xFFC0CB, string);
                            GraczDajacyNeon[playa] = playerid;
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GREY, "Pojazd w którym siedzi klient nie nale¿y do niego.");
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "Ten gracz nie siedzi w samochodzie.");
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "Jesteœ za daleko od gracza");
                }
            }
            else
            {
                SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ w warsztacie");
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ z NoA/nie masz 3 lub wiêkszej rangi");
        }
    }
    //rup
    return 1;
}
