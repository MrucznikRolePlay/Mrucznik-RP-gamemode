//resoursces.pwn

LoadDLSkins()
{
/*
SKIN_TYPE_DEFAULT	====> Domyœlnie 0, ustawia siê na skiny zwyk³e. 
SKIN_TYPE_PREMIUM	====> Domyœlnie 1, ustawia siê na skiny przeznaczone pod kupno premium
SKIN_TYPE_EVENT		====> Domyœlnie 2, ustawia siê na skiny przeznaczone pod eventy
SKIN_TYPE_ADMIN		====> Domyœlnie 3, s¹ to skiny tylko mo¿liwe do wyboru dla @
SKIN_TYPE_FRACTION	====> Domyœlnie 4, s¹ to skiny wy³¹cznie do systemu frakcyjnego

AddNewSkin(type, newID, sex, color, cost) -  w przypadku darmowego skina, pozostawiæ wartoœæ cost na 0
*/

	//SKINY PRZEZNACZONE POD EVENTY 20.000-20.099
	
	
	//SKINY PRZEZNACZONE DLA FRAKCJI 20.101-20.300
	AddNewSkin(1, 20101, SKIN_MEN, SKIN_WHITE, 0);// [FACET[LSMC]] [ŒREDNI] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20102, SKIN_WOMEN, SKIN_WHITE, 0);

	//SKINY PRZEZNACZONE POD UNIKATY 20.301-20.400
	AddNewSkin(1, 20301, SKIN_MEN, SKIN_BLACK, 0);//[By: Mrucznik-rp -> User mrN] [Added: 2.6.1]
	AddNewSkin(1, 20302, SKIN_MEN, SKIN_WHITE, 0);// [FACET[STALIN]] [STARY] [By:____] [Added: 2.6.1]
	AddNewSkin(1, 20303, SKIN_MEN, SKIN_WHITE, 0);// [FACET] [ŒREDNI] [By:____] [Added: 2.6.1]
	AddNewSkin(1, 20304, SKIN_WOMEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11] 
	AddNewSkin(1, 20305, SKIN_MEN, SKIN_BLACK, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20306, SKIN_MEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20307, SKIN_MEN, SKIN_BLACK, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20308, SKIN_MEN, SKIN_BLACK, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20309, SKIN_WOMEN, SKIN_BLACK, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20310, SKIN_MEN, SKIN_BLACK, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20311, SKIN_MEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20312, SKIN_MEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20313, SKIN_WOMEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20314, SKIN_MEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By: https://vk.com/slivprivata/skins] [Added: 2.6.11]
	AddNewSkin(1, 20315, SKIN_MEN, SKIN_WHITE, 0);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.11]


	//ZWYK£E SKINY 20.401 - BRAK
	AddNewSkin(0, 20401, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20402, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20403, SKIN_MEN, SKIN_BLACK, 7500);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20404, SKIN_MEN, SKIN_WHITE, 10000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20405, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20406, SKIN_WOMEN, SKIN_BLACK, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20407, SKIN_MEN, SKIN_BLACK, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20408, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20409, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20410, SKIN_MEN, SKIN_WHITE, 12500);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20411, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20412, SKIN_MEN, SKIN_YELLOW, 12500);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20413, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20414, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20415, SKIN_WOMEN, SKIN_WHITE, 20000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20416, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20417, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20418, SKIN_WOMEN, SKIN_WHITE, 20000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20419, SKIN_MEN, SKIN_ANOTHER, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20420, SKIN_MEN, SKIN_BLACK, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20421, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20422, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20423, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20424, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20425, SKIN_MEN, SKIN_WHITE, 20000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20426, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20427, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20428, SKIN_WOMEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20429, SKIN_MEN, SKIN_WHITE, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20430, SKIN_MEN, SKIN_ANOTHER, 15000);// [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20431, SKIN_ANOTHER, SKIN_ANOTHER, 15000); // [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20432, SKIN_ANOTHER, SKIN_ANOTHER, 15000); // [KOBIETA/FACET] [M£ODA/ŒREDNIA/STARA] [By:____] [Added: 2.6.1]
	AddNewSkin(0, 20433, SKIN_MEN, SKIN_WHITE, 17500); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20434, SKIN_MEN, SKIN_WHITE, 15000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20435, SKIN_WOMEN, SKIN_WHITE, 15000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20436, SKIN_WOMEN, SKIN_WHITE, 20000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20437, SKIN_WOMEN, SKIN_BLACK, 17500); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20438, SKIN_WOMEN, SKIN_WHITE, 10000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20439, SKIN_WOMEN, SKIN_ANOTHER, 10000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20440, SKIN_WOMEN, SKIN_WHITE, 15000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20441, SKIN_WOMEN, SKIN_WHITE, 15000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20442, SKIN_WOMEN, SKIN_WHITE, 15000); 
	AddNewSkin(SKIN_TYPE_DEFAULT, 20443, SKIN_WOMEN, SKIN_WHITE, 15500);
	AddNewSkin(SKIN_TYPE_DEFAULT, 20444, SKIN_WOMEN, SKIN_WHITE, 10500);
	AddNewSkin(SKIN_TYPE_DEFAULT, 20445, SKIN_WOMEN, SKIN_WHITE, 17500);
	AddNewSkin(SKIN_TYPE_DEFAULT, 20446, SKIN_WOMEN, SKIN_BLACK, 17500);
	AddNewSkin(SKIN_TYPE_DEFAULT, 20447, SKIN_WOMEN, SKIN_BLACK, 17500);
	return 0; 
}