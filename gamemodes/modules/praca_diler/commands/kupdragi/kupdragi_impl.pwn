//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  kupdragi                                                 //
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
// Data utworzenia: 06.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kupdragi_Impl(playerid, weight)
{
    if(GetPVarInt(playerid, PVAR_DEALER_PRICE) != 0)
    {
        MruMessageFail(playerid, "Nie mo¿esz kupiæ narkotyków, gdy sam nimi dilujesz.");
        return 1;
    }

    new dealerid = GetClosestDrugDealer(playerid);
    if(dealerid == INVALID_PLAYER_ID)
    {
        MruMessageFail(playerid, "Nie ma w pobli¿u ¿adnego dilera lub jesteœ od niego zbyt daleko.");
        return 1;
    }

    if(weight < 0)
    {
        MruMessageFail(playerid, "Waga nie mo¿e byæ ujemna.");
        return 1;
    }

    if(weight + PlayerInfo[playerid][pDrugs]  > NORMAL_PLAYER_MAX_DRUGS)
    {
        MruMessageFailF(playerid, "Mo¿esz mieæ maksymalnie %d gram narkotyków. Aktualnie masz %d.", NORMAL_PLAYER_MAX_DRUGS, PlayerInfo[playerid][pDrugs]);
        return 1;
    }

    new perGramPrice = GetPVarInt(dealerid, PVAR_DEALER_PRICE);
    new price = perGramPrice * weight;
    if(kaska[playerid] < price)
    {
        MruMessageFailF(playerid, "Nie staæ ciê! U tego dilera %d gram narkotyku kosztuje %d$.", weight, price);
        return 1;
    }

    // functionality
    ZabierzKase(playerid, price);
    DajKase(dealerid, price - DRUG_SELL_PRICE);

    PlayerInfo[playerid][pDrugs] += weight;

    // messages
    Log(payLog, INFO, "%s kupi³ od dilera %s narkotyki w iloœci %d gram za %d$", 
        GetPlayerLogName(playerid), GetPlayerLogName(dealerid), weight, price);

    MruMessageGoodInfoF(dealerid, "%s kupi³ od ciebie %d gram narkotyku za %d$.", GetNick(playerid), weight, price);
    MruMessageGoodInfoF(playerid, "Kupi³eœ od dilera %s %d gram narkotyku za %d$.", GetNick(dealerid), weight, price);
    ChatMe(playerid, sprintf("odbiera zupe³nie niepodejrzanego loda od lodziarza %s", GetNick(dealerid)));

    // zdemaskowanie
    new redisKey[64];
    format(redisKey, sizeof(redisKey), "player:%d:deconspired", PlayerInfo[playerid][pUID]);
    if(IsAPolicja(playerid) && OnDuty[playerid] && SecretAgent[playerid] > 0 && spamwl[dealerid] == 0)
    {
        PoziomPoszukiwania[dealerid] += 4;
        PlayCrimeReportForPlayer(playerid, dealerid, 14);
        SetPlayerCriminal(dealerid, playerid, "sprzeda¿ narkotyków");
        SetPlayerWantedLevel(dealerid, PoziomPoszukiwania[dealerid]);

        PursuitMode(playerid, dealerid);

        if(RedisGetInt(redisKey))
        {
            new reward = 75_000;
            DajKase(playerid, reward);
            Log(payLog, INFO, "%s z³apa³ dilera %s na gor¹cym uczynku i dosta³ %d$", GetPlayerLogName(playerid), GetPlayerLogName(dealerid), reward);
            MruMessageGoodInfoF(playerid, "Nakry³eœ %s na sprzeda¿y narkotyków! Dostajesz %d$ za wykonywanie swojej pracy.", GetNick(dealerid), reward);
        }
        else
        {
            MruMessageGoodInfoF(playerid, "Nakry³eœ %s na sprzeda¿y narkotyków! Ju¿ raz nakry³eœ tego gracza w przeci¹gu 24h wiêc nie dostajesz bonusu.", GetNick(dealerid));
        }
        MruMessageBadInfoF(dealerid, "Tajny agent %s nakry³ Ciê na sprzeda¿y narkotyków! Masz teraz %d Poziom Poszukiwania.", GetNick(playerid), PoziomPoszukiwania[dealerid]);

        SetTimerEx("spamujewl",300_000,0,"d",dealerid); //5min anty-wl
        spamwl[dealerid] = 1;

        Redis_SetInt(RedisClient, redisKey, 1);
        RedisExpire(redisKey, 24 * 3600);
    }
    else
    {
        IncreasePlayerJobSkill(dealerid, JOB_DRUG_DEALER, 1);
    }
    return 1;
}

//end