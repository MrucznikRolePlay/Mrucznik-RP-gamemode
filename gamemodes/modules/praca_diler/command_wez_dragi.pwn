

diler_wez_dragi(playerid, weight)
{
    if(GetPlayerJob(playerid) != JOB_DRUG_DEALER)
    {
        MruMessageFail(playerid, "Nie jesteœ dilerem narkotyków.");
        return 1;
    }

    new string[MAX_MESSAGE_LENGTH];
    if(weight <= 0)
    {
        sendTipMessage(playerid, "U¿yj /wez dragi [ilosc]");
        return 1;
    }

    new skill = GetPlayerJobSkill(playerid, JOB_DRUG_DEALER);
    new currentDrugs = PlayerInfo[playerid][pDrugs];
    new maxDrugs = 6 * skill;
    if(PlayerInfo[playerid][pDrugs] >= maxDrugs)
    {
        MruMessageFailF(playerid, "Jako diler narkotyków skillu %d, mo¿esz mieæ przy sobie tylko %d narkotyków, a masz %d.", skill, maxDrugs, currentDrugs);
        return 1;
    }

    if()
    {
        MruMessageFailF(playerid, "Jako diler narkotyków skillu %d, mo¿esz mieæ przy sobie tylko %d narkotyków, wiêc bierzesz %d gram.");
    }

    new tel;
    new price;
    new level = ;

    new priceMultiplier
    switch()
    {
        case 1:
            priceMultiplier = 
        case 2:
        case 3:
        case 4:
        case 5:
    }

    if ( && PlayerToPoint(5.0, playerid, 322.6724,1117.9385,1083.8828) || PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, -1022.34930420,-2158.46484375,33.91813278))
    {
        price = weight * tel;
        if(kaska[playerid] > price)
        {
            format(string, sizeof(string), "* Kupi³eœ %d gram dragów za $%d.", weight, price);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            ZabierzKase(playerid, price);
            PlayerInfo[playerid][pDrugs] += weight;
        }
        else
        {
            sendTipMessageEx(playerid, COLOR_GREY, "Nie mo¿esz kupiæ dragów !");
            return 1;
        }
    }
    else
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Nie jesteœ Dilerem Dragów albo nie jesteœ w melinie !");
        return 1;
    }
    return 1;
}