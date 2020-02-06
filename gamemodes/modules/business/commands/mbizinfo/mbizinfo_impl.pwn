//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbizinfo                                                 //
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
// Data utworzenia: 05.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mbizinfo_Impl(playerid)
{
    if(GetPVarInt(playerid, "MozeUzycKomendyBiz") == 1)
    {
        sendErrorMessage(playerid, "Odczekaj 5 sekund!"); 
        return 1;
    }
    new string[250];
    for(new i; i <= MAX_BIZ; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]))
        {
            format(string, sizeof(string), "Nazwa: %s\nW³aœciciel: %s\nTyp: %s\nLokalizacja: %s\nCena: %d\ntID: %d",
            mBiz[i][b_Name],
            mBiz[i][b_Name_Owner],
            GetTypeNameBiz(i),
            mBiz[i][b_Location],
            mBiz[i][b_cost],
            i);
            ShowPlayerDialogEx(playerid, BIZ_DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Mrucznik Role Play", string, "Okej", "");
            break;  
        }  
    }
    return 1;
}

//end