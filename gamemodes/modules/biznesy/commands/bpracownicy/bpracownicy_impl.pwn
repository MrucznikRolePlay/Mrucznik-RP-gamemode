//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                bpracownicy                                                //
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
// Autor: Simeone
// Data utworzenia: 19.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_bpracownicy_Impl(playerid)
{
    new string[256];
    if(IsALeaderBusiness(playerid))
    {
        sendTipMessageEx(playerid, COLOR_GREEN, "=========[Pracownicy Biznesu On-Line]=========");
        foreach(new i : Player)
        {
            if(PlayerInfo[i][pBusinessMember] == PlayerInfo[playerid][pBusinessOwner])
            {
                format(string, sizeof(string), "> %s [%d] <", GetNick(i), i); 
                SendClientMessage(playerid, COLOR_WHITE, string); 
            }
        }
        sendTipMessageEx(playerid, COLOR_GREEN, "=========[Koniec Pracowników On-Line]=========");
    }else{
        sendErrorMessage(playerid, "Nie jesteœ liderem biznesu!"); 
    }
    return 1;
}

//end