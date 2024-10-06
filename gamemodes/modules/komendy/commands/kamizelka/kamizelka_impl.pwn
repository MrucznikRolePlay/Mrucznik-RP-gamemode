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
command_kamizelka_Impl(playerid)
{
    new string[128];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        GetPlayerName(playerid, sendername, sizeof(sendername));
        if(IsAPolicja(playerid) || PlayerInfo[playerid][pMember] == 7 || PlayerInfo[playerid][pLider] == 7)
        {
            if (IsAtDutyPlace(playerid))
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
