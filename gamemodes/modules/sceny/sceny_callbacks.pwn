//----------------------------------------------<< Callbacks >>----------------------------------------------//
//                                                   scena                                                   //
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
// Autor: wiger
// Data utworzenia: 23.04.2025
//Opis:
/*
	Scena
*/

//

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	if(dialogid == SCENA_DIALOG_MAIN)
    {
        if(!response) return 1;
        switch(listitem)
        {
            case 0:
            {
                if(!Scena[SCCreated])
                {
                    new Float:x, Float:y, Float:z, Float:a;
                    GetPlayerPos(playerid, x, y, z);
                    GetPlayerFacingAngle(playerid, a);
                    x += 10.0 * floatsin(-a, degrees);
                    y += 10.0 * floatcos(-a, degrees);
                    Scena_CreateAt(x, y, z+0.2);
                    new str[64];
                    format(str, 64, "Scena stworzona przez %s", GetNick(playerid));
                    SendAdminMessage(COLOR_RED, str);
                    Log(serverLog, INFO, "%s stworzy³ scenê w: %f %f %f", GetPlayerLogName(playerid), x, y, z);
                }
                else
                {
                    Scena_Destroy();
                    new str[64];
                    format(str, 64, "Scena zniszczona przez %s", GetNick(playerid));
                    SendAdminMessage(COLOR_RED, str);
                    Log(serverLog, INFO, "%s usuna³ scenê", GetPlayerLogName(playerid));
                }
            }
            case 1:
            {
                ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz¹dzanie ekranem", "Zmieñ napis g³ówny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
            }
            case 2:
            {
                ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz¹dzanie neonami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
            }
            case 3:
            {
                ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz¹dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
            }
            case 4: ShowPlayerDialogEx(playerid, SCENA_DIALOG_AUDIO, DIALOG_STYLE_INPUT, "Zarz¹dzanie audio", "WprowadŸ link", "Ustaw", "Wyjdz");
            case 5:
            {
                if(Scena[SCSmokeMachine])
                {
                    DestroyDynamicObject(Scena[SCSmokeObject][0]);
                    DestroyDynamicObject(Scena[SCSmokeObject][1]);
                    Scena[SCSmokeMachine]=false;
                }
                else
                {
                    Scena[SCSmokeObject][0] = CreateDynamicObject(2780, Scena[SCPosition][0]+5.84926, Scena[SCPosition][1]+4.44155, Scena[SCPosition][2]+0.10611,   0.00000, 0.00000, -48.24001);
                    Scena[SCSmokeObject][1] = CreateDynamicObject(2780, Scena[SCPosition][0]+5.98447, Scena[SCPosition][1]-5.16050, Scena[SCPosition][2]+0.10611,   0.00000, 0.00000, -143.22002);
                    Scena[SCSmokeMachine]=true;
                    Scena_Refresh();
                }
            }
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_CREATE)
    {
        if(!response) return 1;

    }
    else if(dialogid == SCENA_DIALOG_EFEKTY)
    {
        if(!response) return 1;
        new str[1024] = "{000000}0\t{FFFFFF}Usuñ\n{000000}18668\t{FFFFFF}Krew\n{000000}18670\t{FFFFFF}B³yski\n{000000}18675\t{FFFFFF}Dymek\n{000000}18678\t{FFFFFF}Eksplozja\n{000000}18683\t{FFFFFF}Eksplozja medium\n{000000}18685\t{FFFFFF}Eksplozja ma³a\n{000000}18692\t{FFFFFF}Ogieñ\n{000000}18702\t{FFFFFF}Niebieski p³omieñ\n{000000}18708\t{FFFFFF}B¹belki\n{000000}18718\t{FFFFFF}Iskry\n{000000}18728\t{FFFFFF}Raca\n{000000}18740\t{FFFFFF}Woda\n";
        strcat(str, "{000000}18680\t{FFFFFF}Dym + iskry\n{000000}18715\t{FFFFFF}Dym du¿y\n{000000}18693\t{FFFFFF}Ogieñ #2\n{000000}18744\t{FFFFFF}Splash big\n{000000}18747\t{FFFFFF}Wodna piana");
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY_TYP, DIALOG_STYLE_LIST, "Zarz¹dzanie dodatkami", str, "Wybierz", "Wyjdz");
            case 1: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY_COUNT, DIALOG_STYLE_INPUT, "Zarz¹dzanie dodatkami", "Podaj iloœæ powtórzeñ\t\tnp.\n-1 - dla nieskoñczonej pêtli\n0 - dla wy³¹czenia\nn - liczba", "Wybierz", "Wyjdz");
            case 2: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY_DELAY, DIALOG_STYLE_INPUT, "Zarz¹dzanie dodatkami", "Podaj odstêp czasowy\t\tnp.\n0 - sta³y efekt\nn [ms] - czas", "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EFEKTY_TYP)
    {
        if(!response) return 1;
        if(strval(inputtext) == 0)
        {
            if(Scena[SCEffectData][SCEffectTimer] != 0)
            {
                KillTimer(Scena[SCEffectData][SCEffectTimer]);
                Scena[SCEffectData][SCEffectTimer] = 0;
            }
            Scena[SCEffectData][SCEffectDelay] = 0;
        }
        else Scena[SCEffectData][SCEffectModel] = strval(inputtext);
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz¹dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
        Scena_GenerateEffect();
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EFEKTY_COUNT)
    {
        if(!response) return 1;
        if(strval(inputtext) < -1 || strval(inputtext) > 0xFFFF) return 1;
        Scena[SCEffectData][SCEffectCount] = strval(inputtext);

        if(Scena[SCEffectData][SCEffectTimer] != 0)
        {
            KillTimer(Scena[SCEffectData][SCEffectTimer]);
            Scena[SCEffectData][SCEffectTimer] = 0;
        }

        if(Scena[SCEffectData][SCEffectCount] == -1)
        {
            if(Scena[SCEffectData][SCEffectDelay] != 0) Scena[SCEffectData][SCEffectTimer] = SetTimer("Scena_GenerateEffect", Scena[SCEffectData][SCEffectDelay], 1);
        }
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz¹dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
        Scena_GenerateEffect();
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EFEKTY_DELAY)
    {
        if(!response) return 1;
        if(strval(inputtext) < 250 || strval(inputtext) > 0xFFFF) return SendClientMessage(playerid, -1, "Od 250");
        Scena[SCEffectData][SCEffectDelay] = strval(inputtext);

        if(Scena[SCEffectData][SCEffectTimer] != 0)
        {
            KillTimer(Scena[SCEffectData][SCEffectTimer]);
            Scena[SCEffectData][SCEffectTimer] = 0;
        }
        if(Scena[SCEffectData][SCEffectCount] == -1)
        {
            if(Scena[SCEffectData][SCEffectDelay] != 0) Scena[SCEffectData][SCEffectTimer] = SetTimer("Scena_GenerateEffect", Scena[SCEffectData][SCEffectDelay], 1);
        }

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EFEKTY, DIALOG_STYLE_LIST, "Zarz¹dzanie dodatkami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
        Scena_GenerateEffect();
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN)
    {
        if(!response) return 1;
        new str[512] = "{000000}0\t{FFFFFF}Usuñ\n{000000}1\t{FFFFFF}Góra-dó³";
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN_TYP, DIALOG_STYLE_INPUT, "Zarz¹dzanie ekranem", "WprowadŸ napis", "Wybierz", "Wyjdz");
            case 1: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN_EFEKT, DIALOG_STYLE_LIST, "Zarz¹dzanie ekranem", str, "Wybierz", "Wyjdz");
            case 2: ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN_EXTRA, DIALOG_STYLE_INPUT, "Zarz¹dzanie ekranem", "Dla efektu Wirnik:\t\tPrêdkoœæ (ca³kowite wartoœci)", "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN_TYP)
    {
        if(!response) return 1;
        if(strlen(inputtext) > 32) return 1;
        format(Scena[SCScreenText], 32, "%s", inputtext);
        new size = 148-(floatround(floatsqroot(strlen(inputtext)*150))*2);
        if(size < 10) size = 10;
        SetDynamicObjectMaterialText(Scena[SCScreenObject], 0, inputtext, OBJECT_MATERIAL_SIZE_512x256, "Arial", size, 1, 0xFFFFFFFF, 0, 1);
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz¹dzanie ekranem", "Zmieñ napis g³ówny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN_EFEKT)
    {
        if(!response) return 1;
        if(strval(inputtext) == 0)
        {
            Scena[SCScreenEnable] = false;
            new Float:x, Float:y, Float:z;
            GetDynamicObjectPos(Scena[SCScreenObject], x, y, z);
            if(Scena[SCScreenMove] == 0) MoveDynamicObject(Scena[SCScreenObject], x, y, Scena[SCPosition][2]+4.18430, Scena[SCScreenSpeed], 0.0, 0.0, 100.0), Scena[SCScreenMove]= 1;
            else if(Scena[SCScreenMove] == 1) MoveDynamicObject(Scena[SCScreenObject], x, y, Scena[SCPosition][2]+4.18430, Scena[SCScreenSpeed], 0.0, 0.0, 100.0), Scena[SCScreenMove]=0;

            SetDynamicObjectMaterialText(Scena[SCScreenObject], 0, Scena[SCScreenText], OBJECT_MATERIAL_SIZE_512x256, "Arial", 72, 1, 0xFFFFFFFF, 0, 1);
        }
        else
        {
            Scena[SCScreenTyp] = strval(inputtext);
            Scena[SCScreenEnable] = true;
        }

        Scena_ScreenEffect();
        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz¹dzanie ekranem", "Zmieñ napis g³ówny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_EKRAN_EXTRA)
    {
        if(!response) return 1;
        if(strval(inputtext) < 0 || strval(inputtext) > 100) return 1;
        Scena[SCScreenSpeed] = float(strval(inputtext));

        Scena_ScreenEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_EKRAN, DIALOG_STYLE_LIST, "Zarz¹dzanie ekranem", "Zmieñ napis g³ówny\nUstaw efekt\nUstaw dodatkowy parametr", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEONY)
    {
        if(!response) return 1;
        new str[512] = "{000000}0\t{FFFFFF}Usuñ\n{000000}1\t{FFFFFF}Slider\n{000000}2\t{FFFFFF}Zderzacz";
        switch(listitem)
        {
            case 0: ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_EFEKT, DIALOG_STYLE_LIST, "Zarz¹dzanie neonami", str, "Wybierz", "Wyjdz");
            case 1: ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_COUNT, DIALOG_STYLE_INPUT, "Zarz¹dzanie neonami", "Aktualnie brak", "Wybierz", "Wyjdz");
            case 2: ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_DELAY, DIALOG_STYLE_INPUT, "Zarz¹dzanie neonami", "Dla efektu:\t\tPrêdkoœæ (ca³kowite wartoœci)", "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_EFEKT)
    {
        if(!response) return 1;
        Scena[SCNeonData][SCNeonTyp] = 0;
        Scena_NeonEffect();

        Scena[SCNeonData][SCNeonTyp] = strval(inputtext);
        if(Scena[SCNeonData][SCNeonTyp] != 0)
        {
            new str[256] = "{000000}18652\t\t{FFFFFF}Bia³y neon\n{000000}18647\t\t{FFFFFF}Czerwony neon\n{000000}18648\t\t{FFFFFF}Niebieski neon\n{000000}18649\t\t{FFFFFF}Zielony neon\n{000000}18650\t\t{FFFFFF}¯ó³ty neon\n{000000}18651\t\t{FFFFFF}Ró¿owy neon <3 :*";
            ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEON_KOLORY, DIALOG_STYLE_LIST, "Zarz¹dzanie neonami", str, "Wybierz", "Wyjdz");
        }
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_COUNT)
    {
        if(!response) return 1;
        if(strval(inputtext) < -1 || strval(inputtext) > 100) return 1;
        Scena[SCNeonData][SCNeonCount] = strval(inputtext);

        Scena_NeonEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz¹dzanie neonami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_DELAY)
    {
        if(!response) return 1;
        if(strval(inputtext) < 0 || strval(inputtext) > 200) return SendClientMessage(playerid, -1, "Do 200");
        Scena[SCNeonData][SCNeonDelay] = strval(inputtext);

        Scena_NeonEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz¹dzanie neonami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_NEON_KOLORY)
    {
        if(!response) return 1;
        Scena[SCNeonData][SCNeonModel] = strval(inputtext);
        Scena[SCNeonData][SCNeonSliderRefresh]=true;

        Scena_NeonEffect();

        ShowPlayerDialogEx(playerid, SCENA_DIALOG_NEONY, DIALOG_STYLE_LIST, "Zarz¹dzanie neonami", "Ustaw efekt\nUstaw powtarzalnoœæ\nUstaw czêstotliwoœæ", "Wybierz", "Wyjdz");
        return 1;
    }
    else if(dialogid == SCENA_DIALOG_AUDIO)
    {
        if(!response) return 1;
		if (ValidateURLAndNotify(playerid, inputtext)) return 1;
        format(Scena[SCAudioStream], 128, "%s", inputtext);
        for(new i=0;i<MAX_PLAYERS;i++)
        {
            if(GetPVarInt(i, "scena-audio") == 1)
            {
                StopAudioStreamForPlayer(i);
                SetPVarInt(i, "scena-audio", 0);
            }
        }
        return 1;
    }
	else if(dialogid == SCENA_DIALOG_GETMONEY)
	{
		if(!response)
		{
			return 1;
		}
		if(kaska[playerid] >= 2_000_000)
		{
			ZabierzKase(playerid, 2000000); 
			Sejf_Add(FRAC_SN, 2000000); 
			Sejf_Save(FRAC_SN); 
			new string[124]; 
			format(string, sizeof(string), "%s umieœci³ w sejfie 2 miliony za scenê!"); 
			SendLeaderRadioMessage(FRAC_SN, COLOR_LIGHTGREEN, string); 
			SN_ACCESS[playerid] = 1; 
			sendTipMessageEx(playerid, COLOR_P@, "Umieœci³eœ op³atê za scenê w sejfie SN"); 
		}
		else
		{
			sendTipMessage(playerid, "Nie masz wystarczaj¹cej iloœci gotówki!"); 
			return 1;
		}
	}
	return 0;
}

hook OnDynamicObjectMoved(objectid)
{
    if(Scena[SCCreated])
    {
        if(objectid == Scena[SCScreenObject])
        {
            Scena_ScreenEffect();
            return 1;
        }
        for(new i=0;i<2;i++)
        {
            if(objectid == Scena[SCNeonData][SCNeonObj][i])
            {
                if(Scena[SCNeonData][SCNeonTyp] == 2)
                {
                    Scena[SCNeonData][SCNeonZderzacz]++;
                    if(Scena[SCNeonData][SCNeonZderzacz] == 2) Scena_NeonEffect();
                }
                else Scena_NeonEffect();
                return 1;
            }
        }
    }
    return 1;
}

//end