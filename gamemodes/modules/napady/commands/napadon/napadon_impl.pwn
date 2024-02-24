//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    anim                                                    //
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
// Autor: Sanda³
// Data utworzenia: 17.02.2024


//

//------------------<[ Implementacja: ]>-------------------
command_napadon_Impl(playerid)
{
    
    if( PlayerInfo[playerid][pAdmin] > 0 || IsAScripter(playerid) )
    {
        if(Heist_HeistOFF == 1)
        {
            new string[256];
            Heist_HeistOFF = 0;
            format(string, sizeof(string), "%s [ID: %d] w³¹czy³ system napadów.", GetNickEx(playerid), playerid);
            ABroadCast(COLOR_PANICRED,string,1);
            SendCommandLogMessage(string);
            Log(adminLog, INFO, "%s manualnie w³¹czy³ system napadów.", GetPlayerLogName(playerid)); 
        }
        else if(Heist_BlockHeisting == 1)
        {
            new string[256];
            Heist_BlockHeisting = 0;
            Heist_Lost();
            format(string, sizeof(string), "%s [ID: %d] zresetowa³ system napadów.", GetNickEx(playerid), playerid);
            ABroadCast(COLOR_YELLOW,string,1);
            SendCommandLogMessage(string);
            Log(adminLog, INFO, "%s zresetowa³ system napadów.", GetPlayerLogName(playerid)); 
        }
        else
            sendTipMessage(playerid, "Napad w tym momencie jest mo¿liwy. Nie wykonano ¿adnej akcji.");
    }
    return 1;
}

//end