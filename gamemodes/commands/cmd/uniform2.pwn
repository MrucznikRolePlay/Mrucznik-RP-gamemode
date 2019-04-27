//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ uniform2 ]-----------------------------------------------//
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

YCMD:uniform2(playerid, params[], help)
{
    if(IsPlayerConnected(playerid) && IsAtClothShop(playerid) && PlayerInfo[playerid][pMember] != 0)
    {
		if(FRAC_SKINS[PlayerInfo[playerid][pMember]][0] == 0)
		{
			sendErrorMessage(playerid, "Ta frakcja nie ma skinów");
			return 1;
		}
        ShowPlayerDialogEx(playerid,DIALOGID_UNIFORM,DIALOG_STYLE_PREVMODEL_LIST,"Zmien skin frakcyjny",DialogListaSkinow(PlayerInfo[playerid][pMember]),"Zmien skin","Anuluj"); //zmieñ dialogid
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD2, "  Nie jesteœ w sklepie odzie¿owym!");
    }
    return 1;
}
