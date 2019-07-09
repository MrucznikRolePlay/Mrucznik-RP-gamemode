//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//--------------------------------------------------[ yo2 ]--------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:biz(playerid, params[], help)
{
    if(IsPlayerConnected(playerid))
    {
		new text[124], ID_BUSINESS;
		if( sscanf(params, "s[124]", text))
		{
			sendTipMessage(playerid, "U¿yj /biz [Text]");
			return 1;
		}
		CorrectPlayerBusiness(playerid);
		if(GetPlayerBusiness(playerid) == INVALID_BIZ_ID)
		{
			sendErrorMessage(playerid, "Nie jesteœ cz³onkiem ¿adnego biznesu!"); 
			return 1;
		}
		if(PlayerInfo[playerid][pBusinessOwner] >= 0)
		{
			ID_BUSINESS = PlayerInfo[playerid][pBusinessOwner]; 
		}
		if(PlayerInfo[playerid][pBusinessMember] >= 0)
		{
			ID_BUSINESS = PlayerInfo[playerid][pBusinessMember]; 
		}
		new string[256]; 
		
		format(string, sizeof(string), "%s mówi przez radio: %s", GetNick(playerid), text); 
		SendMessageToBiz(ID_BUSINESS, string, KOLOR_NIEBIESKI, 1);
		ProxDetector(10.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		format(string, sizeof(string), "Radio: %s", text);
		SetPlayerChatBubble(playerid,string,COLOR_YELLOW,10.0,8000);
	}
	return 1;
}
