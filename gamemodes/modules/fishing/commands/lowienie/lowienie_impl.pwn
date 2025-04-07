//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  lowienie                                                 //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_lowienie_Impl(playerid)
{
    new string[128];
    if(PlayerInfo[playerid][pFishes] > 5)
    {
        if (PlayerInfo[playerid][pFishes] > gettime()) {
            sendTipMessageEx(playerid, COLOR_GREY, sprintf("Odczekaj ~%d minut zanim znowu zaczniesz �owi�!", floatround(floatdiv(PlayerInfo[playerid][pFishes] - gettime(), 60), floatround_ceil)));
            return 1;
        }
        PlayerInfo[playerid][pFishes] = 0;
    }
    if(Fishes[playerid][pWeight1] > 0 && Fishes[playerid][pWeight2] > 0 && Fishes[playerid][pWeight3] > 0 && Fishes[playerid][pWeight4] > 0 && Fishes[playerid][pWeight5] > 0)
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Masz ju� 5 ryb, ugotuj je / sprzedaj / wywal !");
        return 1;
    }
    new Veh = GetPlayerVehicleID(playerid);
    if(IsAtFishPlace(playerid) || IsABoat(Veh))
    {
        if(Veh && !IsABoat(Veh)) return sendTipMessageEx(playerid, COLOR_GREY, "Wysi�d� z pojazdu. �owi� mo�na tylko pieszo lub na kutrze rybackim !");
        new Caught;
        new rand;
        new fstring[MAX_PLAYER_NAME];
        new Level = PlayerInfo[playerid][pFishSkill];
        new Float:health;

        if(Level >= 0 && Level <= 50) { Caught = random(200)-70; }
        else if(Level >= 51 && Level <= 100) { Caught = random(500)-200; }
        else if(Level >= 101 && Level <= 200) { Caught = random(1000)-400; }
        else if(Level >= 201 && Level <= 400) { Caught = random(1600)-600; }
        else if(Level >= 401) { Caught = random(1800)-700; }
        rand = random(sizeof(FishNames));

        new vehicleID = GetPlayerVehicleID(playerid);
        new isBoatOwner = IsABoat(vehicleID) && IsCarOwner(playerid, vehicleID);
        if(isBoatOwner) 
        {
            if(!CA_IsVehicleNearWater(vehicleID))
            {
                sendErrorMessage(playerid, "Twoja ��d� nie jest w wodzie!");
                return 1;
            }

            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            CA_FindZ_For2DCoord(x, y, z);
            new Float:depthBonus = 1 + (-z) * 0.1;
            if(depthBonus < 1) 
            {
                depthBonus = 1;
            }
            else if(depthBonus > 1.2) 
            {
                depthBonus = 1.2;
            }

            Caught = floatround(Caught*depthBonus, floatround_ceil);
        }

        if(GetWeather() == 8) 
        {
            Caught = floatround(Caught * 1.5, floatround_ceil);
        }

        if(IsPlayerSick(playerid, FANATYK_WEDKARSTWA)) 
        {
            Caught = floatround(Caught * 1.2, floatround_ceil);
        }
        else
        {
            if(random(1000) == 1)
            {
                InfectPlayer(playerid, FANATYK_WEDKARSTWA);
                ChatMe(playerid, "sta� si� fanatykiem w�dkarstwa.");
                SendClientMessage(playerid, COLOR_PANICRED, "twoja posta� sta�a si� fanatykiem w�dkarstwa. �owisz wi�ksze ryby, ale idzie te� za tym pewien koszt...");
            }
        }

        new hour,unused;
        gettime(hour,unused,unused);
        if((hour >= 18 && hour <= 24) || hour <= 2)
        {
            Caught = floatround(Caught * 1.25, floatround_ceil);
        }
        
        if(Caught <= 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "�y�ka p�k�a!");
            return 1;
        }
        else if(rand == 0)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Z�owi�e� Kie�bas�, wi�c j� zjadasz!");
            GetPlayerHealth(playerid, health);
            SetPlayerHealth(playerid, health + 1.0);
            return 1;
        }
        else if(rand == 4)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Z�owi�e� stare gacie, wi�c je zak�adasz!");
            return 1;
        }
        else if(rand == 7)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Z�owi�e� mu�, wi�c go wyrzucasz!");
            return 1;
        }
        else if(rand == 10)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Z�owi�e� Stare Kalosze, wi�c je zak�adasz!");
            return 1;
        }
        else if(rand == 13)
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Z�owi�e� smalec, wi�c go zjadasz!");
            GetPlayerHealth(playerid, health);
            SetPlayerHealth(playerid, health + 1.0);
            return 1;
        }
        else if(rand == 20)
        {
            new mrand = random(3500);
            format(string, sizeof(string), "* Z�apa�e� sakiewk� pieni�dzy, w �rodku znalaz�e� $%d.", mrand);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            DajKase(playerid, mrand);
            return 1;
        }
        else if(rand == 22) // Wale�
        {
            if(hour >= 18 && hour <= 22)
            {
                Caught = 60000 + random(20000);
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "�y�ka p�k�a!");
                return 1;
            }
        }
        else if(rand == 23) // P�etwal b��kitny
        {
            if(hour >= 18 && hour <= 22)
            {
                Caught = 113000 + random(37000);
            }
            else
            {
                sendTipMessageEx(playerid, COLOR_GREY, "�y�ka p�k�a!");
                return 1;
            }
        }
        if(PlayerInfo[playerid][pFishLic] < 1)
        {
            if(PoziomPoszukiwania[playerid] == 0)
                PoziomPoszukiwania[playerid]++;
            SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Nielegalny po��w ryb");
        }
        if(Fishes[playerid][pWeight1] == 0)
        {
            PlayerInfo[playerid][pFishes] += 1;
            PlayerInfo[playerid][pFishSkill] += 1;
            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
            strmid(Fishes[playerid][pFish1], fstring, 0, strlen(fstring));
            Fishes[playerid][pWeight1] = Caught;
            format(string, sizeof(string), "* Z�apa�e� %s, wa��c� %d kg.", Fishes[playerid][pFish1], Caught);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Fishes[playerid][pLastWeight] = Caught;
            Fishes[playerid][pLastFish] = 1;
            Fishes[playerid][pFid1] = rand;
            Fishes[playerid][pFishID] = rand;
            if(Caught > PlayerInfo[playerid][pBiggestFish])
            {
                format(string, sizeof(string), "* Tw�j stary rekord wynosi� %d kg, zosta� on pobity i tw�j rekord wynosi teraz: %d KG.", PlayerInfo[playerid][pBiggestFish], Caught);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                PlayerInfo[playerid][pBiggestFish] = Caught;
            }
        }
        else if(Fishes[playerid][pWeight2] == 0)
        {
            PlayerInfo[playerid][pFishes] += 1;
            PlayerInfo[playerid][pFishSkill] += 1;
            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
            strmid(Fishes[playerid][pFish2], fstring, 0, strlen(fstring));
            Fishes[playerid][pWeight2] = Caught;
            format(string, sizeof(string), "* Z�apa�e� %s, wa��c� %d kg.", Fishes[playerid][pFish2], Caught);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Fishes[playerid][pLastWeight] = Caught;
            Fishes[playerid][pLastFish] = 2;
            Fishes[playerid][pFid2] = rand;
            Fishes[playerid][pFishID] = rand;
            if(Caught > PlayerInfo[playerid][pBiggestFish])
            {
                format(string, sizeof(string), "* Tw�j stary rekord wynosi� %d kg, zosta� on pobity i tw�j rekord wynosi teraz: %d KG.", PlayerInfo[playerid][pBiggestFish], Caught);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                PlayerInfo[playerid][pBiggestFish] = Caught;
            }
        }
        else if(Fishes[playerid][pWeight3] == 0)
        {
            PlayerInfo[playerid][pFishes] += 1;
            PlayerInfo[playerid][pFishSkill] += 1;
            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
            strmid(Fishes[playerid][pFish3], fstring, 0, strlen(fstring));
            Fishes[playerid][pWeight3] = Caught;
            format(string, sizeof(string), "* Z�apa�e� %s, wa��c� %d kg.", Fishes[playerid][pFish3], Caught);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Fishes[playerid][pLastWeight] = Caught;
            Fishes[playerid][pLastFish] = 3;
            Fishes[playerid][pFid3] = rand;
            Fishes[playerid][pFishID] = rand;
            if(Caught > PlayerInfo[playerid][pBiggestFish])
            {
                format(string, sizeof(string), "* Tw�j stary rekord wynosi� %d kg, zosta� on pobity i tw�j rekord wynosi teraz: %d KG.", PlayerInfo[playerid][pBiggestFish], Caught);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                PlayerInfo[playerid][pBiggestFish] = Caught;
            }
        }
        else if(Fishes[playerid][pWeight4] == 0)
        {
            PlayerInfo[playerid][pFishes] += 1;
            PlayerInfo[playerid][pFishSkill] += 1;
            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
            strmid(Fishes[playerid][pFish4], fstring, 0, strlen(fstring));
            Fishes[playerid][pWeight4] = Caught;
            format(string, sizeof(string), "* Z�apa�e� %s, wa��c� %d kg.", Fishes[playerid][pFish4], Caught);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Fishes[playerid][pLastWeight] = Caught;
            Fishes[playerid][pLastFish] = 4;
            Fishes[playerid][pFid4] = rand;
            Fishes[playerid][pFishID] = rand;
            if(Caught > PlayerInfo[playerid][pBiggestFish])
            {
                format(string, sizeof(string), "* Tw�j stary rekord wynosi� %d kg, zosta� on pobity i tw�j rekord wynosi teraz: %d KG.", PlayerInfo[playerid][pBiggestFish], Caught);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                PlayerInfo[playerid][pBiggestFish] = Caught;
            }
        }
        else if(Fishes[playerid][pWeight5] == 0)
        {
            PlayerInfo[playerid][pFishes] += 1;
            PlayerInfo[playerid][pFishSkill] += 1;
            format(fstring, sizeof(fstring), "%s", FishNames[rand]);
            strmid(Fishes[playerid][pFish5], fstring, 0, strlen(fstring));
            Fishes[playerid][pWeight5] = Caught;
            format(string, sizeof(string), "* Z�apa�e� %s, wa��c� %d kg.", Fishes[playerid][pFish5], Caught);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            Fishes[playerid][pLastWeight] = Caught;
            Fishes[playerid][pLastFish] = 5;
            Fishes[playerid][pFid5] = rand;
            Fishes[playerid][pFishID] = rand;
            if(Caught > PlayerInfo[playerid][pBiggestFish])
            {
                format(string, sizeof(string), "* Tw�j stary rekord wynosi� %d kg, zosta� on pobity i tw�j rekord wynosi teraz: %d KG.", PlayerInfo[playerid][pBiggestFish], Caught);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                PlayerInfo[playerid][pBiggestFish] = Caught;
            }
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie masz ju� miejsca na nowe ryby !");
            return 1;
        }
        if(PlayerInfo[playerid][pFishSkill] == 50)
        { SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiej�tno�ci rybaka wynosz� teraz 2, mo�esz �owi� wi�ksze ryby."); }
        else if(PlayerInfo[playerid][pFishSkill] == 100)
        { SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiej�tno�ci rybaka wynosz� teraz 3, mo�esz �owi� wi�ksze ryby."); }
        else if(PlayerInfo[playerid][pFishSkill] == 200)
        { SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiej�tno�ci rybaka wynosz� teraz 4, mo�esz �owi� wi�ksze ryby."); }
        else if(PlayerInfo[playerid][pFishSkill] == 400)
        { SendClientMessage(playerid, COLOR_YELLOW, "* Twoje umiej�tno�ci rybaka wynosz� teraz 5, mo�esz �owi� wi�ksze ryby."); }
        if (PlayerInfo[playerid][pFishes] == 5)
            PlayerInfo[playerid][pFishes] = gettime() + 60 * 15; // 15 minutes
        MruMySQL_UpdateFish(playerid, Fishes[playerid][pLastFish]);
    }
    else
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Nie jeste� w miejscu gdzie mo�na �owi� (Molo z ko�em) ani na kutrze rybackim !");
        return 1;
    }
    return 1;
}

//end