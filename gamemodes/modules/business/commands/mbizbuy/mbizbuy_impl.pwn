//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbizbuy                                                  //
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

//------------------<[ Implementacja: ]>-------------------
command_mbizbuy_Impl(playerid)
{
    new string[124]; 
    if(PlayerInfo[playerid][pLevel] < LVL_TO_BUY_BIZ)
    {
        format(string, sizeof(string), "Nie mo¿esz zakupiæ biznesu, musisz posiadaæ %d LVL!", LVL_TO_BUY_BIZ);
        sendErrorMessage(playerid, string); 
        return 1;
    }
    if(GetPLocal(playerid) != PLOCAL_FRAC_DMV)
    {
        sendErrorMessage(playerid, "Aby tego u¿yæ musisz siê znajdowaæ w Urzêdzie Miasta!"); 
        return 1;
    }
    ShowPlayerDialogEx(playerid, DIALOG_BIZ_BUY, DIALOG_STYLE_INPUT, "Zakup biznes", "WprowadŸ poni¿ej numer biznesu, który chcia³byœ zakupiæ.\n[UWAGA] Je¿eli biznes nigdy wczeœniej nie by³ kupywany (jego cena nie zosta³a ustalona)\npo twoim zakupie rozpoczêta zostanie licytacja.", "Dalej", "Anuluj");
    return 1;
}

//end