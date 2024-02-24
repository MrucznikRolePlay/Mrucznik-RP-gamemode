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

YCMD:sprzedajbron(playerid, params[], help)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];
    new giveplayer[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pJob] == 9)
        {
            if(GetPlayerOrg(playerid) == 21 || GetPlayerOrg(playerid) == 4 || GetPlayerOrg(playerid) == 23)
            {
                if(GetPlayerOrg(playerid) == 21 && PlayerInfo[playerid][pRank] < 4) //ammunation willowfield
                {
                    return SendClientMessage(playerid,COLOR_GREY,"* U¿ycie komendy wymaga rangi [3] w tej rodzinie."); //ammunation willowfield
                }
                else if(GetPlayerOrg(playerid) == 23) // Ammunation Los Santos (remiza)
                {
                    if(PlayerInfo[playerid][pRank] < 3) return SendClientMessage(playerid,COLOR_GREY,"* U¿ycie komendy wymaga rangi [3] w tej rodzinie.");
                    if(!IsAtAmmunationLosSantos(playerid) && !IsNearSecuricar(playerid)) return SendClientMessage(playerid,COLOR_GREY,"* Broñ mo¿esz sprzedawaæ tylko w ammunation lub przy securicar.");
                }
                else if(GetPlayerOrg(playerid) == 22) //Ammunation Commerce
                {
                    if(PlayerInfo[playerid][pRank] < 3) return SendClientMessage(playerid, COLOR_GREY,"* U¿ycie komendy wymaga [3] w tej rodzinie.");
                } 
            }
            new umiejetnosc;
            new skillz;
            new x_weapon[16],weapon[MAX_PLAYERS],ammo[MAX_PLAYERS],price[MAX_PLAYERS];
            new giveplayerid;
            if( sscanf(params, "k<fix>s[16]", giveplayerid, x_weapon))
            {
                SendClientMessage(playerid, COLOR_GRAD1, "U¿yj: /sprzedajbron [ID gracza] [nazwa broni]");
                SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI - GANG]----");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 1 Skill: pistolety(75)");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 2 Skill: sdpistol(125) eagle(200)");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 4 Skill: UZI(875)");
                SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI - MAFIA / SKLEP Z BRONI¥]----");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 1 Skill: pistolety(75) shotgun(125)");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 2 Skill: sdpistol(125) eagle(200) mp5(225)");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 3 Skill: ak47(325) m4(350) rifle(325)");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 4 Skill: spas12(1500) UZI(875) sniper(1000) pila(1000)");
                SendClientMessage(playerid, COLOR_GREY, "Bronie 5 Skill: c4(2500) ogniomiotacz(10000)");
                return 1;
            }

            if (zmatsowany[playerid] == 1)
            {
                SendClientMessage(playerid,COLOR_GREY,"   Poczekaj 10 sekund zanim sprzedasz temu graczowi nastêpn¹ broñ !");
                return 1;
            }
            if (IsPlayerConnected(giveplayerid))
            {
                if(PlayerInfo[playerid][pConnectTime] >= 5)
                {
                    if(PlayerInfo[giveplayerid][pGunLic] == 1 || IsAPrzestepca(giveplayerid) || IsAPolicja(giveplayerid) || IsABOR(giveplayerid) || strcmp(x_weapon,"pistolety",true) == 0)
                    {
                        if(IsPlayerInAnyVehicle(giveplayerid)) return SendClientMessage(playerid, COLOR_GREY, "Klient nie mo¿e byæ w pojeŸdzie!");
                        if(giveplayerid != INVALID_PLAYER_ID)
                        {
                            if(!strlen(x_weapon))
                            {
                                SendClientMessage(playerid, COLOR_GREEN, "________________________________________________");
                                SendClientMessage(playerid, COLOR_WHITE, "*** Sprzedaj broñ ***");
                                SendClientMessage(playerid, COLOR_GRAD1, "U¿yj: /sprzedajbron [ID gracza] [nazwa broni]");
                                SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI - GANG]----");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 1 Skill: pistolety(75)");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 2 Skill: sdpistol(125) eagle(200)");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 4 Skill: UZI(875)");
                                SendClientMessage(playerid, COLOR_GREY, "----[DILER BRONI - MAFIA / SKLEP Z BRONI¥]----");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 1 Skill: pistolety(75) shotgun(125)");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 2 Skill: sdpistol(125) eagle(200) mp5(225)");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 3 Skill: ak47(325) m4(350) rifle(325)");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 4 Skill: spas12(1500) UZI(875) sniper(1000) pila(1000)");
                                SendClientMessage(playerid, COLOR_GREY, "Bronie 5 Skill: c4(2500) ogniomiotacz(10000)");
                                return 1;
                            }
                        }
                        if(PlayerInfo[playerid][pGunSkill] < 50)
                        {
                            skillz = 1;
                        }
                        else if(PlayerInfo[playerid][pGunSkill] >= 50 && PlayerInfo[playerid][pGunSkill] <= 99)
                        {
                            skillz = 2;
                        }
                        else if(PlayerInfo[playerid][pGunSkill] >= 100 && PlayerInfo[playerid][pGunSkill] <= 199)
                        {
                            skillz = 3;
                        }
                        else if(PlayerInfo[playerid][pGunSkill] >= 200 && PlayerInfo[playerid][pGunSkill] <= 399)
                        {
                            skillz = 4;
                        }
                        else if(PlayerInfo[playerid][pGunSkill] >= 400)
                        {
                            skillz = 5;
                        }
                        new slot;
                        if(strcmp(x_weapon,"katana",true) == 0)//
                        {
                            if(PlayerInfo[playerid][pMats] > 99 && IsASklepZBronia(playerid))
                            {
                                weapon[playerid] = 8;
                                price[playerid] = 100;
                                ammo[playerid] = 1;
                                umiejetnosc = 1;
                                slot = 2;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Masz za ma³o materia³ów na tê broñ lub nie jesteœ pracownikiem sklepu z broni¹!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"sdpistol",true) == 0)//
                        {
                            if(PlayerInfo[playerid][pMats] > 124)
                            {
                                weapon[playerid] = 23;
                                price[playerid] = 125;
                                ammo[playerid] = 114;
                                umiejetnosc = 2;
                                slot = 3;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"pila",true) == 0)//
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 999 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 9;
                                price[playerid] = 1000;
                                ammo[playerid] = 1;
                                umiejetnosc = 4;
                                slot = 2;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"pistolety",true) == 0)//
                        {
                            if(PlayerInfo[playerid][pMats] > 74)
                            {
                                weapon[playerid] = 22;
                                price[playerid] = 75;
                                ammo[playerid] = 200;
                                umiejetnosc = 1;
                                slot = 3;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"eagle",true) == 0)//
                        {
                            if(PlayerInfo[playerid][pMats] > 199)
                            {
                                weapon[playerid] = 24;
                                price[playerid] = 200;
                                ammo[playerid] = 107;
                                umiejetnosc = 2;
                                slot = 3;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"mp5",true) == 0)//
                        {
                            if(PlayerInfo[playerid][pMats] > 224 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 29;
                                price[playerid] = 225;
                                ammo[playerid] = 700;
                                umiejetnosc = 2;
                                slot = 5;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"uzi",true) == 0)//
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 874 && (IsAGang(playerid) || IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 28;
                                price[playerid] = 875;
                                ammo[playerid] = 750;
                                umiejetnosc = 4;
                                slot = 5;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do gangu/mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"shotgun",true) == 0)//
                        {
                            if(PlayerInfo[playerid][pMats] > 124 && (IsASklepZBronia(playerid) || IsAMafia(playerid)))
                            {
                                weapon[playerid] = 25;
                                price[playerid] = 125;
                                ammo[playerid] = 50;
                                umiejetnosc = 1;
                                slot = 4;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Masz za ma³o materia³ów na tê broñ lub nie nale¿ysz do mafii/nie jesteœ pracownikiem sklepu z broni¹!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"spas12",true) == 0)//
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 1499 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 27;
                                price[playerid] = 1500;
                                ammo[playerid] = 57;
                                umiejetnosc = 4;
                                slot = 4;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"ak47",true) == 0)
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 324 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 30;
                                price[playerid] = 325;
                                ammo[playerid] = 550;
                                umiejetnosc = 3;
                                slot = 6;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"m4",true) == 0)
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 349 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 31;
                                price[playerid] = 350;
                                ammo[playerid] = 550;
                                umiejetnosc = 3;
                                slot = 6;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"rifle",true) == 0)
                        {
                            if(PlayerInfo[playerid][pMats] > 324 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 33;
                                price[playerid] = 325;
                                ammo[playerid] = 51;
                                umiejetnosc = 3;
                                slot = 7;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"sniper",true) == 0)
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 999 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 34;
                                price[playerid] = 1000;
                                ammo[playerid] = 51;
                                umiejetnosc = 4;
                                slot = 7;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"c4",true) == 0)
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 2499 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 39;
                                price[playerid] = 2500;
                                ammo[playerid] = 10;
                                umiejetnosc = 5;
                                slot = 9;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else if(strcmp(x_weapon,"ogniomiotacz",true) == 0)
                        {
                            if((GetPlayerOrg(playerid) == 23 || GetPlayerOrg(playerid) == 22) && PlayerInfo[playerid][pRank] < 4)
                            {
                                SendClientMessage(playerid,COLOR_GREY,"    Broñ ciê¿k¹ mo¿esz sprzedawaæ od [4]!");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMats] > 9999 && (IsAMafia(playerid) || IsASklepZBronia(playerid)))
                            {
                                weapon[playerid] = 37;
                                price[playerid] = 10000;
                                ammo[playerid] = 200;
                                umiejetnosc = 5;
                                slot = 8;
                            }
                            else
                            {
                                SendClientMessage(playerid,COLOR_GREY,"   Nie masz wystarczaj¹cej iloœci materia³ów na tê broñ lub nie nale¿ysz do mafii!");
                                return 1;
                            }
                        }
                        else
                        {
                            SendClientMessage(playerid,COLOR_GREY,"   Z³a nazwa broni!");
                            return 1;
                        }
                        if (ProxDetectorS(5.0, playerid, giveplayerid))
                        {
                            if(PlayerInfo[giveplayerid][pConnectTime] < 5)
                            {
                                SendClientMessage(playerid, COLOR_GRAD1, "* Broñ mog¹ posiadaæ tylko gracze z przegranymi minimum 5. godzinami online !");
                                SendClientMessage(giveplayerid, COLOR_GRAD1, "* Broñ mog¹ posiadaæ tylko gracze z przegranymi minimum 5. godzinami online !");
                                return 1;
                            }
                            if(PlayerInfo[playerid][pMiserPerk] > 0)
                            {
                                new skill = 2 * PlayerInfo[playerid][pMiserPerk];
                                new mats = price[playerid] / 100;
                                price[playerid] -= (mats)*(skill);
                            }
                            if(umiejetnosc <= skillz)
                            {
                                if(umiejetnosc >= 2 && PlayerInfo[giveplayerid][pGunLic] == 0)
                                {
                                    SendClientMessage(playerid, COLOR_RED, "Ten gracz nie posiada licencji na broñ, mo¿esz sprzedaæ mu tylko bronie dla 1 skillu !");
                                    return 1;
                                }
                                new cenacraftu = 0;
                                if(IsASklepZBronia(playerid)) {
                                    new gsid = GetPlayerOrg(playerid)-21;
                                    cenacraftu = GS_BronCena[gsid][weapon[playerid]];
                                    if(cenacraftu > 0) {
                                        new str[128];
                                        if(kaska[playerid] < cenacraftu) {
                                            format(str, 128, "Stworzenie tej broni kosztuje $%d. Nie staæ cie na to!", cenacraftu);
                                            SendClientMessage(playerid, COLOR_GRAD1, str);
                                            return 1;
                                        }
                                        ZabierzKase(playerid, cenacraftu);
                                        SejfR_Add(gsid+21, cenacraftu);
                                        format(str, 128, "Pobrano od ciebie $%d za stworzenie broni. Kwota trafi³a do sejfu organizacji", cenacraftu);
                                        SendClientMessage(playerid, COLOR_BLUE, str);
                                    }
                                }
                                if(weapon[playerid] == 39)
                                {
                                    GivePlayerWeapon(giveplayerid, 40, 1);
                                    PlayerInfo[giveplayerid][pGun8] = 39;
                                    PlayerInfo[giveplayerid][pAmmo8] = 10;
                                    PlayerInfo[giveplayerid][pGun12] = 40;
                                    PlayerInfo[giveplayerid][pAmmo12] = 1;
                                }
                                if(weapon[playerid] == 37)
                                {
                                    PlayerInfo[giveplayerid][pGun7] = 37;
                                    PlayerInfo[giveplayerid][pAmmo7] = 150;
                                }
                                if(weapon[playerid] == 34)
                                {
                                    PlayerInfo[giveplayerid][pGun6] = 34;
                                    PlayerInfo[giveplayerid][pAmmo6] = 51;
                                }
                                if(weapon[playerid] == 33)
                                {
                                    PlayerInfo[giveplayerid][pGun6] = 33;
                                    PlayerInfo[giveplayerid][pAmmo6] = 51;
                                }
                                if(weapon[playerid] == 31)
                                {
                                    PlayerInfo[giveplayerid][pGun5] = 31;
                                    PlayerInfo[giveplayerid][pAmmo5] = 550;
                                }
                                if(weapon[playerid] == 30)
                                {
                                    PlayerInfo[giveplayerid][pGun5] = 30;
                                    PlayerInfo[giveplayerid][pAmmo5] = 550;
                                }
                                if(weapon[playerid] == 27)
                                {
                                    PlayerInfo[giveplayerid][pGun3] = 27;
                                    PlayerInfo[giveplayerid][pAmmo3] = 57;
                                }
                                if(weapon[playerid] == 25)
                                {
                                    PlayerInfo[giveplayerid][pGun3] = 25;
                                    PlayerInfo[giveplayerid][pAmmo3] = 50;
                                }
                                if(weapon[playerid] == 28)
                                {
                                    PlayerInfo[giveplayerid][pGun4] = 28;
                                    PlayerInfo[giveplayerid][pAmmo4] = 750;
                                }
                                if(weapon[playerid] == 29)
                                {
                                    PlayerInfo[giveplayerid][pGun4] = 29;
                                    PlayerInfo[giveplayerid][pAmmo4] = 700;
                                }
                                if(weapon[playerid] == 24)
                                {
                                    PlayerInfo[giveplayerid][pGun2] = 24;
                                    PlayerInfo[giveplayerid][pAmmo2] = 107;
                                }
                                if(weapon[playerid] == 22)
                                {
                                    PlayerInfo[giveplayerid][pGun2] = 22;
                                    PlayerInfo[giveplayerid][pAmmo2] = 200;
                                }
                                if(weapon[playerid] == 9)
                                {
                                    PlayerInfo[giveplayerid][pGun1] = 9;
                                    PlayerInfo[giveplayerid][pAmmo1] = 1;
                                }
                                if(weapon[playerid] == 23)
                                {
                                    PlayerInfo[giveplayerid][pGun2] = 23;
                                    PlayerInfo[giveplayerid][pAmmo2] = 114;
                                }
                                if(weapon[playerid] == 8)
                                {
                                    PlayerInfo[giveplayerid][pGun1] = 8;
                                    PlayerInfo[giveplayerid][pAmmo1] = 1;
                                }
                                GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
                                GetPlayerName(playerid, sendername, sizeof(sendername));
                                new stringdiscord[128], frakcja[8];
                                switch(PlayerInfo[giveplayerid][pMember])
                                {
                                    case 1: format(frakcja, sizeof(frakcja), "LSPD");
                                    case 2: format(frakcja, sizeof(frakcja), "FBI");
                                    case 3: format(frakcja, sizeof(frakcja), "Armia");
                                    case 4: format(frakcja, sizeof(frakcja), "ERS");
                                    case 7: format(frakcja, sizeof(frakcja), "USSS");
                                    case 11: format(frakcja, sizeof(frakcja), "DMV");
                                    default: format(frakcja, sizeof(frakcja), "CYWIL");
                                }
                                format(stringdiscord, sizeof(stringdiscord), " Diler %s da³ graczowi %s *[%s]* %s. Do sejfu trafi³o $%i", sendername, giveplayer, frakcja, x_weapon, cenacraftu);
                                if(GetPlayerOrg(playerid) == 21) SendDiscordMessage(DISCORD_LOG_GSWF, stringdiscord);//wf
                                else if(GetPlayerOrg(playerid) == 22) SendDiscordMessage(DISCORD_LOG_GSCM, stringdiscord);//cm
                                else if(GetPlayerOrg(playerid) == 23) SendDiscordMessage(DISCORD_LOG_GSLS, stringdiscord);//ls
                                format(string, sizeof(string), "   Da³eœ %s, %s z %d nabojami, z %d materia³ów.", giveplayer,x_weapon, ammo[playerid], price[playerid]);
                                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                                SendClientMessage(playerid, COLOR_GRAD1, string);
                                format(string, sizeof(string), "   Odebra³eœ %s z %d nabojami od %s.", x_weapon, ammo[playerid], sendername);
                                SendClientMessage(giveplayerid, COLOR_GRAD1, string);
                                PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
                                format(string, sizeof(string), "* %s stworzy³ broñ z materia³ów i da³ j¹ %s.", sendername ,giveplayer);
                                ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                GivePlayerWeapon(giveplayerid,weapon[playerid],ammo[playerid]);
								Log(payLog, INFO, "Gracz %s sprzeda³ graczowi %s broñ %s", GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), GetWeaponLogName(weapon[playerid], ammo[playerid]));
                                PlayerInfo[playerid][pMats] -= price[playerid];
                                new weapons[13][2];
                                for (new i = 0; i <= 12; i++)
                                {
                                    GetPlayerWeaponData(giveplayerid, i, weapons[i][0], weapons[i][1]);
                                }
                                if(IsAMafia(playerid)) {
                                    switch(slot) {
                                        case 2: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal2] = 0;
                                            //}
                                        }
                                        case 3: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal3] = 0;
                                            //}
                                        }
                                        case 5: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal5] = 0;
                                            //}
                                        }
                                        case 4: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal4] = 0;
                                            //}
                                        }
                                        case 6: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal6] = 0;
                                            //}
                                        }
                                        case 7: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal7] = 0;
                                            //}
                                        }
                                        case 9: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal9] = 0;
                                            //}
                                        }
                                        case 8: {
                                            //if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal8] = 0;
                                            //}
                                        }
                                    }
                                } else {
                                    switch(slot) {
                                        case 2: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal2] = 1;
                                            }
                                        }
                                        case 3: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal3] = 1;
                                            }
                                        }
                                        case 5: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal5] = 1;
                                            }
                                        }
                                        case 4: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal4] = 1;
                                            }
                                        }
                                        case 6: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal6] = 1;
                                            }
                                        }
                                        case 7: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal7] = 1;
                                            }
                                        }
                                        case 9: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal9] = 1;
                                            }
                                        }
                                        case 8: {
                                            if(weapons[slot-1][0] == 0) {
                                                playerWeapons[giveplayerid][weaponLegal8] = 1;
                                            }
                                        }
                                    }
                                }
                                //saveLegale(giveplayerid);
                                if(playerid != giveplayerid)
                                {
                                    if(strcmp(x_weapon,"katana",true) == 0)
                                    {
                                        SetTimerEx("spamujebronia",10000,0,"d",playerid);
                                        zmatsowany[playerid] = 1;
                                    }
                                    else
                                    {
                                        SendClientMessage(playerid, COLOR_GRAD1, "Skill + 1 !");
                                        PlayerInfo[playerid][pGunSkill] ++;
                                        SetTimerEx("spamujebronia",10000,0,"d",playerid);
                                        zmatsowany[playerid] = 1;
                                    }
                                }
                            }
                            else
                            {
                                format(string, sizeof(string), "   Ta broñ potrzebuje %d skillu, ty masz tylko %d", umiejetnosc, skillz);
                                SendClientMessage(playerid, COLOR_GRAD1, string);
                            }
                        }
                        else
                        {
                            SendClientMessage(playerid, COLOR_GRAD1, "   Ten gracz jest za daleko !");
                            return 1;
                        }
                    }
                    else
                    {
                        SendClientMessage(playerid, COLOR_GRAD1, "   Nie mo¿esz sprzedaæ broni graczowi który nie posiada na ni¹ licencji !");
                        return 1;
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_GRAD1, "* Broñ mog¹ posiadaæ tylko gracze z przegranymi minimum 5. godzinami online !");
                    SendClientMessage(giveplayerid, COLOR_GRAD1, "* Broñ mog¹ posiadaæ tylko gracze z przegranymi minimum 5. godzinami online !");
                    return 1;
                }
            }
            else
            {
                format(string, sizeof(string), "   Gracz o ID %d nie istnieje.", giveplayerid);
                SendClientMessage(playerid, COLOR_GRAD1, string);
            }
        }
        else
        {
            SendClientMessage(playerid,COLOR_GREY,"   Nie jesteœ dilerem broni !");
            return 1;
        }
    }
    return 1;
}
