//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                     a                                                     //
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
// Data utworzenia: 15.09.2024


//

//------------------<[ Implementacja: ]>-------------------
command_kamizelka_Impl(playerid, params[256])
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        GetPlayerName(playerid, sendername, sizeof(sendername));
        if(IsAPolicja(playerid) || PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLider] == 7)
        {
            if (PlayerToPoint(3,playerid, -1674.8365, 866.0356, -52.4141)
			|| PlayerToPoint(3, playerid,255.3,77.4,1003.6)
            || PlayerToPoint(5, playerid, 266.7904,118.9303,1004.6172)
            || PlayerToPoint(3, playerid, 1579.6711,-1635.4512,13.5609) //STARE DUTY
            || PlayerToPoint(3, playerid, -2614.1667,2264.6279,8.2109)
            || PlayerToPoint(3, playerid, 2425.6,117.69,26.5)//nowe domy
            || PlayerToPoint(3, playerid, -1649.6832,885.4910,-45.4141)//nowe komi by dywan
            || PlayerToPoint(3, playerid, -1645.3046,895.2336,-45.4141)
			|| PlayerToPoint(3.5, playerid, 592.5598,-1477.5116,82.4736) //nowe FBI by Ubunteq
            || PlayerToPoint(5, playerid, 185.3000488281,-1571.0999755859,-54.5)//nowe domy
            || PlayerToPoint(5, playerid, 1189.5999755859,-1574.6999511719,-54.5 ) //nowe komi by dywan)
			|| IsPlayerInRangeOfPoint(playerid, 5.0, 254.1888,77.0841,1003.6406) 
            || IsPlayerInRangeOfPoint(playerid, 5.0, 2522.8916,-2441.6270,13.6435)
            || IsPlayerInRangeOfPoint(playerid, 5.0, 1527.2361,-1453.2623,67.8331)
			|| IsPlayerInRangeOfPoint(playerid, 5.0, 609.0364,-555.1090,19.4573))
            {
                if(OnDuty[playerid] == 1)
                {
                    if(kaska[playerid] < 10000) return sendErrorMessage(playerid, "Nie staæ ciê na kamizelke");
                    ZabierzKase(playerid, 10000);
                    sendTipMessageEx(playerid, COLOR_P@, "Zap³aci³eœ $10000 za kamizelkê - wpisz /dopasuj aby dopasowaæ."); 
                    format(string, sizeof(string), "* %s wyci¹ga z szafki i ubiera kamizelkê.", sendername);
                    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                    RunCommand(playerid, "/dopasuj",  "kamizelke");
                    SetPlayerArmour(playerid, 90);
                }
                else
                {
                    sendTipMessage(playerid, "Nie jesteœ na s³u¿bie!");
                }
            }
            else
            {
                sendTipMessage(playerid, "Nie jesteœ w szatni!");
                return 1;
            }
        }
        else
        {
            sendErrorMessage(playerid, "Nie jesteœ z PD!");
            return 1;
        }
    }
    return 1;
}

//end
