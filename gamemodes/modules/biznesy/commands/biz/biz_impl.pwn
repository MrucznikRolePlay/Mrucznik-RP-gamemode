//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                    biz                                                    //
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
command_biz_Impl(playerid, message[124])
{
	CorrectPlayerBusiness(playerid);
	new businessID = GetPlayerBusiness(playerid); 
	new string[256];
	if(businessID == INVALID_BIZ_ID)
	{
		sendErrorMessage(playerid, "Nie jesteœ cz³onkiem ¿adnego biznesu!"); 
		return 1;
	} 
	format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), message); 
	SendMessageToBiz(businessID, string, KOLOR_NIEBIESKI, 1);
	ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	format(string, sizeof(string), "Radio: %s", message);
	SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
    return 1;
}

//end