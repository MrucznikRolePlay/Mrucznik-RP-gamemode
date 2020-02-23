//-----------------------------------------------<< Defines >>-----------------------------------------------//
//                                              nawigacjaDialogs                                             //
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
nawigacja_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_NAWI_MAIN)
    {
       if(response)
       {
           switch(listitem)
           {
               case 0:
               {
                   ShowNawiDialog(playerid, DIALOG_NAWI_ZNANEMIEJSCA);
               }
               case 1:
               {
                   ShowNawiDialog(playerid, DIALOG_NAWI_BIZNESY); 
               }
               case 2:
               {
                   ShowNawiDialog(playerid, DIALOG_NAWI_ULICE); 
               }
               case 3:
               {
                   sendErrorMessage(playerid, "Nie za³o¿y³eœ nikomu nadajnika GPS"); //Wkrótce
               }
           }
       }
    }
    else if(dialogid == DIALOG_NAWI_ZNANEMIEJSCA)
    {
        if(!response)
        {
            return ShowNawiDialog(playerid, DIALOG_NAWI_MAIN); 
        }
        else{
            new string[124];
            switch(listitem)
            {
                case 0://urzad
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Urz¹d Miasta Los Santos");
                    format(string, sizeof(string), "Do celu pozosta³o %0.2f metrów!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_UMLS][N_POSX], posNawi[NAWI_UMLS][N_POSY], posNawi[NAWI_UMLS][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    StartNavigation(playerid, NAWI_UMLS); 
                }
                case 1://bank
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Bank 0Verte oddzia³ LS");
                    format(string, sizeof(string), "Do celu pozosta³o %0.2f metrów!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BANK][N_POSX], posNawi[NAWI_BANK][N_POSY], posNawi[NAWI_BANK][N_POSZ]));
                    sendTipMessage(playerid, string);
                    StartNavigation(playerid, NAWI_BANK); 
                }
                case 2://lspd
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Los Santos Police Department");
                    format(string, sizeof(string), "Do celu pozosta³o %0.2f metrów!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_LSPD][N_POSX], posNawi[NAWI_LSPD][N_POSY], posNawi[NAWI_LSPD][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    StartNavigation(playerid, NAWI_LSPD);
                }
                case 3://baza mechów
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Centralna siedziba mechaników");
                    format(string, sizeof(string), "Do celu pozosta³o %0.2f metrów!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_BAZA][N_POSX], posNawi[NAWI_BAZA][N_POSY], posNawi[NAWI_BAZA][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    StartNavigation(playerid, NAWI_BAZA);
                }
                case 4://vinyl
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Vinyl Club");
                    format(string, sizeof(string), "Do celu pozosta³o %0.2f metrów!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_VINYL][N_POSX], posNawi[NAWI_VINYL][N_POSY], posNawi[NAWI_VINYL][N_POSZ]));
                    sendTipMessage(playerid, string);
                    StartNavigation(playerid, NAWI_VINYL); 
                }
                case 5://ibiza
                {
                    sendTipMessageEx(playerid, COLOR_GREEN, "==============<[ Mrucznik Navigation ]>==============");
                    sendTipMessageEx(playerid, COLOR_GREEN, "Wybrano cel: {FFFFFF}Ibiza Club");
                    format(string, sizeof(string), "Do celu pozosta³o %0.2f metrów!", 
                    GetPlayerDistanceFromPoint(playerid, posNawi[NAWI_IBIZA][N_POSX], posNawi[NAWI_IBIZA][N_POSY], posNawi[NAWI_IBIZA][N_POSZ]));
                    sendTipMessage(playerid, string); 
                    StartNavigation(playerid, NAWI_IBIZA);
                }
            }
        }
    }
    return 1;
}

//end