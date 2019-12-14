//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-----------------------------------------------[ przekaz ]-----------------------------------------------//
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
// Autor: Sanda³ / Gumbalowsky
// Data utworzenia: 14.12.2019

// Opis:
/*

*/


// Notatki skryptera:
/*
	
*/

YCMD:przekaz(playerid, params[], help)
{   
    new frac = GetPlayerFraction(playerid);
    new giveplayerid;
    new cuffedplayerid;
    new Float:przekaz_x, Float:przekaz_y, Float:przekaz_z;
    new string[128];
    cuffedplayerid = SkutyGracz[playerid];
    if(sscanf(params, "d<fix>", giveplayerid))
    {
        if((frac > 0 && frac <= 3) || frac == 7)
        {
            sendTipMessage(playerid, "U¿yj /przekaz [id]");
            return 1;
        }
        else
        {
            sendTipMessage(playerid, "Musisz byæ z organizacji porz¹dkowych!");
            return 1;
        }
    }
    if(!IsACop(giveplayerid) && OnDuty[giveplayerid] == 0)
	{
        sendTipMessage(playerid, "Gracz nie jest na s³u¿bie / nie jest funkcjonariuszem!");
        return 1;
    }
    if(PDkuje[cuffedplayerid] == playerid)
    {
        GetPlayerPos(playerid, przekaz_x, przekaz_y, przekaz_z);
        if(IsPlayerInRangeOfPoint(giveplayerid, 8.0, przekaz_x, przekaz_y, przekaz_z))
        {
            uzytekajdanki[playerid] = 0;
            uzytekajdanki[giveplayerid] = 1;
            PDkuje[cuffedplayerid] = giveplayerid;
            SkutyGracz[giveplayerid] = cuffedplayerid;
            SkutyGracz[playerid] = -1;
            sendTipMessage(playerid, "Przekaza³eœ skutego innemu funkcjonariuszowi.");
            sendTipMessage(giveplayerid, "Funkcjonariusz przekaza³ ci skutego!");
            format(string, sizeof(string), "* %s przekaza³ skutego %s dla %s", GetNick(playerid, true), GetNick(cuffedplayerid, true), GetNick(giveplayerid, true));
            ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
                                
            return 1;
        }
        else
        {
            sendTipMessage(playerid, "Funkcjonariusz nie stoi obok ciebie.");
            return 1;
        }  
    }
    else
    {
        sendTipMessage(playerid, "Nikogo nie masz skutego!");
         return 1;
    }
return 1;
}