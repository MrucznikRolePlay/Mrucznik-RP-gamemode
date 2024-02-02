//------------------------------------------<< Generated source >>-------------------------------------------//
//                                                    anim                                                   //
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
#include "lockdown_impl.pwn"

//-------<[ initialize ]>-------
command_lockdown()
{
    new command = Command_GetID("lockdown");

    //permissions
    Group_SetCommand(Group_GetID("admini"), command, true);
}

//-------<[ command ]>-------
YCMD:lockdown(playerid, params[], help)
{
    if (help)
    {
        sendTipMessage(playerid, "Komenda steruj¹ca weryfikacjami administracyjnymi.");
        return 1;
    }
    //fetching params
    new typLock;
    if(sscanf(params, "d", typLock))
    {
        sendTipMessage(playerid, "U¿yj /lockdown [typ]");
        if(PlayerInfo[playerid][pAdmin] >= 1) {
            sendTipMessage(playerid, "[0] Wy³¹czenie [1] W³¹czenie dla kont z 0h [2] W³¹czenie dla kont z mniej ni¿ 2h");
            sendTipMessage(playerid, "Ka¿de konto po /weryfikacja bêdzie mia³o 'przepustke' do czasu restartu serwera.");
            new string[128];
            format(string, sizeof(string), "Aktualny tryb lockdown: [%d]", Lockdown_Mode);
            sendTipMessage(playerid, string);
        }
        return 1;
    }
    if(typLock < 0 || typLock > 2)
    {
        sendErrorMessage(playerid, "Nie znaleziono typu lockdown przypisanego do tego numeru.");
        return 1;
    }
    //command body
    return command_lockdown_Impl(playerid, typLock);
}