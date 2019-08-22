//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    obiz                                                   //
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
// Data utworzenia: 20.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_obiz_Impl(playerid, text[124])
{
    new ID_BUSINESS;
    CorrectPlayerBusiness(playerid);
    if(GetPlayerBusiness(playerid) == INVALID_BIZ_ID)
    {
        sendErrorMessage(playerid, "Nie jesteœ cz³onkiem ¿adnego biznesu!"); 
        return 1;
    }
    new string[256]; 
    ID_BUSINESS = GetPlayerBusiness(playerid); 
    format(string, sizeof(string), "%s [%d]: %s", GetNick(playerid), playerid,  text); 
    SendMessageToBiz(ID_BUSINESS, string, KOLOR_NIEBIESKI, 0);
	Log(chatLog, INFO, "%s biznes chat OOC: %s", GetPlayerLogName(playerid), text);
    return 1;
}

//end