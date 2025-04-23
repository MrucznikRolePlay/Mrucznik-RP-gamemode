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
command_scena_Impl(playerid)
{
    if(GetPlayerFraction(playerid) == FRAC_SN && PlayerInfo[playerid][pAdmin] < 1)
    {
        if(GetPVarInt(playerid, "scena-allow") != 1)
        {
            if(PlayerInfo[playerid][pRank] < 4) return sendTipMessageEx(playerid, COLOR_GRAD2, "Scena dost�pna za pozwoleniem admin�w i od 4 rangi!");
            else
            {
                if(GetPVarInt(playerid, "scena-req") == 1)
                {
                    new str[128];
                    format(str, 128, "��� Gracz %s (ID: %d) prosi o pozwolenie na zarz�dzanie scen�.", GetNick(playerid), playerid);
                    SendAdminMessage(COLOR_PANICRED, str);
                    SetPVarInt(playerid, "scena-req", 2);
                }
                else if(GetPVarInt(playerid, "scena-req") == 0)
                {
                    SendClientMessage(playerid, COLOR_RED, "Mo�esz tworzy� scen� za pozwoleniem administracji. Aby wys�a� zapytanie wpisz ponownie /scena");
                    SetPVarInt(playerid, "scena-req", 1);
                }
                else
                {
                    sendTipMessageEx(playerid, COLOR_RED, "Czekaj na akceptacj� administracji!");
                }
            }
        }
    }
    if(PlayerInfo[playerid][pAdmin] < 200 && GetPVarInt(playerid, "scena-allow") != 1) return 1;
    if(GetPlayerFraction(playerid) != FRAC_SN && SN_ACCESS[playerid] == 0)
    {
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_GETMONEY, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play", "Aby postawi� scen� w swoim zakresie musisz umie�ci� op�at�\nW sejf San News w wysoko�ci 2 milion�w!!!!\nJe�eli organizujesz event OOC zg�o� si� do lidera SN po pozwolenie na scen� (darmow�)", "Zap�a�", "Anuluj"); 
        return 1;
    }
    ShowPlayerDialogEx(playerid, SCENA_DIALOG_MAIN, DIALOG_STYLE_LIST, "Zarz�dzanie scen�", "Zbuduj scen� � Zniszcz scen�\nZarz�dzanie ekranem\nZarz�dzanie neonami\nDodatkowe efekty\nAudio URL\nMaszyny do dymu", "Wybierz", "Wyjdz");
    return 1;
}

//end
