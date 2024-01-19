//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ ruleta ]------------------------------------------------//
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

static enum
{
    ROULETTE_COLOR_GREEN,
    ROULETTE_COLOR_RED,
    ROULETTE_COLOR_BLACK
}

static enum
{
    ROULETTE_TYPE_NUMBERS,
    ROULETTE_TYPE_RED,
    ROULETTE_TYPE_BLACK,
    ROULETTE_TYPE_EVEN,
    ROULETTE_TYPE_ODD,
    ROULETTE_TYPE_HALF,
    ROULETTE_TYPE_ROW,
    ROULETTE_TYPE_LINES
}

static const ROULETTE_COLORS[] =
{
    ROULETTE_COLOR_GREEN,	// 0
    ROULETTE_COLOR_RED,		// 1
    ROULETTE_COLOR_BLACK,	// 2
    ROULETTE_COLOR_RED,		// 3
    ROULETTE_COLOR_BLACK,	// 4
    ROULETTE_COLOR_RED,		// 5
    ROULETTE_COLOR_BLACK,	// 6
    ROULETTE_COLOR_RED,		// 7
    ROULETTE_COLOR_BLACK,	// 8
    ROULETTE_COLOR_RED,		// 9
    ROULETTE_COLOR_BLACK,	// 10
    ROULETTE_COLOR_BLACK,	// 11
    ROULETTE_COLOR_RED,		// 12
    ROULETTE_COLOR_BLACK,	// 13
    ROULETTE_COLOR_RED,		// 14
    ROULETTE_COLOR_BLACK,	// 15
    ROULETTE_COLOR_RED,		// 16
    ROULETTE_COLOR_BLACK,	// 17
    ROULETTE_COLOR_RED,		// 18
    ROULETTE_COLOR_RED,		// 19
    ROULETTE_COLOR_BLACK,	// 20
    ROULETTE_COLOR_RED,		// 21
    ROULETTE_COLOR_BLACK,	// 22
    ROULETTE_COLOR_RED,		// 23
    ROULETTE_COLOR_BLACK,	// 24
    ROULETTE_COLOR_RED,		// 25
    ROULETTE_COLOR_BLACK,	// 26
    ROULETTE_COLOR_RED,		// 27
    ROULETTE_COLOR_BLACK,	// 28
    ROULETTE_COLOR_BLACK,	// 29
    ROULETTE_COLOR_RED,		// 30
    ROULETTE_COLOR_BLACK,	// 31
    ROULETTE_COLOR_RED,		// 32
    ROULETTE_COLOR_BLACK,	// 33
    ROULETTE_COLOR_RED,		// 34
    ROULETTE_COLOR_BLACK,	// 35
    ROULETTE_COLOR_RED		// 36
};

static sendRouletteTipMessage(playerid)
{
    sendTipMessage(playerid, "U¿yj: /ruleta (opcja) (liczby)");
    sendTipMessage(playerid, "Zak³ady niskiego ryzyka (szansa 1-2): /ruleta czerwone, /ruleta czarne, /ruleta parzyste, /ruleta nieparzyste,");
    sendTipMessage(playerid, "1-18: /ruleta polowki 1, 19-36: /ruleta polowki 2");
    sendTipMessage(playerid, "Œrednie ryzyko: /ruleta rzad [1-3] (1:3), /ruleta [0-36] [0-36] [0-36] [0-36] (1:9), /ruleta linie [1-12] [1-12] (1:6),");
    sendTipMessage(playerid, "/ruleta pierwsze (1, 2, 3, 4 i 5, 1:7)");
    sendTipMessage(playerid, "Wysokie ryzyko: /ruleta [0-36] (1:35), /ruleta [0-36] [0-36] (1:17), /ruleta [0-36] [0-36] [0-36] (1:11).");

    return 1;
}

YCMD:ruleta(playerid, params[], help)
{
    if (!IsPlayerInRangeOfPoint(playerid, 5.0, 1038.22924805, -1090.59741211, -67.52223969))
    {
        return sendErrorMessage(playerid, "Nie jesteœ przy stole z ruletk¹.");
    }
    if (kaska[playerid] < 10000)
    {
        return sendErrorMessage(playerid, "Nie staæ Ciê na grê w ruletkê (10 000$)!");
    }

    new option[16], numbers[5], amount, type;
    sscanf(params, "A<i>(-1)[4]", numbers);

    if (numbers[0] == -1)
    {
        if (sscanf(params, "s[16]A<i>(-1)[4]", option, numbers))
        {
            return sendRouletteTipMessage(playerid);
        }

        if (!strcmp(option, "czerwone", true) || !strcmp(option, "red", true))
        {
            type = ROULETTE_TYPE_RED;
        }
        else if (!strcmp(option, "czarne", true) || !strcmp(option, "black", true))
        {
            type = ROULETTE_TYPE_BLACK;
        }
        else if (!strcmp(option, "zielone", true) || !strcmp(option, "green", true))
        {
            numbers[0] = 0;
            amount = 1;
        }
        else if (!strcmp(option, "parzyste", true) || !strcmp(option, "even", true))
        {
            type = ROULETTE_TYPE_EVEN;
        }
        else if (!strcmp(option, "nieparzyste", true) || !strcmp(option, "odd", true))
        {
            type = ROULETTE_TYPE_ODD;
        }
        else if (!strcmp(option, "polowki", true) || !strcmp(option, "po³ówki", true) || !strcmp(option, "half", true))
        {
            if (!(1 <= numbers[0] <= 2))
            {
                return sendRouletteTipMessage(playerid);
            }

            type = ROULETTE_TYPE_HALF;
        }
        else if (!strcmp(option, "rzad", true) || !strcmp(option, "rz¹d", true) || !strcmp(option, "row", true))
        {
            if (!(1 <= numbers[0] <= 3))
            {
                return sendRouletteTipMessage(playerid);
            }

            type = ROULETTE_TYPE_ROW;
        }
        else if (!strcmp(option, "linie", true) || !strcmp(option, "lines", true))
        {
            if (!(1 <= numbers[0] <= 12) || !(1 <= numbers[1] <= 12) || numbers[0] == numbers[1])
            {
                return sendRouletteTipMessage(playerid);
            }

            type = ROULETTE_TYPE_LINES;
        }
        else if (!strcmp(option, "pierwsze", true) || !strcmp(option, "first", true))
        {
            for (new i; i < sizeof(numbers); i ++)
            {
                numbers[i] = i + 1;
            }

            amount = 5;
        }
    }
    else
    {
        new Iterator:RouletteNumbers<37>;

        for (new i; i < sizeof(numbers); i ++)
        {
            if (numbers[i] == -1)
            {
                break;
            }
            if (!(0 <= numbers[i] <= 36) || Iter_Contains(RouletteNumbers, numbers[i]))
            {
                return sendRouletteTipMessage(playerid);
            }

            Iter_Add(RouletteNumbers, numbers[i]);
        }

        amount = Iter_Count(RouletteNumbers);
    }

    new rand = true_random(37), reward = 10000,
        bool:win, name[MAX_PLAYER_NAME + 1], string[128];

    GetPlayerName(playerid, name, sizeof(name));
    Log(payLog, INFO, "%s zakrêci³ ruletk¹ i wypad³o: %d", GetPlayerLogName(playerid), rand);

    switch (ROULETTE_COLORS[rand])
    {
        case ROULETTE_COLOR_GREEN: format(string, sizeof(string), "* %s krêci ruletk¹ i kulka zatrzymuje siê na zielonym %d.", name, rand);
        case ROULETTE_COLOR_RED: format(string, sizeof(string), "* %s krêci ruletk¹ i kulka zatrzymuje siê na czerwonej %d.", name, rand);
        case ROULETTE_COLOR_BLACK: format(string, sizeof(string), "* %s krêci ruletk¹ i kulka zatrzymuje siê na czarnej %d.", name, rand);
    }

    ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR, TEAM_GREEN_COLOR, TEAM_GREEN_COLOR, TEAM_GREEN_COLOR, TEAM_GREEN_COLOR);

    switch (type)
    {
        case ROULETTE_TYPE_NUMBERS:
        {
            for (new i; i < amount; i ++)
            {
                if (numbers[i] == rand)
                {
                    win = true;
                    break;
                }
            }
        }
        case ROULETTE_TYPE_RED: win = ROULETTE_COLORS[rand] == ROULETTE_COLOR_RED;
        case ROULETTE_TYPE_BLACK: win = ROULETTE_COLORS[rand] == ROULETTE_COLOR_BLACK;
        case ROULETTE_TYPE_EVEN: win = rand && !(rand % 2);
        case ROULETTE_TYPE_ODD: win = rand && (rand % 2);
        case ROULETTE_TYPE_HALF:
        {
            if (numbers[0] == 1)
            {
                win = 1 <= rand <= 18;
            }
            else
            {
                win = 19 <= rand <= 36;
            }
        }
        case ROULETTE_TYPE_ROW:
        {
            switch (numbers[0])
            {
                case 1: win = rand && (rand % 3 == 1);
                case 2: win = rand && (rand % 3 == 2);
                case 3: win = rand && (rand % 3 == 0);
            }
        }
        case ROULETTE_TYPE_LINES: win = (((numbers[0] - 1) * 3 + 1) <= rand <= ((numbers[0] - 1) + 3)) || (((numbers[1] - 1) * 3 + 1) <= rand <= ((numbers[1] - 1) + 3));
    }

    if (win)
    {
        switch (type)
        {
            case ROULETTE_TYPE_NUMBERS:
            {
                switch (amount)
                {
                    case 1: reward *= 35;
                    case 2: reward *= 17;
                    case 3: reward *= 11;
                    case 4: reward *= 9;
                    case 5: reward *= 7;
                }
            }
            case ROULETTE_TYPE_RED, ROULETTE_TYPE_BLACK, ROULETTE_TYPE_EVEN, ROULETTE_TYPE_ODD, ROULETTE_TYPE_HALF:
                reward *= 2;
            case ROULETTE_TYPE_ROW: reward *= 3;
            case ROULETTE_TYPE_LINES: reward *= 6;
        }

        format(string, sizeof(string), "~g~+$%d", reward - 10000);
        DajKase(playerid, reward - 10000);
    }
    else
    {
        format(string, sizeof(string), "~r~-$10000");
        ZabierzKase(playerid, 10000);
    }

    return GameTextForPlayer(playerid, string, 5000, 1);
}
