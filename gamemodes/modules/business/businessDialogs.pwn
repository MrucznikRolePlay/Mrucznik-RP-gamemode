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
                    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUYBOX, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play", string, "Kupujê", "Rezygnujê"); 
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
            //Coœ tu ma sie zadziaæ (Timer)
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
    return 1;
}

//end