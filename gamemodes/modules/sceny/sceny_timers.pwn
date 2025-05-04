//-----------------------------------------------<< Timers >>------------------------------------------------//
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

//-----------------<[ Timery: ]>-------------------

public Scena_GenerateEffect()
{
    if(Scena[SCEffectData][SCEffectCount] > 1)
    {
        Scena[SCEffectData][SCEffectCount]--;
        if(Scena[SCEffectData][SCEffectDelay] != 0) Scena[SCEffectData][SCEffectTimer] = SetTimer("Scena_GenerateEffect", Scena[SCEffectData][SCEffectDelay], 0);
    }
    new Float:x, Float:y, Float:z;
    for(new i=0;i<5;i++)
    {
        if(Scena[SCEffectData][SCEffectObj][i] != 0)
        {
            DestroyDynamicObject(Scena[SCEffectData][SCEffectObj][i]);
            Scena[SCEffectData][SCEffectObj][i] = 0;
        }
        if(Scena[SCEffectWait])
        {
            GetDynamicObjectPos(Scena[SCEffectOriginObj][i], x, y, z);
            Scena[SCEffectData][SCEffectObj][i] = CreateDynamicObject(Scena[SCEffectData][SCEffectModel], x, y, z-1.5, 0.0, 0.0, 0.0);
        }
    }
    if(Scena[SCEffectWait]) Scena[SCEffectWait]=false;
    else Scena[SCEffectWait]=true;
    Scena_Refresh();
}

//end