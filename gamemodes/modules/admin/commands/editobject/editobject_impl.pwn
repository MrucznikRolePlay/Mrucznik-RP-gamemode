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
command_editobject_Impl(playerid, params[256])
{
    if(PlayerInfo[playerid][pAdmin] != 5000) return 1;
    SetPVarInt(playerid, "Allow-edit", 1);
    new id=-1;
    new comment[128];
    sscanf(params, "D(-1)S()[128]", id, comment);
    SetPVarString(playerid, "edit-object-comment", comment);
    if(id == -1) SelectObject(playerid);
    else
    {
        new Float:x, Float:y, Float:z;
        if(IsValidDynamicObject(id))
        {
            GetDynamicObjectPos(id, x, y, z);
            SetPlayerPos(playerid, x+0.2, y+0.2, z+0.5);
            EditDynamicObject(playerid, id);
            SendClientMessage(playerid, -1, "DYNAMIC");
         }
         else if(IsValidPlayerObject(playerid, id))
         {
            GetPlayerObjectPos(playerid, id, x, y, z);
            SetPlayerPos(playerid, x+0.2, y+0.2, z+0.5);
            SendClientMessage(playerid, -1, "PLAYER");
         }
    }
    return 1;
}

//end
