//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//------------------------------------------------[ glosnik ]------------------------------------------------//
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

YCMD:glosnik(playerid, params[], help)
{
    if((PlayerInfo[playerid][pMember] == 9 && PlayerInfo[playerid][pRank] >= 3) || PlayerInfo[playerid][pLider] == 9 || (GetPlayerOrg(playerid) == 19 && IsPlayerInRangeOfPoint(playerid, 75.0 , 578.6193,-2195.7708,1.6288) && PlayerInfo[playerid][pRank] >= 3) || (GetPlayerOrg(playerid) == FAMILY_IBIZA && PlayerInfo[playerid][pRank] >= 6))
    {
        if(SanDuty[playerid] == 0 && PlayerInfo[playerid][pMember] == 9) return sendErrorMessage(playerid, "Musisz byæ na s³u¿bie San News");
		if(SANradio == 0)
		{
            new bool:inpos=true;
		    if(inpos)
		    {
		        ShowPlayerDialogEx(playerid, 765, DIALOG_STYLE_LIST, "Wybierz muzykê", "Mrucznik Radio 1\nMrucznik Radio 2\nDisco polo\nDance100\nPrzeboje\nHip hop\nParty\nW³asna", "Wybierz", "Anuluj");
		    }
		}
		else
		{
		    DestroyDynamicObject(SANradio);
			DestroyDynamic3DTextLabel(SAN3d);
		    SANradio = 0;
		    foreach(new i : Player)
	        {
	            if(IsPlayerConnected(i))
	            {
                    if(IsPlayerInRangeOfPoint(playerid, 75.0, SANx, SANy, SANz))
					{
                        if(GetPVarInt(i, "sanaudio") == 1)
                        {
                            StopAudioStreamForPlayer(i);
                            SetPVarInt(i, "sanaudio", 0);
                        }
					}
	            }
	        }
            sendTipMessageEx(playerid, COLOR_GREY, "G³oœnik wy³¹czony!");
            StopAudioStreamForPlayer(playerid);
	    	return 1;
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ z SAN News/Ibizy!");
	    return 1;
	}
    return 1;
}
