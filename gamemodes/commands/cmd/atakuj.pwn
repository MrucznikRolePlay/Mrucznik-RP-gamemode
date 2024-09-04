//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ atakuj ]------------------------------------------------//
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

YCMD:atakuj(playerid, params[], help)
{
    if(ZONE_DISABLED == 1)
    {
        MSGBOX_Show(playerid, "Opcja_wylaczona", MSGBOX_ICON_TYPE_ERROR);
        return 1;
    }
    new frac = GetPlayerFraction(playerid);
    new fam = GetPlayerOrg(playerid);
    if(GetPlayerOrgType(playerid) == ORG_TYPE_GANG && PlayerInfo[playerid][pRank] > 3)
    {
        if(GetPVarInt(playerid, "zoneid") == -1) return sendTipMessageEx(playerid, -1, "Nie jestes na strefie.");
        if(ZoneAttack[GetPVarInt(playerid, "zoneid")])
        {
            MSGBOX_Show(playerid, "Wojna_aktualnie_trwa!", MSGBOX_ICON_TYPE_WARNING);
            return 1;
        }
        if(frac != 0)
        {
            if(!ZoneGangLimit[frac]) return MSGBOX_Show(playerid, "Limit_czasowy_trwa", MSGBOX_ICON_TYPE_ERROR);
            if(Zone_CheckPossToAttack(playerid, GetPVarInt(playerid, "zoneid")))
            {
                PoziomPoszukiwania[playerid] += 1;
                if(ZoneControl[GetPVarInt(playerid, "zoneid")] == 0)
                {
                    Zone_StartAttack(GetPVarInt(playerid, "zoneid"), frac, 0);
                }
                else
                {
                    Zone_StartAttack(GetPVarInt(playerid, "zoneid"), frac, ZoneControl[GetPVarInt(playerid, "zoneid")]);
                }
              //  SetPlayerCriminal(playerid, INVALID_PLAYER_ID, "Wojna gangów");
            }
        }
        else
        {
            if(!ZoneGangLimit[fam+100]) return MSGBOX_Show(playerid, "Limit_czasowy_trwa", MSGBOX_ICON_TYPE_ERROR);
            if(Zone_CheckPossToAttack(playerid, GetPVarInt(playerid, "zoneid")) && ZoneGangLimit[fam+100])
            {
                PoziomPoszukiwania[playerid] += 1;
                if(ZoneControl[GetPVarInt(playerid, "zoneid")] == 0)
                {
                    Zone_StartAttack(GetPVarInt(playerid, "zoneid"), fam+100, 0);
                }
                else
                {
                    Zone_StartAttack(GetPVarInt(playerid, "zoneid"), fam+100, ZoneControl[GetPVarInt(playerid, "zoneid")]);
                }
              //  SetPlayerCriminal(playerid, INVALID_PLAYER_ID, "Wojna gangów");
            }
        }
    }
    return 1;
}
