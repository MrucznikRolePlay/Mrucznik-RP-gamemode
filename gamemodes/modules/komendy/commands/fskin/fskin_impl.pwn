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
command_fskin_Impl(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if(GetPlayerAdminDutyStatus(playerid) == 1)
		{
			sendErrorMessage(playerid, "Nie mo�esz tego u�y�  podczas @Duty! Zejd� ze s�u�by u�ywaj�c /adminduty");
			return 1;
		}
		if (IsAtClothShop(playerid) ||
            IsPlayerInRangeOfPoint(playerid, 4.0, 1147.3623,-1314.4891,13.6743) || //duty ers
            IsPlayerInRangeOfPoint(playerid, 4.0, GetPVarFloat(playerid,"xposspawn"),GetPVarFloat(playerid,"yposspawn"),GetPVarFloat(playerid,"zposspawn")))
		{
            new frac = GetPlayerFraction(playerid);
            new fam = GetPlayerOrg(playerid);
            if(frac != 0)
            {
                //FRAC_SKINS
                if(FRAC_SKINS[frac][0] == 0)
                {
                    return SendClientMessage(playerid, COLOR_GRAD2, "Twoja frakcja nie ma w�asnych skin�w.");
                }
                ShowPlayerDialogEx(playerid, DIALOGID_UNIFORM_FRAKCJA, DIALOG_STYLE_PREVIEW_MODEL, "Zmien skin frakcyjny", DialogListaSkinow(frac), "Zmien skin", "Anuluj"); //zmie� dialogid
            }
            else if(fam != 0)
            {
                //FAM_SKINS
                if(OrgSkins[fam][0] == 0)
                {
                    return SendClientMessage(playerid, COLOR_GRAD2, "Twoja organizacja nie ma w�asnych skin�w.");
                }
                ShowPlayerDialogEx(playerid, DIALOGID_UNIFORM_FAMILY, DIALOG_STYLE_PREVIEW_MODEL, "Zmien skin organizacji", DialogListaSkinowFamily(fam), "Zmien skin", "Anuluj"); //zmie� dialogid
                
            }
            else if(GetPlayerJob(playerid) == JOB_MEDIC)
            {
                ShowPlayerDialogEx(playerid, DIALOGID_UNIFORM_FRAKCJA, DIALOG_STYLE_PREVIEW_MODEL, "Zmien skin frakcyjny", DialogListaSkinow(FRAC_ERS), "Zmien skin", "Anuluj"); //zmie� dialogid
            }
            else return SendClientMessage(playerid, COLOR_GRAD2, "Nie mo�esz tego u�y�.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD2, "Nie jeste� w sklepie z ubraniami obok ikonki ubrania lub na miejscu spawnu!");
			return 1;
		}
	}
	return 1;
}

//end
