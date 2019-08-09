//resoursces.pwn

Load_DL_Skins()
{
	//0 - normal
	//1 - unikaty
	//2 - frakcje 
	//3 - event 
	//SKINY PRZEZNACZONE POD EVENTY 20.000-20.100
	AddCharModelEx(45, 20001, "mrucznik_skin07.dff", "mrucznik_skin07.txd", 3);//Shrek
	AddCharModelEx(45, 20002, "mrucznik_skin19.dff", "mrucznik_skin19.txd", 3);//Pies
	AddCharModelEx(45, 20003, "mrucznik_skin34.dff", "mrucznik_skin34.txd", 3);//lll rzesza 
	
	//SKINY PRZEZNACZONE DLA FRAKCJI 20.101-20.300


	//SKINY PRZEZNACZONE POD UNIKATY 20.301-20.400
	AddCharModelEx(45, 20301, "mrucznik_skin02.dff", "mrucznik_skin02.txd", 1);//Skin konkursowy!
	AddCharModelEx(20, 20302, "mrucznik_skin38.dff", "mrucznik_skin38.txd", 1);//stalin
	AddCharModelEx(20, 20303, "mrucznik_skin35.dff", "mrucznik_skin35.txd", 1); //skPembleton

	//ZWYK£E SKINY 20.401 - BRAK
	AddCharModelEx(45, 20401, "mrucznik_skin01.dff", "mrucznik_skin01.txd", 0);
	AddCharModelEx(45, 20402, "mrucznik_skin03.dff", "mrucznik_skin03.txd", 0);
	AddCharModelEx(45, 20403, "mrucznik_skin04.dff", "mrucznik_skin04.txd", 0);
	AddCharModelEx(45, 20404, "mrucznik_skin05.dff", "mrucznik_skin05.txd", 0);
	AddCharModelEx(45, 20405, "mrucznik_skin06.dff", "mrucznik_skin06.txd", 0);
	AddCharModelEx(45, 20406, "mrucznik_skin08.dff", "mrucznik_skin08.txd", 0);
	AddCharModelEx(45, 20407, "mrucznik_skin09.dff", "mrucznik_skin09.txd", 0);
	AddCharModelEx(45, 20408, "mrucznik_skin10.dff", "mrucznik_skin10.txd", 0);
	AddCharModelEx(45, 20409, "mrucznik_skin11.dff", "mrucznik_skin11.txd", 0);
	AddCharModelEx(45, 20410, "mrucznik_skin12.dff", "mrucznik_skin12.txd", 0);
	AddCharModelEx(45, 20411, "mrucznik_skin13.dff", "mrucznik_skin13.txd", 0);
	AddCharModelEx(45, 20412, "mrucznik_skin14.dff", "mrucznik_skin14.txd", 0);
	AddCharModelEx(45, 20413, "mrucznik_skin15.dff", "mrucznik_skin15.txd", 0);
	AddCharModelEx(45, 20414, "mrucznik_skin16.dff", "mrucznik_skin16.txd", 0);
	AddCharModelEx(45, 20415, "mrucznik_skin17.dff", "mrucznik_skin17.txd", 0);
	AddCharModelEx(45, 20416, "mrucznik_skin18.dff", "mrucznik_skin18.txd", 0);
	AddCharModelEx(45, 20417, "mrucznik_skin20.dff", "mrucznik_skin20.txd", 0);
	AddCharModelEx(45, 20418, "mrucznik_skin21.dff", "mrucznik_skin21.txd", 0);
	AddCharModelEx(45, 20419, "mrucznik_skin22.dff", "mrucznik_skin22.txd", 0);
	AddCharModelEx(45, 20420, "mrucznik_skin23.dff", "mrucznik_skin23.txd", 0);
	AddCharModelEx(45, 20421, "mrucznik_skin24.dff", "mrucznik_skin24.txd", 0);
	AddCharModelEx(45, 20422, "mrucznik_skin25.dff", "mrucznik_skin25.txd", 0);
	AddCharModelEx(45, 20423, "mrucznik_skin26.dff", "mrucznik_skin26.txd", 0);
	AddCharModelEx(45, 20424, "mrucznik_skin27.dff", "mrucznik_skin27.txd", 0);
	AddCharModelEx(45, 20425, "mrucznik_skin28.dff", "mrucznik_skin28.txd", 0);
	AddCharModelEx(45, 20426, "mrucznik_skin29.dff", "mrucznik_skin29.txd", 0);
	AddCharModelEx(45, 20427, "mrucznik_skin30.dff", "mrucznik_skin30.txd", 0);
	AddCharModelEx(45, 20428, "mrucznik_skin31.dff", "mrucznik_skin31.txd", 0);
	AddCharModelEx(45, 20429, "mrucznik_skin32.dff", "mrucznik_skin32.txd", 0);
	AddCharModelEx(45, 20430, "mrucznik_skin33.dff", "mrucznik_skin33.txd", 0);
	AddCharModelEx(12, 20431, "mrucznik_skin36.dff", "mrucznik_skin36.txd", 0); 
	AddCharModelEx(20, 20431, "mrucznik_skin37.dff", "mrucznik_skin37.txd", 0); 

	//MODELE
	AddSimpleModel(0, 19353, -1001, "sn_logo.dff", "wallito.txd");//LOGO LSPD 
	AddSimpleModel(0, 19353, -1002, "pd_logo.dff", "wallito.txd");//LOGO SN
	AddSimpleModel(0, 19464, -1003, "mrp_logo.dff", "wallito.txd");//MRUCZNIK LOGO
	AddSimpleModel(0, 19371, -1004, "usss_logo.dff", "wallito.txd");//USSS LOGO
	AddSimpleModel(0, 19327, -1005, "sn_logos.dff", "logos.txd");//San News Logo (na plakacie)
	AddSimpleModel(0, 4238, -1006, "bilb_cotta.dff", "bilb_cotta.txd"); //Simon Cotta - SIM_DEV (SIM-DEV)

	return 0; 
}