//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              sprzedajmatsbot                                              //
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
// Data utworzenia: 18.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_sprzedajmatsbot_Impl(playerid, mats)
{
    if(mats < 1 || mats > 50000) 
    {
        sendErrorMessage(playerid, "Ilo�� od 1 do 50 000!");
        return 1;
    }

    if(PlayerInfo[playerid][pMats] < mats) 
    {
        sendErrorMessage(playerid, "Nie masz tyle materia��w!");
        return 1;
    }

    new bizId = IsAtFrontBusinessInteriorType(playerid, FRONT_BIZ_TYPE_GUNSHOP);
    if(bizId == -1)
    {
        MruMessageFail(playerid, "By sprzeda� materia�y botowi, musisz znajdowa� si� w gunshopie.");
        return 1;
    }

    if (!IsFrontBusinnesOwnedByPlayerOrg(playerid, bizId))
    {
        MruMessageFail(playerid, "Ten gunshop nie nale�y do twojej organizacji.");
        return 1;
    }

    new gsid = GetGsBot(bizId);
    if(!IsPlayerInRangeOfPoint(playerid, 5.0, GS_MatsBot[gsid][0], GS_MatsBot[gsid][1], GS_MatsBot[gsid][2]))
    {
        MruMessageFail(playerid, "Znajdujesz si� za daleko od bota sprzedawcy broni.");
        return 1;
    }

    new org = GetPlayerOrg(playerid);

    if(GS_MatsCena[org] == 0) 
    {
        sendErrorMessage(playerid, "Sprzeda� u bota jest wy��czona!");
        return 1;
    }

    new cena = GS_MatsCena[org] * mats;
    if(Sejf_Rodziny[org] < cena) 
    {
        sendErrorMessage(playerid, "W sejfie nie ma tyle pieni�dzy!");
        return 1;
    }

    PlayerInfo[playerid][pMats] -= mats;
    DajKase(playerid, cena);
    SejfR_AddMats(org, mats);
    SejfR_Add(org, -cena);

    MruMessageGoodInfo(playerid, sprintf("Sprzeda�e� botowi %i mats�w za $%i", mats, cena));
    SendOrgMessage(org, TEAM_AZTECAS_COLOR, sprintf("Diler broni %s sprzeda� botowi %i mats za $%i, nowy stan sejfu: %d$ i %d materia��w", 
        GetNick(playerid), mats, cena, Sejf_Rodziny[org], Rodzina_Mats[org]));
    Log(payLog, INFO, "Gracz %s sprzeda� botowi %d mats za $%d", GetPlayerLogName(playerid),  mats, cena);
    return 1;
}

//end