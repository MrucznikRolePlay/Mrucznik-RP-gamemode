//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   zjedz                                                   //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
zjedz_OnDialogResponse(playerid, response, listitem)
{
    if(response)
    {
        new hp = 0;
        if(Cooking[playerid][ID] == 16 || Cooking[playerid][ID] == 18)
        {//Dolphin or Turtle
            PoziomPoszukiwania[playerid] += 1;
            SetPlayerCriminal(playerid,INVALID_PLAYER_ID, "Spo¿ywanie zagro¿onych gatunków");
        }
        if(Cooking[playerid][ID] == 31 && random(2) == 1) //wuhan bat
        {
            InfectPlayer(playerid, KORONAWIRUS);
            SendClientMessage(playerid, COLOR_RED, "Zarazi³eœ siê coronawirusem! Lepiej idŸ do lekarza.");
        }
        SetPlayerHealth(playerid, health + (Cooking[playerid][Weight]));
        hp = Cooking[playerid][Weight];
        format(string, sizeof(string), "* %s zjada %s.", sendername, Cooking[playerid][Name]);
        ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        format(string, sizeof(string), "* Zjad³eœ %s wa¿¹c¹ %d, dosta³eœ wiêcej ¿ycia.", Cooking[playerid][Name], hp);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        ClearCookingID(playerid, cookid);

        if(random(20) == 0) //5% szans na zatrucie
        {
            InfectPlayer(playerid, ZATRUCIE);
        }
    }
    return 1;
}

command_zjedz_Impl(playerid)
{
    new Float:health, string[256];
    if(GetPlayerHealth(playerid, health) > 80)
    {
        sendTipMessageEx(playerid, COLOR_GREY, "Twój poziom ¿ycia jest za wysoki, mo¿esz jeœæ od 80 HP !");
        return 1;
    }
    
    ShowPlayerDialog(playerid, DIALOG_EATING, DIALOG_STYLE_TABLIST_HEADERS, "Twoje potrawy", string, "Jedz", "Anuluj");
    return 1;
}

//end