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
#include "frakcje\frakcje.def"
#include "names\names.def"
#include "admin\admin.def"
#include "pojazdy\pojazdy.def"
#include "actors\actors.def"
#include "chaty\chaty.def"
#include "biznesy\biznesy.def"
#include "debug\debug.def"
#include "fishing\fishing.def"
#include "prace\prace.def"
#include "bramy\bramy.def"
#include "animacje\animacje.def"
#include "bw\bw.def"
#include "wypadek\wypadek.def"
#include "convoy\convoy.def"
#include "przedmioty\przedmioty.def"
#include "logi\logi.def"
#include "graffiti\graffiti.def"
#include "weryfikacje\weryfikacje.def"
#include "adminduty\adminduty.def"
#include "oferty\oferty.def"
#include "player_attachments\player_attachments.def"
#include "wejscia\wejscia.def"
#include "sannews\sannews.def"
#include "antyspam\antyspam.def"
#include "cooking\cooking.def"
#include "03DL\03DL.def"
#include "vehicle_attachments\vehicle_attachments.def"
#include "money\money.def"
#include "sila\sila.def"
#include "organizacje\organizacje.def"
#include "premium\premium.def"
#include "discord\discord.def"
#include "urzadls\urzadls.def"
#include "ibiza\ibiza.def"
#include "budki\budki.def"
#include "antycheat\antycheat.def"
#include "komendy\komendy.def"
#include "choroby\choroby.def"


//-------<[ .hwn ]>-------
#include "frakcje\frakcje.hwn"
#include "names\names.hwn"
#include "admin\admin.hwn"
#include "pojazdy\pojazdy.hwn"
#include "actors\actors.hwn"
#include "chaty\chaty.hwn"
#include "biznesy\biznesy.hwn"
#include "debug\debug.hwn"
#include "fishing\fishing.hwn"
#include "prace\prace.hwn"
#include "bramy\bramy.hwn"
#include "animacje\animacje.hwn"
#include "bw\bw.hwn"
#include "wypadek\wypadek.hwn"
#include "convoy\convoy.hwn"
#include "przedmioty\przedmioty.hwn"
#include "logi\logi.hwn"
#include "graffiti\graffiti.hwn"
#include "weryfikacje\weryfikacje.hwn"
#include "adminduty\adminduty.hwn"
#include "oferty\oferty.hwn"
#include "player_attachments\player_attachments.hwn"
#include "wejscia\wejscia.hwn"
#include "sannews\sannews.hwn"
#include "antyspam\antyspam.hwn"
#include "cooking\cooking.hwn"
#include "03DL\03DL.hwn"
#include "vehicle_attachments\vehicle_attachments.hwn"
#include "money\money.hwn"
#include "sila\sila.hwn"
#include "organizacje\organizacje.hwn"
#include "premium\premium.hwn"
#include "discord\discord.hwn"
#include "urzadls\urzadls.hwn"
#include "ibiza\ibiza.hwn"
#include "budki\budki.hwn"
#include "antycheat\antycheat.hwn"
#include "komendy\komendy.hwn"
#include "choroby\choroby.hwn"


//-------<[ .pwn ]>-------
#include "frakcje\frakcje.pwn"
#include "names\names.pwn"
#include "admin\admin.pwn"
#include "pojazdy\pojazdy.pwn"
#include "actors\actors.pwn"
#include "chaty\chaty.pwn"
#include "biznesy\biznesy.pwn"
#include "debug\debug.pwn"
#include "fishing\fishing.pwn"
#include "prace\prace.pwn"
#include "bramy\bramy.pwn"
#include "animacje\animacje.pwn"
#include "bw\bw.pwn"
#include "wypadek\wypadek.pwn"
#include "convoy\convoy.pwn"
#include "przedmioty\przedmioty.pwn"
#include "logi\logi.pwn"
#include "graffiti\graffiti.pwn"
#include "weryfikacje\weryfikacje.pwn"
#include "adminduty\adminduty.pwn"
#include "oferty\oferty.pwn"
#include "player_attachments\player_attachments.pwn"
#include "wejscia\wejscia.pwn"
#include "sannews\sannews.pwn"
#include "antyspam\antyspam.pwn"
#include "cooking\cooking.pwn"
#include "03DL\03DL.pwn"
#include "vehicle_attachments\vehicle_attachments.pwn"
#include "money\money.pwn"
#include "sila\sila.pwn"
#include "organizacje\organizacje.pwn"
#include "premium\premium.pwn"
#include "discord\discord.pwn"
#include "urzadls\urzadls.pwn"
#include "ibiza\ibiza.pwn"
#include "budki\budki.pwn"
#include "antycheat\antycheat.pwn"
#include "komendy\komendy.pwn"
#include "choroby\choroby.pwn"


//-------<[ timers ]>-------
#include "admin\admin_timers.pwn"
#include "pojazdy\pojazdy_timers.pwn"
#include "prace\prace_timers.pwn"
#include "wypadek\wypadek_timers.pwn"
#include "convoy\convoy_timers.pwn"
#include "graffiti\graffiti_timers.pwn"
#include "weryfikacje\weryfikacje_timers.pwn"
#include "sannews\sannews_timers.pwn"
#include "antyspam\antyspam_timers.pwn"
#include "money\money_timers.pwn"
#include "organizacje\organizacje_timers.pwn"
#include "premium\premium_timers.pwn"
#include "urzadls\urzadls_timers.pwn"
#include "choroby\choroby_timers.pwn"


//-------<[ mysql ]>-------
#include "admin\admin_mysql.pwn"
#include "pojazdy\pojazdy_mysql.pwn"
#include "biznesy\biznesy_mysql.pwn"
#include "fishing\fishing_mysql.pwn"
#include "prace\prace_mysql.pwn"
#include "graffiti\graffiti_mysql.pwn"
#include "weryfikacje\weryfikacje_mysql.pwn"
#include "player_attachments\player_attachments_mysql.pwn"
#include "cooking\cooking_mysql.pwn"
#include "vehicle_attachments\vehicle_attachments_mysql.pwn"
#include "organizacje\organizacje_mysql.pwn"
#include "premium\premium_mysql.pwn"
#include "choroby\choroby_mysql.pwn"


//-------<[ others ]>-------
#include "03DL\resources.pwn"
#include "choroby\choroby_effects.pwn"


//-------<[ callbacks ]>-------
#include "admin\admin_callbacks.pwn"
#include "pojazdy\pojazdy_callbacks.pwn"
#include "biznesy\biznesy_callbacks.pwn"
#include "fishing\fishing_callbacks.pwn"
#include "prace\prace_callbacks.pwn"
#include "wypadek\wypadek_callbacks.pwn"
#include "convoy\convoy_callbacks.pwn"
#include "logi\logi_callbacks.pwn"
#include "player_attachments\player_attachments_callbacks.pwn"
#include "cooking\cooking_callbacks.pwn"
#include "vehicle_attachments\vehicle_attachments_callbacks.pwn"
#include "money\money_callbacks.pwn"
#include "organizacje\organizacje_callbacks.pwn"
#include "premium\premium_callbacks.pwn"
#include "antycheat\antycheat_callbacks.pwn"
#include "choroby\choroby_callbacks.pwn"


//-------<[ commands ]>-------
#include "frakcje\commands\frakcje_commands.pwn"
#include "admin\commands\admin_commands.pwn"
#include "pojazdy\commands\pojazdy_commands.pwn"
#include "chaty\commands\chaty_commands.pwn"
#include "biznesy\commands\biznesy_commands.pwn"
#include "debug\commands\debug_commands.pwn"
#include "fishing\commands\fishing_commands.pwn"
#include "prace\commands\prace_commands.pwn"
#include "bramy\commands\bramy_commands.pwn"
#include "animacje\commands\animacje_commands.pwn"
#include "wypadek\commands\wypadek_commands.pwn"
#include "convoy\commands\convoy_commands.pwn"
#include "logi\commands\logi_commands.pwn"
#include "graffiti\commands\graffiti_commands.pwn"
#include "weryfikacje\commands\weryfikacje_commands.pwn"
#include "oferty\commands\oferty_commands.pwn"
#include "player_attachments\commands\player_attachments_commands.pwn"
#include "sannews\commands\sannews_commands.pwn"
#include "cooking\commands\cooking_commands.pwn"
#include "vehicle_attachments\commands\vehicle_attachments_commands.pwn"
#include "sila\commands\sila_commands.pwn"
#include "organizacje\commands\organizacje_commands.pwn"
#include "premium\commands\premium_commands.pwn"
#include "urzadls\commands\urzadls_commands.pwn"
#include "ibiza\commands\ibiza_commands.pwn"
#include "antycheat\commands\antycheat_commands.pwn"
#include "komendy\commands\komendy_commands.pwn"
#include "choroby\commands\choroby_commands.pwn"
