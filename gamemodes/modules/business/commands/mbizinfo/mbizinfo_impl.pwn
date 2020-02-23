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
    new string[426];
    new value; 
    for(new i; i <= MAX_BIZ; i++)
    {
        if(value == loadedBiz)
        {
            sendErrorMessage(playerid, "Nie znajdujesz siê obok ¿adnego biznesu!"); 
            break;
        }
        if(BizExist(i))
        {
            if(IsPlayerInRangeOfPoint(playerid, 4.0, mBiz[i][b_enX], mBiz[i][b_enY], mBiz[i][b_enZ]))
            {
                format(string, sizeof(string), " \t{FF1493}%s\n{FFFFFF}W³aœciciel: {747b41}%s\n{FFFFFF}Typ: {747b41}%s\n{FFFFFF}Lokalizacja: {747b41}%s\n{FFFFFF}Cena: {747b41}$%d\n{FFFFFF}TID: {747b41}%d\n{FFFFFF}U1: {747b41}%d | {FFFFFF}U2: {747b41}%d | {FFFFFF}U3: {747b41}%d | {FFFFFF}U4: {747b41}%d | {FFFFFF}U5: {747b41}%d",
                GetBusinessName(i),
                GetBusinessOwnerName(i),
                GetTypeNameBiz(i),
                mBiz[i][b_Location],
                mBiz[i][b_cost],
                i,
                mBiz[i][b_ulepszenie1],
                mBiz[i][b_ulepszenie2],
                mBiz[i][b_ulepszenie3],
                mBiz[i][b_ulepszenie4],
                mBiz[i][b_ulepszenie5]);
                ShowPlayerDialogEx(playerid, BIZ_DIALOG_INFO, DIALOG_STYLE_MSGBOX, "nameToDialogs", string, "Okej", "");
                return 1; 
            }
            value++; 
        } 
    }
    return 1;
}

//end