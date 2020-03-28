//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ felga ]-------------------------------------------------//
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

YCMD:felga(playerid, params[], help)
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsANoA(playerid) || GetPlayerOrg(playerid) == 15 || GetPlayerOrg(playerid) == 16 || GetPlayerOrg(playerid) == 19)//if(PlayerInfo[playerid][pJob] == 7 || IsANoA(playerid))
        {
            if(!IsAtWarsztat(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
            new playa, idfelgi;
            if( sscanf(params, "k<fix>d", playa, idfelgi))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /felga [Nick/ID] [id felgi]");
                SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Koszt tuningu to: 15 000$ , aby zobaczyæ liste felg wpisz /felgi");
                return 1;
            }

            if(IsPlayerConnected(playa))
            {
                if(playa != INVALID_PLAYER_ID)
                {
                    if(GetDistanceBetweenPlayers(playerid,playa) < 10)
                    {
                        if(IsPlayerInAnyVehicle(playa))
                        {
                            if(kaska[playerid] > 15000)
                            {
                                if(idfelgi >= 1 && idfelgi <= 17)
                                {
                                    if(PlayerInfo[playerid][pMechSkill] >= 100)
                                    {
                                        new pojazd = GetPlayerVehicleID(playa);
                                        if(!IsCarOwner(playa, pojazd))
                                            return SendClientMessage(playerid, COLOR_GRAD2, "Ten pojazd nie nale¿y do tego gracza.");

                                        new felga = idfelgi+1072;
                                        GetPlayerName(playerid, sendername, sizeof(sendername));
                                        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                        format(string, sizeof(string), "* Zamontowa³eœ nowe felgi graczowi %s (koszt -15 000$)",giveplayer);
                                        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowe felgi",sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                        SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                        format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje nowe felgi w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                        ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                        ZabierzKase(playerid, 15000);
                                        format(string, sizeof(string), "~r~-$%d", 15000);
                                        GameTextForPlayer(playerid, string, 5000, 1);
                                        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                        if(felga >= 173 && felga <= 1085)
                                        {
                                            AddVehicleComponent(pojazd,felga);//felga1079
                                            CarData[VehicleUID[pojazd][vUID]][c_Felgi] = felga;
                                        }
                                        else if(felga >= 1086 && felga <= 1088)
                                        {
                                            AddVehicleComponent(pojazd,felga+10);//felga
                                            CarData[VehicleUID[pojazd][vUID]][c_Felgi] = felga+10;
                                        }
                                        else if(idfelgi == 17)
                                        {
                                            AddVehicleComponent(pojazd,1025);//felga
                                            CarData[VehicleUID[pojazd][vUID]][c_Felgi] = 1025;
                                        }
                                        if(playa != playerid)
                                        {
                                            PlayerInfo[playerid][pMechSkill] ++;
                                            SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                            PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                        }
                                    }
                                    else
                                    {
                                        SendClientMessage(playerid, COLOR_GRAD2, "Musisz mieæ 3 skill mechanika");
                                    }
                                }
                            }
                            else
                            {
                                SendClientMessage(playerid, COLOR_WHITE, "Nie masz wystarczaj¹cej iloœci pieniêdzy (15000$)");
                            }
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_WHITE, "Gracz nie jest w samochodzie");
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_WHITE, "Gracz nie jest za daleko");
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_WHITE, "Nie ma takiego gracza");
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_WHITE, "Nie jesteœ mechanikiem");
        }
    }
    return 1;
}
