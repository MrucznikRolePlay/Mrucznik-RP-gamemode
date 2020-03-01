//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                kuplicencje                                                //
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
// Data utworzenia: 20.09.2019

//------------------<[ Implementacja: ]>-------------------
command_kuplicencje_Impl(playerid)
{
    if(PlayerInDmvPoint(playerid))
    {
        if(!DmvActorStatus)
        {
            sendErrorMessage(playerid, "Ta komenda jest wy³¹czona - Urz¹d miasta nie obs³uguj¹ boty!"); 
            return 1;
        }
        new string[356]; 
        format(string, sizeof(string), "Nazwa\tKoszt\n\
        Dowód Osobisty\t{80FF00}$%d\n\
        Karta wêdkarska\t{80FF00}$%d\n\
        Pozwolenie na broñ\t{80FF00}$%d\n\
        Patent ¿eglarski\t{80FF00}$%d\n\
        Prawo jazdy - teoria\t{80FF00}$%d\n\
        Prawo Jazdy - praktyka\t{80FF00}$%d\n\
        Prawo jazdy - odbiór\t{80FF00}$%d\n\
        Licencja pilota\t{80FF00}$%d", 
        DmvLicenseCost[0], 
        DmvLicenseCost[1],
        DmvLicenseCost[2],
        DmvLicenseCost[3],
        DmvLicenseCost[4],
        DmvLicenseCost[5],
        DmvLicenseCost[6],
        DmvLicenseCost[7]);
        /* na póŸniej
        DmvLicenseCost[8], - rejestracja pojazdu
        DmvLicenseCost[9]); - w³asna tablica rejestracyjna
        */
        ProxDetector(30.0, playerid, "Urzêdnik mówi: Witam Pana(i) w Urzêdzie Miasta! W czym mogê Panu(i) pomóc?", COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY,COLOR_GREY);
        ShowPlayerDialogEx(playerid, DIALOG_DMV, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz dokument:", string, "Wyrób", "Wyjdz");
    }
    else
    {
        sendErrorMessage(playerid, "Nie jesteœ przy okienkach urzêdu miasta!"); 
    }
    return 1;
}

//end