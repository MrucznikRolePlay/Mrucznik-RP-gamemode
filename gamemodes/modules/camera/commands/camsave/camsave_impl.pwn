//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  camsave                                                  //
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
// Data utworzenia: 03.10.2024


//

//------------------<[ Implementacja: ]>-------------------
command_camsave_Impl(playerid, comment[128])
{
    new Float:camX, Float:camY, Float:camZ;
    new Float:vecX, Float:vecY, Float:vecZ;
    GetPlayerCameraPos(playerid, camX, camY, camZ);
    GetPlayerCameraFrontVector(playerid, vecX, vecY, vecZ);
    
    new File:file = fopen("camera.txt", io_append);
    if(file)
    {
        new buffer[256];
        if(strlen(comment) > 0)
        {
            format(buffer, sizeof(buffer), "// %s\n", comment);
            fwrite(file, buffer);
        }
        format(buffer, sizeof(buffer), "SetPlayerCameraPos(playerid, %.4f, %.4f, %.4f);\n", camX, camY, camZ);
        fwrite(file, buffer);
        format(buffer, sizeof(buffer), "SetPlayerCameraLookAt(playerid, %.4f, %.4f, %.4f);\n", camX + vecX, camY + vecY, camZ + vecZ);
        fwrite(file, buffer);
        fwrite(file, "\n");
        fclose(file);
        SendClientMessage(playerid, -1, "Camera position saved to scriptfiles/camera.txt");
    }
    else
    {
        SendClientMessage(playerid, -1, "Error: Could not open camera.txt for writing");
    }
    return 1;
}

//end