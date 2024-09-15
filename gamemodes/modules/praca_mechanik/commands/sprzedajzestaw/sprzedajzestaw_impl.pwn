//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               sprzedajzestaw                                              //
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
// Data utworzenia: 01.04.2024


//

//------------------<[ Implementacja: ]>-------------------
command_sprzedajzestaw_Impl(playerid, giveplayerid)
{
	if(PlayerInfo[playerid][pJob] != 7)
    {
        MruMessageFail(playerid, "Nie jesteœ mechanikiem lub pracownikiem warsztatu.");
        return 1;
    }

    if(GetDistanceBetweenPlayers(playerid, giveplayerid) > 8)
    {
        MruMessageFail(playerid, "Gracz jest za daleko.");
        return 1;
    }

    if(SpamujeMechanik[playerid] != 0)
    {
        MruMessageFail(playerid, "Poczekaj 10 sekund przed ponownym u¿yciem komendy.");
        return 1;
    }

    if(playerid == giveplayerid) 
    { 
        MruMessageFail(playerid, "Nie mo¿esz sprzedaæ zestawu naprawczego samemu sobie!"); 
        return 1; 
    }

    if(PlayerInfo[giveplayerid][pFixKit] >= 3) 
    {
        MruMessageFail(playerid, "Ten gracz posiada maksymaln¹ iloœæ zestawów");
        return 1;
    }

    SetPVarInt(giveplayerid, "FixKitOffer", playerid);

    MruMessageGoodInfoF(playerid, "Proponujesz %s kupno zestawu za 15000$.", GetNick(giveplayerid));
    MruMessageGoodInfoF(giveplayerid, "Mechanik %s proponuje Ci kupno zestawu za 15000$. Wpisz /akceptuj zestaw, by zaakceptowaæ.", GetNick(playerid));
    
    SetTimerEx("AntySpamTimer",10000,0,"d",playerid);
    AntySpam[playerid] = 1;
    return 1;
}

command_sprzedajzestaw_accept(playerid)
{
    new id = GetPVarInt(playerid, "FixKitOffer");
    
    if(id == -1)
    {
        SendClientMessage(playerid, -1, "Nikt nie oferowa³ ci zestawu naprawczego!");
        return 1;
    }
    if(!IsPlayerConnected(id))
    {
        SetPVarInt(playerid, "FixKitOffer", -1);
        SendClientMessage(playerid, -1, "Gracz, który oferowa³ ci zestaw naprawczy wyszed³ z serwera!");
        return 1;
    }
    if(kaska[playerid] < 15000)
    {
        SendClientMessage(id, -1, "Ten gracz nie ma tyle kasy");
        SendClientMessage(playerid, -1, "Nie masz wystarczaj¹cej iloœci pieniêdzy");
        return 1;
    }
    if(!ProxDetectorS(10.5, playerid, id))
    {
        SendClientMessage(playerid, -1, "Jesteœ za daleko od mechanika, który oferowa³ ci zestaw.");
        return 1;
    }

    SendClientMessage(id, 0x0080D0FF, sprintf("%s kupi³ od Ciebie zestaw naprawczy. Otrzymujesz 15000$", GetNick(playerid)));
    SendClientMessage(playerid, 0x00FF00FF, sprintf("Kupi³eœ zestaw od mechanika %s za 15000$", GetNick(id)));
    ZabierzKase(playerid, 15000);
    DajKase(id, 15000);
    PlayerInfo[playerid][pFixKit]++;
    PlayerInfo[id][pMechSkill]++;
    if(PlayerInfo[id][pMechSkill] == 50)
    { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 2, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
    else if(PlayerInfo[id][pMechSkill] == 100)
    { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 3, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
    else if(PlayerInfo[id][pMechSkill] == 200)
    { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 4, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
    else if(PlayerInfo[id][pMechSkill] == 400)
    { SendClientMessage(id, COLOR_YELLOW, "* Twoje umiejêtnoœci Mechanika wynosz¹ 5, Mo¿esz teraz tankowaæ graczom wiêcej paliwa za jednym razem."); }
    
    SetPVarInt(playerid, "FixKitOffer", -1);
    return 1;
}

//end