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
command_kupskin_Impl(playerid, params[256])
{
    if(IsPlayerConnected(playerid))
    {
        if(IsAtClothShop(playerid))
        {
			DialogKupSkin(playerid);
			return 1;
		}
	}
	return 1;
}

DialogKupSkin(playerid)
{
	static string[sizeof(ShopSkins) * 20];
	if(isnull(string)) {
        for(new i; i<sizeof(ShopSkins); i++)  {
			if(ShopSkins[i][SKIN_TYPE] == SKIN_TYPE_DEFAULT) {
            	strcat(string, sprintf("%d\t~g~$%d\n", ShopSkins[i][SKIN_ID], ShopSkins[i][SKIN_PRICE]));
			}
        }
		string[strlen(string)-1] = '\0';
	}

	ShowPlayerDialogEx(playerid, DIALOG_KUPSKIN, DIALOG_STYLE_PREVIEW_MODEL, "Skiny do kupienia", string, "Kup", "Wyjdz");
}

//end
