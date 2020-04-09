//------------------------------------------<< Generated source >>-------------------------------------------//
//-----------------------------------------------[ Modules ]-------------------------------------------------//
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
// Kod wygenerowany automatycznie narzêdziem Mrucznik CTL

// ================= UWAGA! =================
//
// WSZELKIE ZMIANY WPROWADZONE DO TEGO PLIKU
// ZOSTAN¥ NADPISANE PO WYWO£ANIU KOMENDY
// > mrucznikctl build
//
// ================= UWAGA! =================


//-------<[ .def ]>-------
#include "cooking\cooking.def"
#include "pojazdy\pojazdy.def"
#include "urzadls\urzadls.def"
#include "choroby\choroby.def"
#include "player_attachments\player_attachments.def"
#include "wejscia\wejscia.def"
#include "convoy\convoy.def"
#include "oferty\oferty.def"
#include "actors\actors.def"
#include "biznesy\biznesy.def"
#include "budki\budki.def"
#include "prace\prace.def"
#include "sila\sila.def"
#include "chaty\chaty.def"
#include "premium\premium.def"
#include "vehicle_attachments\vehicle_attachments.def"
#include "adminduty\adminduty.def"
#include "antyspam\antyspam.def"
#include "names\names.def"
#include "komendy\komendy.def"
#include "graffiti\graffiti.def"
#include "03DL\03DL.def"
#include "money\money.def"
#include "wielkanoc\wielkanoc.def"
#include "ibiza\ibiza.def"
#include "debug\debug.def"
#include "bw\bw.def"
#include "discord\discord.def"
#include "organizacje\organizacje.def"
#include "sannews\sannews.def"
#include "animacje\animacje.def"
#include "admin\admin.def"
#include "wypadek\wypadek.def"
#include "logi\logi.def"
#include "przedmioty\przedmioty.def"
#include "antycheat\antycheat.def"
#include "frakcje\frakcje.def"
#include "bramy\bramy.def"
#include "fishing\fishing.def"


//-------<[ .hwn ]>-------
#include "cooking\cooking.hwn"
#include "pojazdy\pojazdy.hwn"
#include "urzadls\urzadls.hwn"
#include "choroby\choroby.hwn"
#include "player_attachments\player_attachments.hwn"
#include "wejscia\wejscia.hwn"
#include "convoy\convoy.hwn"
#include "oferty\oferty.hwn"
#include "actors\actors.hwn"
#include "biznesy\biznesy.hwn"
#include "budki\budki.hwn"
#include "prace\prace.hwn"
#include "sila\sila.hwn"
#include "chaty\chaty.hwn"
#include "premium\premium.hwn"
#include "vehicle_attachments\vehicle_attachments.hwn"
#include "adminduty\adminduty.hwn"
#include "antyspam\antyspam.hwn"
#include "names\names.hwn"
#include "komendy\komendy.hwn"
#include "graffiti\graffiti.hwn"
#include "03DL\03DL.hwn"
#include "money\money.hwn"
#include "wielkanoc\wielkanoc.hwn"
#include "ibiza\ibiza.hwn"
#include "debug\debug.hwn"
#include "bw\bw.hwn"
#include "discord\discord.hwn"
#include "organizacje\organizacje.hwn"
#include "sannews\sannews.hwn"
#include "animacje\animacje.hwn"
#include "admin\admin.hwn"
#include "wypadek\wypadek.hwn"
#include "logi\logi.hwn"
#include "przedmioty\przedmioty.hwn"
#include "antycheat\antycheat.hwn"
#include "frakcje\frakcje.hwn"
#include "bramy\bramy.hwn"
#include "fishing\fishing.hwn"


//-------<[ .pwn ]>-------
#include "cooking\cooking.pwn"
#include "pojazdy\pojazdy.pwn"
#include "urzadls\urzadls.pwn"
#include "choroby\choroby.pwn"
#include "player_attachments\player_attachments.pwn"
#include "wejscia\wejscia.pwn"
#include "convoy\convoy.pwn"
#include "oferty\oferty.pwn"
#include "actors\actors.pwn"
#include "biznesy\biznesy.pwn"
#include "budki\budki.pwn"
#include "prace\prace.pwn"
#include "sila\sila.pwn"
#include "chaty\chaty.pwn"
#include "premium\premium.pwn"
#include "vehicle_attachments\vehicle_attachments.pwn"
#include "adminduty\adminduty.pwn"
#include "antyspam\antyspam.pwn"
#include "names\names.pwn"
#include "komendy\komendy.pwn"
#include "graffiti\graffiti.pwn"
#include "03DL\03DL.pwn"
#include "money\money.pwn"
#include "wielkanoc\wielkanoc.pwn"
#include "ibiza\ibiza.pwn"
#include "debug\debug.pwn"
#include "bw\bw.pwn"
#include "discord\discord.pwn"
#include "organizacje\organizacje.pwn"
#include "sannews\sannews.pwn"
#include "animacje\animacje.pwn"
#include "admin\admin.pwn"
#include "wypadek\wypadek.pwn"
#include "logi\logi.pwn"
#include "przedmioty\przedmioty.pwn"
#include "antycheat\antycheat.pwn"
#include "frakcje\frakcje.pwn"
#include "bramy\bramy.pwn"
#include "fishing\fishing.pwn"


//-------<[ timers ]>-------
#include "pojazdy\pojazdy_timers.pwn"
#include "urzadls\urzadls_timers.pwn"
#include "choroby\choroby_timers.pwn"
#include "convoy\convoy_timers.pwn"
#include "prace\prace_timers.pwn"
#include "premium\premium_timers.pwn"
#include "antyspam\antyspam_timers.pwn"
#include "graffiti\graffiti_timers.pwn"
#include "money\money_timers.pwn"
#include "wielkanoc\wielkanoc_timers.pwn"
#include "organizacje\organizacje_timers.pwn"
#include "sannews\sannews_timers.pwn"
#include "admin\admin_timers.pwn"
#include "wypadek\wypadek_timers.pwn"


//-------<[ mysql ]>-------
#include "cooking\cooking_mysql.pwn"
#include "pojazdy\pojazdy_mysql.pwn"
#include "choroby\choroby_mysql.pwn"
#include "player_attachments\player_attachments_mysql.pwn"
#include "biznesy\biznesy_mysql.pwn"
#include "prace\prace_mysql.pwn"
#include "premium\premium_mysql.pwn"
#include "vehicle_attachments\vehicle_attachments_mysql.pwn"
#include "graffiti\graffiti_mysql.pwn"
#include "organizacje\organizacje_mysql.pwn"
#include "admin\admin_mysql.pwn"
#include "fishing\fishing_mysql.pwn"


//-------<[ others ]>-------
#include "choroby\choroby_effects.pwn"
#include "03DL\resources.pwn"


//-------<[ callbacks ]>-------
#include "cooking\cooking_callbacks.pwn"
#include "pojazdy\pojazdy_callbacks.pwn"
#include "choroby\choroby_callbacks.pwn"
#include "player_attachments\player_attachments_callbacks.pwn"
#include "convoy\convoy_callbacks.pwn"
#include "biznesy\biznesy_callbacks.pwn"
#include "prace\prace_callbacks.pwn"
#include "premium\premium_callbacks.pwn"
#include "vehicle_attachments\vehicle_attachments_callbacks.pwn"
#include "money\money_callbacks.pwn"
#include "wielkanoc\wielkanoc_callbacks.pwn"
#include "organizacje\organizacje_callbacks.pwn"
#include "admin\admin_callbacks.pwn"
#include "wypadek\wypadek_callbacks.pwn"
#include "logi\logi_callbacks.pwn"
#include "antycheat\antycheat_callbacks.pwn"
#include "fishing\fishing_callbacks.pwn"


//-------<[ commands ]>-------
#include "cooking\commands\cooking_commands.pwn"
#include "pojazdy\commands\pojazdy_commands.pwn"
#include "urzadls\commands\urzadls_commands.pwn"
#include "choroby\commands\choroby_commands.pwn"
#include "player_attachments\commands\player_attachments_commands.pwn"
#include "convoy\commands\convoy_commands.pwn"
#include "oferty\commands\oferty_commands.pwn"
#include "biznesy\commands\biznesy_commands.pwn"
#include "prace\commands\prace_commands.pwn"
#include "sila\commands\sila_commands.pwn"
#include "chaty\commands\chaty_commands.pwn"
#include "premium\commands\premium_commands.pwn"
#include "vehicle_attachments\commands\vehicle_attachments_commands.pwn"
#include "komendy\commands\komendy_commands.pwn"
#include "graffiti\commands\graffiti_commands.pwn"
#include "ibiza\commands\ibiza_commands.pwn"
#include "debug\commands\debug_commands.pwn"
#include "organizacje\commands\organizacje_commands.pwn"
#include "sannews\commands\sannews_commands.pwn"
#include "animacje\commands\animacje_commands.pwn"
#include "admin\commands\admin_commands.pwn"
#include "wypadek\commands\wypadek_commands.pwn"
#include "logi\commands\logi_commands.pwn"
#include "antycheat\commands\antycheat_commands.pwn"
#include "frakcje\commands\frakcje_commands.pwn"
#include "bramy\commands\bramy_commands.pwn"
#include "fishing\commands\fishing_commands.pwn"
