//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ fskin ]-------------------------------------------------//
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

CMD:mundur(playerid) return cmd_fskin(playerid);
CMD:uniform(playerid) return cmd_fskin(playerid);
CMD:fskin(playerid)
{
    if(IsPlayerConnected(playerid))
    {
		if (IsAtClothShop(playerid) || (GetPlayerOrg(playerid) == FAMILY_RSC && IsPlayerInRangeOfPoint(playerid, 4.0, 1636.9476,-1813.6195,13.5263)) || IsPlayerInRangeOfPoint(playerid, 4.0, GetPVarFloat(playerid,"xposspawn"),GetPVarFloat(playerid,"yposspawn"),GetPVarFloat(playerid,"zposspawn")))
		{
            //W³¹czenie trybu skinów
            if(GetPVarInt(playerid, "skin-select") != 0) return DestroySkinSelection(playerid);
            SetPVarInt(playerid, "skin-select", 1);
            new frac = GetPlayerFraction(playerid);
            new fam = GetPlayerOrg(playerid);
            if(frac != 0)
            {
                if(!ProceedSkinSelection(playerid,frac, 1)) return SendClientMessage(playerid, COLOR_GRAD2, "Twoja frakcja nie ma w³asnych skinów.");
            }
            else if(fam != 0)
            {
                if(!ProceedSkinSelection(playerid,fam, 2)) return SendClientMessage(playerid, COLOR_GRAD2, "Twoja rodzina nie ma w³asnych skinów.");
            }
            else return SendClientMessage(playerid, COLOR_GRAD2, "Nie mo¿esz tego u¿yæ.");
		}
		else
		{
			SendClientMessage(playerid, COLOR_GRAD2, "Nie jesteœ w sklepie z ubraniami lub na miejscu spawnu!");
			return 1;
		}
	}
	return 1;
}

