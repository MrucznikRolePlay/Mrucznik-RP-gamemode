//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  kuracja                                                  //
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
// Data utworzenia: 07.02.2020


//

//------------------<[ Implementacja: ]>-------------------
kuracja_akceptuj(playerid)
{
    new giveplayerid = GetPVarInt(playerid, "kuracja-doctorid");
    new uid = GetPVarInt(playerid, "kuracja-uid");
    new cost = GetPVarInt(playerid, "kuracja-cost");
    new commission = GetPVarInt(playerid, "kuracja-commission");
    new eDiseases:disease = eDiseases:GetPVarInt(playerid, "kuracja-disease");

    if(giveplayerid == INVALID_PLAYER_ID || !IsPlayerConnected(giveplayerid))
    {
        SendClientMessage(playerid, COLOR_GREY, "   Gracz, który oferowa³ Ci kuracjê, wyszed³ z gry.");
        return 1;
    }

    if(uid != PlayerInfo[giveplayerid][pUID]) 
    {
        SendClientMessage(playerid, COLOR_GREY, "   Gracz, który oferowa³ Ci kuracjê, wyszed³ z gry.");
        SetPVarInt(playerid, "kuracja-doctorid", INVALID_PLAYER_ID);
        return 1;
    }

    if (!ProxDetectorS(10.0, playerid, giveplayerid))
    {
        SendClientMessage(playerid, COLOR_GREY, "   Jesteœ za daleko !");
        return 1;
    }

    //body
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Akceptowa³eœ kuracjê %s, koszt %d$.", DiseaseData[disease][Name], cost));

    ZabierzKase(playerid, cost);
    DajKase(giveplayerid, commission);
    Sejf_Add(FRAC_ERS, cost-commission);
    Log(payLog, INFO, "%s zap³aci³ %s $%d (prowizja $%d) za kuracjê choroby %s", 
        GetPlayerLogName(playerid), GetPlayerLogName(giveplayerid), cost, commission, DiseaseData[disease][Name]
    );

    StartPlayerTreatment(playerid, disease);
}

command_kuracja_Impl(playerid, giveplayerid, disease[], money)
{
	if (!(IsAMedyk(playerid) && PlayerInfo[playerid][pRank] >= 2))
	{
		sendErrorMessage(playerid, "Nie masz 2 rangi lub nie jesteœ medykiem!");
        return 1;
	}

    new eDiseases:diseaseID = GetDiseaseID(disease);
    if(diseaseID == eDiseases:NONE) 
    {
        ShowDiseaseList(playerid);
        return 1;
    }
    
    if(!IsPlayerNear(playerid, giveplayerid))
    {
        sendErrorMessage(playerid, sprintf("Jesteœ zbyt daleko od gracza %s", GetNick(giveplayerid)));
        return 1;
    }

    if(money < 0) 
    {
        sendErrorMessage(playerid, "Prowizja musi byæ wiêksza ni¿ 0.");
        return 1;
    }

    if(IsPlayerTreated(giveplayerid)) 
    {
        sendErrorMessage(playerid, "Ten gracz ma ju¿ przeprowadzan¹ kuracjê.");
        return 1;
    }

    //TODO: Check czy gracz jest w szpitalu

    new cost = money + DiseaseData[diseaseID][CureCost];
    new currationTime = DiseaseData[diseaseID][CureTime];
    new chance = 100 - DiseaseData[diseaseID][DrugResistance];
    SendClientMessage(playerid, COLOR_LIGHTBLUE, sprintf("* Oferujesz %s %d minutow¹ kuracjê %s za $%d$ (prowizja %d$).", 
        GetNick(giveplayerid), currationTime, disease, cost, money
    ));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* %s oferuje Ci kuracjê choroby %s.", GetNick(playerid), disease));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* kuracja potrwa %d minut i bêdzie kosztowaæ %d$.", currationTime, cost));
    SendClientMessage(giveplayerid, COLOR_LIGHTBLUE, sprintf("* Szanse powodzenia kuracji to %d%%. wpisz /akceptuj kuracja aby siê zgodziæ.", chance));

    SetPVarInt(giveplayerid, "kuracja-doctorid", playerid);
    SetPVarInt(giveplayerid, "kuracja-uid", PlayerInfo[playerid][pUID]);
    SetPVarInt(giveplayerid, "kuracja-cost", cost);
    SetPVarInt(giveplayerid, "kuracja-commission", money);
    SetPVarInt(giveplayerid, "kuracja-disease", diseaseID);
    return 1;
}

//end