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
command_uprawnienia_Impl(playerid)
{
    new str[512];
    strcat(str, "\t\t\tUPRAWNIENIA\n");
    if(Uprawnienia(playerid, ACCESS_PANEL)) strcat(str, "{00FF00}+{FFFFFF} Panel administracyjny\n");
    if(Uprawnienia(playerid, ACCESS_KARY)) strcat(str, "{00FF00}+{FFFFFF} Panel kar\n");
    if(Uprawnienia(playerid, ACCESS_KARY_ZNAJDZ)) strcat(str, "\t» Wyszukiwanie kar\n");
    if(Uprawnienia(playerid, ACCESS_KARY_BAN)) strcat(str, "\t» Nadawanie kar\n");
    if(Uprawnienia(playerid, ACCESS_KARY_UNBAN)) strcat(str, "\t» Zdejmowanie kar\n");
    if(Uprawnienia(playerid, ACCESS_ZG)) strcat(str, "{00FF00}+{FFFFFF} Nadawanie ZG\n");
    if(Uprawnienia(playerid, ACCESS_MAKELEADER)) strcat(str, "{00FF00}+{FFFFFF} Nadawanie paneli\n");
    if(Uprawnienia(playerid, ACCESS_GIVEHALF)) strcat(str, "{00FF00}+{FFFFFF} Nadawanie P@ i @\n");

    if(Uprawnienia(playerid, ACCESS_MAKEFAMILY)) strcat(str, "{00FF00}+{FFFFFF} Tworzenie organizacji\n");
    if(Uprawnienia(playerid, ACCESS_DELETEORG)) strcat(str, "{00FF00}+{FFFFFF} Usuwanie organizacji\n");

    if(Uprawnienia(playerid, ACCESS_EDITCAR)) strcat(str, "{00FF00}+{FFFFFF} Edycja pojazdów\n");
    if(Uprawnienia(playerid, ACCESS_EDITRANG)) strcat(str, "{00FF00}+{FFFFFF} Edycja rang\n");
    if(Uprawnienia(playerid, ACCESS_EDITPERM)) strcat(str, "{00FF00}+{FFFFFF} Edycja uprawnieñ");
    if(strlen(str) < 20) strcat(str, "{FF0000}Brak jakichkolwiek uprawnieñ!");
    ShowPlayerDialogEx(playerid, D_INFO, DIALOG_STYLE_LIST, "Twoje uprawnienia", str, "OK", "");
    return 1;
}

//end
