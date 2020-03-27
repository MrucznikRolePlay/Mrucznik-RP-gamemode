//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                 wypuscrybe                                                //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
command_wypuscrybe_Impl(playerid, fishid)
{
    if(fishid < 1 || fishid > 5) { sendTipMessageEx(playerid, COLOR_GREY, "Numer ryby od 1 do 5 !"); return 1; }
    else if(fishid == 1 && PlayerFishes[playerid][pWeight1] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(1) !"); return 1; }
    else if(fishid == 2 && PlayerFishes[playerid][pWeight2] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(2) !"); return 1; }
    else if(fishid == 3 && PlayerFishes[playerid][pWeight3] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(3) !"); return 1; }
    else if(fishid == 4 && PlayerFishes[playerid][pWeight4] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(4) !"); return 1; }
    else if(fishid == 5 && PlayerFishes[playerid][pWeight5] < 1) { SendClientMessage(playerid, COLOR_GREY, "   Nie z³owi³eœ ¿adnej ryby pod numerem(5) !"); return 1; }
    ClearFishID(playerid, fishid);
    PlayerFishes[playerid][pLastFish] = 0;
    PlayerFishes[playerid][pFishID] = 0;
    SendClientMessage(playerid, COLOR_GREY, sprintf("* Wypuœci³eœ rybkê pod numerem [%d] *", fishid));
    return 1;
}

//end