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
	AddCharModelEx(45, 20001, "mrucznikskin07.dff", "mrucznikskin07.txd", 3);// [SHREK] [STARY] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20002, "mrucznikskin19.dff", "mrucznikskin19.txd", 3);// [PIES] [ŒREDNI] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20003, "mrucznikskin34.dff", "mrucznikskin34.txd", 3);// [FACET[SS_MAN]] [M£ODY] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20004, "mrucznikzombie1.dff", "mrucznikzombie1.txd", 3);// [FACET[ZOMBIE]] [M£ODY] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20005, "mrucznikzombie2.dff", "mrucznikzombie2.txd", 3);// [KOBIETA[ZOMBIE]] [M£ODA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20006, "mrucznikzombie3.dff", "mrucznikzombie3.txd", 3);// [FACET[ZOMBIE]] [M£ODY] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20007, "mrucznikzombie4.dff", "mrucznikzombie4.txd", 3);// [KOBIETA[ZOMBIE]] [STARA] [By:____] [Added: 2.6.1]
	
	//SKINY PRZEZNACZONE DLA FRAKCJI 20.101-20.300
	AddCharModelEx(20, 20101, "mrucznikskin46.dff", "mrucznikskin46.txd", 1);// [FACET[LSMC]] [ŒREDNI] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20102, "mrucznikskin47.dff", "mrucznikskin47.txd", 1);// [KOBIETA[LSMC]] [M£ODA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]

	//SKINY PRZEZNACZONE POD UNIKATY 20.301-20.400
	AddCharModelEx(45, 20301, "mrucznikskin02.dff", "mrucznikskin02.txd", 1);// [FACET] [ŒREDNIA] [By: Mrucznik-rp -> User mrN] [Added: 2.6.1]
	AddCharModelEx(20, 20302, "mrucznikskin38.dff", "mrucznikskin38.txd", 1);// [FACET[STALIN]] [STARY] [By:____] [Added: 2.6.1]
	AddCharModelEx(20, 20303, "mrucznikskin35.dff", "mrucznikskin35.txd", 1);// [FACET] [ŒREDNI] [By:____] [Added: 2.6.1]
	AddCharModelEx(20, 20304, "mrucznikskin39.dff", "mrucznikskin39.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11] 
	AddCharModelEx(20, 20305, "mrucznikskin40.dff", "mrucznikskin40.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20306, "mrucznikskin41.dff", "mrucznikskin41.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20307, "mrucznikskin42.dff", "mrucznikskin42.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20308, "mrucznikskin43.dff", "mrucznikskin43.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20309, "mrucznikskin44.dff", "mrucznikskin44.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20310, "mrucznikskin45.dff", "mrucznikskin45.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20311, "mrucznikskin48.dff", "mrucznikskin48.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20312, "mrucznikskin49.dff", "mrucznikskin49.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20313, "mrucznikskin50.dff", "mrucznikskin50.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20314, "mrucznikskin51.dff", "mrucznikskin51.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddCharModelEx(20, 20315, "mrucznikskin52.dff", "mrucznikskin52.txd", 1);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.11]


	//ZWYK£E SKINY 20.401 - BRAK
	AddCharModelEx(45, 20401, "mrucznikskin01.dff", "mrucznikskin01.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20402, "mrucznikskin03.dff", "mrucznikskin03.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20403, "mrucznikskin04.dff", "mrucznikskin04.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20404, "mrucznikskin05.dff", "mrucznikskin05.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20405, "mrucznikskin06.dff", "mrucznikskin06.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20406, "mrucznikskin08.dff", "mrucznikskin08.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20407, "mrucznikskin09.dff", "mrucznikskin09.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20408, "mrucznikskin10.dff", "mrucznikskin10.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20409, "mrucznikskin11.dff", "mrucznikskin11.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20410, "mrucznikskin12.dff", "mrucznikskin12.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20411, "mrucznikskin13.dff", "mrucznikskin13.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20412, "mrucznikskin14.dff", "mrucznikskin14.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20413, "mrucznikskin15.dff", "mrucznikskin15.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20414, "mrucznikskin16.dff", "mrucznikskin16.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20415, "mrucznikskin17.dff", "mrucznikskin17.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20416, "mrucznikskin18.dff", "mrucznikskin18.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20417, "mrucznikskin20.dff", "mrucznikskin20.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20418, "mrucznikskin21.dff", "mrucznikskin21.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20419, "mrucznikskin22.dff", "mrucznikskin22.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20420, "mrucznikskin23.dff", "mrucznikskin23.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20421, "mrucznikskin24.dff", "mrucznikskin24.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20422, "mrucznikskin25.dff", "mrucznikskin25.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20423, "mrucznikskin26.dff", "mrucznikskin26.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20424, "mrucznikskin27.dff", "mrucznikskin27.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20425, "mrucznikskin28.dff", "mrucznikskin28.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20426, "mrucznikskin29.dff", "mrucznikskin29.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20427, "mrucznikskin30.dff", "mrucznikskin30.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20428, "mrucznikskin31.dff", "mrucznikskin31.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20429, "mrucznikskin32.dff", "mrucznikskin32.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(45, 20430, "mrucznikskin33.dff", "mrucznikskin33.txd", 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(12, 20431, "mrucznikskin36.dff", "mrucznikskin36.txd", 0); // [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddCharModelEx(20, 20431, "mrucznikskin37.dff", "mrucznikskin37.txd", 0); // [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]

	//MODELE
	AddSimpleModel(0, 19353, -1001, "snlogos1.dff", "wallito.txd");//LOGO LSPD 
	AddSimpleModel(0, 19353, -1002, "pdlogo.dff", "wallito.txd");//LOGO SN
	AddSimpleModel(0, 19464, -1003, "mrplogo.dff", "wallito.txd");//MRUCZNIK LOGO
	AddSimpleModel(0, 19371, -1004, "ussslogo.dff", "wallito.txd");//USSS LOGO
	AddSimpleModel(0, 19327, -1005, "snlogos2.dff", "logos.txd");//San News Logo (na plakacie)
	AddSimpleModel(0, 4238, -1006, "bilbcotta.dff", "bilbcotta.txd"); //Simon Cotta - SIMDEV (SIM-DEV)

	return 0; 
}