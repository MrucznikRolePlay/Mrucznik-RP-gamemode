//komendy.pwn

forward KomunikatTimer();
forward SprzedajMatsTimer(playerid,giveplayerid);
forward Naprawa(playerid);

forward OtherTimer();
forward PlayerFixRadio(playerid);
forward PlayerFixRadio2();
forward StopMusic();
forward AddsOn();
forward JednaSekundaTimer();//textdraw
forward SlapperTimer();
forward Spectator();
forward SyncUp();
forward SyncTime();
forward SaveAccounts();
forward Production();
forward PayDay();
forward CustomPickups();
forward IdleKick();
forward Fillup();
forward CheckGas();
forward PlayersCheckerMinute();
forward CarCheck();
forward SetPlayerUnjail();
forward StoppedVehicle();
forward ServerStuffSave();

//  09.06.2014
//Przeniesione z funkcji
forward Float:GetDistanceBetweenPoints(Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2);
forward Float:GetDistanceBetweenPlayers(p1,p2);

forward Wchodzenie(playerid);
forward freezuj(playerid);
forward AntySB(playerid);
forward TiNzPJwGUI(playerid); //Koniec czasu na prawo jazdy
forward Naprawianie(playerid);
forward KickEx(playerid, reason[]);
forward Banicja(playerid);
forward BanExTimer(playerid);
forward Matsowanie(playerid);
forward togczastimer(playerid);
forward spamujewl(playerid);
forward AntySpamMechanik(playerid);
forward PoscigTimer(playerid);
forward AntySpamTimer(playerid);
forward spamujebronia(playerid);
forward odpalanie(playerid);
forward udalo1(playerid); //Odpalanie auta
forward udalo2(playerid);
forward udalo3(playerid);
forward nieudalo1(playerid);
forward nieudalo2(playerid);
forward nieudalo3(playerid);
forward WylaczAlarm(vehi);
forward UsuwanieBroniReset(playerid);
forward Odlicz(wyscig);//system wyscig�w
forward CleanPlayaPointsPJ(playerid); //Czyszczenie tablic na testy prawo jazdy
forward Wywalonyzdmv(playerid);
forward ZlyKodUn(playerid);
forward OgladanieDOM(playerid);
forward CzasOgladaniaDOM(playerid);
forward RSPAWN(playerid);
forward SzukanieAuta(playerid);
forward TablicaWynikow(playerid);
forward AutodbzesRH(playerid);
forward Dopalaj(playerid); // Dopalacz auta
forward StopMusic();
forward PlayerFixRadio2();
forward CountDownVehsRespawn();
forward EditObj(playerid, obj); //Timer do edycji obiekt�w
forward obiekty_timer(wartosc);
forward usuwanie_obiektow(playerid);

//09.06.2014 aktualizacja
forward ElevatorTravelEND(playerid); //09.06.2014 - Teleportacja wind w LSMC
forward LSMCElevatorFree(); //09.06.2014 - Zwolnienie wind LSMC - ponowne otwarcie.
forward NG_OpenGateWithKey(playerid);  //Stanowe otwieranie bramy
forward StandUp(playerid); //Timer do wstania po HS
forward OnPlayerFakeKill(playerid);
//15.06
forward OPCLogin(playerid); //Kamera po polaczeniu, przeciw wczytywaniu kamery, synchro.
forward PrzeniesKonto(playerid);
//23.06
forward Odmroz(playerid);
forward MySQL_Refresh();
forward MySQL_Close();
//11.07
forward INT_AirTower_RadarLoop(playerid);
//12.07
forward TRAIN_DoHorn(veh);
//16.07

forward B_OnTrailerDetached(trailerid, fromvehicleid);
forward B_OnTrailerAttached(trailerid, tovehicleid);
forward B_TrailerCheck();
forward B_DisableBlinks(vehicleid); //For external call in GM when you want to destroy vehicle. CallRemoteFunction("B_DisableBlinks", "i", vehicleid);
//25.07
forward Zone_HideInfo(playerid);
forward Zone_AttackEnd(zoneid, attacker, defender);
forward OnPlayerEnterGangZone(playerid, zoneid);
forward OnPlayerLeaveGangZone(playerid, zoneid);
forward GangZone_Process();
//01.08 speedo
forward Speedo_CalculateSpeed(playerid, veh);
forward MRP_ChangeVehicleColor(vehicleid, color1, color2);
//23.08 poprawki lspd
forward OnPlayerEnterSpikes(playerid);
forward PatrolGPS();
//19.06
forward VehicleUpdate();
forward OnPlayerEnterOilSpot(playerid);
//
forward MruMySQL_LoadAccount(playerid);
//12.10
forward VendCheck(playerid);
//30.10
forward TJDTimer();
forward TJD_LoadTime(playerid, count, maxcount);
forward TJD_UnloadTime(playerid, count, maxcount);

forward BBD_Timer();
//12.11
forward UnhireRentCar(playerid, veh);
forward MyItems_Load(playerid);

//Sandal
forward SpecEnd(playerid);
forward Stanowe_CheckPlyInVeh(playerid);

forward SlideRope(playerid);
forward closeGate(i, j, playerid);

forward DamagedHP(playerid);

forward DeathAdminWarning(playerid, killerid, reason);

forward Float:GetVehicleBoundingBoxDiagonal(vehicleid);
//EOF
