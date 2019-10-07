//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   dolacz                                                  //
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
// Data utworzenia: 07.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_dolacz_Impl(playerid)
{
    new jobPosID; 
    if(GetPlayerJobID(playerid) != JOB_DEFAULT)
    {
        sendErrorMessage(playerid, "Posiadasz ju¿ jak¹œ pracê!"); 
        sendTipMessage(playerid, "Wpisz /quitjob - aby zerwaæ kontrakt poprzedniej pracy!"); 
        return 1;
    }
    if(!IsPlayerInJobPoint(playerid, 5.0))
    {
        sendErrorMessage(playerid, "Nie jesteœ w miejscu, w którym otrzymaæ pracê dorywcz¹!"); 
        sendTipMessage(playerid, "Wpisz /prace - aby wyœwietliæ listê dostêpnych na serwerze prac dorywczych."); 
        return 1;
    }
    if(PlayerInfo[playerid][pMember] > 0 || PlayerInfo[playerid][pLider] > 0)
    {
        sendErrorMessage(playerid, "Jako cz³onek organizacji nie mo¿esz wzi¹æ pracy dorywczej!"); 
        return 1;
    }
    if(PlayerInfo[playerid][pDowod] != 1)
    {
        sendErrorMessage(playerid, "Nie posiadasz dowodu osobistego!");
        sendTipMessage(playerid, "Dowód osobisty mo¿esz nabyæ w Urzêdzie Miasta Los Santos"); 
        return 1;
    }
    jobPosID = GetJobPointFromPlayerPos(playerid); 
    if(jobPosID == JOB_DEFAULT)
    {
        sendErrorMessage(playerid, "Wyst¹pi³ b³¹d!"); 
    }
    if(playerInputDolacz[playerid] == 0)
    {
        ShowArgForJob(playerid, jobPosID); 
        sendTipMessage(playerid, "Wpisz ponownie /dolacz, je¿eli akceptujesz powy¿ej przedstawione warunki!"); 
        playerInputDolacz[playerid] = 1;
        return 1;
    }
    if(!CheckArgForJob(playerid, jobPosID))
    {
        sendErrorMessage(playerid, "Nie spe³niasz wszystkich podanych warunków!"); 
        return 1;
    }
    SetPlayerJob(playerid, jobPosID); 
    SendClientMessage(playerid, COLOR_P@, "Gratulacje! W³aœnie podpisa³eœ kontrakt w nowej pracy!"); 
    playerInputDolacz[playerid] = 0; 
    return 1;
}

//end