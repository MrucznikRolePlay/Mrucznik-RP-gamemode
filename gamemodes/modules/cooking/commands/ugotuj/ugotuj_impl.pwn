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

    //TODO: refactor koniecznie
    if(type < 30) //fishes
    {
        new slot = type;
        switch(slot)
        {
            case 1: { type=Fishes[playerid][pFid1]; }
            case 2: { type=Fishes[playerid][pFid2]; }
            case 3: { type=Fishes[playerid][pFid3]; }
            case 4: { type=Fishes[playerid][pFid4]; }
            case 5: { type=Fishes[playerid][pFid5]; }
        }
        format(name, sizeof(name), "%s", FishNames[type]);
        model = FishModels[type];
        ClearFishID(playerid, slot);
    }
    else //meals
    {
        format(name, sizeof(name), "%s", MealNames[type-30]);
        model = MealModels[type-30];
        switch(type)
        {
            case 30: Groceries[playerid][pChicken] = 0;
            case 31: Groceries[playerid][pPizza] = 0;
            case 32: Groceries[playerid][pHamburger] = 0;
        }
    }

    MruMySQL_AddCookedMeal(playerid, model, name, weight, type);

    SendClientMessage(playerid,COLOR_LIGHTBLUE, sprintf("* Ugotowa³es potrawê: %s, wa¿¹c¹ %dg.",
        name, weight   
    ));
    command_ugotuj_Impl(playerid);
}

AddCookingFishRow(playerid, string[1024], slot, id, weight)
{
    strcat(string, sprintf("%i\t%s~n~~g~~h~%dg\n", FishModels[id], Odpolszcz(FishNames[id]), weight), 1024);
    DynamicGui_AddRow(playerid, slot, weight);
}

AddCookingRow(playerid, string[1024], id, weight)
{
    strcat(string, sprintf("%i\t%s~n~~g~~h~%dg\n", MealModels[id-30], MealNames[id-30], weight), 1024);
    DynamicGui_AddRow(playerid, id, weight);
}

command_ugotuj_Impl(playerid)
{
    if(!IsAtCookPlace(playerid))
    {
        sendErrorMessage(playerid, "Nie jesteœ w miejscu przeznaczonym do gotowania (Cluckin Bell / Burger Shot / Pizzeria).");
        return 1;
    }

    new string[1024];
    DynamicGui_Init(playerid);
    //TODO: refactor koniecznie
    if(Fishes[playerid][pWeight1] > 1) AddCookingFishRow(playerid, string, 1, Fishes[playerid][pFid1], Fishes[playerid][pWeight1]);
    if(Fishes[playerid][pWeight2] > 1) AddCookingFishRow(playerid, string, 2, Fishes[playerid][pFid2], Fishes[playerid][pWeight2]);
    if(Fishes[playerid][pWeight3] > 1) AddCookingFishRow(playerid, string, 3, Fishes[playerid][pFid3], Fishes[playerid][pWeight3]);
    if(Fishes[playerid][pWeight4] > 1) AddCookingFishRow(playerid, string, 4, Fishes[playerid][pFid4], Fishes[playerid][pWeight4]);
    if(Fishes[playerid][pWeight5] > 1) AddCookingFishRow(playerid, string, 5, Fishes[playerid][pFid5], Fishes[playerid][pWeight5]);
    if(Groceries[playerid][pChicken] != 0) AddCookingRow(playerid, string, 30, Groceries[playerid][pChicken]);
    if(Groceries[playerid][pPizza] != 0) AddCookingRow(playerid, string, 31, Groceries[playerid][pPizza]);
    if(Groceries[playerid][pHamburger] != 0) AddCookingRow(playerid, string, 32, Groceries[playerid][pHamburger]);

    if(strlen(string) < 2) 
    {
        sendErrorMessage(playerid, "Nie masz nic do ugotowania.");
        return 1;
    }
    string[strlen(string)-1] = '\0';

    ShowPlayerDialogEx(playerid, DIALOG_COOKING, DIALOG_STYLE_PREVIEW_MODEL, "Dostepne do ugotowania", string, "Ugotuj", "Anuluj");
    return 1;
}

//end