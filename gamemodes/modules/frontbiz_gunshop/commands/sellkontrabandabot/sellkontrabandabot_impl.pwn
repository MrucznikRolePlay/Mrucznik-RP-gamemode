//-----------------------------------------------<< Source >>------------------------------------------------//
//                                             sellkontrabandabot                                            //
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
// Autor: wiger
// Data utworzenia: 11.04.2025


//

//------------------<[ Implementacja: ]>-------------------
command_sellkontrabandabot_Impl(playerid, kontrabanda)
{
    if(kontrabanda < 1 || kontrabanda > 50000) 
    {
        sendErrorMessage(playerid, "Zakres od 1 do 50 000!");
        return 1;
    }

    if(GetContraband(playerid) < kontrabanda) 
    {
        sendErrorMessage(playerid, "Nie masz tyle kontrabandy!");
        return 1;
    }

    new bizId = IsAtFrontBusinessInteriorType(playerid, FRONT_BIZ_TYPE_GUNSHOP);
    if(bizId == -1)
    {
        MruMessageFail(playerid, "By sprzedaæ kontrabandê botowi, musisz znajdowaæ siê w gunshopie.");
        return 1;
    }

    new gsid = GetGsBot(bizId);
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, GS_MatsBot[gsid][0], GS_MatsBot[gsid][1], GS_MatsBot[gsid][2]))
    {
        MruMessageFail(playerid, "Znajdujesz siê za daleko od bota sprzedawcy broni.");
        return 1;
    }

    new org = FrontBusiness[bizId][Owner];

    if(GS_KontraCena[org] == 0) 
    {
        sendErrorMessage(playerid, "Sprzeda¿ kontrabandy u bota jest wy³¹czona!");
        return 1;
    }

    new cena = GS_KontraCena[org] * kontrabanda;
    if(Sejf_Rodziny[org] < cena) 
    {
        sendErrorMessage(playerid, "W sejfie nie ma tyle pieniêdzy!");
        return 1;
    }

    TakeContraband(playerid, kontrabanda);
    DajKase(playerid, cena);
    SejfR_AddContraband(org, kontrabanda);
    SejfR_Add(org, -cena);

    MruMessageGoodInfo(playerid, sprintf("Sprzeda³eœ botowi %i kontrabandy za $%i", kontrabanda, cena));
    SendOrgLeaderMessage(org, TEAM_AZTECAS_COLOR, sprintf("%s sprzeda³ botowi %i kontrabandy za $%i, nowy stan sejfu: %d$ i %d kontrabandy", 
        GetNick(playerid), kontrabanda, cena, Sejf_Rodziny[org], Rodzina_Contraband[org]));
    Log(payLog, INFO, "%s sprzeda³ botowi biznesu %s organizacji %s %d kontrabandy za $%d", GetPlayerLogName(playerid), GetFrontBizLogName(bizId), GetOrgLogName(org), kontrabanda, cena);
    return 1;
}

//end