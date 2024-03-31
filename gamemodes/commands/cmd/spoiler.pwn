//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ spoiler ]------------------------------------------------//
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

YCMD:spoiler(playerid, params[], help)
{
    new string[256];
    new giveplayer[MAX_PLAYER_NAME];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(IsAMechazordWarsztatowy(playerid) || PlayerInfo[playerid][pJob] == 7)
        {
            if(!IsAtWarsztat(playerid)) return sendErrorMessage(playerid, "Nie jesteœ w warsztacie, w którym mo¿na prowadziæ tuning");
            new playa, spojlerid;
            if( sscanf(params, "k<fix>d", playa, spojlerid))
            {
                SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: /spojler [Nick/ID] [id spojlera]");
                SendClientMessage(playerid, COLOR_GRAD3, "INFORMACJA: Koszt spojera to: 25 000$ , aby zobaczyæ listê spojlerów wpisz /spojlery");
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
                            if(kaska[playerid] > 25000)
                            {
                                if(PlayerInfo[playerid][pMechSkill] >= 200)
                                {
                                    if(spojlerid >= 1 && spojlerid <= 10)
                                    {
                                        new pojazd = GetPlayerVehicleID(playa);
                                        GetPlayerName(playerid, sendername, sizeof(sendername));
                                        GetPlayerName(playa, giveplayer, sizeof(giveplayer));
                                        if(IsASpojler(pojazd))
                                        {
                                            if(spojlerid < 5)
                                            {
                                                new spojler = spojlerid+999;
                                                format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                ZabierzKase(playerid, 25000);
                                                format(string, sizeof(string), "~r~-$%d", 25000);
                                                GameTextForPlayer(playerid, string, 5000, 1);
                                                PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                AddVehicleComponent(pojazd,spojler);//spojler
                                                CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                if(playa != playerid)
                                                {
                                                    PlayerInfo[playerid][pMechSkill] ++;
                                                    SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                    PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                }
                                            }
                                            else if(spojlerid >= 5 && spojlerid <= 7)
                                            {
                                                new spojler = spojlerid+1009;
                                                format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                ZabierzKase(playerid, 25000);
                                                format(string, sizeof(string), "~r~-$%d", 25000);
                                                GameTextForPlayer(playerid, string, 5000, 1);
                                                PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                AddVehicleComponent(pojazd,spojler);//spojler
                                                CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                if(playa != playerid)
                                                {
                                                    PlayerInfo[playerid][pMechSkill] ++;
                                                    SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                    PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                }
                                            }
                                            else if(spojlerid == 8)
                                            {
                                                new spojler = 1023;
                                                format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                ZabierzKase(playerid, 25000);
                                                format(string, sizeof(string), "~r~-$%d", 25000);
                                                GameTextForPlayer(playerid, string, 5000, 1);
                                                PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                AddVehicleComponent(pojazd,spojler);//spojler
                                                CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                if(playa != playerid)
                                                {
                                                    PlayerInfo[playerid][pMechSkill] ++;
                                                    SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                    PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                }
                                            }
                                            else if(spojlerid >= 9)
                                            {
                                                if(GetVehicleModel(pojazd) == 558)
                                                {
                                                    new spojler = 1154+spojlerid;
                                                    format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                    ZabierzKase(playerid, 25000);
                                                    format(string, sizeof(string), "~r~-$%d", 25000);
                                                    GameTextForPlayer(playerid, string, 5000, 1);
                                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                    AddVehicleComponent(pojazd,spojler);//spojler
                                                    CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                    if(playa != playerid)
                                                    {
                                                        PlayerInfo[playerid][pMechSkill] ++;
                                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                    }
                                                }
                                                else if(GetVehicleModel(pojazd) == 559)
                                                {
                                                    new spojler;
                                                    if(spojlerid == 9)
                                                    {
                                                        spojler = 1162;
                                                    }
                                                    else if(spojlerid == 10)
                                                    {
                                                        spojler = 1158;
                                                    }
                                                    format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                    ZabierzKase(playerid, 25000);
                                                    format(string, sizeof(string), "~r~-$%d", 25000);
                                                    GameTextForPlayer(playerid, string, 5000, 1);
                                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                    AddVehicleComponent(pojazd,spojler);//spojler
                                                    CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                    if(playa != playerid)
                                                    {
                                                        PlayerInfo[playerid][pMechSkill] ++;
                                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                    }
                                                }
                                                else if(GetVehicleModel(pojazd) == 560)
                                                {
                                                    new spojler;
                                                    if(spojlerid == 9)
                                                    {
                                                        spojler = 1138;
                                                    }
                                                    else if(spojlerid == 10)
                                                    {
                                                        spojler = 1139;
                                                    }
                                                    format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25000$)", giveplayer);
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                    ZabierzKase(playerid, 25000);
                                                    format(string, sizeof(string), "~r~-$%d", 2500);
                                                    GameTextForPlayer(playerid, string, 5000, 1);
                                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                    AddVehicleComponent(pojazd,spojler);//spojler
                                                    CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                    if(playa != playerid)
                                                    {
                                                        PlayerInfo[playerid][pMechSkill] ++;
                                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                    }
                                                }
                                                else if(GetVehicleModel(pojazd) == 561)
                                                {
                                                    new spojler;
                                                    if(spojlerid == 9)
                                                    {
                                                        spojler = 1058;
                                                    }
                                                    else if(spojlerid == 10)
                                                    {
                                                        spojler = 1060;
                                                    }
                                                    format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                    ZabierzKase(playerid, 25000);
                                                    format(string, sizeof(string), "~r~-$%d", 25000);
                                                    GameTextForPlayer(playerid, string, 5000, 1);
                                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                    AddVehicleComponent(pojazd,spojler);//spojler
                                                    CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                    if(playa != playerid)
                                                    {
                                                        PlayerInfo[playerid][pMechSkill] ++;
                                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                    }
                                                }
                                                else if(GetVehicleModel(pojazd) == 562)
                                                {
                                                    new spojler;
                                                    if(spojlerid == 9)
                                                    {
                                                        spojler = 1146;
                                                    }
                                                    else if(spojlerid == 10)
                                                    {
                                                        spojler = 1147;
                                                    }
                                                    format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                    ZabierzKase(playerid, 25000);
                                                    format(string, sizeof(string), "~r~-$%d", 25000);
                                                    GameTextForPlayer(playerid, string, 5000, 1);
                                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                    AddVehicleComponent(pojazd,spojler);//spojler
                                                    CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                    if(playa != playerid)
                                                    {
                                                        PlayerInfo[playerid][pMechSkill] ++;
                                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                    }
                                                }
                                                else if(GetVehicleModel(pojazd) == 565)
                                                {
                                                    new spojler;
                                                    if(spojlerid == 9)
                                                    {
                                                        spojler = 1049;
                                                    }
                                                    else if(spojlerid == 10)
                                                    {
                                                        spojler = 1050;
                                                    }
                                                    format(string, sizeof(string), "* Zamontowa³eœ nowy spojler graczowi %s (koszt -25 000$)", giveplayer);
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string), "* Mechanik %s zamontowa³ ci w twoim %s nowy spojler", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    SendClientMessage(playa, COLOR_LIGHTBLUE, string);
                                                    format(string, sizeof(string),"* Mechanik %s wyci¹ga narzêdzia i montuje spojler w %s.", sendername, VehicleNames[GetVehicleModel(pojazd)-400]);
                                                    ProxDetector(20.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                                    ZabierzKase(playerid, 25000);
                                                    format(string, sizeof(string), "~r~-$%d", 25000);
                                                    GameTextForPlayer(playerid, string, 5000, 1);
                                                    PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
                                                    AddVehicleComponent(pojazd,spojler);//spojler
                                                    CarData[VehicleUID[pojazd][vUID]][c_Spoiler] = spojler;
                                                    if(playa != playerid)
                                                    {
                                                        PlayerInfo[playerid][pMechSkill] ++;
                                                        SendClientMessage(playerid, COLOR_GRAD2, "Skill +1");
                                                        PlayerPlaySound(playa, 1133, 0.0, 0.0, 0.0);
                                                    }
                                                }
                                                else
                                                {
                                                    SendClientMessage(playerid, COLOR_LIGHTBLUE, "W tym wozie nie mo¿na zamontowaæ spojleru Alien ani X-Flow");
                                                    return 1;
                                                }
                                            }
                                            Log(payLog, INFO, "Gracz %s zamontowa³ %s spoiler %d na pojazd %s za %d$",
                                                GetPlayerLogName(playerid), GetPlayerLogName(playa), spojlerid, GetVehicleLogName(pojazd), 25000
                                            );
                                        }
                                        else
                                        {
                                            SendClientMessage(playerid, COLOR_LIGHTBLUE, "W tym wozie nie mo¿na zamontowaæ spojleru");
                                        }
                                    }
                                    else
                                    {
                                        SendClientMessage(playerid, COLOR_GREY, "Z³y numer spojlera");
                                    }
                                }
                                else
                                {
                                    SendClientMessage(playerid, COLOR_GREY, "Potrzebujesz 4 skilla mechanika aby móc dawaæ spojlery");
                                }
                            }
                            else
                            {
                                SendClientMessage(playerid, COLOR_GREY, "Nie masz wystarczaj¹cej iloœci pieniêdzy (25 000$)");
                            }
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GREY, "Gracz nie jest w samochodzie");
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GREY, "Gracz nie jest za daleko");
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GREY, "Nie ma takiego gracza");
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ mechanikiem");
        }
    }
    return 1;
}
