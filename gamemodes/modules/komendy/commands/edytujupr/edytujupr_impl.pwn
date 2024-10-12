//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_edytujupr_Impl(playerid, params[256])
{
    if(!(Uprawnienia(playerid, ACCESS_EDITPERM) && IsPlayerAdmin(playerid))) return SendClientMessage(playerid, -1, "(PERM) - Nie posiadasz pe³nych praw.");
    new id;
    if(sscanf(params, "k<fix>", id)) return SendClientMessage(playerid, -1, "(PERM) - Podaj Nick lub ID gracza.");
    new str[512];
    format(str, sizeof(str), "\t\tUPRAWNIENIA %s\n", GetNickEx(id));
    if(Uprawnienia(id, ACCESS_PANEL)) strcat(str, "{00FF00}+{FFFFFF} Panel administracyjny\n");
    else strcat(str, "{FF0000}-{FFFFFF} Panel administracyjny\n");
    if(Uprawnienia(id, ACCESS_KARY)) strcat(str, "{00FF00}+{FFFFFF} Panel kar\n");
    else strcat(str, "{FF0000}-{FFFFFF} Panel kar\n");
    if(Uprawnienia(id, ACCESS_KARY_ZNAJDZ)) strcat(str, "\t» Wyszukiwanie kar\n");
    else strcat(str, "{FF0000}\t» Wyszukiwanie kar\n");
    if(Uprawnienia(id, ACCESS_KARY_BAN)) strcat(str, "\t» Nadawanie kar\n");
    else strcat(str, "{FF0000}\t» Nadawanie kar\n");
    if(Uprawnienia(id, ACCESS_KARY_UNBAN)) strcat(str, "\t» Zdejmowanie kar\n");
    else strcat(str, "{FF0000}\t» Zdejmowanie kar\n");

    if(Uprawnienia(id, ACCESS_ZG)) strcat(str, "{00FF00}+{FFFFFF} Nadawanie ZG\n");
    else strcat(str, "{FF0000}-{FFFFFF} Nadawanie ZG\n");
    if(Uprawnienia(id, ACCESS_GIVEHALF)) strcat(str, "{00FF00}+{FFFFFF} Nadawanie P@ i @\n");
    else strcat(str, "{FF0000}-{FFFFFF} Nadawanie P@\n");
    if(Uprawnienia(id, ACCESS_MAKELEADER)) strcat(str, "{00FF00}+{FFFFFF} Nadawanie paneli\n");
    else strcat(str, "{FF0000}-{FFFFFF} Nadawanie paneli\n");

    if(Uprawnienia(id, ACCESS_MAKEFAMILY)) strcat(str, "{00FF00}+{FFFFFF} Tworzenie organizacji\n");
    else strcat(str, "{FF0000}-{FFFFFF} Tworzenie organizacji\n");
    if(Uprawnienia(id, ACCESS_DELETEORG)) strcat(str, "{00FF00}+{FFFFFF} Usuwanie organizacji\n");
    else strcat(str, "{FF0000}-{FFFFFF} Usuwanie organizacji\n");

    if(Uprawnienia(id, ACCESS_EDITCAR)) strcat(str, "{00FF00}+{FFFFFF} Edycja pojazdów\n");
    else strcat(str, "{FF0000}-{FFFFFF} Edycja pojazdów\n");
    if(Uprawnienia(id, ACCESS_EDITRANG)) strcat(str, "{00FF00}+{FFFFFF} Edycja rang\n");
    else strcat(str, "{FF0000}-{FFFFFF} Edycja rang\n");
    if(Uprawnienia(id, ACCESS_EDITPERM)) strcat(str, "{00FF00}+{FFFFFF} Edycja uprawnieñ\n");
    else strcat(str, "{FF0000}-{FFFFFF} Edycja uprawnieñ\n");
    if(Uprawnienia(id, ACCESS_SKRYPTER)) strcat(str, "{00FF00}+{FFFFFF} Skrypter\n");
    else strcat(str, "{FF0000}-{FFFFFF} Skrypter\n");
    if(Uprawnienia(id, ACCESS_OWNER)) strcat(str, "{00FF00}OWNER RIGHT'S");
    valstr(params, id);
    SetPVarString(playerid, "perm-id", params);
    ShowPlayerDialogEx(playerid, D_PERM, DIALOG_STYLE_LIST, "Edycja uprawnieñ", str, "Zmieñ", "WyjdŸ");
    return 1;
}

//end
