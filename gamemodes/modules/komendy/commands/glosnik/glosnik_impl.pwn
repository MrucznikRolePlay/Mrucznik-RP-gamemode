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
command_glosnik_Impl(playerid)
{
    if(((PlayerInfo[playerid][pMember] == 9 && PlayerInfo[playerid][pRank] >= 3) || PlayerInfo[playerid][pLider] == 9) || (IsAClubBusinessOwner(playerid) && PlayerInfo[playerid][pRank] >= 3))
    {
        if(SanDuty[playerid] == 0 && PlayerInfo[playerid][pMember] == 9) return sendErrorMessage(playerid, "Musisz byæ na s³u¿bie San News");
		if(PlayerInfo[playerid][pMember] == 9)
		{
			if(SANradio == 0)
			{
				new bool:inpos=true;
				if(inpos)
				{
					ShowPlayerDialogEx(playerid, 765, DIALOG_STYLE_LIST, "Wybierz muzykê", "Lepa Station\nDisco polo\nDance100\nPrzeboje\nHip hop\nParty\nW³asna", "Wybierz", "Anuluj");
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
		else if(IsAClubBusinessOwner(playerid))
		{
			if(KLUBOWEradio == 0)
			{
				new bool:inpos=true;
				if(inpos)
				{
					ShowPlayerDialogEx(playerid, 768, DIALOG_STYLE_LIST, "Wybierz muzykê", "Lepa Station\nDisco polo\nDance100\nPrzeboje\nHip hop\nParty\nW³asna", "Wybierz", "Anuluj");
				}
			}
			else
			{
				DestroyDynamicObject(KLUBOWEradio);
				DestroyDynamic3DTextLabel(KLUBOWE3d);
				KLUBOWEradio = 0;
				foreach(new i : Player)
				{
					if(IsPlayerConnected(i))
					{
						if(IsPlayerInRangeOfPoint(playerid, 75.0, KLUBOWEx, KLUBOWEy, KLUBOWEz))
						{
							if(GetPVarInt(i, "kluboweaudio") == 1)
							{
								StopAudioStreamForPlayer(i);
								SetPVarInt(i, "kluboweaudio", 0);
							}
						}
					}
				}
				sendTipMessageEx(playerid, COLOR_GREY, "G³oœnik wy³¹czony!");
				StopAudioStreamForPlayer(playerid);
				return 1;
			}
		}
	}
	else
	{
	    sendErrorMessage(playerid, "Nie jesteœ z SAN News/Organizacji posiadaj¹cej biznes typu Klub, lub nie masz 3 rangi!");
	    return 1;
	}
    return 1;
}

//end
