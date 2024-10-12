//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  gotobiz                                                  //
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
command_gotobiz_Impl(playerid, businessID)
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(businessID > BusinessLoaded || businessID < 0)
        {
            sendErrorMessage(playerid, "Nie ma takiego biznesu!"); 
            return 1;
        }
        SetPlayerPos(playerid, Business[businessID][b_enX], Business[businessID][b_enY], Business[businessID][b_enZ]); 
        SetPlayerVirtualWorld(playerid, Business[businessID][b_enVw]);
        SetPlayerInterior(playerid, Business[businessID][b_enInt]);
        sendTipMessage(playerid, "Teleportowano Ciê do biznesu!"); 
    }
    else
    {
        noAccessMessage(playerid);
    }
    return 1;
}

//end