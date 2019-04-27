//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ dopasuj ]------------------------------------------------//
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

CMD:dopasuj(playerid, params[])
{
	new type[24];
    if(sscanf(params, "s[24]", type)) {
        return sendTipMessage(playerid, "Dostepne /dopasuj: kamizelke");
    }
	if(IsACop(playerid))
	{
		if(!strcmp(type, "kamizelke", true))
		{
			new Float:armor;
			GetPlayerArmour(playerid, armor);
			if(armor < 1.0) return 1;
			//RemovePlayerAttachedObject(playerid, 7);
			SetPlayerAttachedObject(playerid, 7, 19142, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
			EditAttachedObject(playerid, 7);
		}
	}
	else
	{
		sendErrorMessage(playerid, "Nie jesteœ z policji!");
		return 1;
	}
    return 1;
}
