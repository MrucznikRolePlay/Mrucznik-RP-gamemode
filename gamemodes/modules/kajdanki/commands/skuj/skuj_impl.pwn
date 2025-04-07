//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  kajdanki                                                 //
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
// Autor: NikodemBanan
// Data utworzenia: 01.03.2024


//

//------------------<[ Implementacja: ]>-------------------
command_skuj_Impl(playerid, cuffedplayerid)
{
    if(IsKajdankiInvalid(playerid, cuffedplayerid))
    {
        return 1;
    }

    if(PlayerInfo[playerid][pBW] >= 1 || PlayerInfo[playerid][pInjury] >= 1)
    {
        MruMessageFail(playerid, "Nie mo¿esz kogoœ skuæ, gdy jesteœ na BW");
        return 1;
    }

    if(isPlayerUsingCuffs[playerid] && isPlayerCuffed[cuffedplayerid] && whoIsCuffing[cuffedplayerid] == playerid)
    {
        new str[32];
        valstr(str, cuffedplayerid);
        RunCommand(playerid, "/rozkuj",  str);
        return 1;
    }
    
    if(!isPlayerUsingCuffs[playerid] && isPlayerCuffed[cuffedplayerid] && whoIsCuffing[cuffedplayerid] != playerid)
    {
        TransferCuffs(cuffedplayerid, playerid);
        return 1;
    }

    if(GetPlayerWeapon(cuffedplayerid) >= 22 && TazerAktywny[cuffedplayerid] == 0)
    {
        MruMessageFail(playerid, "Ten gracz trzyma niebezpieczn¹ broñ, jeœli chcesz go zakuæ musisz go najpierw sparali¿owaæ tazerem lub zmusiæ do schowania broni.");
        return 1;
    }

    new string[128];

    SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
    AntySpam[playerid] = 1;

    // Automatyczny sukces
    if(PlayerInfo[cuffedplayerid][pBW] >= 1 || PlayerInfo[cuffedplayerid][pInjury] >= 1)
    {
        CuffAutoSuccess(playerid, cuffedplayerid);
        return 1;
    }

    format(string, sizeof(string), "* %s wyci¹ga kajdanki i próbuje je za³o¿yæ %s.", GetNick(playerid),GetNick(cuffedplayerid));
    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

    whoIsCuffing[cuffedplayerid] = playerid;
    ShowPlayerDialogEx(cuffedplayerid, CUFFING_DIALOG_ID, DIALOG_STYLE_MSGBOX, "Aresztowanie", "Policjant chce za³o¿yæ ci kajdanki, jeœli osacza ciê niedu¿a liczba policjantów mo¿esz spróbowaæ siê wyrwaæ\nJednak pamiêtaj jeœli siê wyrwiesz i jesteœ uzbrojony policjant ma prawo ciê zabiæ. \nMo¿esz tak¿e dobrowolnie poddaæ siê policjantom.", "Poddaj siê", "Wyrwij siê");
    
    return 1;
}

//end