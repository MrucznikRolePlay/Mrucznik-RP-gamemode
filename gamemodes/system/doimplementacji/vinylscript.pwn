//vinylscript.pwn
stock DestroyNeons(){
	DestroyDynamicObject(neon1);
	DestroyDynamicObject(neon2);
	DestroyDynamicObject(neon3);
	DestroyDynamicObject(neon4);
	DestroyDynamicObject(neon5);
	DestroyDynamicObject(neon6);
	DestroyDynamicObject(neon7);
	DestroyDynamicObject(neon8);
	DestroyDynamicObject(neon9);
	DestroyDynamicObject(neon10);
	DestroyDynamicObject(neon11);
	DestroyDynamicObject(neon12);
	DestroyDynamicObject(neon13);
	DestroyDynamicObject(neon14);
	DestroyDynamicObject(neon15);
	DestroyDynamicObject(neon16);
	DestroyDynamicObject(neon17);
	DestroyDynamicObject(neon18);
	DestroyDynamicObject(neon19);
	DestroyDynamicObject(neon20);
	DestroyDynamicObject(neon21);
	DestroyDynamicObject(neon22);
	DestroyDynamicObject(neon23);
}
stock DestroyEq(){
	DestroyDynamicObject(eq_1_1);
	DestroyDynamicObject(eq_1_2);
	DestroyDynamicObject(eq_2_1);
	DestroyDynamicObject(eq_2_2);
	DestroyDynamicObject(eq_3_1);
	DestroyDynamicObject(eq_3_2);
	DestroyDynamicObject(eq_4_1);
	DestroyDynamicObject(eq_4_2);
	DestroyDynamicObject(eq_5_1);
	DestroyDynamicObject(eq_5_2);
	DestroyDynamicObject(eq_6_1);
	DestroyDynamicObject(eq_6_2);
	DestroyDynamicObject(eq_7_1);
	DestroyDynamicObject(eq_7_2);
	DestroyDynamicObject(eq_8_1);
	DestroyDynamicObject(eq_8_2);
}

//timery

forward SphereSpinFirst();
public SphereSpinFirst(){
	sphereTimer_second = SetTimer("SphereSpinSecond", 5000, true);
	return 1;
}
forward SphereSpinSecond();
public SphereSpinSecond(){
	new Float:Pos[3];
	GetDynamicObjectRot(kula, Pos[0], Pos[1], Pos[2]);
	if((Pos[0] == 0.000000) && (Pos[1] == 0.000000) && (Pos[2] == 0.000000)){
		MoveDynamicObject(kula, 817.169311, -1394.821899, -13.629315+0.001, 0.001, 0.000000, 0.000000, 180.000000);
	}else{
		MoveDynamicObject(kula, 817.169311, -1394.821899, -13.629315-0.001, 0.001, 0.000000, 0.000000, 0.000000);
	}
	return 1;
}
forward MoveNeons();
public MoveNeons(){
	new Float:Pos[3];
	// red
	GetDynamicObjectPos(neon1, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 821.522766){
		MoveDynamicObject(neon1, 812.322387, -1400.391113, -19.608976, 3);
	}else{
		MoveDynamicObject(neon1, 821.522766, -1400.391113, -19.608976, 3);
	}
	GetDynamicObjectPos(neon2, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 812.322387){
		MoveDynamicObject(neon2, 821.522766, -1400.391113, -19.608976, 3);
	}else{
		MoveDynamicObject(neon2, 812.322387, -1400.391113, -19.608976, 3);
	}
	
	// purple
	GetDynamicObjectPos(neon13, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 821.579284){
		MoveDynamicObject(neon13, 831.959838, -1414.808471, -19.919300, 3);
	}else{
		MoveDynamicObject(neon13, 821.579284, -1414.808471, -19.919300, 3);
	}
	GetDynamicObjectPos(neon14, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 831.959838){
		MoveDynamicObject(neon14, 821.579284, -1414.808471, -19.919300, 3);
	}else{
		MoveDynamicObject(neon14, 831.959838, -1414.808471, -19.919300, 3);
	}
	GetDynamicObjectPos(neon15, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 811.879882){
		MoveDynamicObject(neon15, 803.919372, -1414.808471, -19.919300, 3);
	}else{
		MoveDynamicObject(neon15, 811.879882, -1414.808471, -19.919300, 3);
	}
	GetDynamicObjectPos(neon16, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 803.919372){
		MoveDynamicObject(neon16, 811.879882, -1414.808471, -19.919300, 3);
	}else{
		MoveDynamicObject(neon16, 803.919372, -1414.808471, -19.919300, 3);
	}
	// yellow
	GetDynamicObjectPos(neon17, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 805.490844){
		MoveDynamicObject(neon17, 828.301147, -1400.387573, -19.639308, 3);
	}else{
		MoveDynamicObject(neon17, 805.490844, -1400.387573, -19.639308, 3);
	}
	GetDynamicObjectPos(neon18, Pos[0], Pos[1], Pos[2]);
	if(Pos[0] == 828.301147){
		MoveDynamicObject(neon18, 805.490844, -1400.387573, -19.639308, 3);
	}else{
		MoveDynamicObject(neon18, 828.301147, -1400.387573, -19.639308, 3);
	}
	// green
	GetDynamicObjectPos(neon19, Pos[0], Pos[1], Pos[2]);
	if(Pos[1] == -1391.377685){
		MoveDynamicObject(neon19, 835.885803, -1393.377685, -19.889291, 3);
	}else{
		MoveDynamicObject(neon19, 835.885803, -1391.377685, -19.889291, 3);
	}
	GetDynamicObjectPos(neon23, Pos[0], Pos[1], Pos[2]);
	if(Pos[1] == -1391.377685){
		MoveDynamicObject(neon23, 798.036376, -1393.377685, -19.889291, 3);
	}else{
		MoveDynamicObject(neon23, 798.036376, -1391.377685, -19.889291, 3);
	}
	
	return 1;
}
forward eqFirst();
public eqFirst(){
	
//KOLOREK
	SetDynamicObjectMaterial(eq_1_1, 0, 19080, "airportgnd_sfse", "white", 0xFFB803FF);
	SetDynamicObjectMaterial(eq_1_2, 0, 19080, "airportgnd_sfse", "white", 0xFFB803FF);

	SetDynamicObjectMaterial(eq_2_1, 0, 19081, "airportgnd_sfse", "white", 0xFFFF00FF);
	SetDynamicObjectMaterial(eq_2_2, 0, 19081, "airportgnd_sfse", "white", 0xFFFF00FF);
	
	SetDynamicObjectMaterial(eq_3_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFF00FF);
	SetDynamicObjectMaterial(eq_3_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFF00FF);

	SetDynamicObjectMaterial(eq_4_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
	SetDynamicObjectMaterial(eq_4_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
 
	SetDynamicObjectMaterial(eq_5_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
	SetDynamicObjectMaterial(eq_5_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);

	SetDynamicObjectMaterial(eq_6_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
	SetDynamicObjectMaterial(eq_6_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);

	SetDynamicObjectMaterial(eq_7_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFFF00);
	SetDynamicObjectMaterial(eq_7_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFFF00);

	SetDynamicObjectMaterial(eq_8_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFF0000);
	SetDynamicObjectMaterial(eq_8_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFF0000);
	//eqTimer_Second = SetTimer("eqSecond", 900, false);
	
	return 1;
}
forward eqSecond();
public eqSecond(){	
// CZARNE 
	SetDynamicObjectMaterial(eq_5_1, 0, 19598, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_5_2, 0, 19598, "airportgnd_sfse", "white", 0xFF202020);

	SetDynamicObjectMaterial(eq_6_1, 0, 19598, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_6_2, 0, 19598, "airportgnd_sfse", "white", 0xFF202020);

	SetDynamicObjectMaterial(eq_7_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_7_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

	SetDynamicObjectMaterial(eq_8_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_8_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	
	

	//eqTimer_Second = SetTimer("eqThird", 600, false);
	
	return 1;
}
forward eqThird();
public eqThird(){
 //KOLOREK
	SetDynamicObjectMaterial(eq_3_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFF00FF);
	SetDynamicObjectMaterial(eq_3_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFF00FF);

	SetDynamicObjectMaterial(eq_4_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
	SetDynamicObjectMaterial(eq_4_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
 
	SetDynamicObjectMaterial(eq_5_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
	SetDynamicObjectMaterial(eq_5_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);

	SetDynamicObjectMaterial(eq_6_1, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
	SetDynamicObjectMaterial(eq_6_2, 0, 19598, "airportgnd_sfse", "white", 0xFFFFA500);
//CZARNE
	SetDynamicObjectMaterial(eq_7_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_7_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

	SetDynamicObjectMaterial(eq_8_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_8_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

	//eqTimer_Third = SetTimer("eqFourth", 300, false);
	
	return 1;
}

forward eqFourth();
public eqFourth(){
 //CZARNE
	SetDynamicObjectMaterial(eq_5_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_5_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

	SetDynamicObjectMaterial(eq_6_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_6_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	
	SetDynamicObjectMaterial(eq_7_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_7_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);

	SetDynamicObjectMaterial(eq_8_1, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	SetDynamicObjectMaterial(eq_8_2, 0, 10765, "airportgnd_sfse", "white", 0xFF202020);
	
	return 1;
}