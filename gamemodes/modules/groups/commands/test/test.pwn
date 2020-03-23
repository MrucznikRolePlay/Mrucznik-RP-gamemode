//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                   test                                                    //
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ include ]>-------

//-------<[ initialize ]>-------
command_test()
{
    new command = Command_GetID("test");

    //permissions
    Group_SetGlobalCommand(command, true);
    

    //prefix
    
}

//-------<[ command ]>-------
YCMD:test(playerid, params[], help)
{
    new groupid = PlayerInfo[playerid][pGroup];
    new rankid = PlayerInfo[playerid][pRank];
    PermsInfo[groupid][rankid][GROUP_PERM_ARREST] = 1;
    SendClientMessage(playerid, -1, sprintf("Aresztowanie: %d, Cos tam: %d", PermsInfo[groupid][rankid][GROUP_PERM_ARREST], PermsInfo[groupid][rankid][GROUP_PERM_TEST]));
    return 1;
}

YCMD:test2(playerid, params[], help)
{
    PlayerInfo[playerid][pGroup] = 2;
    new groupid = PlayerInfo[playerid][pGroup];
    new rankid = PlayerInfo[playerid][pRank];
    PermsInfo[groupid][rankid][GROUP_PERM_ARREST] = 1;
    SendClientMessage(playerid, -1, sprintf("Aresztowanie: %d, Cos tam: %d", PermsInfo[groupid][rankid][GROUP_PERM_ARREST], PermsInfo[groupid][rankid][GROUP_PERM_TEST]));
    return 1;
}