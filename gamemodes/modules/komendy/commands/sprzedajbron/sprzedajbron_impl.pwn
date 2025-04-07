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
command_sprzedajbron_Impl(playerid, params[256])
{
    if(GetPlayerJob(playerid) != JOB_GUN_DEALER)
    {
        MruMessageFail(playerid, "Nie jeste� dilerem broni.");
        return 1;
    }

    new x_weapon[16];
    new giveplayerid;
    if(sscanf(params, "k<fix>s[16]", giveplayerid, x_weapon))
    {
        SprzedajBronTip(playerid);
        return 1;
    }

    if(!IsPlayerConnected(giveplayerid))
    {
        MruMessageFail(playerid, "Nie ma takiego gracza.");
        return 1;
    }

    if(PlayerInfo[giveplayerid][pConnectTime] < 3)
    {
        MruMessageFail(playerid, "Bro� mog� posiada� tylko gracze z przegranymi minimum 3 godzinami online !");
        MruMessageFail(giveplayerid, "Bro� mog� posiada� tylko gracze z przegranymi minimum 3 godzinami online !");
        return 1;
    }

    if(IsPlayerInAnyVehicle(giveplayerid)) 
    {
        MruMessageFail(playerid, "Klient nie mo�e by� w poje�dzie.");
        return 1;
    }
    
    if(!IsPlayerNear(playerid, giveplayerid))
    {
        MruMessageFail(playerid, "Ten gracz jest za daleko !");
        return 1;
    }

    if(!strlen(x_weapon))
    {
        SprzedajBronTip(playerid);
        return 1;
    }

    new weaponid = -1;
    for(new i; i<sizeof(GunInfo); i++)
    {
        if(strcmp(GunInfo[i], x_weapon, true) == 0)
        {
            weaponid = i;
            break;
        }
    }
    if(weaponid == -1)
    {
        SprzedajBronTip(playerid);
        return 1;
    }

    // perk matsiarz - obni� koszt broni
    new matsCost = GunInfo[weaponid][GunMaterialsCost];
    if(PlayerInfo[playerid][pMiserPerk] > 0)
    {
        new skill = 2 * PlayerInfo[playerid][pMiserPerk];
        new mats = GunInfo[weaponid][GunMaterialsCost] / 100;
        matsCost -= (mats)*(skill);
    }

    if(GetPlayerJobSkill(playerid, JOB_GUN_DEALER) < GunInfo[weaponid][GunSkill])
    {
        MruMessageFailF(playerid, "By sprzeda� %s potrzebujesz %d skilla dilera broni.", x_weapon, GunInfo[weaponid][GunSkill]);
        return 1;
    }

    if(PlayerInfo[playerid][pMats] < matsCost)
    {
        MruMessageFailF(playerid, "Bro� %s wymaga %d materia��w by j� stworzy�, a masz tylko %d.", x_weapon, matsCost, PlayerInfo[playerid][pMats]);
        return 1;
    }

    new contrabandCost = GunInfo[weaponid][GunContrabandCost];
    if(GetContraband(playerid) < contrabandCost)
    {
        MruMessageFailF(playerid, "Bro� %s wymaga %d kontrabandy by j� stworzy�, a masz tylko %d.", x_weapon, contrabandCost, GetContraband(playerid));
        return 1;
    }

    if(Cooldown(playerid, "sprzedajbron", 10))
    {
        MruMessageFail(playerid, "Odczekaj chwil� zanim ponownie wpiszesz t� komend�.");
        return 1;
    }

    if(playerid != giveplayerid)
    {
        IncreasePlayerJobSkill(playerid, JOB_GUN_DEALER, 1);
    }

    // give weapon, etc
    new legalWeapon = IsBusinessTypeOwnedByPlayerOrg(playerid, FRONT_BIZ_TYPE_GUNSHOP);
    GivePlayerWeaponEx(giveplayerid, GunInfo[weaponid][GunId], GunInfo[weaponid][GunAmmo], legalWeapon);
    if(GunInfo[weaponid][GunId] == 39) //C4
    {
        GivePlayerWeaponEx(giveplayerid, 40, 1, legalWeapon); // pilot do C4
    }
    if(PlayerInfo[giveplayerid][pGunLic] != 1)
    {
        PoziomPoszukiwania[giveplayerid] += 1;
        SetPlayerCriminal(giveplayerid, INVALID_PLAYER_ID, "nielegalne posiadanie broni");
        SetPlayerWantedLevel(giveplayerid, PoziomPoszukiwania[giveplayerid]);   
    }

    // take mats & contraband
    PlayerInfo[playerid][pMats] -= matsCost;
    TakeContraband(playerid, contrabandCost);

    // messages
    if(contrabandCost > 0)
    {
        MruMessageGoodInfoF(playerid, "Da�e� %s, %s z %d nabojami, z %d materia��w i %d kontrabandy.", GetNick(giveplayerid), x_weapon, GunInfo[weaponid][GunAmmo], matsCost, contrabandCost);
    }
    else
    {
        MruMessageGoodInfoF(playerid, "Da�e� %s, %s z %d nabojami, z %d materia��w.", GetNick(giveplayerid), x_weapon, GunInfo[weaponid][GunAmmo], matsCost);
    }
    MruMessageGoodInfoF(giveplayerid, "Odebra�e� %s z %d nabojami od %s.", x_weapon, GunInfo[weaponid][GunAmmo], GetNick(playerid));
    ChatMe(playerid, sprintf("%s stworzy� bro� z materia��w i da� j� %s.", GetNick(playerid), GetNick(giveplayerid)));

    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);

    // Tajniak
    new redisKey[64];
    format(redisKey, sizeof(redisKey), "player:%d:deconspired", PlayerInfo[playerid][pUID]);
    if(!legalWeapon && IsAPolicja(playerid) && OnDuty[playerid] && SecretAgent[playerid] > 0 && spamwl[giveplayerid] == 0)
    {
        PoziomPoszukiwania[giveplayerid] += 4;
        PlayCrimeReportForPlayer(playerid, giveplayerid, 14);
        SetPlayerCriminal(giveplayerid, playerid, "nielegalna sprzeda� broni");
        SetPlayerWantedLevel(giveplayerid, PoziomPoszukiwania[giveplayerid]);

        PursuitMode(playerid, giveplayerid);

        if(RedisGetInt(redisKey))
        {
            new reward = 125_000;
            DajKase(playerid, reward);
            Log(payLog, INFO, "%s z�apa� dilera broni %s na gor�cym uczynku i dosta� %d$", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), reward);
            MruMessageGoodInfoF(playerid, "Nakry�e� %s na sprzeda�y nielegalnej broni! Dostajesz %d$ za wykonywanie swojej pracy.", GetNick(giveplayerid), reward);
        }
        else
        {
            MruMessageGoodInfoF(playerid, "Nakry�e� %s na sprzeda�y nielegalnej broni! Ju� raz nakry�e� tego gracza w przeci�gu 24h wi�c nie dostajesz bonusu.", GetNick(giveplayerid));
        }
        MruMessageBadInfoF(giveplayerid, "Tajny agent %s nakry� Ci� na sprzeda�y nielegalnej broni! Masz teraz %d Poziom Poszukiwania.", GetNick(playerid), PoziomPoszukiwania[giveplayerid]);

        SetTimerEx("spamujewl",300_000,0,"d",giveplayerid); //5min anty-wl
        spamwl[giveplayerid] = 1;

        Redis_SetInt(RedisClient, redisKey, 1);
        RedisExpire(redisKey, 24 * 3600);
    }

    Log(payLog, INFO, "Gracz %s sprzeda� graczowi %s bro� %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetWeaponLogName(GunInfo[weaponid][GunId], GunInfo[weaponid][GunAmmo]));
    return 1;
}

SprzedajBronTip(playerid)
{
    new guns[5][MAX_MESSAGE_LENGTH];
    new contrabandGuns[5][MAX_MESSAGE_LENGTH];
    for(new i; i < 5; i++)
    {
        strcat(guns[i], sprintf("Bronie %d skill: ", i + 1));
        strcat(contrabandGuns[i], sprintf("Bronie %d skill: ", i + 1));
    }
    new startlen = strlen(guns[0]);
    new startlenContra = strlen(contrabandGuns[0]);

    for(new i; i<sizeof(GunInfo); i++)
    {
        new skill = GunInfo[i][GunSkill] - 1;
        if(GunInfo[i][GunContrabandCost] > 0)
        {
            format(contrabandGuns[skill], MAX_MESSAGE_LENGTH, "%s%s(%d + %d) ", contrabandGuns[skill], GunInfo[i][GunName], GunInfo[i][GunMaterialsCost], GunInfo[i][GunContrabandCost]);
        }
        else
        {
            format(guns[skill], MAX_MESSAGE_LENGTH, "%s%s(%d) ", guns[skill], GunInfo[i][GunName], GunInfo[i][GunMaterialsCost]);
        }
    }

    SendClientMessage(playerid, COLOR_GREEN, "________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1, "U�yj: /sprzedajbron [ID gracza] [nazwa broni]");
    SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI]----");
    for(new i; i < 5; i++)
    {
        if(strlen(guns[i]) == startlen) continue;
        SendClientMessage(playerid, COLOR_GREY, guns[i]);
    }
    SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI - KONTRABANDA]----");
    for(new i; i < 5; i++)
    {
        if(strlen(contrabandGuns[i]) == startlenContra) continue;
        SendClientMessage(playerid, COLOR_GREY, contrabandGuns[i]);
    }
}

GivePlayerWeaponEx(playerid, weaponid, ammo, legal)
{
    GivePlayerWeapon(playerid, weaponid, ammo);

    new slot = GetWeaponSlot(weaponid);
    switch(slot)
    {
        case 1: { playerWeapons[playerid][weaponLegal1] = legal; PlayerInfo[playerid][pGun1] = weaponid; PlayerInfo[playerid][pAmmo1] = ammo; }
        case 2: { playerWeapons[playerid][weaponLegal2] = legal; PlayerInfo[playerid][pGun2] = weaponid; PlayerInfo[playerid][pAmmo2] = ammo; }
        case 3: { playerWeapons[playerid][weaponLegal3] = legal; PlayerInfo[playerid][pGun3] = weaponid; PlayerInfo[playerid][pAmmo3] = ammo; }
        case 4: { playerWeapons[playerid][weaponLegal4] = legal; PlayerInfo[playerid][pGun4] = weaponid; PlayerInfo[playerid][pAmmo4] = ammo; }
        case 5: { playerWeapons[playerid][weaponLegal5] = legal; PlayerInfo[playerid][pGun5] = weaponid; PlayerInfo[playerid][pAmmo5] = ammo; }
        case 6: { playerWeapons[playerid][weaponLegal6] = legal; PlayerInfo[playerid][pGun6] = weaponid; PlayerInfo[playerid][pAmmo6] = ammo; }
        case 7: { playerWeapons[playerid][weaponLegal7] = legal; PlayerInfo[playerid][pGun7] = weaponid; PlayerInfo[playerid][pAmmo7] = ammo; }
        case 8: { playerWeapons[playerid][weaponLegal8] = legal; PlayerInfo[playerid][pGun8] = weaponid; PlayerInfo[playerid][pAmmo8] = ammo; }
        case 9: { playerWeapons[playerid][weaponLegal9] = legal; PlayerInfo[playerid][pGun9] = weaponid; PlayerInfo[playerid][pAmmo9] = ammo; }
        case 10: { playerWeapons[playerid][weaponLegal10] = legal; PlayerInfo[playerid][pGun10] = weaponid; PlayerInfo[playerid][pAmmo10] = ammo; }
        case 11: { playerWeapons[playerid][weaponLegal11] = legal; PlayerInfo[playerid][pGun11] = weaponid; PlayerInfo[playerid][pAmmo11] = ammo; }
        case 12: { playerWeapons[playerid][weaponLegal12] = legal; PlayerInfo[playerid][pGun12] = weaponid; PlayerInfo[playerid][pAmmo12] = ammo; }
        default:
        {
            MruMessageErrorF(playerid, "Niepoprawna bro� id %d, zg�o� Mrucznikowi", weaponid);
            printf("niepoprawna bron: %s %d %d %d %d", GetNick(playerid), playerid, weaponid, ammo, legal);
        }
    }
}

Cooldown(playerid, name[], cooldownInSeconds)
{
    new key[64];
    format(key, sizeof(key), "cooldown_%s", name);
    new timeToWait = GetPVarInt(playerid, key) - gettime();
    if(timeToWait > 0)
    {
        MruMessageFailF(playerid, "Musisz odczeka� %d sekund zanim ponownie u�yjesz tej komendy.", timeToWait);
        return 0;
    }
    SetPVarInt(playerid, key, gettime() + cooldownInSeconds);
    return 1;
}

//end
