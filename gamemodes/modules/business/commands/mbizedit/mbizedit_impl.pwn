//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbizedit                                                 //
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
// Data utworzenia: 06.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mbizedit_Impl(playerid, bIDE)
{
    new string[124];
    if(!IsABusinessGod(playerid))
    {
        sendErrorMessage(playerid, "Nie maszu prawnieñ do zarz¹dzania biznesami!"); 
        return 1;
    }
    if(!BizExist(bIDE))
    {
        sendErrorMessage(playerid, "Nie ma takiego biznesu!"); 
        return 1;
    }
    new bChoiceEdit = GetPVarInt(playerid, "bizChoice");
    new Float:pPosX, Float:pPosY, Float:pPosZ;
    new pBVW = GetPlayerVirtualWorld(playerid);
    new pBINT = GetPlayerInterior(playerid); 
    new pBLocal = GetPLocal(playerid); 
    GetPlayerPos(playerid, pPosX, pPosY, pPosZ);
    if(bChoiceEdit == BIZ_CHOICE_NOTHING)
    {
        ShowPlayerDialogEx(playerid, DIALOG_BIZ_ADMINEDIT, DIALOG_STYLE_LIST, "Mrucznik Role Play", "Przenieœ wejœcie\nDodaj wyjœcie\nUsuñ biznes\nUsuñ w³aœciciela\nWyzeruj pieni¹dze biznesu\nZmieñ cene biznesu", "Dalej", "Odrzuæ"); 
    }
    else if(bChoiceEdit == BIZ_CHOICE_PRZENIES)
    {
        mBiz[bIDE][b_enX] = pPosX;
        mBiz[bIDE][b_enY] = pPosY;
        mBiz[bIDE][b_enZ] = pPosZ; 
        sendTipMessageEx(playerid, COLOR_GREEN, "Pomyœlnie przeniesiono biznes na nowe koordynaty"); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
        SaveBiz(bIDE);
    } 
    else if(bChoiceEdit == BIZ_CHOICE_DODAJ)
    {
        mBiz[bIDE][b_exX] = pPosX;
        mBiz[bIDE][b_exY] = pPosY;
        mBiz[bIDE][b_exZ] = pPosZ; 
        mBiz[bIDE][b_vw] = pBVW;
        mBiz[bIDE][b_int] = pBINT; 
        mBiz[bIDE][b_pLocal] = pBLocal;
        sendTipMessageEx(playerid, COLOR_GREEN, "Pomyœlnie dodano wyjœcie do interioru"); 
        format(string, sizeof(string), "PosX: %f", pPosX);
        sendTipMessage(playerid, string);
        format(string, sizeof(string), "PosY: %f", pPosY);
        sendTipMessage(playerid, string);
        format(string, sizeof(string), "PosZ: %f", pPosZ);
        sendTipMessage(playerid, string);
        format(string, sizeof(string), "VW: [%d] INT: [%d] pLocal: [%d]", pBVW, pBINT, pBLocal);
        sendTipMessage(playerid, string);
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
        SaveBiz(bIDE); 
    }
    else
    {
        sendErrorMessage(playerid, "Nieznany dla systemu wybór!"); 
        SetPVarInt(playerid, "bizChoice", BIZ_CHOICE_NOTHING);
    }
    return 1;
}

//end