//------------------------------------------<< Generated source >>-------------------------------------------//
//-----------------------------------------------[ Commands ]------------------------------------------------//
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


#include <YSI\y_hooks>

//-------<[ include ]>-------
#include "a\cmd_a.pwn"
#include "adajrange\cmd_adajrange.pwn"
#include "addcar\cmd_addcar.pwn"
#include "admindutycmd\cmd_admindutycmd.pwn"
#include "admini\cmd_admini.pwn"
#include "adminjail\cmd_adminjail.pwn"
#include "adminkill\cmd_adminkill.pwn"
#include "adminstats\cmd_adminstats.pwn"
#include "ah\cmd_ah.pwn"
#include "akceptujnaprawe\cmd_akceptujnaprawe.pwn"
#include "akceptujtankowanie\cmd_akceptujtankowanie.pwn"
#include "alarm\cmd_alarm.pwn"
#include "alkomat\cmd_alkomat.pwn"
#include "ann\cmd_ann.pwn"
#include "antybh\cmd_antybh.pwn"
#include "anuluj\cmd_anuluj.pwn"
#include "anulujzp\cmd_anulujzp.pwn"
#include "app\cmd_app.pwn"
#include "apteczka\cmd_apteczka.pwn"
#include "aresztuj\cmd_aresztuj.pwn"
#include "armor\cmd_armor.pwn"
#include "asystem\cmd_asystem.pwn"
#include "atakuj\cmd_atakuj.pwn"
#include "autok\cmd_autok.pwn"
#include "autoranny\cmd_autoranny.pwn"
#include "autorzy\cmd_autorzy.pwn"
#include "awans\cmd_awans.pwn"
#include "b\cmd_b.pwn"
#include "balans\cmd_balans.pwn"
#include "ban\cmd_ban.pwn"
#include "bandana\cmd_bandana.pwn"
#include "banip\cmd_banip.pwn"
#include "barierka\cmd_barierka.pwn"
#include "basenstats\cmd_basenstats.pwn"
#include "bdaj\cmd_bdaj.pwn"
#include "bigears\cmd_bigears.pwn"
#include "blackjack\cmd_blackjack.pwn"
#include "blok\cmd_blok.pwn"
#include "blokujnews\cmd_blokujnews.pwn"
#include "blokujnoba\cmd_blokujnoba.pwn"
#include "blokujsprzedaz\cmd_blokujsprzedaz.pwn"
#include "boombox\cmd_boombox.pwn"
#include "boxstats\cmd_boxstats.pwn"
#include "bp\cmd_bp.pwn"
#include "brama\cmd_brama.pwn"
#include "bwcmd\cmd_bwcmd.pwn"
#include "c\cmd_c.pwn"
#include "caluj\cmd_caluj.pwn"
#include "car\cmd_car.pwn"
#include "carjump\cmd_carjump.pwn"
#include "carslot\cmd_carslot.pwn"
#include "cbradio\cmd_cbradio.pwn"
#include "cca\cmd_cca.pwn"
#include "cennik\cmd_cennik.pwn"
#include "check\cmd_check.pwn"
#include "checkadminstats\cmd_checkadminstats.pwn"
#include "checkbw\cmd_checkbw.pwn"
#include "checkcar\cmd_checkcar.pwn"
#include "checkcars\cmd_checkcars.pwn"
#include "checktank\cmd_checktank.pwn"
#include "clearwlall\cmd_clearwlall.pwn"
#include "clearzone\cmd_clearzone.pwn"
#include "cmdinfo\cmd_cmdinfo.pwn"
#include "cnn\cmd_cnn.pwn"
#include "cnnn\cmd_cnnn.pwn"
#include "cp\cmd_cp.pwn"
#include "cp_usun\cmd_cp_usun.pwn"
#include "crimereport\cmd_crimereport.pwn"
#include "cwarsztat\cmd_cwarsztat.pwn"
#include "cygaro\cmd_cygaro.pwn"
#include "czas\cmd_czas.pwn"
#include "czyjtonumer\cmd_czyjtonumer.pwn"
#include "czysc\cmd_czysc.pwn"
#include "dajapteczke\cmd_dajapteczke.pwn"
#include "dajdowozu\cmd_dajdowozu.pwn"
#include "dajdzwiek\cmd_dajdzwiek.pwn"
#include "dajfiltr\cmd_dajfiltr.pwn"
#include "dajkase\cmd_dajkase.pwn"
#include "dajklucze\cmd_dajklucze.pwn"
#include "dajkm\cmd_dajkm.pwn"
#include "dajlideraorg\cmd_dajlideraorg.pwn"
#include "dajpodatek\cmd_dajpodatek.pwn"
#include "dajpomocnika\cmd_dajpomocnika.pwn"
#include "dajrange\cmd_dajrange.pwn"
#include "dajscene\cmd_dajscene.pwn"
#include "dajskryptera\cmd_dajskryptera.pwn"
#include "dajzaufanego\cmd_dajzaufanego.pwn"
#include "datek\cmd_datek.pwn"
#include "degraduj\cmd_degraduj.pwn"
#include "delete3dtext\cmd_delete3dtext.pwn"
#include "deletedom\cmd_deletedom.pwn"
#include "deleteobject\cmd_deleteobject.pwn"
#include "demorgan\cmd_demorgan.pwn"
#include "departament\cmd_departament.pwn"
#include "depo\cmd_depo.pwn"
#include "disabletruckerjob\cmd_disabletruckerjob.pwn"
#include "dl\cmd_dl.pwn"
#include "dn\cmd_dn.pwn"
#include "do\cmd_do.pwn"
#include "dodajweryfikacje\cmd_dodajweryfikacje.pwn"
#include "domint\cmd_domint.pwn"
#include "dopasuj\cmd_dopasuj.pwn"
#include "dpa\cmd_dpa.pwn"
#include "dr\cmd_dr.pwn"
#include "dskill\cmd_dskill.pwn"
#include "dsus\cmd_dsus.pwn"
#include "dutycd\cmd_dutycd.pwn"
#include "dzwon\cmd_dzwon.pwn"
#include "edytuj\cmd_edytuj.pwn"
#include "edytujupr\cmd_edytujupr.pwn"
#include "elo\cmd_elo.pwn"
#include "elo2\cmd_elo2.pwn"
#include "endround\cmd_endround.pwn"
#include "entercar\cmd_entercar.pwn"
#include "fbidrzwi\cmd_fbidrzwi.pwn"
#include "fdaj\cmd_fdaj.pwn"
#include "federalne\cmd_federalne.pwn"
#include "finfo\cmd_finfo.pwn"
#include "finisz\cmd_finisz.pwn"
#include "fixallveh\cmd_fixallveh.pwn"
#include "fixr\cmd_fixr.pwn"
#include "fixveh\cmd_fixveh.pwn"
#include "flip\cmd_flip.pwn"
#include "fly\cmd_fly.pwn"
#include "fooc\cmd_fooc.pwn"
#include "forceskin\cmd_forceskin.pwn"
#include "forum\cmd_forum.pwn"
#include "fpanel\cmd_fpanel.pwn"
#include "fracinfo\cmd_fracinfo.pwn"
#include "fskin\cmd_fskin.pwn"
#include "getcar\cmd_getcar.pwn"
#include "gethere\cmd_gethere.pwn"
#include "getint\cmd_getint.pwn"
#include "getposp\cmd_getposp.pwn"
#include "getvw\cmd_getvw.pwn"
#include "givegun\cmd_givegun.pwn"
#include "giveroom\cmd_giveroom.pwn"
#include "glosnik\cmd_glosnik.pwn"
#include "glosowanie\cmd_glosowanie.pwn"
#include "goto\cmd_goto.pwn"
#include "gotoadmin\cmd_gotoadmin.pwn"
#include "gotobank\cmd_gotobank.pwn"
#include "gotocar\cmd_gotocar.pwn"
#include "gotoczit\cmd_gotoczit.pwn"
#include "gotodom\cmd_gotodom.pwn"
#include "gotoin\cmd_gotoin.pwn"
#include "gotoint\cmd_gotoint.pwn"
#include "gotojet\cmd_gotojet.pwn"
#include "gotols\cmd_gotols.pwn"
#include "gotolv\cmd_gotolv.pwn"
#include "gotomark\cmd_gotomark.pwn"
#include "gotomechy\cmd_gotomechy.pwn"
#include "gotopos\cmd_gotopos.pwn"
#include "gotosalon\cmd_gotosalon.pwn"
#include "gotosf\cmd_gotosf.pwn"
#include "gotostacja\cmd_gotostacja.pwn"
#include "gotostad\cmd_gotostad.pwn"
#include "gotoszpital\cmd_gotoszpital.pwn"
#include "gps\cmd_gps.pwn"
#include "house\cmd_house.pwn"
#include "houseinfo\cmd_houseinfo.pwn"
#include "houseowner\cmd_houseowner.pwn"
#include "hpall\cmd_hpall.pwn"
#include "hq\cmd_hq.pwn"
#include "i\cmd_i.pwn"
#include "icons\cmd_icons.pwn"
#include "id\cmd_id.pwn"
#include "idz\cmd_idz.pwn"
#include "innyspawn\cmd_innyspawn.pwn"
#include "inwigilacja\cmd_inwigilacja.pwn"
#include "ip\cmd_ip.pwn"
#include "irc\cmd_irc.pwn"
#include "ja\cmd_ja.pwn"
#include "jail\cmd_jail.pwn"
#include "jump\cmd_jump.pwn"
#include "k\cmd_k.pwn"
#include "kamera\cmd_kamera.pwn"
#include "kamera_wiezienie\cmd_kamera_wiezienie.pwn"
#include "kamerau\cmd_kamerau.pwn"
#include "kamizelka\cmd_kamizelka.pwn"
#include "kanister\cmd_kanister.pwn"
#include "kasa\cmd_kasa.pwn"
#include "kaucja\cmd_kaucja.pwn"
#include "kb\cmd_kb.pwn"
#include "kick\cmd_kick.pwn"
#include "kickall\cmd_kickall.pwn"
#include "killall\cmd_killall.pwn"
#include "kmwyniki\cmd_kmwyniki.pwn"
#include "kod\cmd_kod.pwn"
#include "kogut\cmd_kogut.pwn"
#include "kolejka\cmd_kolejka.pwn"
#include "kolo\cmd_kolo.pwn"
#include "komandos\cmd_komandos.pwn"
#include "komendacmd\cmd_komendacmd.pwn"
#include "komendycmd\cmd_komendycmd.pwn"
#include "komentuj\cmd_komentuj.pwn"
#include "konsola\cmd_konsola.pwn"
#include "kontakty\cmd_kontakty.pwn"
#include "kontrakt\cmd_kontrakt.pwn"
#include "kostka\cmd_kostka.pwn"
#include "kostka2\cmd_kostka2.pwn"
#include "koxubankot\cmd_koxubankot.pwn"
#include "kradnij\cmd_kradnij.pwn"
#include "ksam\cmd_ksam.pwn"
#include "ksiazkatel\cmd_ksiazkatel.pwn"
#include "kup\cmd_kup.pwn"
#include "kupbiletpociag\cmd_kupbiletpociag.pwn"
#include "kupdildo\cmd_kupdildo.pwn"
#include "kuphelikopter\cmd_kuphelikopter.pwn"
#include "kupkredyty\cmd_kupkredyty.pwn"
#include "kuplodzie\cmd_kuplodzie.pwn"
#include "kupowaniedomu\cmd_kupowaniedomu.pwn"
#include "kuppojazd\cmd_kuppojazd.pwn"
#include "kuppozwolenie\cmd_kuppozwolenie.pwn"
#include "kupsamoloty\cmd_kupsamoloty.pwn"
#include "kupskin\cmd_kupskin.pwn"
#include "laptop\cmd_laptop.pwn"
#include "licencje\cmd_licencje.pwn"
#include "linie\cmd_linie.pwn"
#include "lkiz\cmd_lkiz.pwn"
#include "loadconfig\cmd_loadconfig.pwn"
#include "loadinfo\cmd_loadinfo.pwn"
#include "lock\cmd_lock.pwn"
#include "lockint\cmd_lockint.pwn"
#include "login\cmd_login.pwn"
#include "losowostworzdom\cmd_losowostworzdom.pwn"
#include "losowypozar\cmd_losowypozar.pwn"
#include "lot\cmd_lot.pwn"
#include "lotto\cmd_lotto.pwn"
#include "lsmcelevator\cmd_lsmcelevator.pwn"
#include "makeircadmin\cmd_makeircadmin.pwn"
#include "makeleader\cmd_makeleader.pwn"
#include "makemember\cmd_makemember.pwn"
#include "makevlider\cmd_makevlider.pwn"
#include "mandacik\cmd_mandacik.pwn"
#include "mark\cmd_mark.pwn"
#include "maska\cmd_maska.pwn"
#include "materialy\cmd_materialy.pwn"
#include "mdc\cmd_mdc.pwn"
#include "megafon\cmd_megafon.pwn"
#include "mi\cmd_mi.pwn"
#include "mikser\cmd_mikser.pwn"
#include "mojeauta\cmd_mojeauta.pwn"
#include "mojskin\cmd_mojskin.pwn"
#include "mole\cmd_mole.pwn"
#include "mp3\cmd_mp3.pwn"
#include "msgbox\cmd_msgbox.pwn"
#include "muzyczka\cmd_muzyczka.pwn"
#include "namierz\cmd_namierz.pwn"
#include "nastepnylevel\cmd_nastepnylevel.pwn"
#include "naucz\cmd_naucz.pwn"
#include "nazywo\cmd_nazywo.pwn"
#include "newbie\cmd_newbie.pwn"
#include "newcar\cmd_newcar.pwn"
#include "news2\cmd_news2.pwn"
#include "nonewbie\cmd_nonewbie.pwn"
#include "noooc\cmd_noooc.pwn"
#include "o\cmd_o.pwn"
#include "obrazenia\cmd_obrazenia.pwn"
#include "oczyscmdc\cmd_oczyscmdc.pwn"
#include "od\cmd_od.pwn"
#include "odmroz\cmd_odmroz.pwn"
#include "odmv\cmd_odmv.pwn"
#include "odpal\cmd_odpal.pwn"
#include "odznaka\cmd_odznaka.pwn"
#include "og\cmd_og.pwn"
#include "okienko\cmd_okienko.pwn"
#include "oldcar\cmd_oldcar.pwn"
#include "opis\cmd_opis.pwn"
#include "opuscdom\cmd_opuscdom.pwn"
#include "otworzlinie\cmd_otworzlinie.pwn"
#include "owarsztat\cmd_owarsztat.pwn"
#include "paj\cmd_paj.pwn"
#include "paka\cmd_paka.pwn"
#include "paliwo\cmd_paliwo.pwn"
#include "panel\cmd_panel.pwn"
#include "panelbasenu\cmd_panelbasenu.pwn"
#include "panelvinyl\cmd_panelvinyl.pwn"
#include "paralizator\cmd_paralizator.pwn"
#include "patrol\cmd_patrol.pwn"
#include "pban\cmd_pban.pwn"
#include "pblok\cmd_pblok.pwn"
#include "personalizuj\cmd_personalizuj.pwn"
#include "piwo\cmd_piwo.pwn"
#include "pjtest\cmd_pjtest.pwn"
#include "pl\cmd_pl.pwn"
#include "plac\cmd_plac.pwn"
#include "placmedyk\cmd_placmedyk.pwn"
#include "po\cmd_po.pwn"
#include "podatek\cmd_podatek.pwn"
#include "poddajesie\cmd_poddajesie.pwn"
#include "poddajsie\cmd_poddajsie.pwn"
#include "podglad\cmd_podglad.pwn"
#include "pogodaall\cmd_pogodaall.pwn"
#include "pojazdygracza\cmd_pojazdygracza.pwn"
#include "pokazcb\cmd_pokazcb.pwn"
#include "pokazdowod\cmd_pokazdowod.pwn"
#include "polej\cmd_polej.pwn"
#include "poszukuj\cmd_poszukuj.pwn"
#include "pozwolenie\cmd_pozwolenie.pwn"
#include "przebierz\cmd_przebierz.pwn"
#include "przedmiotycmd\cmd_przedmiotycmd.pwn"
#include "przejazd\cmd_przejazd.pwn"
#include "przelew\cmd_przelew.pwn"
#include "przeszukaj\cmd_przeszukaj.pwn"
#include "przyjmij\cmd_przyjmij.pwn"
#include "pwarn\cmd_pwarn.pwn"
#include "qf\cmd_qf.pwn"
#include "quitpraca\cmd_quitpraca.pwn"
#include "r\cmd_r.pwn"
#include "radiostacja\cmd_radiostacja.pwn"
#include "ranny\cmd_ranny.pwn"
#include "rapidfly\cmd_rapidfly.pwn"
#include "raport\cmd_raport.pwn"
#include "re\cmd_re.pwn"
#include "red\cmd_red.pwn"
#include "reflektor\cmd_reflektor.pwn"
#include "reklama\cmd_reklama.pwn"
#include "reloadbans\cmd_reloadbans.pwn"
#include "removecar\cmd_removecar.pwn"
#include "removeganglimit\cmd_removeganglimit.pwn"
#include "removezoneprotect\cmd_removezoneprotect.pwn"
#include "rentroom\cmd_rentroom.pwn"
#include "reset_ulepszen\cmd_reset_ulepszen.pwn"
#include "resetsejfhasla\cmd_resetsejfhasla.pwn"
#include "resms\cmd_resms.pwn"
#include "respawn\cmd_respawn.pwn"
#include "respawncar\cmd_respawncar.pwn"
#include "respawnplayer\cmd_respawnplayer.pwn"
#include "restart\cmd_restart.pwn"
#include "rezonans\cmd_rezonans.pwn"
#include "rodzinny\cmd_rodzinny.pwn"
#include "roleta\cmd_roleta.pwn"
#include "rooc\cmd_rooc.pwn"
#include "rozbierz\cmd_rozbierz.pwn"
#include "rozwiaz\cmd_rozwiaz.pwn"
#include "rozwiedz\cmd_rozwiedz.pwn"
#include "rozwod\cmd_rozwod.pwn"
#include "ruleta\cmd_ruleta.pwn"
#include "sad\cmd_sad.pwn"
#include "say\cmd_say.pwn"
#include "sb\cmd_sb.pwn"
#include "sban\cmd_sban.pwn"
#include "sblock\cmd_sblock.pwn"
#include "sblok\cmd_sblok.pwn"
#include "scena\cmd_scena.pwn"
#include "scenaallow\cmd_scenaallow.pwn"
#include "scenadisallow\cmd_scenadisallow.pwn"
#include "screenshot\cmd_screenshot.pwn"
#include "sejfpomoc\cmd_sejfpomoc.pwn"
#include "selldom\cmd_selldom.pwn"
#include "setactoranime\cmd_setactoranime.pwn"
#include "setarmor\cmd_setarmor.pwn"
#include "setcarhp\cmd_setcarhp.pwn"
#include "setcarint\cmd_setcarint.pwn"
#include "setcarvw\cmd_setcarvw.pwn"
#include "setdrunk\cmd_setdrunk.pwn"
#include "setint\cmd_setint.pwn"
#include "setmats\cmd_setmats.pwn"
#include "setname\cmd_setname.pwn"
#include "setplocal\cmd_setplocal.pwn"
#include "setpogoda\cmd_setpogoda.pwn"
#include "setserverpass\cmd_setserverpass.pwn"
#include "setskin\cmd_setskin.pwn"
#include "setslot\cmd_setslot.pwn"
#include "setstat\cmd_setstat.pwn"
#include "setstrong\cmd_setstrong.pwn"
#include "setveh\cmd_setveh.pwn"
#include "setvw\cmd_setvw.pwn"
#include "sex\cmd_sex.pwn"
#include "sh\cmd_sh.pwn"
#include "showkary\cmd_showkary.pwn"
#include "skick\cmd_skick.pwn"
#include "skill\cmd_skill.pwn"
#include "skinf\cmd_skinf.pwn"
#include "skret\cmd_skret.pwn"
#include "skydive\cmd_skydive.pwn"
#include "slap\cmd_slap.pwn"
#include "slub\cmd_slub.pwn"
#include "sluzba\cmd_sluzba.pwn"
#include "sms\cmd_sms.pwn"
#include "snn\cmd_snn.pwn"
#include "spec\cmd_spec.pwn"
#include "spoiler\cmd_spoiler.pwn"
#include "spoilery\cmd_spoilery.pwn"
#include "sprawdzczasgry\cmd_sprawdzczasgry.pwn"
#include "sprawdzdom\cmd_sprawdzdom.pwn"
#include "sprawdzin\cmd_sprawdzin.pwn"
#include "sprawdzinv\cmd_sprawdzinv.pwn"
#include "sprawdzkase\cmd_sprawdzkase.pwn"
#include "sprawdzkredyty\cmd_sprawdzkredyty.pwn"
#include "sprawdztest\cmd_sprawdztest.pwn"
#include "sprobuj\cmd_sprobuj.pwn"
#include "sprunk\cmd_sprunk.pwn"
#include "sprzedajalkohol\cmd_sprzedajalkohol.pwn"
#include "sprzedajauto\cmd_sprzedajauto.pwn"
#include "sprzedajbron\cmd_sprzedajbron.pwn"
#include "sprzedajmaterialy\cmd_sprzedajmaterialy.pwn"
#include "stan\cmd_stan.pwn"
#include "startlotto\cmd_startlotto.pwn"
#include "startskinevent\cmd_startskinevent.pwn"
#include "startujlekcje\cmd_startujlekcje.pwn"
#include "staty\cmd_staty.pwn"
#include "staty2\cmd_staty2.pwn"
#include "stopanim\cmd_stopanim.pwn"
#include "stopbieg\cmd_stopbieg.pwn"
#include "streamer\cmd_streamer.pwn"
#include "strefagangu\cmd_strefagangu.pwn"
#include "studia\cmd_studia.pwn"
#include "stworzdom\cmd_stworzdom.pwn"
#include "stworztrase\cmd_stworztrase.pwn"
#include "swat\cmd_swat.pwn"
#include "swiadek\cmd_swiadek.pwn"
#include "szept\cmd_szept.pwn"
#include "szturmowy\cmd_szturmowy.pwn"
#include "szukani\cmd_szukani.pwn"
#include "tablet\cmd_tablet.pwn"
#include "tankujauta\cmd_tankujauta.pwn"
#include "tankveh\cmd_tankveh.pwn"
#include "taryfikator\cmd_taryfikator.pwn"
#include "teczka\cmd_teczka.pwn"
#include "teleturniej\cmd_teleturniej.pwn"
#include "temat\cmd_temat.pwn"
#include "ticketend\cmd_ticketend.pwn"
#include "tickets\cmd_tickets.pwn"
#include "tod\cmd_tod.pwn"
#include "togadmin\cmd_togadmin.pwn"
#include "togadminmess\cmd_togadminmess.pwn"
#include "togbw\cmd_togbw.pwn"
#include "togcb\cmd_togcb.pwn"
#include "togdepo\cmd_togdepo.pwn"
#include "togfam\cmd_togfam.pwn"
#include "togfinfo\cmd_togfinfo.pwn"
#include "togglepozwo\cmd_togglepozwo.pwn"
#include "toglicznik\cmd_toglicznik.pwn"
#include "togname\cmd_togname.pwn"
#include "tognewbie\cmd_tognewbie.pwn"
#include "togooc\cmd_togooc.pwn"
#include "togopis\cmd_togopis.pwn"
#include "togpodglad\cmd_togpodglad.pwn"
#include "togro\cmd_togro.pwn"
#include "togscroll\cmd_togscroll.pwn"
#include "togtxda\cmd_togtxda.pwn"
#include "togvopis\cmd_togvopis.pwn"
#include "togwl\cmd_togwl.pwn"
#include "tp\cmd_tp.pwn"
#include "trampolina\cmd_trampolina.pwn"
#include "trasy\cmd_trasy.pwn"
#include "trasybiegu\cmd_trasybiegu.pwn"
#include "ubranie\cmd_ubranie.pwn"
#include "ucisz\cmd_ucisz.pwn"
#include "uid\cmd_uid.pwn"
#include "ulepsz\cmd_ulepsz.pwn"
#include "unblock\cmd_unblock.pwn"
#include "unbp\cmd_unbp.pwn"
#include "unbw\cmd_unbw.pwn"
#include "undemorgan\cmd_undemorgan.pwn"
#include "unfrakcja\cmd_unfrakcja.pwn"
#include "unjail\cmd_unjail.pwn"
#include "unrentroom\cmd_unrentroom.pwn"
#include "unspec\cmd_unspec.pwn"
#include "unwarn\cmd_unwarn.pwn"
#include "up\cmd_up.pwn"
#include "uprawnienia\cmd_uprawnienia.pwn"
#include "ustawcena\cmd_ustawcena.pwn"
#include "ustawmistrz\cmd_ustawmistrz.pwn"
#include "usunbron\cmd_usunbron.pwn"
#include "usunopis\cmd_usunopis.pwn"
#include "usunpozar\cmd_usunpozar.pwn"
#include "usunzaufanego\cmd_usunzaufanego.pwn"
#include "uwb\cmd_uwb.pwn"
#include "veh\cmd_veh.pwn"
#include "vinyl\cmd_vinyl.pwn"
#include "vopis\cmd_vopis.pwn"
#include "walka\cmd_walka.pwn"
#include "warn\cmd_warn.pwn"
#include "wczytajrangi\cmd_wczytajrangi.pwn"
#include "wczytajskiny\cmd_wczytajskiny.pwn"
#include "wczytajskrypt\cmd_wczytajskrypt.pwn"
#include "wejdz\cmd_wejdz.pwn"
#include "wejdzw\cmd_wejdzw.pwn"
#include "wez\cmd_wez.pwn"
#include "wezportfel\cmd_wezportfel.pwn"
#include "wezwij\cmd_wezwij.pwn"
#include "wezwijwoz\cmd_wezwijwoz.pwn"
#include "wezzlecenie\cmd_wezzlecenie.pwn"
#include "wiadomosc\cmd_wiadomosc.pwn"
#include "wieza\cmd_wieza.pwn"
#include "winda\cmd_winda.pwn"
#include "winda2\cmd_winda2.pwn"
#include "windalock\cmd_windalock.pwn"
#include "witaj\cmd_witaj.pwn"
#include "wizytowka\cmd_wizytowka.pwn"
#include "wk\cmd_wk.pwn"
#include "wlsett\cmd_wlsett.pwn"
#include "wobiekt\cmd_wobiekt.pwn"
#include "worek\cmd_worek.pwn"
#include "wplac\cmd_wplac.pwn"
#include "wrzuc\cmd_wrzuc.pwn"
#include "wybieralka\cmd_wybieralka.pwn"
#include "wyczysc\cmd_wyczysc.pwn"
#include "wyjdz\cmd_wyjdz.pwn"
#include "wyjedz\cmd_wyjedz.pwn"
#include "wyloguj\cmd_wyloguj.pwn"
#include "wylogujall\cmd_wylogujall.pwn"
#include "wylogujgracz\cmd_wylogujgracz.pwn"
#include "wymiana\cmd_wymiana.pwn"
#include "wyniki\cmd_wyniki.pwn"
#include "wypij\cmd_wypij.pwn"
#include "wypisz\cmd_wypisz.pwn"
#include "wyplac\cmd_wyplac.pwn"
#include "wypusc\cmd_wypusc.pwn"
#include "wyrzucbronie\cmd_wyrzucbronie.pwn"
#include "wyscig\cmd_wyscig.pwn"
#include "wyscig_start\cmd_wyscig_start.pwn"
#include "wyscig_stop\cmd_wyscig_stop.pwn"
#include "wywal\cmd_wywal.pwn"
#include "wywalcb\cmd_wywalcb.pwn"
#include "wywaldmv\cmd_wywaldmv.pwn"
#include "wywaldragi\cmd_wywaldragi.pwn"
#include "wywalmaterialy\cmd_wywalmaterialy.pwn"
#include "wywaltelefon\cmd_wywaltelefon.pwn"
#include "wywalzsad\cmd_wywalzsad.pwn"
#include "wywaz\cmd_wywaz.pwn"
#include "yo\cmd_yo.pwn"
#include "yo2\cmd_yo2.pwn"
#include "yo3\cmd_yo3.pwn"
#include "yo4\cmd_yo4.pwn"
#include "z\cmd_z.pwn"
#include "zabierz\cmd_zabierz.pwn"
#include "zabierzgps\cmd_zabierzgps.pwn"
#include "zabierzlideraorg\cmd_zabierzlideraorg.pwn"
#include "zablokujtel\cmd_zablokujtel.pwn"
#include "zablokujw\cmd_zablokujw.pwn"
#include "zaliczegz\cmd_zaliczegz.pwn"
#include "zamknijlinie\cmd_zamknijlinie.pwn"
#include "zamroz\cmd_zamroz.pwn"
#include "zaparkuj\cmd_zaparkuj.pwn"
#include "zapiszdomy\cmd_zapiszdomy.pwn"
#include "zapiszkonta\cmd_zapiszkonta.pwn"
#include "zapytaj\cmd_zapytaj.pwn"
#include "zasady\cmd_zasady.pwn"
#include "zatankuj\cmd_zatankuj.pwn"
#include "zatrzymajlekcje\cmd_zatrzymajlekcje.pwn"
#include "zaufani\cmd_zaufani.pwn"
#include "zaufanioff\cmd_zaufanioff.pwn"
#include "zaufanion\cmd_zaufanion.pwn"
#include "zaufanyggracz\cmd_zaufanyggracz.pwn"
#include "zawodnicy\cmd_zawodnicy.pwn"
#include "zawodnik\cmd_zawodnik.pwn"
#include "zaznacz\cmd_zaznacz.pwn"
#include "zbijwl\cmd_zbijwl.pwn"
#include "zdejmijkevlar\cmd_zdejmijkevlar.pwn"
#include "zdmv\cmd_zdmv.pwn"
#include "zgas\cmd_zgas.pwn"
#include "zk\cmd_zk.pwn"
#include "zlomuj\cmd_zlomuj.pwn"
#include "zmiendom\cmd_zmiendom.pwn"
#include "zmiendomk\cmd_zmiendomk.pwn"
#include "zmienhaslo\cmd_zmienhaslo.pwn"
#include "zmienhp\cmd_zmienhp.pwn"
#include "zmiennick\cmd_zmiennick.pwn"
#include "zmienplec\cmd_zmienplec.pwn"
#include "zmienprace\cmd_zmienprace.pwn"
#include "zmienskin\cmd_zmienskin.pwn"
#include "zmienwl\cmd_zmienwl.pwn"
#include "zniszczobiekty\cmd_zniszczobiekty.pwn"
#include "zonedelay\cmd_zonedelay.pwn"
#include "zoneid\cmd_zoneid.pwn"
#include "zrobkolejke\cmd_zrobkolejke.pwn"
#include "zuzel\cmd_zuzel.pwn"
#include "zuzel_start\cmd_zuzel_start.pwn"
#include "zuzel_stop\cmd_zuzel_stop.pwn"
#include "zwiaz\cmd_zwiaz.pwn"
#include "zwolnij\cmd_zwolnij.pwn"


//-------<[ initialize ]>-------
hook OnGameModeInit()
{
    command_a();
    command_adajrange();
    command_addcar();
    command_admindutycmd();
    command_admini();
    command_adminjail();
    command_adminkill();
    command_adminstats();
    command_ah();
    command_akceptujnaprawe();
    command_akceptujtankowanie();
    command_alarm();
    command_alkomat();
    command_ann();
    command_antybh();
    command_anuluj();
    command_anulujzp();
    command_app();
    command_apteczka();
    command_aresztuj();
    command_armor();
    command_asystem();
    command_atakuj();
    command_autok();
    command_autoranny();
    command_autorzy();
    command_awans();
    command_b();
    command_balans();
    command_ban();
    command_bandana();
    command_banip();
    command_barierka();
    command_basenstats();
    command_bdaj();
    command_bigears();
    command_blackjack();
    command_blok();
    command_blokujnews();
    command_blokujnoba();
    command_blokujsprzedaz();
    command_boombox();
    command_boxstats();
    command_bp();
    command_brama();
    command_bwcmd();
    command_c();
    command_caluj();
    command_car();
    command_carjump();
    command_carslot();
    command_cbradio();
    command_cca();
    command_cennik();
    command_check();
    command_checkadminstats();
    command_checkbw();
    command_checkcar();
    command_checkcars();
    command_checktank();
    command_clearwlall();
    command_clearzone();
    command_cmdinfo();
    command_cnn();
    command_cnnn();
    command_cp();
    command_cp_usun();
    command_crimereport();
    command_cwarsztat();
    command_cygaro();
    command_czas();
    command_czyjtonumer();
    command_czysc();
    command_dajapteczke();
    command_dajdowozu();
    command_dajdzwiek();
    command_dajfiltr();
    command_dajkase();
    command_dajklucze();
    command_dajkm();
    command_dajlideraorg();
    command_dajpodatek();
    command_dajpomocnika();
    command_dajrange();
    command_dajscene();
    command_dajskryptera();
    command_dajzaufanego();
    command_datek();
    command_degraduj();
    command_delete3dtext();
    command_deletedom();
    command_deleteobject();
    command_demorgan();
    command_departament();
    command_depo();
    command_disabletruckerjob();
    command_dl();
    command_dn();
    command_do();
    command_dodajweryfikacje();
    command_domint();
    command_dopasuj();
    command_dpa();
    command_dr();
    command_dskill();
    command_dsus();
    command_dutycd();
    command_dzwon();
    command_edytuj();
    command_edytujupr();
    command_elo();
    command_elo2();
    command_endround();
    command_entercar();
    command_fbidrzwi();
    command_fdaj();
    command_federalne();
    command_finfo();
    command_finisz();
    command_fixallveh();
    command_fixr();
    command_fixveh();
    command_flip();
    command_fly();
    command_fooc();
    command_forceskin();
    command_forum();
    command_fpanel();
    command_fracinfo();
    command_fskin();
    command_getcar();
    command_gethere();
    command_getint();
    command_getposp();
    command_getvw();
    command_givegun();
    command_giveroom();
    command_glosnik();
    command_glosowanie();
    command_goto();
    command_gotoadmin();
    command_gotobank();
    command_gotocar();
    command_gotoczit();
    command_gotodom();
    command_gotoin();
    command_gotoint();
    command_gotojet();
    command_gotols();
    command_gotolv();
    command_gotomark();
    command_gotomechy();
    command_gotopos();
    command_gotosalon();
    command_gotosf();
    command_gotostacja();
    command_gotostad();
    command_gotoszpital();
    command_gps();
    command_house();
    command_houseinfo();
    command_houseowner();
    command_hpall();
    command_hq();
    command_i();
    command_icons();
    command_id();
    command_idz();
    command_innyspawn();
    command_inwigilacja();
    command_ip();
    command_irc();
    command_ja();
    command_jail();
    command_jump();
    command_k();
    command_kamera();
    command_kamera_wiezienie();
    command_kamerau();
    command_kamizelka();
    command_kanister();
    command_kasa();
    command_kaucja();
    command_kb();
    command_kick();
    command_kickall();
    command_killall();
    command_kmwyniki();
    command_kod();
    command_kogut();
    command_kolejka();
    command_kolo();
    command_komandos();
    command_komendacmd();
    command_komendycmd();
    command_komentuj();
    command_konsola();
    command_kontakty();
    command_kontrakt();
    command_kostka();
    command_kostka2();
    command_koxubankot();
    command_kradnij();
    command_ksam();
    command_ksiazkatel();
    command_kup();
    command_kupbiletpociag();
    command_kupdildo();
    command_kuphelikopter();
    command_kupkredyty();
    command_kuplodzie();
    command_kupowaniedomu();
    command_kuppojazd();
    command_kuppozwolenie();
    command_kupsamoloty();
    command_kupskin();
    command_laptop();
    command_licencje();
    command_linie();
    command_lkiz();
    command_loadconfig();
    command_loadinfo();
    command_lock();
    command_lockint();
    command_login();
    command_losowostworzdom();
    command_losowypozar();
    command_lot();
    command_lotto();
    command_lsmcelevator();
    command_makeircadmin();
    command_makeleader();
    command_makemember();
    command_makevlider();
    command_mandacik();
    command_mark();
    command_maska();
    command_materialy();
    command_mdc();
    command_megafon();
    command_mi();
    command_mikser();
    command_mojeauta();
    command_mojskin();
    command_mole();
    command_mp3();
    command_msgbox();
    command_muzyczka();
    command_namierz();
    command_nastepnylevel();
    command_naucz();
    command_nazywo();
    command_newbie();
    command_newcar();
    command_news2();
    command_nonewbie();
    command_noooc();
    command_o();
    command_obrazenia();
    command_oczyscmdc();
    command_od();
    command_odmroz();
    command_odmv();
    command_odpal();
    command_odznaka();
    command_og();
    command_okienko();
    command_oldcar();
    command_opis();
    command_opuscdom();
    command_otworzlinie();
    command_owarsztat();
    command_paj();
    command_paka();
    command_paliwo();
    command_panel();
    command_panelbasenu();
    command_panelvinyl();
    command_paralizator();
    command_patrol();
    command_pban();
    command_pblok();
    command_personalizuj();
    command_piwo();
    command_pjtest();
    command_pl();
    command_plac();
    command_placmedyk();
    command_po();
    command_podatek();
    command_poddajesie();
    command_poddajsie();
    command_podglad();
    command_pogodaall();
    command_pojazdygracza();
    command_pokazcb();
    command_pokazdowod();
    command_polej();
    command_poszukuj();
    command_pozwolenie();
    command_przebierz();
    command_przedmiotycmd();
    command_przejazd();
    command_przelew();
    command_przeszukaj();
    command_przyjmij();
    command_pwarn();
    command_qf();
    command_quitpraca();
    command_r();
    command_radiostacja();
    command_ranny();
    command_rapidfly();
    command_raport();
    command_re();
    command_red();
    command_reflektor();
    command_reklama();
    command_reloadbans();
    command_removecar();
    command_removeganglimit();
    command_removezoneprotect();
    command_rentroom();
    command_reset_ulepszen();
    command_resetsejfhasla();
    command_resms();
    command_respawn();
    command_respawncar();
    command_respawnplayer();
    command_restart();
    command_rezonans();
    command_rodzinny();
    command_roleta();
    command_rooc();
    command_rozbierz();
    command_rozwiaz();
    command_rozwiedz();
    command_rozwod();
    command_ruleta();
    command_sad();
    command_say();
    command_sb();
    command_sban();
    command_sblock();
    command_sblok();
    command_scena();
    command_scenaallow();
    command_scenadisallow();
    command_screenshot();
    command_sejfpomoc();
    command_selldom();
    command_setactoranime();
    command_setarmor();
    command_setcarhp();
    command_setcarint();
    command_setcarvw();
    command_setdrunk();
    command_setint();
    command_setmats();
    command_setname();
    command_setplocal();
    command_setpogoda();
    command_setserverpass();
    command_setskin();
    command_setslot();
    command_setstat();
    command_setstrong();
    command_setveh();
    command_setvw();
    command_sex();
    command_sh();
    command_showkary();
    command_skick();
    command_skill();
    command_skinf();
    command_skret();
    command_skydive();
    command_slap();
    command_slub();
    command_sluzba();
    command_sms();
    command_snn();
    command_spec();
    command_spoiler();
    command_spoilery();
    command_sprawdzczasgry();
    command_sprawdzdom();
    command_sprawdzin();
    command_sprawdzinv();
    command_sprawdzkase();
    command_sprawdzkredyty();
    command_sprawdztest();
    command_sprobuj();
    command_sprunk();
    command_sprzedajalkohol();
    command_sprzedajauto();
    command_sprzedajbron();
    command_sprzedajmaterialy();
    command_stan();
    command_startlotto();
    command_startskinevent();
    command_startujlekcje();
    command_staty();
    command_staty2();
    command_stopanim();
    command_stopbieg();
    command_streamer();
    command_strefagangu();
    command_studia();
    command_stworzdom();
    command_stworztrase();
    command_swat();
    command_swiadek();
    command_szept();
    command_szturmowy();
    command_szukani();
    command_tablet();
    command_tankujauta();
    command_tankveh();
    command_taryfikator();
    command_teczka();
    command_teleturniej();
    command_temat();
    command_ticketend();
    command_tickets();
    command_tod();
    command_togadmin();
    command_togadminmess();
    command_togbw();
    command_togcb();
    command_togdepo();
    command_togfam();
    command_togfinfo();
    command_togglepozwo();
    command_toglicznik();
    command_togname();
    command_tognewbie();
    command_togooc();
    command_togopis();
    command_togpodglad();
    command_togro();
    command_togscroll();
    command_togtxda();
    command_togvopis();
    command_togwl();
    command_tp();
    command_trampolina();
    command_trasy();
    command_trasybiegu();
    command_ubranie();
    command_ucisz();
    command_uid();
    command_ulepsz();
    command_unblock();
    command_unbp();
    command_unbw();
    command_undemorgan();
    command_unfrakcja();
    command_unjail();
    command_unrentroom();
    command_unspec();
    command_unwarn();
    command_up();
    command_uprawnienia();
    command_ustawcena();
    command_ustawmistrz();
    command_usunbron();
    command_usunopis();
    command_usunpozar();
    command_usunzaufanego();
    command_uwb();
    command_veh();
    command_vinyl();
    command_vopis();
    command_walka();
    command_warn();
    command_wczytajrangi();
    command_wczytajskiny();
    command_wczytajskrypt();
    command_wejdz();
    command_wejdzw();
    command_wez();
    command_wezportfel();
    command_wezwij();
    command_wezwijwoz();
    command_wezzlecenie();
    command_wiadomosc();
    command_wieza();
    command_winda();
    command_winda2();
    command_windalock();
    command_witaj();
    command_wizytowka();
    command_wk();
    command_wlsett();
    command_wobiekt();
    command_worek();
    command_wplac();
    command_wrzuc();
    command_wybieralka();
    command_wyczysc();
    command_wyjdz();
    command_wyjedz();
    command_wyloguj();
    command_wylogujall();
    command_wylogujgracz();
    command_wymiana();
    command_wyniki();
    command_wypij();
    command_wypisz();
    command_wyplac();
    command_wypusc();
    command_wyrzucbronie();
    command_wyscig();
    command_wyscig_start();
    command_wyscig_stop();
    command_wywal();
    command_wywalcb();
    command_wywaldmv();
    command_wywaldragi();
    command_wywalmaterialy();
    command_wywaltelefon();
    command_wywalzsad();
    command_wywaz();
    command_yo();
    command_yo2();
    command_yo3();
    command_yo4();
    command_z();
    command_zabierz();
    command_zabierzgps();
    command_zabierzlideraorg();
    command_zablokujtel();
    command_zablokujw();
    command_zaliczegz();
    command_zamknijlinie();
    command_zamroz();
    command_zaparkuj();
    command_zapiszdomy();
    command_zapiszkonta();
    command_zapytaj();
    command_zasady();
    command_zatankuj();
    command_zatrzymajlekcje();
    command_zaufani();
    command_zaufanioff();
    command_zaufanion();
    command_zaufanyggracz();
    command_zawodnicy();
    command_zawodnik();
    command_zaznacz();
    command_zbijwl();
    command_zdejmijkevlar();
    command_zdmv();
    command_zgas();
    command_zk();
    command_zlomuj();
    command_zmiendom();
    command_zmiendomk();
    command_zmienhaslo();
    command_zmienhp();
    command_zmiennick();
    command_zmienplec();
    command_zmienprace();
    command_zmienskin();
    command_zmienwl();
    command_zniszczobiekty();
    command_zonedelay();
    command_zoneid();
    command_zrobkolejke();
    command_zuzel();
    command_zuzel_start();
    command_zuzel_stop();
    command_zwiaz();
    command_zwolnij();
    
}