//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   kuporg                                                  //
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
// Data utworzenia: 07.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kuporg_Impl(playerid, color, name[34])
{
    if(kaska[playerid] < CREATE_ORG_COST)
    {
        MruMessageFail(playerid, "Stworzenie organizacji kosztuje "#CREATE_ORG_COST"$, a Ty tyle nie masz.");
        return 1;
    }

    if(GetContraband(playerid) < CREATE_ORG_CONTRABAND_COST)
    {
        MruMessageFail(playerid, "Stworzenie organizacji kosztuje "#CREATE_ORG_CONTRABAND_COST" kontrabandy, a Ty tyle nie masz.");
        return 1;
    }

    new org = GetFreeOrgSlot();
    if(org <= 0)
    {
        MruMessageFail(playerid, "Aktualnie nie ma wolnego slotu na organizacje.");
        return 1;
    }

    if(GetPlayerFraction(playerid) != 0 || GetPlayerOrg(playerid) != 0)
    {
        MruMessageFail(playerid, "By zostaæ liderem organizacji nie mo¿esz byæ we frakcji/organizacji.");
        return 1;
    }

    new job = GetPlayerJob(playerid);
    if(job != 0 && !IsAJobForAll(job) && !IsACrimeJob(playerid, job))
    {
        MruMessageFail(playerid, "By zostaæ liderem organizacji nie mo¿esz byæ w legalnej pracy.");
        return 1;
    }

    if(strlen(name) > MAX_ORG_NAME_LENGTH)
    {
        MruMessageFail(playerid, "Nazwa organizacji nie mo¿e byæ d³u¿sza ni¿ "#MAX_ORG_NAME_LENGTH" znaki.");
        return 1;
    }

    if(color <= 0x0 || color >= 0xFFFFFF)
    {
        MruMessageFail(playerid, "  Niepoprawny kolor, zakres od 0 do FFFFFF.");
        return 1;
    }

    CreateOrganisation(org, name, (color << 8) | 0x000000FF);
    InvitePlayerToOrg(playerid, org, MAIN_LEADER_RANK);

    ZabierzKase(playerid, CREATE_ORG_COST);
    TakeContraband(playerid, CREATE_ORG_CONTRABAND_COST);

    MruMessageGoodInfoF(playerid, "Gratulacje! Stworzy³eœ now¹ organizacjê o nazwie \"%s\"", name);
    MruMessageGoodInfo(playerid, "Ka¿dego dnia z sejfu organizacji pobierana jest kwota "#ORG_DAILY_COST"$ za prowadzenie organizacji i "#ORG_DAILY_MEMBER_COST"$ za ka¿dego pracownika.");
    MruMessageGoodInfo(playerid, "UWAGA! Pilnuj by d³ug w sejfie Twojej organizacji nie przekroczy³ -100 000$, inaczej Twoja organizacja zostanie usuniêta!");
    MruMessageGoodInfo(playerid, "Aby zobaczyæ dostêpne komendy wpisz /liderpomoc.");
    return 1;
}

//end