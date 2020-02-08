//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                  mbiznesy                                                 //
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
// Autor: Simeone
// Data utworzenia: 04.02.2020


//

//------------------<[ Implementacja: ]>-------------------
command_mbiznesy_Impl(playerid)
{
    SendClientMessage(playerid, COLOR_GREEN, "==========<[ Biznesy Mrucznik Role Play 2.0 ]>==========");
    SendClientMessage(playerid, COLOR_WHITE, "Autor: Simeone");
    SendClientMessage(playerid, COLOR_WHITE, "Nowy system biznesów Mrucznik Role Play opiera siê na dowolnoœci wyboru."); 
    SendClientMessage(playerid, COLOR_WHITE, "Gracz mo¿e wybraæ jaki typ biznesu chce prowadziæ, a tak¿e swobodnie wybraæ lokalizacjê w mieœcie.");
    SendClientMessage(playerid, COLOR_WHITE, "Biznesy s¹ stale aktualizowane, zapisywane, dokumentowane - dziêki czemu straty z tym zwi¹zane s¹ minimalne.");
    SendClientMessage(playerid, COLOR_WHITE, "Gracze uzyskuj¹ komendy takie jak: /mbizbuy /mbizsell, /mbizinvite, /mbizquit [..]");
    SendClientMessage(playerid, COLOR_WHITE, "Aby zakupiæ w³asny biznes nale¿y udaæ siê do urzêdu miasta, dozwolone s¹ 2 typy [.]");
    SendClientMessage(playerid, COLOR_WHITE, "[.] Przemys³owy, Us³ugowy. Us³ugowe s¹ to np. sklepy 24/7, kasyna, restauracje.");
    SendClientMessage(playerid, COLOR_WHITE, "Przemys³owe s¹ to np. Kopalnie, rafinerie, fabryki odzie¿y. ");
    SendClientMessage(playerid, COLOR_GREEN, "=====================<[ Koniec ]>====================");
    return 1;
}

//end