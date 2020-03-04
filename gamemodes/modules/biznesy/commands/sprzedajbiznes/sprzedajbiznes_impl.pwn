//-----------------------------------------------<< Source >>------------------------------------------------//
//                                               sprzedajbiznes                                              //
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
// Data utworzenia: 19.08.2019


//

//------------------<[ Implementacja: ]>-------------------
command_sprzedajbiznes_Impl(playerid, giveplayerid, valueCost)
{
    new string[256];
    if(giveplayerid == playerid)
    {
        sendTipMessage(playerid, "Nie mo¿esz zaoferowaæ sprzeda¿y samemu sobie"); 
        return 1;
    }
    CorrectPlayerBusiness(playerid);
    if(ProxDetectorS(8.0, playerid, giveplayerid))
    {
        new businessID = GetNearestBusiness(playerid); 
        if(businessID == INVALID_BIZ_ID)
        {
            sendErrorMessage(playerid, "Nie jesteœ obok biznesu!");
            return 1;
        }
        if(PlayerInfo[playerid][pBusinessOwner] != businessID)
        {
            sendErrorMessage(playerid, "To nie jest twój biznes"); 
            return 1;
        }
        if(valueCost <= 0)
        {
            sendErrorMessage(playerid, "Nie mo¿esz sprzedaæ biznesu za ujemn¹ kwotê.");
            return 1;
        }

        if(kaska[giveplayerid] >= valueCost)
        {
            format(string, sizeof(string), "Wys³a³eœ ofertê do %s odnoœnie kupna biznesu [ID %d] za %d (-%d podatku)", 
                GetNickEx(giveplayerid), 
                businessID, 
                valueCost,
                valueCost/12
            );
            sendTipMessage(playerid, string);
            sendTipMessage(playerid, "Oczekuj na akceptacje"); 
            
            
            //do giveplayerid
            format(string, sizeof(string), "Gracz %s oferuje Ci kupno biznesu [ID: %d] za kwotê %d$, wpisz /akceptuj biznes", GetNickEx(playerid), businessID, valueCost); 
            sendTipMessage(giveplayerid, string); 
            SetPVarInt(giveplayerid, "Oferujacy_ID", playerid);
            SetPVarInt(giveplayerid, "Biznes_ID", PlayerInfo[playerid][pBusinessOwner]);
            SetPVarInt(giveplayerid, "Oferujacy_Cena", valueCost); 
        }
        else
        {
            sendTipMessage(playerid, "Ten gracz nie ma przy sobie takiej kwoty"); 
            return 1;
        }
    }
    else
    {
        sendErrorMessage(playerid, "Ten gracz nie znajduje siê obok Ciebie!"); 
        return 1;
    }
    
  
    return 1;
}

//end