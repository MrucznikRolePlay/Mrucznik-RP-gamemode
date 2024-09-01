//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//----------------------------------------------[ sprzedajbron ]---------------------------------------------//
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

enum eGunInfo {
    GunName[16],
    GunSkill,
    GunId,
    GunSlot,
    GunAmmo,
    GunMaterialsCost,
    GunContrabandCost
};
new GunInfo[][eGunInfo] = {
    // name,    skill,  gunid,  slot,   ammo,   materials, contraband
    // broñ bia³a
    {"katana",      1,      8,      1,      1,      100,        0},
    {"pila",        4,      9,      1,      1,      1000,       20},
    {"noz",         5,      4,      1,      1,      100,        100},
    // pistolety
    {"pistolety",   1,      22,     2,      200,    75,         0},
    {"sdpistol",    2,      23,     2,      114,    125,        0},
    {"eagle",       3,      24,     2,      107,    200,        0},
    // strzelby
    {"shotgun",     1,      25,     3,      50,     125,        0},
    {"spas12",      4,      27,     3,      57,     1500,       0},
    {"obrzyn",      4,      26,     3,      100,    1500,       35},
    // pistolety maszynowe
    {"mp5",         2,      29,     4,      700,    225,        0},
    {"tec9",        3,      32,     4,      750,    875,        20},
    {"uzi",         4,      28,     4,      750,    900,        15},
    // karabiny
    {"ak47",        3,      30,     5,      550,    650,        1},
    {"m4",          4,      31,     5,      550,    700,        1},
    // karabiny wyborowe
    {"rifle",       3,      33,     6,      51,     325,        0},
    {"sniper",      4,      34,     6,      51,     1000,       1},
    // bronie specjalne
    {"ogniomiotacz",5,      37,     7,      200,    10000,      50},
    {"rpg",         5,      35,     7,      10,     15000,      200},
    {"minigun",     5,      38,     7,      100,    50000,      1000},
    // ³adunki wybuchowe
    {"molotov",     3,      18,     8,      10,     2500,       25},
    {"granaty",     4,      16,     8,      10,     2500,       35},
    {"c4",          5,      39,     8,      10,     2500,       50}
};

YCMD:sprzedajbron(playerid, params[], help)
{
    if(GetPlayerJob(playerid) != JOB_GUN_DEALER)
    {
        MruMessageFail(playerid, "Nie jesteœ dilerem broni.");
        return 1;
    }

    new x_weapon[16];
    new giveplayerid;
    if( sscanf(params, "k<fix>s[16]", giveplayerid, x_weapon))
    {
        SprzedajBronTip(playerid);
        return 1;
    }

    if (IsPlayerConnected(giveplayerid))
    {
        MruMessageFail(playerid, "Nie ma takiego gracza.");
        return 1;
    }

    if(PlayerInfo[giveplayerid][pConnectTime] >= 3)
    {
        MruMessageFail(playerid, "Broñ mog¹ posiadaæ tylko gracze z przegranymi minimum 3 godzinami online !");
        MruMessageFail(giveplayerid, "Broñ mog¹ posiadaæ tylko gracze z przegranymi minimum 3 godzinami online !");
        return 1;
    }

    if(IsASklepZBronia(playerid))
    {
        if(PlayerInfo[giveplayerid][pGunLic] != 1 || strcmp(x_weapon,"pistolety",true) == 0)
        {
            MruMessageFail(playerid, "Ten gracz nie ma licencji na broñ. Mo¿esz sprzedaæ mu tylko pistolety.");
            return 1;
        }
    }

    if(IsPlayerInAnyVehicle(giveplayerid)) 
    {
        MruMessageFail(playerid, "Klient nie mo¿e byæ w pojeŸdzie.");
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

    // perk matsiarz - obni¿ koszt broni
    new matsCost = GunInfo[weaponid][GunMaterialsCost];
    if(PlayerInfo[playerid][pMiserPerk] > 0)
    {
        new skill = 2 * PlayerInfo[playerid][pMiserPerk];
        new mats = GunInfo[weaponid][GunMaterialsCost] / 100;
        matsCost -= (mats)*(skill);
    }

    if(GetPlayerJobSkill(playerid, JOB_DRUG_DEALER) < GunInfo[weaponid][GunSkill])
    {
        MruMessageFailF(playerid, "By sprzedaæ %s potrzebujesz %d skilla dilera broni.", x_weapon, GunInfo[weaponid][GunSkill]);
        return 1;
    }

    if(PlayerInfo[playerid][pMats] < matsCost)
    {
        MruMessageFailF(playerid, "Broñ %s wymaga %d materia³ów by j¹ stworzyæ, a masz tylko %d.", x_weapon, matsCost, PlayerInfo[playerid][pMats]);
        return 1;
    }

    new contrabandCost = GunInfo[weaponid][GunContrabandCost];
    if(GetContraband(playerid) < contrabandCost)
    {
        MruMessageFailF(playerid, "Broñ %s wymaga %d kontrabandy by j¹ stworzyæ, a masz tylko %d.", x_weapon, contrabandCost, GetContraband(playerid));
        return 1;
    }

    if(Cooldown(playerid, "sprzedajbron", 10))
    {
        return 1;
    }

    if(playerid != giveplayerid)
    {
        IncreasePlayerJobSkill(playerid, JOB_GUN_DEALER, 1);
    }

    // give weapon, etc
    new legalWeapon = IsASklepZBronia(playerid);
    GivePlayerWeaponEx(giveplayerid, GunInfo[weaponid][GunId], GunInfo[weaponid][GunAmmo], legalWeapon);
    if(GunInfo[weaponid][GunId] == 39) //C4
    {
        GivePlayerWeaponEx(giveplayerid, 40, 1, legalWeapon); // pilot do C4
    }
    if(PlayerInfo[giveplayerid][pGunLic] != 1)
    {
        PoziomPoszukiwania[giveplayerid] += 1;
        SetPlayerCriminal(giveplayerid, INVALID_PLAYER_ID, "posiadanie nielegalnej broni");
        SetPlayerWantedLevel(giveplayerid, PoziomPoszukiwania[giveplayerid]);   
    }

    // take mats & contraband
    PlayerInfo[playerid][pMats] -= matsCost;
    TakeContraband(playerid, contrabandCost);

    // messages
    if(contrabandCost > 0)
    {
        MruMessageGoodInfoF(playerid, "Da³eœ %s, %s z %d nabojami, z %d materia³ów i %d kontrabandy.", GetNick(giveplayerid), x_weapon, GunInfo[weaponid][GunAmmo], matsCost, contrabandCost);
    }
    else
    {
        MruMessageGoodInfoF(playerid, "Da³eœ %s, %s z %d nabojami, z %d materia³ów.", GetNick(giveplayerid), x_weapon, GunInfo[weaponid][GunAmmo], matsCost);
    }
    MruMessageGoodInfoF(giveplayerid, "Odebra³eœ %s z %d nabojami od %s.", x_weapon, GunInfo[weaponid][GunAmmo], GetNick(playerid));
    ChatMe(playerid, sprintf("%s stworzy³ broñ z materia³ów i da³ j¹ %s.", GetNick(playerid), GetNick(giveplayerid)));

    PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
    PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);

    Log(payLog, INFO, "Gracz %s sprzeda³ graczowi %s broñ %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetWeaponLogName(GunInfo[weaponid][GunId], GunInfo[weaponid][GunAmmo]));

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

    for(new i; i<sizeof(GunInfo); i++)
    {
        new skill = GunInfo[i][GunSkill];
        if(GunInfo[i][GunContrabandCost] > 0)
        {
            strcat(contrabandGuns[skill], sprintf("%s(%d + %d) "));
        }
        else
        {
            strcat(guns[skill], sprintf("%s(%d + %d) "));
        }
    }


    SendClientMessage(playerid, COLOR_GREEN, "________________________________________________");
    SendClientMessage(playerid, COLOR_GRAD1, "U¿yj: /sprzedajbron [ID gracza] [nazwa broni]");
    SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI]----");
    for(new i; i<sizeof(guns); i++)
    {
        if(strlen(guns[i]) == startlen) continue;
        SendClientMessage(playerid, COLOR_GREY, guns[i]);
    }
    SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI - KONTRABANDA]----");
    for(new i; i<sizeof(guns); i++)
    {
        if(strlen(contrabandGuns[i]) == startlen) continue;
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
            MruMessageErrorF(playerid, "Niepoprawna broñ id %d, zg³oœ Mrucznikowi", weaponid);
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
        MruMessageFailF(playerid, "Musisz odczekaæ %d sekund zanim ponownie u¿yjesz tej komendy.", timeToWait);
        return 0;
    }
    SetPVarInt(playerid, key, gettime() + cooldownInSeconds);
    return 1;
}