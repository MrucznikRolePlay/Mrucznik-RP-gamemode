//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                panelbiznesu                                               //
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
// Data utworzenia: 20.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_panelbiznesu_Impl(playerid, choice[32])
{
    if(GetPlayerBusiness(playerid) == INVALID_BIZ_ID)
    {
        sendTipMessage(playerid, "Nie jesteœ w ¿adnym biznesie!"); 
        return 1; 
    }
    if(PlayerInfo[playerid][pBusinessOwner] == INVALID_BIZ_ID)
    {
        sendErrorMessage(playerid, "Nie jesteœ liderem biznesu"); 
        return 1;
    }
    new string[256];
    if(strcmp(choice, "Przyjmij", true) == 0)
    {
        format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej ID gracza\nktórego pragniesz zatrudniæ w swoim biznesie.\n",
        Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
        ShowPlayerDialogEx(playerid, 4469, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
        SetPVarInt(playerid, "bizWhatToDo", 1); 
    }
    else if(strcmp(choice, "Zwolnij", true) == 0)
    {
        format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej ID gracza\nktórego pragniesz zwolniæ ze swojego biznesu.\n",
        Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
        ShowPlayerDialogEx(playerid, 4469, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
        SetPVarInt(playerid, "bizWhatToDo", 2); 
    }
    else if(strcmp(choice, "Wplac", true) == 0)
    {
        format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej kwotê jak¹ chcesz wp³aciæ\ndo swojego sejfu!",
        Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
        ShowPlayerDialogEx(playerid, 4469, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
        SetPVarInt(playerid, "bizWhatToDo", 3); 
    }
    else if(strcmp(choice, "Wyplac", true) == 0)
    {
        format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}Wpisz poni¿ej kwotê jak¹ chcesz wyp³aciæ\nze swojego sejfu biznesowego",
        Business[PlayerInfo[playerid][pBusinessOwner]][b_Name]); 
        ShowPlayerDialogEx(playerid, 4469, DIALOG_STYLE_INPUT, "Mrucznik Role Play", string, "Akceptuj", "Odrzuæ"); 
        SetPVarInt(playerid, "bizWhatToDo", 4); 
    }
    else if(strcmp(choice, "Stan", true) == 0)
    {
        format(string, sizeof(string), "{FF00FF}%s\n{FFFFFF}W sejfie twojego biznesu znajduje siê aktualnie: $%d",
        Business[PlayerInfo[playerid][pBusinessOwner]][b_Name], Business[PlayerInfo[playerid][pBusinessOwner]][b_moneyPocket]); 
    }
    else
    {
        sendErrorMessage(playerid, "Niepoprawny Choice_Name!"); 
    }
    return 1;
}

//end