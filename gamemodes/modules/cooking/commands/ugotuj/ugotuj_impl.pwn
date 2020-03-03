//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   ugotuj                                                  //
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
// Data utworzenia: 03.03.2020


//

//------------------<[ Implementacja: ]>-------------------
ugotuj_OnDialogResponse(playerid, listitem)
{
    new name[MAX_COOKED_NAME], model;
    new type = DynamicGui_GetValue(playerid, listitem);
    new weight = DynamicGui_GetDataInt(playerid, listitem);
    if(type < 30) 
    {//fishes
        format(name, sizeof(name), "%s", FishNames[type]);
        model = FishModels[type];
    }
    else 
    {//meals
        format(name, sizeof(name), "%s", MealNames[type-30]);
        model = MealModels[type-30];
    }

    MruMySQL_AddCookedMeal(playerid, model, name, weight, type);

    SendClientMessage(playerid,COLOR_LIGHTBLUE, sprintf("* Ugotowa³es potrawê: %s, wa¿¹c¹ %dg.",
        name, weight   
    ));
}

AddCookingFishRow(playerid, string[], id, weight)
{
    strcat(string, sprintf("%i\t%s\n", FishModels[id], FishNames[id]), MAX_COOKED_NAME);
    DynamicGui_AddRow(playerid, id, weight);
}

AddCookingRow(playerid, string[], id, weight)
{
    strcat(string, sprintf("%i\t%s\n", MealModels[id-30], MealNames[id-30]), MAX_COOKED_NAME);
    DynamicGui_AddRow(playerid, id, weight);
}

command_ugotuj_Impl(playerid)
{
    if(!IsAtCookPlace(playerid))
    {
        sendErrorMessage(playerid, "Nie jesteœ w miejscu przeznaczonym do gotowania (Cluckin Bell / Burger Shot / Pizzeria).");
        return 1;
    }

    new string[256];
    DynamicGui_Init(playerid);
    if(Fishes[playerid][pWeight1] < 1) AddCookingFishRow(playerid, string, Fishes[playerid][pFid1], Fishes[playerid][pWeight1]);
    if(Fishes[playerid][pWeight2] < 1) AddCookingFishRow(playerid, string, Fishes[playerid][pFid2], Fishes[playerid][pWeight2]);
    if(Fishes[playerid][pWeight3] < 1) AddCookingFishRow(playerid, string, Fishes[playerid][pFid3], Fishes[playerid][pWeight3]);
    if(Fishes[playerid][pWeight4] < 1) AddCookingFishRow(playerid, string, Fishes[playerid][pFid4], Fishes[playerid][pWeight4]);
    if(Fishes[playerid][pWeight5] < 1) AddCookingFishRow(playerid, string, Fishes[playerid][pFid5], Fishes[playerid][pWeight5]);
    if(Groceries[playerid][pChicken] != 0) AddCookingRow(playerid, string, 30, Groceries[playerid][pChicken]);
    if(Groceries[playerid][pPizza] != 0) AddCookingRow(playerid, string, 31, Groceries[playerid][pPizza]);
    if(Groceries[playerid][pHamburger] != 0) AddCookingRow(playerid, string, 32, Groceries[playerid][pHamburger]);
    if(Groceries[playerid][pWuhanBat] != 0) AddCookingRow(playerid, string, 33, Groceries[playerid][pWuhanBat]);

    if(strlen(string) < 2) 
    {
        sendErrorMessage(playerid, "Nie masz nic do ugotowania.");
        return 1;
    }
    string[strlen(string)-1] = '\0';

    ShowPlayerDialog(playerid, DIALOG_COOKING, DIALOG_STYLE_PREVIEW_MODEL, "Dostêpne do ugotowania", string, "Ugotuj", "Anuluj");
    return 1;
}

//end