//resoursces.pwn

LoadDLSkins()
{
	//0 - normal
	//1 - unikaty
	//2 - frakcje 
	//3 - event 
	/*
	=========================================
	================[LEGENDA]================
	=========================================

	---> [P£EÆ[Tytu³*]] [WIEK] [Autor] [Dodane w aktualizacji] <----

				* Tytu³ - nieobowi¹zkowy, raczej tyczy siê tylko skinów eventowych. 

	ARGUMENTACJA: AddCharModelEx(BaseID, NewID, ".dff", ".txd", TYPE);  
	Dostêpne typy: 0 - normal, 1 - unikaty, 2 - frakcje, 3 - event; 
	*/

	//SKINY PRZEZNACZONE POD EVENTY 20.000-20.099
	AddCharModelEx(3);// [SHREK] [STARY] [By:____] [Added: 2.6.1]
	AddCharModelEx(3);// [PIES] [ŒREDNI] [By:____] [Added: 2.6.1]
	AddCharModelEx(3);// [FACET[SS_MAN]] [M£ODY] [By:____] [Added: 2.6.1]
	AddCharModelEx(3);// [FACET[ZOMBIE]] [M£ODY] [By:____] [Added: 2.6.1]
	AddCharModelEx(3);// [KOBIETA[ZOMBIE]] [M£ODA] [By:____] [Added: 2.6.1]
	AddCharModelEx(3);// [FACET[ZOMBIE]] [M£ODY] [By:____] [Added: 2.6.1]
	AddCharModelEx(3);// [KOBIETA[ZOMBIE]] [STARA] [By:____] [Added: 2.6.1]
	
	//SKINY PRZEZNACZONE DLA FRAKCJI 20.101-20.300
	AddCharModelEx(1);// [FACET[LSMC]] [ŒREDNI] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);

	//SKINY PRZEZNACZONE POD UNIKATY 20.301-20.400
	AddCharModelEx(1);// [FACET] [ŒREDNIA] [By: Mrucznik-rp -> User mrN] [Added: 2.6.1]
	AddCharModelEx(1);// [FACET[STALIN]] [STARY] [By:____] [Added: 2.6.1]
	AddCharModelEx(1);// [FACET] [ŒREDNI] [By:____] [Added: 2.6.1]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11] 
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx();// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.11]


	//ZWYK£E SKINY 20.401 - BRAK
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0); // [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0); // [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(0); 

	return 0; 
}