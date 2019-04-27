//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ sejfpomoc ]-----------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:sejfpomoc(playerid, params[], help)
{
	//SendClientMessage(playerid, COLOR_PANICRED, "Sejf wy³¹czony na czas naprawy. Przepraszamy za uniedogodnienia.");
    if(IsPlayerConnected(playerid))
    {
	    if(gPlayerLogged[playerid] == 1)
	    {
	        if(GUIExit[playerid] == 0)
	    	{
	    	    if(PlayerInfo[playerid][pDom] == 0 && PlayerInfo[playerid][pDomWKJ] == 0)
				{
					sendErrorMessage(playerid,"Nie posiadasz domu.");
					return 1;
				}
		        if(PlayerInfo[playerid][pDom] == PlayerInfo[playerid][pDomWKJ])
		        {
		            new xxx[20];
		            format(xxx, sizeof(xxx), "500500500500");
		            new xxx2[20];
		            format(xxx2, sizeof(xxx2), "%s", Dom[PlayerInfo[playerid][pDom]][hKodSejf]);
		            if(strcmp(xxx2, xxx, true ) == 0)
		            {
		                ShowPlayerDialogEx(playerid, 8004, DIALOG_STYLE_INPUT, "Sejf - ustalanie kodu", "Kod twojego sejfu nie jest ustalony - musisz go ustaliæ.\nAby to zrobiæ wpisz nowy kod do okienka poni¿ej. (MIN 4 MAX 10 znaków)", "OK", "");
		            }
		            else
					{
			            ShowPlayerDialogEx(playerid, 8000, DIALOG_STYLE_LIST, "Sejf", "Zawartoœæ sejfu\nW³ó¿ do sejfu\nWyjmij z sejfu\nUstal kod sejfu", "Wybierz", "Anuluj");
	                    sendErrorMessage(playerid,"Poniewa¿ jesteœ w³aœcicielem domu kod zosta³ wpisany automatycznie.");
					}
				}
		        else
		        {
		            if(AntyWlamSejf[playerid] >= 5)
		            {
		                sendErrorMessage(playerid, "Nie mo¿esz wpisaæ ju¿ kodu do sejfu - zbyt du¿o nieudanych prób. Spróbuj za 5 minut");
		                return 1;
		            }
		            new xxx[20];
		            format(xxx, sizeof(xxx), "500500500500");
		            new xxx2[20];
		            format(xxx2, sizeof(xxx2), "%s", Dom[PlayerInfo[playerid][pDomWKJ]][hKodSejf]);
		            if(strcmp(xxx2, xxx, true ) == 0)
		            {
		            	sendErrorMessage(playerid,"Ten dom nie ma sejfu/nie jesteœ w domu.");
		            	return 1;
		            }
		            else
		            {
                        SetPVarInt(playerid, "kodVw", GetPlayerVirtualWorld(playerid));
						ShowPlayerDialogEx(playerid, 8015, DIALOG_STYLE_INPUT, "Sejf - wpisz kod", "Ten sejf jest zabezpieczony kodem. Aby siê do niego dostaæ wpisz poprawny kod w okienko poni¿ej", "ZatwierdŸ", "WyjdŸ");
		            }
		        }
		    }
	    }
	}
	return 1;
}
