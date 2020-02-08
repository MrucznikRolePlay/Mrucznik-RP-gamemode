//-----------------------------------------------<< Defines >>-----------------------------------------------//
//                                               businessDialogs                                             //
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
// Autor: Simeone
// Data utworzenia: 04.02.2020

//

//------------------<[ Dialogi: ]>-------------------
business_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_BIZ_BUY)
    {
        if(!response)
        {
            sendTipMessage(playerid, "Zrezygnowa³eœ z zakupu biznesu!"); 
            return 1;
        }
        if(PlayerInfo[playerid][pBusinessOwner] != INVALID_BUSINESSID)
        {
            sendTipMessage(playerid, "Najpierw zrezygnuj z obecnego biznesu!"); 
            return 1;
        }
        if(response)
        {
            new valueID = strval(inputtext); 
            if(valueID > MAX_BIZ || valueID <= 0)
            { 
                sendTipMessage(playerid, "Nieprawid³owe ID biznesu!"); 
                return 1;
            }
            if(!BizExist(valueID))
            {
                sendErrorMessage(playerid, "Taki biznes nie istnieje!"); 
                return 1;
            }
            SetPVarInt(playerid, "BuyBiz_ID", valueID);
            ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY2, DIALOG_STYLE_LIST, "Wybierz Typ", "Us³ugowy\nPrzemys³owy", "Dalej", "Anuluj");
        }
    }
    else if(dialogid == DIALOG_BIZ_BUY2)
    {
        if(!response) 
        {
            sendTipMessage(playerid, "Przerwano kupno biznesu!"); 
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
            return 1;
        }
        if(response)
        {
            switch(listitem)
            {
                case 0: 
                {
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY3, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz podtyp", 
                    "Typ\tDodatkowa Cena\n\
                    Sklep 24-7\t500.000$\n\
                    Sklep z ubraniami\t750.000$\n\
                    Kasyno\t1.000.000$\n\
                    Restauracja\t1.000.000$", "Dalej", "Anuluj");
                }
                case 1:
                {
                    sendTipMessage(playerid, "Ten typ biznesów zostanie odblokowany ju¿ nied³ugo!"); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_BUY3)
    {
        if(!response)
        {
            sendErrorMessage(playerid, "Zrezygnowa³eœ z zakupu biznesu!"); 
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
            return 1;
        }
        if(response)
        {
            new string[124];
            new pBizID = GetPVarInt(playerid, "BuyBiz_ID"); 
            switch(listitem)
            {
                case 0: 
                {

                    format(string, sizeof(string), "PotwierdŸ zakup biznesu %s\nKoszt biznesu to: %d$\nLokalizacja: %s",
                    pBizID, 
                    mBiz[pBizID][b_cost]+COST_SHOP24, 
                    mBiz[pBizID][b_Location]); 
                    SetPVarInt(playerid, "BuyBizChoice", 1); 
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUYBOX, DIALOG_STYLE_MSGBOX, nameToDialogs, string, "Kupujê", "Rezygnujê"); 
                }
                case 1:
                {

                }
                case 2:
                {

                }
                case 3:
                {

                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_BUYBOX)
    {
        if(response)
        {
            new pBizID = GetPVarInt(playerid, "BuyBiz_ID");
            new bChoice = GetPVarInt(playerid, "BuyBizChoice"); 
            if(bChoice == 1)//Zakup sklepu 24-7
            {
                if(mBiz[pBizID][b_ownerUID] == 0)
                {
                    if(kaska[playerid] >= mBiz[pBizID][b_cost]+COST_SHOP24)
                    {
                        ZabierzKase(playerid, mBiz[pBizID][b_cost]+COST_SHOP24);
                        GiveBizToPlayer(playerid, pBizID, BTYPE_SERVICES, BTYPE2_SHOP); 
                        Log(businessLog, INFO, "%s kupil biznes %s jako sklep 24-7 za %d", GetPlayerLogName(playerid), GetBusinessLogName(pBizID), (mBiz[pBizID][b_cost]+COST_SHOP24));
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci gotówki!"); 
                        return 1;
                    }
                }
                else{ 
                    sendErrorMessage(playerid, "Ten biznes ma ju¿ swojego w³aœciciela!"); 
                    return 1;
                }
            }
        }
        else
        {
            SetPVarInt(playerid, "BuyBiz_ID", INVALID_BUSINESSID); 
        }
    }
    else if(dialogid == BIZ_DIALOG_INFO)
    {
        if(response)
        {
            SetTimerEx("OdczekajDialogBiz", 5000, false, "i", playerid);
            SetPVarInt(playerid, "MozeUzycKomendyBiz", 1);
        }
    }
    else if(dialogid == DIALOG_BIZ_ADMINEDIT)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0://Przenieœ wejœcie
                {
                    //new choiceTwo = GetPVarInt(playerid, "bizChoice");
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_PRZENIES); 
                    sendTipMessage(playerid, "Stañ w miejscu, w którym ma zostaæ przeniesiony biznes i wpisz ponownie komendê.");
                    sendErrorMessage(playerid, "Pamiêtaj, ¿e wpisanie komendy zmieni automatycznie pozycje!");  
                    sendTipMessage(playerid, "Jeœli chcesz anulowaæ przenoszenie biznesu wpisz /bizback");
                }
                case 1://Dodaj wyjœcie
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_DODAJ); 
                    sendTipMessage(playerid, "Stañ w miejscu, w którym ma powstaæ wyjœcie (interior).");
                    sendTipMessage(playerid, "Mo¿esz u¿yæ /setvw i /setint do ustawienia INT i VW (pLocal tak¿e)"); 
                    sendErrorMessage(playerid, "Pamiêtaj, ¿e wpisanie komendy zmieni automatycznie pozycje!");  
                    sendTipMessage(playerid, "Jeœli chcesz anulowaæ przenoszenie biznesu wpisz /bizback");
                }
                case 2://Usuñ biznes
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_USUN_BIZ); 
                    sendTipMessage(playerid, "PotwierdŸ usuniêcie biznesu wpisuj¹c ponownie komendê!"); 
                    sendTipMessage(playerid, "Jeœli chcesz anulowaæ usuwanie biznesu wpisz /bizback");
                }
                case 3://Usuñ w³aœciciela
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_USUN_WLAS); 
                    sendTipMessage(playerid, "PotwierdŸ usuniêcie w³aœciciela biznesu wpisuj¹c ponownie komendê!");
                    sendErrorMessage(playerid, "Pamiêtaj, ¿e wpisanie komendy usunie automatycznie w³aœciciela!");  
                    sendTipMessage(playerid, "Jeœli chcesz anulowaæ usuwanie w³aœciciela biznesu wpisz /bizback");
                }
                case 4://Wyzeruj pieni¹dze biznesu
                {
                    SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_WYZERUJ_KASE); 
                    sendTipMessage(playerid, "PotwierdŸ wyzerowanie gotówki zebraniej w sejfie biznesu wpisuj¹c komendê ponownie!");
                    sendErrorMessage(playerid, "Pamiêtaj, ¿e wpisanie komendy usunie automatycznie gotówkê!");  
                    sendTipMessage(playerid, "Jeœli chcesz anulowaæ usuwanie gotówki biznesu wpisz /bizback");   
                }
                case 5://Zmieñ cenê biznesu
                {
                    sendTipMessage(playerid, "Ta opcja pojawi siê ju¿ nied³ugo!"); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER)
    {
        if(!response)
        {
            sendTipMessage(playerid, "Wyszed³eœ z panelu w³aœciciela biznesu!"); 
            return 1;
        }
        else
        {
            switch(listitem)
            {
                case 0: //Nazwa biz, zwrot
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_MAIN); 
                }
                case 1:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_WORKERS); 
                }
                case 2:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
                }
                case 3:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_DOORS);
                }
                case 4:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_ADDS); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER2)//DIALOG WORKERS
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN); 
            return 1;
        }
        else 
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_WORKERS);
                }
                case 1:
                {
                    sendTipMessage(playerid, "Ta opcja pojawi siê ju¿ nied³ugo!");
                }
                case 2:
                {
                    sendTipMessage(playerid, "Ta opcja pojawi siê ju¿ nied³ugo!"); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER3)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
            return 1;
        }
        else 
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
                }
                case 1:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF);
                }
                case 2:
                {//wp³acanie
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_WPLAC, DIALOG_STYLE_INPUT, nameToDialogs, 
                    "Wpisz poni¿ej sumê jak¹ chcesz wp³aciæ\nWskazówka - mo¿esz u¿ywaæ mno¿nika k (np. 10k)", "Wp³aæ", "Zrezygnuj");  
                }
                case 3://wyp³acanie
                {
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_WYPLAC, DIALOG_STYLE_INPUT, nameToDialogs, 
                    "Wpisz poni¿ej sumê jak¹ chcesz wyp³aciæ\nWskazówka - mo¿esz u¿ywaæ mno¿nika k (np. 10k)", "Wyp³aæ", "Zrezygnuj");
                }
                case 4:
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_SEJF);
                }
                case 5:
                {//Wyp³acanie 
                    PlayerRunWithMoney(playerid); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_BIZ_WPLAC)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
            return 1;
        }
        else 
        {
            new value = FunkcjaK(inputtext); 
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            new string[124];
            if(mBiz[bIDE][b_moneyPocket]+value > GetPocketMaxSpace(bIDE))
            {
                sendErrorMessage(playerid, "Nie mo¿esz wp³aciæ takiej iloœci gotówki!");
                format(string, sizeof(string), "Twój sejf zmieœci maksymalnie: $%d", GetPocketMaxSpace(bIDE));
                sendTipMessage(playerid, string); 
                return 1;
            }
            if(kaska[playerid] < value)
            {
                sendErrorMessage(playerid, "Nie masz takiej iloœci gotówki!"); 
                return 1;
            }
            Log(businessCashLog, INFO, "Gracz %s wplacil do sejfu %s kwote %d stary stan %d nowy stan %d",
            GetPlayerLogName(playerid),
            GetBusinessLogName(bIDE),
            value,
            mBiz[bIDE][b_moneyPocket],
            (mBiz[bIDE][b_moneyPocket]+value));
            format(string, sizeof(string), "Wp³aci³eœ do g³ównego sejfu biznesu $%d, nowy stan $%d", value, mBiz[bIDE][b_moneyPocket]+value); 
            mBiz[bIDE][b_moneyPocket] = mBiz[bIDE][b_moneyPocket]+value; 
            sendTipMessageEx(playerid, COLOR_GREEN, string);
            ZabierzKase(playerid, value); 
            SaveBiz(bIDE); 
        }
    }
    else if(dialogid == DIALOG_BIZ_WYPLAC)
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_SEJF); 
            return 1;
        }
        else 
        {
            new value = FunkcjaK(inputtext); 
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            new string[124];
            if(mBiz[bIDE][b_moneyPocket] < value)
            {
                sendErrorMessage(playerid, "Twój biznes nie posiada takiej sumy!"); 
                return 1;
            }
            Log(businessCashLog, INFO, "Gracz %s wyplacil z sejfu %s kwote %d stary stan %d nowy stan %d",
            GetPlayerLogName(playerid),
            GetBusinessLogName(bIDE),
            value,
            mBiz[bIDE][b_moneyPocket],
            (mBiz[bIDE][b_moneyPocket]-value));
            format(string, sizeof(string), "Wyp³aci³eœz g³ównego sejfu biznesu $%d, nowy stan $%d", value, mBiz[bIDE][b_moneyPocket]-value); 
            mBiz[bIDE][b_moneyPocket] = mBiz[bIDE][b_moneyPocket]-value; 
            sendTipMessageEx(playerid, COLOR_GREEN, string);
            DajKase(playerid, value); 
            SaveBiz(bIDE); 
            
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER4)//DRZWI
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
            return 1;
        }
        else 
        {
            sendTipMessage(playerid, "Ta opcja zostanie dodana ju¿ wkrótce!"); 
        }
    }
    else if(dialogid == DIALOG_BIZ_OWNER5)//DODATKI
    {
        if(!response)
        {
            ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
            return 1;
        }
        else 
        {
            new string[256];
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            switch(listitem)
            {
                case 0: 
                {
                    ShowBusinessOwnerDialog(playerid, DIALOG_ADDS); 
                }
                case 1:
                {
                    format(string, sizeof(string), "WprowadŸ poni¿ej now¹ nazwê biznesu.\nPamiêtaj, ¿e maksymalna liczba znaków to 64!\nKoszt zmiany: $%d",
                    B_CENA_ZMIENAZWE);
                    ShowPlayerDialogEx(playerid, DIALOG_INPUT_NOWANAZWA, DIALOG_STYLE_INPUT, nameToDialogs, 
                    string, "Akceptuj", "Main");
                }
                case 2:
                {
                    format(string, sizeof(string), "WprowadŸ poni¿ej nowe MOTD biznesu\nPamiêtaj, ¿e maksymalna liczba znaków to 64!\nKoszt zmiany: $%d",
                    B_CENA_ZMIENMOTD);
                    ShowPlayerDialogEx(playerid, DIALOG_INPUT_NOWEMOTD, DIALOG_STYLE_INPUT, nameToDialogs, 
                    string, "Akceptuj", "Main");
                }
                case 3:
                {
                    sendTipMessage(playerid, "Ta opcja bêdzie dostêpna ju¿ niebawem!"); 
                }
                case 4:
                {
                    if(kaska[playerid] < B_CENA_SEJFG)
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci gotówki!"); 
                        return 1;
                    }
                    if(mBiz[bIDE][b_ulepszenie4]+1 > 10)
                    {
                        sendErrorMessage(playerid, "Ten biznes osi¹gn¹³ maksymaln¹ liczbê ulepszeñ - 10!");
                        format(string, sizeof(string), "Mo¿esz w nim zmieœciæ teraz $%d.", GetPocketMaxSpace(bIDE));
                        sendTipMessage(playerid, string);
                        return 1;
                    }
                    ZabierzKase(playerid, B_CENA_SEJFG); 
                    mBiz[bIDE][b_ulepszenie4]++; 
                    sendTipMessage(playerid, "Ulepszy³eœ sejf g³ówny w swoim biznesie!");
                    format(string, sizeof(string), "Aktualny poziom ulepszenia [%d], mo¿esz zmieœciæ w sejfie teraz $%d", mBiz[bIDE][b_ulepszenie4], GetPocketMaxSpace(bIDE));
                    sendTipMessage(playerid, string); 
                    Log(businessLog, INFO, "%s ulepszyl w biznesie %s sejf glowny - aktualny poziom %d", GetPlayerLogName(playerid), GetBusinessLogName(bIDE), mBiz[bIDE][b_ulepszenie4]);
                    SaveBiz(bIDE); 
                }
                case 5:
                {
                    if(kaska[playerid] < B_CENA_SEJFT)
                    {
                        sendErrorMessage(playerid, "Nie masz wystarczaj¹cej iloœci gotówki!"); 
                        return 1;
                    }
                    if(mBiz[bIDE][b_ulepszenie5]+1 > 10)
                    {
                        sendErrorMessage(playerid, "Ten biznes osi¹gn¹³ maksymaln¹ liczbê ulepszeñ - 10!");
                        format(string, sizeof(string), "Mo¿esz w sejfie tymczasowym zmieœciæ teraz $%d.", GetTempPocketMaxSpace(bIDE));
                        sendTipMessage(playerid, string);
                        return 1;
                    }
                    ZabierzKase(playerid, B_CENA_SEJFT); 
                    mBiz[bIDE][b_ulepszenie5]++; 
                    sendTipMessage(playerid, "Ulepszy³eœ sejf tymczasowy w swoim biznesie!");
                    format(string, sizeof(string), "Aktualny poziom ulepszenia [%d], mo¿esz zmieœciæ w sejfie teraz $%d", mBiz[bIDE][b_ulepszenie5], GetTempPocketMaxSpace(bIDE));
                    sendTipMessage(playerid, string); 
                    Log(businessLog, INFO, "%s ulepszyl w biznesie %s sejf tymczasowy - aktualny poziom %d", GetPlayerLogName(playerid), GetBusinessLogName(bIDE), mBiz[bIDE][b_ulepszenie5]);
                    SaveBiz(bIDE); 
                }
            }
        }
    }
    else if(dialogid == DIALOG_INPUT_NOWANAZWA)
    {
        if(!response)
        {
            return ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
        }
        else 
        {
            new string[256];
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            if(kaska[playerid] < B_CENA_ZMIENAZWE)
            {
                sendErrorMessage(playerid, "Nie posiadasz wystarczaj¹cej iloœci gotówki!"); 
                return 1;
            }
            if(strlen(inputtext) > 64)
            {
                sendErrorMessage(playerid, "Zbyt d³uga nazwa!"); 
                return 1;
            }
            if(CheckVulgarityString(inputtext) == 1)
            {
                sendErrorMessage(playerid, "Nazwa nie mo¿e byæ wulgarna!");
                return 1;
            }
            format(string, sizeof(string), "Zmieni³eœ nazwê biznesu %s na %s", mBiz[bIDE][b_Name], inputtext); 
            sendTipMessage(playerid, string); 
            Log(businessLog, INFO, "%s zmienil nazwe biznesu %s na %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE),inputtext);
            ZabierzKase(playerid, B_CENA_ZMIENAZWE); 
            mysql_real_escape_string(inputtext, mBiz[bIDE][b_Name]);
            SaveBiz(bIDE);  
        }
    }
    else if(dialogid == DIALOG_INPUT_NOWEMOTD)
    {
        if(!response)
        {
            return ShowBusinessOwnerDialog(playerid, DIALOG_MAIN);
        }
        else 
        {
            new string[256];
            new bIDE = PlayerInfo[playerid][pBusinessOwner];
            if(kaska[playerid] < B_CENA_ZMIENMOTD)
            {
                sendErrorMessage(playerid, "Nie posiadasz wystarczaj¹cej iloœci gotówki!"); 
                return 1;
            }
            if(strlen(inputtext) > 64)
            {
                sendErrorMessage(playerid, "Zbyt d³ugie MOTD!"); 
                return 1;
            }
            if(CheckVulgarityString(inputtext) == 1)
            {
                sendErrorMessage(playerid, "MOTD nie mo¿e byæ wulgarne!");
                return 1;
            }
            format(string, sizeof(string), "Zmieni³eœ MOTD biznesu %s na %s", mBiz[bIDE][b_Name], inputtext); 
            sendTipMessage(playerid, string); 
            Log(businessLog, INFO, "%s zmienil motd biznesu %s na %s", GetPlayerLogName(playerid), GetBusinessLogName(bIDE),inputtext);
            ZabierzKase(playerid, B_CENA_ZMIENMOTD); 
            mysql_real_escape_string(inputtext, mBiz[bIDE][b_motd]); 
            SaveBiz(bIDE); 
        }
    }
    return 1;
}

//end