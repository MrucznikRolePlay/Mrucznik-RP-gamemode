//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  frakcje                                                  //
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
// Autor: Mrucznik
// Data utworzenia: 15.05.2019
//Opis:
/*
	System frakcji.
*/

//

//-----------------<[ Callbacki: ]>-----------------
//-----------------<[ Funkcje: ]>-------------------
GetFractionMembersNumber(fractionid, bool:withOnDutyCheck)
{
	new membersNumber;
	foreach(new i : Player)
	{
		if(PlayerInfo[i][pMember] == fractionid || PlayerInfo[i][pLider] == fractionid)
		{
			if(withOnDutyCheck)
			{
				if(fractionid == FRAC_SN && SanDuty[i] == 0)
					continue;
				else if((fractionid == FRAC_LSPD || fractionid == FRAC_FBI || fractionid == FRAC_NG || fractionid == FRAC_BOR) && OnDuty[i] == 0)
					continue;
				else if( (fractionid == FRAC_ERS || fractionid == FRAC_GOV || fractionid == FRAC_KT) && JobDuty[i])
					continue;
			}
			membersNumber++;
		}
	}
	return membersNumber;
}


IsAnInstructor(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member==11)
		{
		    return 1;
		}
		if(leader==11)
		{
		    return 1;
		}
	}
	return 0;
}

IsAPolicja(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member==1 || member==2 || member==3)
		{
		    return 1;
		}
		else if(leader==1 || leader==2 || leader==3)
		{
		    return 1;
		}
	}
	return 0;
}

IsAHA(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member==8)
		{
		    return 1;
		}
		if(leader==8)
		{
		    return 1;
		}
	}
	return 0;
}

IsPlayerInFraction(playerid, frac, adminlvl=-1)
{
    new leader = PlayerInfo[playerid][pLider];
    new member = PlayerInfo[playerid][pMember];
    if(member==frac || leader == frac) return 1;
    else if(adminlvl != -1 && PlayerInfo[playerid][pAdmin] >= adminlvl) return 1;
	return 0;
}

IsAMedyk(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member==4)
		{
		    return 1;
		}
		if(leader==4)
		{
		    return 1;
		}
		if(GetPlayerJob(playerid) == JOB_MEDIC)
		{
			return 1;
		}
	}
	return 0;
}

IsAUrzednik(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member==11)
		{
		    return 1;
		}
		else if(leader==11 )
		{
		    return 1;
		}
	}
	return 0;
}

IsABOR(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member==7)
		{
		    return 1;
		}
		else if(leader==7 )
		{
		    return 1;
		}
	}
	return 0;
}

IsAPorzadkowy(playerid)
{
	return IsAPolicja(playerid) || IsAMedyk(playerid) || IsABOR(playerid);
}

IsAFBI(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    new leader = PlayerInfo[playerid][pLider];
	    new member = PlayerInfo[playerid][pMember];
	    if(member == 2)
		{
		    return 1;
		}
		if(leader == 2)
		{
		    return 1;
		}
	}
	return 0;
}


//-----------------<[ Timery: ]>-------------------
//------------------<[ MySQL: ]>--------------------

//end