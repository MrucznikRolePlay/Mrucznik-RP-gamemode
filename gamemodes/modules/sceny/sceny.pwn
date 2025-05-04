//-----------------------------------------------<< Source >>------------------------------------------------//
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

//-----------------<[ Funkcje: ]>-------------------

Scena_CreateAt(Float:x, Float:y, Float:z)
{
	//Pod³oga
	Scena[SCObjects][0] = CreateDynamicObject(19464, 0.00000, 0.00000, 0.00000,   0.00000, 90.00000, 0.00000);
	Scena[SCObjects][1] = CreateDynamicObject(19464, 0.00000, 5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
	Scena[SCObjects][2] = CreateDynamicObject(19464, 5.09520, 5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
	Scena[SCObjects][3] = CreateDynamicObject(19464, 5.09520, 0.00000, 0.00000,   0.00000, 90.00000, 0.00000);
	Scena[SCObjects][4] = CreateDynamicObject(19464, 0.00000, -5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
	Scena[SCObjects][5] = CreateDynamicObject(19464, 5.09520, -5.93500, 0.00000,   0.00000, 90.00000, 0.00000);
	//Podstawa
	Scena[SCObjects][6] = CreateDynamicObject(19463, -2.49824, 4.11975, -1.65150,   0.00000, 0.00000, 0.00000);
	Scena[SCObjects][7] = CreateDynamicObject(19463, -2.49000, -4.09100, -1.65150,   0.00000, 0.00000, 0.00000);
	Scena[SCObjects][8] = CreateDynamicObject(19463, 2.38022, -8.82674, -1.65150,   0.00000, 0.00000, 90.00000);
	Scena[SCObjects][9] = CreateDynamicObject(19463, 2.38020, 8.82670, -1.65150,   0.00000, 0.00000, 90.00000);
	Scena[SCObjects][10] = CreateDynamicObject(19463, 7.56052, -4.08956, -1.65150,   0.00000, 0.00000, 0.00000);
	Scena[SCObjects][11] = CreateDynamicObject(19463, 7.56050, 4.10710, -1.65150,   0.00000, 0.00000, 0.00000);
	Scena[SCObjects][12] = CreateDynamicObject(19463, 2.79501, 8.83527, -1.65150,   0.00000, 0.00000, 90.00000);
	Scena[SCObjects][13] = CreateDynamicObject(19463, 2.79500, -8.83530, -1.65150,   0.00000, 0.00000, 90.00000);
	//Ty³
	Scena[SCObjects][14] = CreateDynamicObject(18766, 7.14500, -6.39960, 3.81240,   0.00000, 90.00000, 90.00000);
	Scena[SCObjects][15] = CreateDynamicObject(18766, 7.14500, -1.39960, 3.81240,   0.00000, 90.00000, 90.00000);
	Scena[SCObjects][16] = CreateDynamicObject(18766, 7.14500, 3.60040, 3.81240,   0.00000, 90.00000, 90.00000);
	Scena[SCObjects][17] = CreateDynamicObject(18766, 7.13720, 6.41620, 3.81240,   0.00000, 90.00000, 90.00000);
	Scena[SCObjects][18] = CreateDynamicObject(16089, 6.62030, 0.00000, 0.52010,   0.00000, 0.00000, 0.00000);
	//Blinkery
	Scena[SCObjects][19] = CreateDynamicObject(19150, 5.89259, 5.30542, 7.19990,   0.00000, 0.00000, 90.00000);
	Scena[SCObjects][20] = CreateDynamicObject(19150, 5.89260, -3.69460, 7.19990,   0.00000, 0.00000, 90.00000);
	//Schody
	Scena[SCObjects][21] = CreateDynamicObject(7096, 0.88983, -12.53191, -1.73484,   0.00000, 0.00000, 90.00000);
	//Napis mid
	Scena[SCObjects][22] = CreateDynamicObject(4988, 6.5, 0.00000, 4.18430,   0.00000, 0.00000, 100.0000);
	Scena[SCObjects][23] = CreateDynamicObject(2232, -2.04205, 8.23906, 0.73210,   0.00000, 0.00000, -72.24001);
	Scena[SCObjects][24] = CreateDynamicObject(2232, -2.04225, -8.23434, 0.73210,   0.00000, 0.00000, -110.27997);
	Scena[SCObjects][25] = CreateDynamicObject(2232, 6.05792, -8.38562, 0.73210,   0.00000, 0.00000, -90.59996);
	Scena[SCObjects][26] = CreateDynamicObject(2232, 6.02001, 8.23435, 0.73210,   0.00000, 0.00000, -84.11996);
	Scena[SCObjects][27] = CreateDynamicObject(2229, -1.72212, 7.32641, 0.12049,   0.00000, 0.00000, -82.91998);
	Scena[SCObjects][28] = CreateDynamicObject(2229, -1.91799, -7.96637, 0.12049,   0.00000, 0.00000, -107.27997);
	//Efekty
	Scena[SCObjects][29] = CreateDynamicObject(1951, -2.03500, 0.00000, -0.01209,   0.00000, 180.00000, 0.00000);
	Scena[SCObjects][30] = CreateDynamicObject(1951, -2.03500, 3.00000, -0.01210,   0.00000, 180.00000, 0.00000);
	Scena[SCObjects][31] = CreateDynamicObject(1951, -2.03500, 6.00000, -0.01210,   0.00000, 180.00000, 0.00000);
	Scena[SCObjects][32] = CreateDynamicObject(1951, -2.03500, -3.00000, -0.01210,   0.00000, 180.00000, 0.00000);
	Scena[SCObjects][33] = CreateDynamicObject(1951, -2.03500, -6.00000, -0.01210,   0.00000, 180.00000, 0.00000);
	for (new i=0; i<=5; i++) SetDynamicObjectMaterial(Scena[SCObjects][i], 0, 18018, "genintintbarb", "cj_metalplate2");
	for (new i=6; i<=13; i++) SetDynamicObjectMaterial(Scena[SCObjects][i], 0, 3862, "hashmarket_sfsx", "ws_tarp4");
	for (new i=14; i<=17; i++) SetDynamicObjectMaterial(Scena[SCObjects][i], 0, -1, "none", "none", 0xFF000000);
	Scena[SCScreenObject] = Scena[SCObjects][22];
	SetDynamicObjectMaterialText(Scena[SCScreenObject], 0, "SCENA", OBJECT_MATERIAL_SIZE_512x256, "Arial", 72, 1, 0xFFFFFFFF, 0, 1);
	Scena[SCEffectOriginObj][0] = Scena[SCObjects][29];
	Scena[SCEffectOriginObj][1] = Scena[SCObjects][30];
	Scena[SCEffectOriginObj][2] = Scena[SCObjects][31];
	Scena[SCEffectOriginObj][3] = Scena[SCObjects][32];
	Scena[SCEffectOriginObj][4] = Scena[SCObjects][33];


    new Float:x1, Float:y1, Float:z1;
    for(new i=0; i<SCENA_OBJECT_COUNT; i++)
    {
        GetDynamicObjectPos(Scena[SCObjects][i], x1, y1, z1);
        SetDynamicObjectPos(Scena[SCObjects][i], x1+x, y1+y,z1+z);
    }
    for(new i=0;i<5;i++)
    {
        Scena[SCEffectData][SCEffectObj][i] = 0;
    }
    Scena[SCPosition][0] = x;
    Scena[SCPosition][1] = y;
    Scena[SCPosition][2] = z;
    Scena[SCCreated] = true;

    format(Scena[SCAudioStream], 128, "http://radioparty.pl/play/glowny.m3u");
    Scena_Refresh();
}

Scena_Refresh()
{
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(IsPlayerInRangeOfPoint(i, 100.0, Scena[SCPosition][0], Scena[SCPosition][1], Scena[SCPosition][2]))
        {
            Streamer_Update(i);
        }
    }
}

Scena_ScreenEffect()
{
    if(!Scena[SCScreenEnable])
    {
        return;
    }
    new Float:x, Float:y, Float:z;
    GetDynamicObjectPos(Scena[SCScreenObject], x, y, z);
    if(Scena[SCScreenTyp] == 1)
    {
        if(Scena[SCScreenMove] == 0) MoveDynamicObject(Scena[SCScreenObject], x, y, Scena[SCPosition][2]+4.18430+2.5, Scena[SCScreenSpeed], 0.0, 0.0, 100.0000), Scena[SCScreenMove]= 1;
        else if(Scena[SCScreenMove] == 1) MoveDynamicObject(Scena[SCScreenObject], x, y, Scena[SCPosition][2]+4.18430-2.5, Scena[SCScreenSpeed], 0.0, 0.0, 100.0000), Scena[SCScreenMove]=0;
    }
}

Scena_NeonEffect()
{
    switch(Scena[SCNeonData][SCNeonTyp])
    {
        case 0:
        {
            for(new i=0;i<2;i++)
            {
                if(Scena[SCNeonData][SCNeonObj][i] != 0)
                {
                    DestroyDynamicObject(Scena[SCNeonData][SCNeonObj][i]);
                    Scena[SCNeonData][SCNeonObj][i] = 0;
                }
            }
            Scena[SCNeonData][SCNeonSlider]=false;
            Scena[SCNeonData][SCNeonSliderRefresh]=false;
            Scena[SCNeonData][SCNeonZderzacz] = false;
        }
        case 1: //slider
        {
            if(Scena[SCNeonData][SCNeonObj][0] == 0)
            {
                Scena[SCNeonData][SCNeonObj][0] = CreateDynamicObject(Scena[SCNeonData][SCNeonModel], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]+SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                Scena_Refresh();
            }
            else if(Scena[SCNeonData][SCNeonSliderRefresh])
            {
                DestroyDynamicObject(Scena[SCNeonData][SCNeonObj][0]);
                Scena[SCNeonData][SCNeonObj][0] = CreateDynamicObject(Scena[SCNeonData][SCNeonModel], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]+SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                Scena_Refresh();
                Scena[SCNeonData][SCNeonSliderRefresh]=false;
            }
            if(Scena[SCNeonData][SCNeonSlider])
            {
                MoveDynamicObject(Scena[SCNeonData][SCNeonObj][0], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]-SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, Scena[SCNeonData][SCNeonDelay]);
                Scena[SCNeonData][SCNeonSlider]=false;
            }
            else
            {
                MoveDynamicObject(Scena[SCNeonData][SCNeonObj][0], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]+SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, Scena[SCNeonData][SCNeonDelay]);
                Scena[SCNeonData][SCNeonSlider]=true;
            }
        }
        case 2: //slider
        {
            if(Scena[SCNeonData][SCNeonObj][0] == 0)
            {
                Scena[SCNeonData][SCNeonObj][0] = CreateDynamicObject(Scena[SCNeonData][SCNeonModel], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]+SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                Scena[SCNeonData][SCNeonObj][1] = CreateDynamicObject(Scena[SCNeonData][SCNeonModel], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]-SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);

                Scena_Refresh();
            }
            else if(Scena[SCNeonData][SCNeonSliderRefresh])
            {
                DestroyDynamicObject(Scena[SCNeonData][SCNeonObj][0]);
                DestroyDynamicObject(Scena[SCNeonData][SCNeonObj][1]);
                Scena[SCNeonData][SCNeonObj][0] = CreateDynamicObject(Scena[SCNeonData][SCNeonModel], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]+SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);
                Scena[SCNeonData][SCNeonObj][1] = CreateDynamicObject(Scena[SCNeonData][SCNeonModel], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]-SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, 0.0, 0.0, 0.0);

                Scena_Refresh();
                Scena[SCNeonData][SCNeonSliderRefresh]=false;
            }

            if(Scena[SCNeonData][SCNeonSlider])
            {
                MoveDynamicObject(Scena[SCNeonData][SCNeonObj][0], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]+SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, Scena[SCNeonData][SCNeonDelay]);
                MoveDynamicObject(Scena[SCNeonData][SCNeonObj][1], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1]-SCENA_NEON_OFFSET_Y,Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, Scena[SCNeonData][SCNeonDelay]);

                Scena[SCNeonData][SCNeonSlider]=false;
            }
            else
            {
                MoveDynamicObject(Scena[SCNeonData][SCNeonObj][0], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1],Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, Scena[SCNeonData][SCNeonDelay]);
                MoveDynamicObject(Scena[SCNeonData][SCNeonObj][1], Scena[SCPosition][0]+SCENA_NEON_OFFSET_X,Scena[SCPosition][1],Scena[SCPosition][2]+SCENA_NEON_OFFSET_Z, Scena[SCNeonData][SCNeonDelay]);

                Scena[SCNeonData][SCNeonSlider]=true;
            }
            Scena[SCNeonData][SCNeonZderzacz] = 0;
        }
    }
}

Scena_Destroy()
{
    for(new i=0; i<SCENA_OBJECT_COUNT; i++)
    {
        DestroyDynamicObject(Scena[SCObjects][i]);
    }
    for(new i=0;i<5;i++)
    {
        if(Scena[SCEffectData][SCEffectObj][i] != 0) DestroyDynamicObject(Scena[SCEffectData][SCEffectObj][i]);
    }
    for(new i=0;i<MAX_PLAYERS;i++)
    {
        if(GetPVarInt(i, "scena-audio") == 1)
        {
            if(IsPlayerInRangeOfPoint(i, 100.0, Scena[SCPosition][0],Scena[SCPosition][1],Scena[SCPosition][2]))
            {
                StopAudioStreamForPlayer(i);
                SetPVarInt(i, "scena-audio", 0);
            }
        }
    }
    Scena[SCNeonData][SCNeonTyp] = 0;
    Scena_NeonEffect();
    Scena[SCCreated] = false;
}

//end