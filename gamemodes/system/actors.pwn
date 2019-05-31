//actors.pwn
//Chwilowa opcja ³adowania actorów, do czasu napisania CreateActorEx. 
stock LoadActors()
{
	//VINYL CLUB
	CreateDynamicActor(11, 812.7278,-1371.3988,23.6475, 267.5658, 1, 100.0, 255, -1,-1);//barman góra
	CreateDynamicActor(189,811.0535,-1350.2653,27.8413,177.3484, 1, 100.0, 255, -1,-1);//barman dó³
	CreateDynamicActor(165, 818.0769,-1376.7991,23.6475,329.0921, 1, 100.0, 255, -1,-1);//vinyl staff - drzwi
	CreateDynamicActor(217,825.0794,-1352.5493,23.6475,172.7841, 1, 100.0, 255, -1,-1);//vinyl staff - konsola
	
	return 0; 
}