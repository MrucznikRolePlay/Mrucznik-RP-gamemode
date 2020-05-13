//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ vopis ]-------------------------------------------------//
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

YCMD:vopis(playerid, params[], help)
{
    //SendClientMessage(playerid, COLOR_RED, "Komenda wy³¹czona na czas naprawy. Przepraszamy za utrudnienia.");
    if(PlayerInfo[playerid][pConnectTime] < 4) return sendErrorMessage(playerid, "Opis dostêpny od 4 godzin online!");

    new var[8], id=-1;
    if(sscanf(params, "s[8]D(-1)", var, id) && PlayerInfo[playerid][pAdmin] > 0)
	{
		sendTipMessage(playerid, "U¿yj /vopis (usuñ) (id pojazdu)");
	}
	
    if(strlen(var) == 4 && (strcmp(var, "usuñ", true) == 0 || strcmp(var, "usun", true) == 0))
    {
        if(id != -1 && PlayerInfo[playerid][pAdmin] >= 1)
        {
            if(Car_GetOwnerType(id) != CAR_OWNER_PLAYER && !Uprawnienia(playerid, ACCESS_EDITCAR)) 
			{
				return SendClientMessage(playerid, COLOR_GRAD2, "Nie mo¿na usun¹æ opisu pojazdu systemowego.");
			}
            if(!CarOpis_Usun(playerid, id)) 
			{
				return SendClientMessage(playerid, -1, "Opis: Pojazd nie posiada opisu.");
			}
			
			new str[64];
			format(str, sizeof(str), "(OPIS) - Usun¹³eœ opis pojazdu ustawiony przez gracza %s.", CarOpisCaller[id]);
			SendClientMessage(playerid, COLOR_PURPLE, str);
			Log(adminLog, INFO, "Admin %s usun¹³ opis pojazdu %s ustawiony przez gracza %s", 
						GetPlayerLogName(playerid),
                        GetVehicleLogName(id),
						CarOpisCaller[id]);
			return 1;
        }
        else
        {
            new vehicleid = GetPlayerVehicleID(playerid);
            if(vehicleid == 0) return 1;
            if(!IsCarOwner(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_GRAD2, " Ten pojazd nie nale¿y do Ciebie.");
            if(!CarOpis_Usun(playerid, vehicleid, true)) return SendClientMessage(playerid, -1, "Opis: Pojazd nie posiada opisu.");
        }
        return 1;
    }

    if(PlayerInfo[playerid][pBP] == 0)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if(vehicleid == 0) return 1;
        if(!IsCarOwner(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_GRAD2, " Ten pojazd nie nale¿y do Ciebie.");

        new opis[128];
        format(opis, sizeof opis, "%s", CarDesc[vehicleid]);
        reColor(opis);
        new lStr[256];
        strunpack(lStr, opis);
        format(lStr, 256, "%s\n» Ustaw opis\n» Zmieñ opis\n» {FF0000}Usuñ", lStr);
        ShowPlayerDialogEx(playerid, D_VEHOPIS, DIALOG_STYLE_LIST, "Opis pojazdu", lStr, "Wybierz", "WyjdŸ");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Posiadasz blokadê pisania na czatach globalnych, nie mo¿esz utworzyæ opisu.");
    }
    return 1;
}
