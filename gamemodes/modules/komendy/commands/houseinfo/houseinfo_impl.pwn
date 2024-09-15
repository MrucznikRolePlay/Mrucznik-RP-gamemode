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
command_houseinfo_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        new koxu = dini_Int("Domy/NRD.ini", "NrDomow");
	        for(new h = 0; h <= koxu; h++)
			{
                if(IsPlayerInRangeOfPoint(playerid, 2.0, Dom[h][hWej_X], Dom[h][hWej_Y], Dom[h][hWej_Z]))
				{
				    new dom=h;
				    new string2[512];
					new wynajem[4];
					if(Dom[dom][hWynajem] == 0)
					{
                        wynajem = "nie";
					}
					else
					{
                        wynajem = "tak";
					}
					new drzwi[30];
					if(Dom[dom][hZamek] == 0)
					{
                        drzwi = "Zamkniête";
					}
					else
					{
                        drzwi = "Otwarte";
					}
	                format(string2, sizeof(string2), "W³aœciciel:\t%s\nStandard:\t%d gwiazdki\nID domu:\t%d\nID wnêtrza:\t%d\nCena domu:\t%d$\nWynajem:\t%s\nIlosc pokoi:\t%d\nPokoi wynajmowanych\t%d\nCena wynajmu:\t%d$\nOœwietlenie:\t%d\nDrzwi:\t\t%s", Dom[dom][hWlasciciel], IntInfo[Dom[dom][hDomNr]][Kategoria], dom, Dom[dom][hDomNr], Dom[dom][hCena], wynajem, Dom[dom][hPokoje], Dom[dom][hPW], Dom[dom][hCenaWynajmu], Dom[dom][hSwiatlo], drzwi);
	                ShowPlayerDialogEx(playerid, 123, DIALOG_STYLE_MSGBOX, "G³ówne informacje domu", string2, "Ogl¹daj", "WyjdŸ");
				}
			}
	    }
	}
	return 1;
}

//end
