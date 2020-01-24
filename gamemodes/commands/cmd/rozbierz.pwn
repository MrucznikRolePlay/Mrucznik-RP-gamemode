//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ naucz ]-------------------------------------------------//
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

YCMD:rozbierz(playerid, params[], help)
{
    new string[128];
    new colorID; 

    if(isNaked[playerid])
    {
        SetPlayerSkinEx(playerid, PlayerInfo[playerid][pSkin]); 
        isNaked[playerid] = 0;
        format(string, sizeof(string), "%s ubiera siê.", GetNick(playerid)); 
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        return 1;
    }
    
    if( sscanf(params, "k<fix>", colorID))
    {
        sendTipMessage(playerid, "U¿yj /rozbierz [1 - bia³y || 2 - czarny]");
        return 1;
    }

    if(GetPlayerVirtualWorld(playerid) == 40 || PlayerInfo[playerid][pDomWKJ] != 0)
    {
        if(PlayerInfo[playerid][pSex] == 2)
        {
            if(colorID == 1)
            {
                SetPlayerSkinEx(playerid, 20109);
            }
            else
            {
                SetPlayerSkinEx(playerid, 20110); 
            }
        }
        else
        {
            if(colorID == 1)
            {
                SetPlayerSkinEx(playerid, 252);
            }
            else
            {
                SetPlayerSkinEx(playerid, 18); 
            }
        }
        format(string, sizeof(string), "%s rozbiera siê.", GetNick(playerid)); 
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        sendTipMessage(playerid, "Aby ubraæ siê spowrotem, ponownie u¿yj komendy /rozbierz.");
        isNaked[playerid] = 1; 
    }
    else
    {
        sendTipMessage(playerid, "Rozebraæ siê mo¿esz tylko w klubie ze striptizem i domu!"); 
    }
    return 1;
}
