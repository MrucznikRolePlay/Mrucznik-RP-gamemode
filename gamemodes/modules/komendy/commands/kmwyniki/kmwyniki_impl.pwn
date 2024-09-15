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
command_kmwyniki_Impl(playerid)
{
    new string[128];
    new kmName[MAX_PLAYER_NAME];
    new pName[MAX_PLAYER_NAME];

    if(!IsPlayerConnected(playerid))
    {
        return 1;
    }

    if(!komentator[playerid])
    {
        sendErrorMessage(playerid, "Nie jesteœ komentatorem!");
        return 1;
    }

    GetPlayerName(playerid, kmName, sizeof(kmName));

    format(string, sizeof(string), "Komentator %s: Podajê wyniki!", kmName);
    ProxDetectorW(300, -1106.9854, -966.4719, 129.1807, COLOR_P@, string);

    foreach(new p : Player)
    {
        if(zawodnik[p]) // je¿eli gracz jest zawodnikiem
        {
            GetPlayerName(playerid, pName);
            strreplace(pName, "_", " ", true);

            format(string, sizeof(string), "Komentator %s: Zawodnik %s - %d okr¹¿eñ.", kmName, pName, okregi[p]);
            ProxDetectorW(300, -1106.9854, -966.4719, 129.1807, COLOR_P@, string);
        }
    }
	
	return 1;
}

//end
