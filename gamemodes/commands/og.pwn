//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//---------------------------------------------------[ og ]--------------------------------------------------//
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

CMD:advertise(playerid, params[]) return cmd_og(playerid, params);
CMD:ad(playerid, params[]) return cmd_og(playerid, params);
CMD:ogloszenie(playerid, params[]) return cmd_og(playerid, params);
CMD:og(playerid, params[])
{
    new string[256];
    new sendername[MAX_PLAYER_NAME];

    if(IsPlayerConnected(playerid))
    {
        if(gPlayerLogged[playerid] == 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie jesteœ zalogowany!");
            return 1;
        }
        if(PlayerInfo[playerid][pPnumber] == 0)
        {
            SendClientMessage(playerid, COLOR_GREY, "Nie masz telefonu. Kup go w 24/7 !");
            return 1;
        }
        GetPlayerName(playerid, sendername, sizeof(sendername));
        if(isnull(params))
        {
            SendClientMessage(playerid, COLOR_GRAD2, "U¯YJ: (/og)loszenie [tekst og³oszenia]");
            return 1;
        }
        if (strfind(params , "ip:" , true)>=0 ||strfind(params , "www." , true)>=0 || strfind(params , ".pl" , true)>=0 || strfind(params , "serw" , true)>=0  || strfind(params , "serv" , true)>=0 || strfind(params , ":7" , true)>=0 || strfind(params , ":2" , true)>=0 || strfind(params , ":3" , true)>=0 || strfind(params , ":4" , true)>=0 || strfind(params , ":5" , true)>=0 || strfind(params , ":6" , true)>=0 || strfind(params , ":8" , true)>=0)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "NIE CHCEMY REKLAM!");
            format(string, sizeof(string), "AdmWarning: [%d] %s REKLAMA: %s.",playerid,sendername,params);
            ABroadCast(COLOR_LIGHTRED,string,1);
            CzitLog(string);
        }
        else if (strfind(params , "jeb" , true)>=0 ||strfind(params , "huj" , true)>=0 || strfind(params , "pizda" , true)>=0 || strfind(params , "pizdy" , true)>=0  || strfind(params , "kurwa" , true)>=0 || strfind(params , "kutas" , true)>=0 || strfind(params , "dupa" , true)>=0 || strfind(params , "cipa" , true)>=0 || strfind(params , "cipka" , true)>=0 || strfind(params , "n00b" , true)>=0 || strfind(params , "noob" , true)>=0 || strfind(params , "n0b" , true)>=0)
        {
            SendClientMessage(playerid, COLOR_GRAD2, "Zosta³eœ ukarany kar¹ 10 000$ dolarów za umieszczanie wulgarnych og³oszeñ!");
            format(string, sizeof(string), "AdmWarning: [%d] %s Wulgarne og³oszenie (kara -10 000$): %s.",playerid,sendername,params);
            DajKase(playerid, -10000);
            ABroadCast(COLOR_LIGHTRED,string,1000);
            WarningLog(string);
        }
        else
        {
            if(PlayerInfo[playerid][pBP] >= 1)
            {
                format(string, sizeof(string), "Nie mo¿esz napisaæ na tym czacie, gdy¿ masz zakaz pisania na globalnych czatach! Minie on za %d godzin.", PlayerInfo[playerid][pBP]);
                SendClientMessage(playerid, TEAM_CYAN_COLOR, string);
                return 1;
            }
            if ((!adds) && PlayerInfo[playerid][pDonateRank] < 2 && PlayerInfo[playerid][pAdmin] < 1)
            {
                format(string, sizeof(string), "Spróbuj póŸniej, %d sekund miêdzy og³oszeniami !",  (addtimer/1000));
                SendClientMessage(playerid, COLOR_GRAD2, string);
                return 1;
            }
            new payout = strlen(params) * 25;
            if(kaska[playerid] < payout)
            {
                format(string, sizeof(string), "* U¿y³eœ %d znaków i masz zap³aciæ $%d, nie posiadasz a¿ tyle.", strlen(params), payout);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                return 1;
            }
            DajKase(playerid, - payout);
            format(string, sizeof(string), "Og³oszenie: %s, Kontakt: %s Tel: %d",  params, GetNick(playerid, true), PlayerInfo[playerid][pPnumber]);
            OOCNews(TEAM_GROVE_COLOR,string);
            format(string, sizeof(string), "~r~Zaplaciles $%d~n~~w~Za: %d Znakow", payout, strlen(params));
            GameTextForPlayer(playerid, string, 5000, 5);
            if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pDonateRank] < 2)
            {
                SetTimer("AddsOn", addtimer, 0);adds = 0;
            }
        }
    }
    return 1;
}

