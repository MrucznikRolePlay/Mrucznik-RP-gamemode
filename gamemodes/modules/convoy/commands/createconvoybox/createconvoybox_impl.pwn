//-----------------------------------------------<< Source >>------------------------------------------------//
//                                              createconvoybox                                              //
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
// Autor: Mrucznik
// Data utworzenia: 20.10.2019


//

//------------------<[ Implementacja: ]>-------------------
command_createconvoybox_Impl(playerid)
{
    if(PlayerInfo[playerid][pAdmin] < 5000)
    {
        noAccessMessage(playerid);
        return 1;
    }

    new Float:x, Float:y, Float:z, Float:ang;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, Float:ang);

    new boxid, bonus = random(BOX_BONUS)+BOX_BONUS_BASE;
    if(IsPlayerInAnyVehicle(playerid)) {
        boxid = DropBoxFromCar(CONVOY_BOX_OBJECT, BOX_TYPE_CONVOY, bonus, GetPlayerVehicleID(playerid));
    } else {
        boxid = CreateBox(CONVOY_BOX_OBJECT, BOX_TYPE_CONVOY, bonus, x, y, z-0.7, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid), ang);
    }
    if(boxid == -1) return SendClientMessage(playerid, -1, "Brak miejsca");
    SendClientMessage(playerid, -1, sprintf("Stworzy�e� box o id %d", boxid));

    Log(adminLog, INFO, "Admin %s stworzy� box konwojowy", 
        GetPlayerLogName(playerid)
    );
    return 1;
}

//end