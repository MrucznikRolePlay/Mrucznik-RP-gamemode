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
command_deletedom_Impl(playerid, params[256])
{
    new string[64];

    if(gPlayerLogged[playerid] == 1)
    {
	    if(PlayerInfo[playerid][pAdmin] == 5000)
		{
		    new kategoria;
			if( sscanf(params, "d", kategoria))
			{
				sendTipMessage(playerid, "U¿yj /usundom [numer pliku]");
				return 1;
			}


			format(string, sizeof(string), "Domy/Dom%d.ini", kategoria);
			if(dini_Exists(string))
			{
				dini_Remove(string);
				DestroyDynamicPickup(Dom[kategoria][hPickup]);
				if(Dom[kategoria][hIkonka] != -1) DestroyDynamicMapIcon(Dom[kategoria][hIkonka]);
                Dom[kategoria][hID] = 0;
				Dom[kategoria][hDomNr] = 0;
				Dom[kategoria][hZamek] = 0;
				Dom[kategoria][hWlasciciel] = 0;
				Dom[kategoria][hKupiony] = 0;
				Dom[kategoria][hBlokada] = 0;
				Dom[kategoria][hOplata] = 0;
				Dom[kategoria][hCena] = 0;
				Dom[kategoria][hUID_W] = 0;
				Dom[kategoria][hData_DD] = 0;
				Dom[kategoria][hWej_X] = 0;
				Dom[kategoria][hWej_Y] = 0;
				Dom[kategoria][hWej_Z] = 0;
				Dom[kategoria][hInt_X] = 0;
				Dom[kategoria][hInt_Y] = 0;
				Dom[kategoria][hInt_Z] = 0;
				Dom[kategoria][hInterior] = 0;
				Dom[kategoria][hParcela] = 0;
				Dom[kategoria][hVW] = 0;
				//Dom[kategoria][h3D_txt] = 0;
				Dom[kategoria][hK_3D] = 0;
				Dom[kategoria][hPickup] = 0;
				Dom[kategoria][hIkonka] = -1;
				Dom[kategoria][hPokoje] = 0;
				Dom[kategoria][hPDW] = 0;
				Dom[kategoria][hPW] = 0;
				Dom[kategoria][hL1] = 0;
				Dom[kategoria][hL2] = 0;
				Dom[kategoria][hL3] = 0;
				Dom[kategoria][hL4] = 0;
				Dom[kategoria][hL5] = 0;
				Dom[kategoria][hL6] = 0;
				Dom[kategoria][hL7] = 0;
				Dom[kategoria][hL8] = 0;
				Dom[kategoria][hL9] = 0;
				Dom[kategoria][hL10] = 0;
				Dom[kategoria][hSwiatlo] = 0;
				Dom[kategoria][hWynajem] = 0;
				Dom[kategoria][hWW] = 0;
				Dom[kategoria][hTWW] = 0;
				Dom[kategoria][hCenaWynajmu] = 0;
				Dom[kategoria][hKomunikatWynajmu] = 0;
				Dom[kategoria][hKomunikatDomowy] = 0;
				Dom[kategoria][hUL_Z] = 0;
				Dom[kategoria][hUL_D] = 0;
				Dom[kategoria][hApteczka] = 0;
				Dom[kategoria][hKami] = 0;
				Dom[kategoria][hZbrojownia] = 0;
				Dom[kategoria][hGaraz] = 0;
				Dom[kategoria][hLadowisko] = 0;
				Dom[kategoria][hAlarm] = 0;
				Dom[kategoria][hZamekD] = 0;
				Dom[kategoria][hKomputer] = 0;
				Dom[kategoria][hRTV] = 0;
				Dom[kategoria][hHazard] = 0;
				Dom[kategoria][hSzafa] = 0;
				Dom[kategoria][hTajemnicze] = 0;
				Dom[kategoria][hSejf] = 0;
				Dom[kategoria][hKodSejf] = 0;
				Dom[kategoria][hS_kasa] = 0;
				Dom[kategoria][hS_mats] = 0;
				Dom[kategoria][hS_ziolo] = 0;
				Dom[kategoria][hS_drugs] = 0;
				Dom[kategoria][hS_PG0] = 0;
				Dom[kategoria][hS_PG1] = 0;
				Dom[kategoria][hS_PG2] = 0;
				Dom[kategoria][hS_PG3] = 0;
				Dom[kategoria][hS_PG4] = 0;
				Dom[kategoria][hS_PG5] = 0;
				Dom[kategoria][hS_PG6] = 0;
				Dom[kategoria][hS_PG7] = 0;
				Dom[kategoria][hS_PG8] = 0;
				Dom[kategoria][hS_PG9] = 0;
				Dom[kategoria][hS_PG10] = 0;
				Dom[kategoria][hS_PG11] = 0;
				Dom[kategoria][hS_G0] = 0;
				Dom[kategoria][hS_G1] = 0;
				Dom[kategoria][hS_G2] = 0;
				Dom[kategoria][hS_G3] = 0;
				Dom[kategoria][hS_G4] = 0;
				Dom[kategoria][hS_G5] = 0;
				Dom[kategoria][hS_G6] = 0;
				Dom[kategoria][hS_G7] = 0;
				Dom[kategoria][hS_G8] = 0;
				Dom[kategoria][hS_G9] = 0;
				Dom[kategoria][hS_G10] = 0;
				Dom[kategoria][hS_G11] = 0;
				Dom[kategoria][hS_A1] = 0;
				Dom[kategoria][hS_A2] = 0;
				Dom[kategoria][hS_A3] = 0;
				Dom[kategoria][hS_A4] = 0;
				Dom[kategoria][hS_A5] = 0;
				Dom[kategoria][hS_A6] = 0;
				Dom[kategoria][hS_A7] = 0;
				Dom[kategoria][hS_A8] = 0;
				Dom[kategoria][hS_A9] = 0;
				Dom[kategoria][hS_A10] = 0;
				Dom[kategoria][hS_A11] = 0;
			    sendTipMessage(playerid, "Dom usuniêty");
				Log(adminLog, INFO, "Admin %s usun¹³ dom %s", GetPlayerLogName(playerid), GetHouseLogName(kategoria));
				return 1;
			}
			else
			{
			    sendErrorMessage(playerid, "Brak pliku");
				return 1;
			}
		}
	}
	return 1;
}

//end
