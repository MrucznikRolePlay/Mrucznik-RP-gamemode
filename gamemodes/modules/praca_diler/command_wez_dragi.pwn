

diler_wez_dragi(playerid, weight)
{
    if(GetPlayerJob(playerid) != JOB_DRUG_DEALER)
    {
        MruMessageFail(playerid, "Nie jesteœ dilerem narkotyków.");
        return 1;
    }

    if(weight <= 0)
    {
        MruMessageFail(playerid, "U¿yj /wez dragi [ilosc]");
        return 1;
    }

    new skill = GetPlayerJobSkill(playerid, JOB_DRUG_DEALER);
    new currentDrugs = PlayerInfo[playerid][pDrugs];
    new maxDrugs = 6 * skill;

    if(PlayerInfo[playerid][pDrugs] >= maxDrugs)
    {
        MruMessageFailF(playerid, "Jako diler narkotyków skillu %d masz ju¿ przy sobie maksymaln¹ wagê narkotyków (%dg).", skill, maxDrugs);
        return 1;
    }

    if(!IsPlayerInDrugsTakingPoint(playerid))
    {
        MruMessageFail(playerid, "Nie jesteœ w miejscu, gdzie mo¿na braæ narkotyki!");
        return 1;
    }

    if(currentDrugs + weight > maxDrugs)
    {
        weight = maxDrugs - currentDrugs;
        MruMessageTipF(playerid, "Jako diler narkotyków skillu %d, mo¿esz mieæ przy sobie tylko %d narkotyków, wiêc bierzesz %d gram.", skill, maxDrugs, weight);
        // no return on purpose
    }
    
    new price = weight * DRUG_SELL_PRICE;
    if(kaska[playerid] < price)
    {
        MruMessageFailF(playerid, "Potrzebujesz %d$ aby kupiæ tak¹ iloœæ narkotyków!", price);
        return 1;
    }

    MruMessageGoodInfoF(playerid, "Kupi³eœ %d gram dragów za $%d.", weight, price);
    ZabierzKase(playerid, price);
    PlayerInfo[playerid][pDrugs] += weight;
    return 1;
}