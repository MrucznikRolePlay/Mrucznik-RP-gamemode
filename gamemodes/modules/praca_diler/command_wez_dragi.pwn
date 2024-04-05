

diler_wez_dragi(playerid, weight)
{
    if(weight == 0)
    {
        sendTipMessage(playerid, "U¿yj /wez dragi [ilosc]");
    }
    if(PlayerInfo[playerid][pDrugs] > 15)
    {
        format(string, sizeof(string), "Posiadasz %d gramów przy sobie, najpierw je sprzedaj !", PlayerInfo[playerid][pDrugs]);
        sendTipMessageEx(playerid, COLOR_GREY, string);
        return 1;
    }
    new tel;
    new price;
    new level = PlayerInfo[playerid][pDrugsSkill];

    if(level >= 0 && level <= 50)
    { tel = 200; if(weight < 1 || weight > 6) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 6g przy tym poziomie Dilera Dragów!"); return 1; } }
    else if(level >= 51 && level <= 100)
    { tel = 150; if(weight < 1 || weight > 12) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 12g przy tym poziomie Dilera Dragów!"); return 1; } }
    else if(level >= 101 && level <= 200)
    { tel = 100; if(weight < 1 || weight > 20) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 20g przy tym poziomie Dilera Dragów!"); return 1; } }
    else if(level >= 201 && level <= 400)
    { tel = 50; if(weight < 1 || weight > 30) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 30g przy tym poziomie Dilera Dragów!"); return 1; } }
    else if(level >= 401)
    { tel = 10; if(weight < 1 || weight > 99) { sendTipMessageEx(playerid, COLOR_GREY, "Mo¿esz braæ od 1 do 99g przy tym poziomie Dilera Dragów!"); return 1; } }
    if (PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, 322.6724,1117.9385,1083.8828) || PlayerInfo[playerid][pJob] == 4 && PlayerToPoint(5.0, playerid, -1022.34930420,-2158.46484375,33.91813278))
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
}