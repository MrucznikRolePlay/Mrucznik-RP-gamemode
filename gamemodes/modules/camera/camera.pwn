//-----------------------------------------------<< Source >>------------------------------------------------//
//                                                   camera                                                  //
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
// Autor: Southclaws
// Data utworzenia: 03.10.2024
//Opis:
/*
	Skrypty dotycz¹ce kamery w grze.
*/

//

//-----------------<[ Funkcje: ]>-------------------
stock FormatMainMenu(playerid)
{
	new
		File:idxFile,
		line[64],
		idx,
		strTitle[32],
		strList[MAX_CAMERAS*(MAX_CAMERA_FILENAME+1)];

	strList = "New Camera...\n";

	if(!fexist(INDEX_FILE))
	{
		idxFile = fopen(INDEX_FILE, io_write); // If the file doesn't exist, create it now in case it's used later
		if(idxFile) fclose(idxFile);
		else SendClientMessage(playerid, 0xFF0000FF, "ERROR: Directory Not Found. Please create a folder called \"cameras\" inside \"scriptfiles\".");
	}
	else // But if it does, read each line and add that to the list
	{
		idxFile = fopen(INDEX_FILE, io_read);
		while(fread(idxFile, line))
		{
			strcat(strList, line);
			line[strlen(line)-1] = EOS; // Remove the "\n" this would need to be "-1" if using linux
			strcpy(indexData[idx], line);
			idx++;
		}
		fclose(idxFile);
	}

	format(strTitle, sizeof(strTitle), "Total Camera Projects: %d", idx);
	ShowPlayerDialogEx(playerid, d_MainMenu, DIALOG_STYLE_LIST, strTitle, strList, "Accept", "Close");
}

CreateCameraMover(playerid, camname[])
{
	new
		File:idxFile,
		File:camFile,
		tmpStr[MAX_CAMERA_FILENAME+2],
		newData[128],
		iLoop,

		Float:camX, Float:camY, Float:camZ,
		Float:vecX, Float:vecY, Float:vecZ;

	if(!fexist(INDEX_FILE))idxFile = fopen(INDEX_FILE, io_write);
	else idxFile = fopen(INDEX_FILE, io_append);

	strcat(tmpStr, camname);
	strcat(tmpStr, "\n");

	while(strlen(indexData[iLoop][0])) iLoop++;
	strcpy(indexData[iLoop], camname);
	fwrite(idxFile, tmpStr);
	fclose(idxFile);


	GetPlayerCameraPos(playerid, camX, camY, camZ);
	GetPlayerCameraFrontVector(playerid, vecX, vecY, vecZ);
	vecX+=camX;
	vecY+=camY;
	vecZ+=camZ;

	format(tmpStr, MAX_CAMERA_FILENAME+2, CAMERA_FILE, camname);
	camFile = fopen(tmpStr, io_write);

	format(newData, 128, "%f, %f, %f, %f, %f, %f, %d, %d, %d", camX, camY, camZ, vecX, vecY, vecZ, DEFAULT_MOVETIME, DEFAULT_WAITTIME, DEFAULT_MOVETYPE);
	fwrite(camFile, newData);
	fclose(camFile);
}

stock EditCameraMover(playerid, camera)
{
	gPlayerCamData[playerid][p_CamID] = camera;
	gPlayerEditing[playerid] = true;

	camera_LoadTextDraws(playerid); // Need a check to see if the player has textdraws loaded (Maybe checking if the first ID is an invalid textdraw ID)
	SelectTextDraw(playerid, 0xFFFF00FF);
	ToggleEditGUI(playerid, true);
	JumpToNode(playerid, 0);
	FlyMode(playerid, 0);
}

stock ExitEditing(playerid)
{
	gPlayerCamData[playerid][p_CamID] = -1;
	gPlayerEditing[playerid] = false;

	CancelSelectTextDraw(playerid);
	ToggleEditGUI(playerid, false);
	CancelFlyMode(playerid);
}

public editor_OnCamMove(playerid, node, bool:cont)
{
	gPlayerCamData[playerid][p_Node]++;
	UpdateGUI(playerid);
}

SaveCameraMover(playerid, exportmode=0)
{
	new
		tmpCam = gPlayerCamData[playerid][p_CamID],
		tmpNode,
		File:camFile_Main,
		File:camFile_Backup,
		tmpFilename[64],
		tmpLine[256],
		tmpData[3];

	// Create the backup file, then write everything from the main one into the new one
	format(tmpFilename, 64, "%s.bak", indexData[tmpCam]);

	camFile_Backup=fopen(tmpFilename, io_write);
	camFile_Main = fopen(indexData[tmpCam], io_write);

	while(fread(camFile_Main, tmpLine))fwrite(camFile_Backup, tmpLine);

	fclose(camFile_Backup);
	fclose(camFile_Main);

	// Now, close that backup file, write all the variable data into the main file

	camFile_Main = fopen(indexData[tmpCam], io_write);
	while (tmpNode <= camMaxNodes[tmpCam])
	{
		if(!exportmode)
		{
			if (cam_NodeData[tmpCam][tmpNode][cam_moveTime] == tmpData[0] &&
				cam_NodeData[tmpCam][tmpNode][cam_waitTime] == tmpData[1] &&
				cam_NodeData[tmpCam][tmpNode][cam_moveType] == tmpData[2] )
			{ // All the data is the same as the last one, ignore it and leave optionals blank
				format(tmpLine, 256, "%f, %f, %f, %f, %f, %f\r\n",
					cam_NodeData[tmpCam][tmpNode][cam_cPosX],
					cam_NodeData[tmpCam][tmpNode][cam_cPosY],
					cam_NodeData[tmpCam][tmpNode][cam_cPosZ],
					cam_NodeData[tmpCam][tmpNode][cam_lPosX],
					cam_NodeData[tmpCam][tmpNode][cam_lPosY],
					cam_NodeData[tmpCam][tmpNode][cam_lPosZ] );
			}
			else
			{ // Data is different, write the new data to the line
				format(tmpLine, 256, "%f, %f, %f, %f, %f, %f, %d, %d, %d\r\n",
					cam_NodeData[tmpCam][tmpNode][cam_cPosX],
					cam_NodeData[tmpCam][tmpNode][cam_cPosY],
					cam_NodeData[tmpCam][tmpNode][cam_cPosZ],
					cam_NodeData[tmpCam][tmpNode][cam_lPosX],
					cam_NodeData[tmpCam][tmpNode][cam_lPosY],
					cam_NodeData[tmpCam][tmpNode][cam_lPosZ],
					cam_NodeData[tmpCam][tmpNode][cam_moveTime],
					cam_NodeData[tmpCam][tmpNode][cam_waitTime],
					cam_NodeData[tmpCam][tmpNode][cam_moveType] );

				tmpData[0] = cam_NodeData[tmpCam][tmpNode][cam_moveTime];
				tmpData[1] = cam_NodeData[tmpCam][tmpNode][cam_waitTime];
				tmpData[2] = cam_NodeData[tmpCam][tmpNode][cam_moveType];
			}
		}
		else
		{
			if(tmpNode == camMaxNodes[tmpCam])strcpy(tmpLine, "\r\n");
			else
			{
				format(tmpLine, 256,
					"InterpolateCameraPos(playerid, %f, %f, %f, %f, %f, %f, %d, %d);\r\n\
					InterpolateCameraLookAt(playerid, %f, %f, %f, %f, %f, %f, %d, %d);\r\n",

					cam_NodeData[tmpCam][tmpNode][cam_cPosX],
					cam_NodeData[tmpCam][tmpNode][cam_cPosY],
					cam_NodeData[tmpCam][tmpNode][cam_cPosZ],
					cam_NodeData[tmpCam][tmpNode+1][cam_cPosX],
					cam_NodeData[tmpCam][tmpNode+1][cam_cPosY],
					cam_NodeData[tmpCam][tmpNode+1][cam_cPosZ],
					cam_NodeData[tmpCam][tmpNode][cam_moveTime],
					cam_NodeData[tmpCam][tmpNode][cam_moveType],

					cam_NodeData[tmpCam][tmpNode][cam_lPosX],
					cam_NodeData[tmpCam][tmpNode][cam_lPosY],
					cam_NodeData[tmpCam][tmpNode][cam_lPosZ],
					cam_NodeData[tmpCam][tmpNode+1][cam_lPosX],
					cam_NodeData[tmpCam][tmpNode+1][cam_lPosY],
					cam_NodeData[tmpCam][tmpNode+1][cam_lPosZ],
					cam_NodeData[tmpCam][tmpNode][cam_moveTime],
					cam_NodeData[tmpCam][tmpNode][cam_moveType] );
			}
		}
		fwrite(camFile_Main, tmpLine);
		tmpNode++;
	}
	fclose(camFile_Main);
}

ToggleEditGUI(playerid, toggle)
{
	if(toggle)
	{
		PlayerTextDrawShow(playerid, cam_buttonBack);
		PlayerTextDrawShow(playerid, cam_boxBackground);
		PlayerTextDrawShow(playerid, cam_arrowLeft);
		PlayerTextDrawShow(playerid, cam_arrowRight);

		PlayerTextDrawShow(playerid, cam_row1);
		PlayerTextDrawShow(playerid, cam_row2);
		PlayerTextDrawShow(playerid, cam_row3);
		PlayerTextDrawShow(playerid, cam_row4);

		PlayerTextDrawShow(playerid, cam_row1Data);
		PlayerTextDrawShow(playerid, cam_row2Data);
		PlayerTextDrawShow(playerid, cam_row3Data);
		PlayerTextDrawShow(playerid, cam_row4Data);

		PlayerTextDrawShow(playerid, cam_buttonEdit);
		PlayerTextDrawShow(playerid, cam_buttonSave);
		PlayerTextDrawShow(playerid, cam_buttonDelt);
		PlayerTextDrawShow(playerid, cam_buttonPrev);
		PlayerTextDrawShow(playerid, cam_buttonAddN);
	}
	else
	{
		PlayerTextDrawHide(playerid, cam_buttonBack);
		PlayerTextDrawHide(playerid, cam_boxBackground);
		PlayerTextDrawHide(playerid, cam_arrowLeft);
		PlayerTextDrawHide(playerid, cam_arrowRight);

		PlayerTextDrawHide(playerid, cam_row1);
		PlayerTextDrawHide(playerid, cam_row2);
		PlayerTextDrawHide(playerid, cam_row3);
		PlayerTextDrawHide(playerid, cam_row4);

		PlayerTextDrawHide(playerid, cam_row1Data);
		PlayerTextDrawHide(playerid, cam_row2Data);
		PlayerTextDrawHide(playerid, cam_row3Data);
		PlayerTextDrawHide(playerid, cam_row4Data);

		PlayerTextDrawHide(playerid, cam_buttonEdit);
		PlayerTextDrawHide(playerid, cam_buttonSave);
		PlayerTextDrawHide(playerid, cam_buttonDelt);
		PlayerTextDrawHide(playerid, cam_buttonPrev);
		PlayerTextDrawHide(playerid, cam_buttonAddN);
	}
}

UpdateGUI(playerid)
{
	new
		tmpCam = gPlayerCamData[playerid][p_CamID],
		tmpNode = gPlayerCamData[playerid][p_Node],
		dataStr[16],
		MoveTypeName[3][5]={"NONE", "MOVE", "CUT"};

	format(dataStr, 16, "%d/%d", tmpNode, camMaxNodes[tmpCam]);
	PlayerTextDrawSetString(playerid, cam_row1Data, dataStr);
	PlayerTextDrawShow(playerid, cam_row1Data);

	format(dataStr, 16, "%d", cam_NodeData[tmpCam][tmpNode][cam_moveTime]);
	PlayerTextDrawSetString(playerid, cam_row2Data, dataStr);
	PlayerTextDrawShow(playerid, cam_row2Data);

	format(dataStr, 16, "%d", cam_NodeData[tmpCam][tmpNode][cam_waitTime]);
	PlayerTextDrawSetString(playerid, cam_row3Data, dataStr);
	PlayerTextDrawShow(playerid, cam_row3Data);

	format(dataStr, 16, "%s(%d)", MoveTypeName[ _:cam_NodeData[tmpCam][tmpNode][cam_moveType] ], cam_NodeData[tmpCam][tmpNode][cam_moveType]);
	PlayerTextDrawSetString(playerid, cam_row4Data, dataStr);
	PlayerTextDrawShow(playerid, cam_row4Data);
}

JumpToNode(playerid, node)
{
	new
		camera = gPlayerCamData[playerid][p_CamID];

	SetPlayerCameraPos(playerid, cam_NodeData[camera][node][cam_cPosX], cam_NodeData[camera][node][cam_cPosY], cam_NodeData[camera][node][cam_cPosZ]);
	SetPlayerCameraLookAt(playerid, cam_NodeData[camera][node][cam_lPosX], cam_NodeData[camera][node][cam_lPosY], cam_NodeData[camera][node][cam_lPosZ]);

	gPlayerCamData[playerid][p_Node] = node;
	UpdateGUI(playerid);
}

EditCurrentNode(playerid)
{
	gPlayerEditingNode[playerid] = true;
	EnterFreeCam(playerid);
}

CommitCurrentNode(playerid)
{
	new
		tmpCam = gPlayerCamData[playerid][p_CamID],
		tmpNode = gPlayerCamData[playerid][p_Node],
		Float:vecX, Float:vecY, Float:vecZ;

	GetPlayerCameraPos(playerid, cam_NodeData[tmpCam][tmpNode][cam_cPosX], cam_NodeData[tmpCam][tmpNode][cam_cPosY], cam_NodeData[tmpCam][tmpNode][cam_cPosZ]);
	GetPlayerCameraFrontVector(playerid, vecX, vecY, vecZ);

	cam_NodeData[tmpCam][tmpNode][cam_lPosX] = cam_NodeData[tmpCam][tmpNode][cam_cPosX]+(vecX*4); // x4 just to give the LookAt node a little distance, I didn't know if this would affect anything
	cam_NodeData[tmpCam][tmpNode][cam_lPosY] = cam_NodeData[tmpCam][tmpNode][cam_cPosY]+(vecY*4);
	cam_NodeData[tmpCam][tmpNode][cam_lPosZ] = cam_NodeData[tmpCam][tmpNode][cam_cPosZ]+(vecZ*4);

	gPlayerEditingNode[playerid] = false;
	ExitFreeCam(playerid);
	UpdateGUI(playerid);
}

CancelCurrentNodeEdit(playerid)
{
	JumpToNode(playerid, gPlayerCamData[playerid][p_Node]);

	gPlayerEditingNode[playerid] = false;
	ExitFreeCam(playerid);
}

EnterFreeCam(playerid)
{
	new
		tmpCam = gPlayerCamData[playerid][p_CamID],
		tmpNode = gPlayerCamData[playerid][p_Node];

	CancelSelectTextDraw(playerid);
	ToggleEditGUI(playerid, false);

	JumpToNode(playerid, gPlayerCamData[playerid][p_Node]);
}

ExitFreeCam(playerid)
{
	JumpToNode(playerid, gPlayerCamData[playerid][p_Node]);

	ToggleEditGUI(playerid, true);
	SelectTextDraw(playerid, 0xFFFF00FF);
}

EditNewNode(playerid)
{
	new
		tmpCam = gPlayerCamData[playerid][p_CamID],
		tmpNode = gPlayerCamData[playerid][p_Node];

	ShiftNodeArray(tmpCam, tmpNode);
	EditCurrentNode(playerid);
	gPlayerCamData[playerid][p_Node]++;
}

DeleteCurrentNode(playerid)
{
	new
		tmpCam = gPlayerCamData[playerid][p_CamID],
		tmpNode = gPlayerCamData[playerid][p_Node];

	ShiftNodeArray(tmpCam, tmpNode, 1);
	JumpToNode(playerid, tmpNode);
	UpdateGUI(playerid);
}

ShiftNodeArray(camera, startnode, direction=0)
{
	if(direction == 0)
	{
		new i = camMaxNodes[camera]++; // Assign the value then increment it because we are adding another cell
		while(i >= startnode) // Loop from the last node to the startnode
		{
			for(new e;e<MAX_CAMDATA;e++) // Shift all the data to the next node cell
			{
				cam_NodeData[camera][i+1][CAM_DATA_ENUM:e] = cam_NodeData[camera][i][CAM_DATA_ENUM:e];
			}
			i--;
		}
	}
	else
	{
		new i = startnode;
		while(i<=camMaxNodes[camera]) // Loop from the startnode to the last node
		{
			for(new e;e<MAX_CAMDATA;e++)
			{
				cam_NodeData[camera][i][CAM_DATA_ENUM:e] = cam_NodeData[camera][i+1][CAM_DATA_ENUM:e];
			}
			i++;
		}
		for(new e;e<MAX_CAMDATA;e++)
		{
			cam_NodeData[camera][camMaxNodes[camera]][CAM_DATA_ENUM:e] = 0;
		}
		// I didn't want to have to call two loops
		// But I'm not sure how do to it otherwise!
		// I'll try a backwards loop when I'm more awake!
		// A backwards loop would be able to blank the last cell easier
		camMaxNodes[camera]--; // Decrement the max value, we just removed a cell
	}
}

GetCameraMaxNodes(camera)
{
	return camMaxNodes[camera];
}

camera_LoadTextDraws(playerid)
{
	// Background
	cam_boxBackground = CreatePlayerTextDraw(playerid, 320.000000, 320.000000, "~n~~n~~n~~n~");
	PlayerTextDrawAlignment(playerid, cam_boxBackground, 2);
	PlayerTextDrawBackgroundColor(playerid, cam_boxBackground, 255);
	PlayerTextDrawFont(playerid, cam_boxBackground, 1);
	PlayerTextDrawLetterSize(playerid, cam_boxBackground, 0.500000, 2.200000);
	PlayerTextDrawColor(playerid, cam_boxBackground, -1);
	PlayerTextDrawSetOutline(playerid, cam_boxBackground, 0);
	PlayerTextDrawSetProportional(playerid, cam_boxBackground, 1);
	PlayerTextDrawSetShadow(playerid, cam_boxBackground, 1);
	PlayerTextDrawUseBox(playerid, cam_boxBackground, 1);
	PlayerTextDrawBoxColor(playerid, cam_boxBackground, 128);
	PlayerTextDrawTextSize(playerid, cam_boxBackground, 380.000000, 300.000000);


	// Node Switch
	cam_arrowLeft = CreatePlayerTextDraw(playerid, 174.000000, 339.000000, "~<~");
	PlayerTextDrawBackgroundColor(playerid, cam_arrowLeft, 255);
	PlayerTextDrawFont(playerid, cam_arrowLeft, 1);
	PlayerTextDrawLetterSize(playerid, cam_arrowLeft, 0.000000, 4.800001);
	PlayerTextDrawColor(playerid, cam_arrowLeft, -1);
	PlayerTextDrawSetOutline(playerid, cam_arrowLeft, 0);
	PlayerTextDrawSetProportional(playerid, cam_arrowLeft, 1);
	PlayerTextDrawSetShadow(playerid, cam_arrowLeft, 1);
	PlayerTextDrawUseBox(playerid, cam_arrowLeft, 1);
	PlayerTextDrawBoxColor(playerid, cam_arrowLeft, 6618980);
	PlayerTextDrawTextSize(playerid, cam_arrowLeft, 210.000000, 58.000000);
	PlayerTextDrawSetSelectable(playerid, cam_arrowLeft, true);

	cam_arrowRight = CreatePlayerTextDraw(playerid, 432.000000, 339.000000, "~>~");
	PlayerTextDrawBackgroundColor(playerid, cam_arrowRight, 255);
	PlayerTextDrawFont(playerid, cam_arrowRight, 1);
	PlayerTextDrawLetterSize(playerid, cam_arrowRight, 0.000000, 4.800001);
	PlayerTextDrawColor(playerid, cam_arrowRight, -1);
	PlayerTextDrawSetOutline(playerid, cam_arrowRight, 0);
	PlayerTextDrawSetProportional(playerid, cam_arrowRight, 1);
	PlayerTextDrawSetShadow(playerid, cam_arrowRight, 1);
	PlayerTextDrawUseBox(playerid, cam_arrowRight, 1);
	PlayerTextDrawBoxColor(playerid, cam_arrowRight, 6618980);
	PlayerTextDrawTextSize(playerid, cam_arrowRight, 466.000000, 58.000000);
	PlayerTextDrawSetSelectable(playerid, cam_arrowRight, true);


	// Info
	cam_row1 = CreatePlayerTextDraw(playerid, 240.000000, 325.000000, "Node:");
	PlayerTextDrawBackgroundColor(playerid, cam_row1, 255);
	PlayerTextDrawFont(playerid, cam_row1, 1);
	PlayerTextDrawLetterSize(playerid, cam_row1, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row1, -1);
	PlayerTextDrawSetOutline(playerid, cam_row1, 0);
	PlayerTextDrawSetProportional(playerid, cam_row1, 1);
	PlayerTextDrawSetShadow(playerid, cam_row1, 1);
	PlayerTextDrawUseBox(playerid, cam_row1, 1);
	PlayerTextDrawBoxColor(playerid, cam_row1, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row1, 400.000000, 0.000000);

	cam_row2 = CreatePlayerTextDraw(playerid, 240.000000, 342.000000, "Move Time (ms):");
	PlayerTextDrawBackgroundColor(playerid, cam_row2, 255);
	PlayerTextDrawFont(playerid, cam_row2, 1);
	PlayerTextDrawLetterSize(playerid, cam_row2, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row2, -1);
	PlayerTextDrawSetOutline(playerid, cam_row2, 0);
	PlayerTextDrawSetProportional(playerid, cam_row2, 1);
	PlayerTextDrawSetShadow(playerid, cam_row2, 1);
	PlayerTextDrawUseBox(playerid, cam_row2, 1);
	PlayerTextDrawBoxColor(playerid, cam_row2, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row2, 400.000000, 0.000000);

	cam_row3 = CreatePlayerTextDraw(playerid, 240.000000, 360.000000, "Wait Time (ms):");
	PlayerTextDrawBackgroundColor(playerid, cam_row3, 255);
	PlayerTextDrawFont(playerid, cam_row3, 1);
	PlayerTextDrawLetterSize(playerid, cam_row3, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row3, -1);
	PlayerTextDrawSetOutline(playerid, cam_row3, 0);
	PlayerTextDrawSetProportional(playerid, cam_row3, 1);
	PlayerTextDrawSetShadow(playerid, cam_row3, 1);
	PlayerTextDrawUseBox(playerid, cam_row3, 1);
	PlayerTextDrawBoxColor(playerid, cam_row3, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row3, 400.000000, 0.000000);

	cam_row4 = CreatePlayerTextDraw(playerid, 240.000000, 378.000000, "Cut Type:");
	PlayerTextDrawBackgroundColor(playerid, cam_row4, 255);
	PlayerTextDrawFont(playerid, cam_row4, 1);
	PlayerTextDrawLetterSize(playerid, cam_row4, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row4, -1);
	PlayerTextDrawSetOutline(playerid, cam_row4, 0);
	PlayerTextDrawSetProportional(playerid, cam_row4, 1);
	PlayerTextDrawSetShadow(playerid, cam_row4, 1);
	PlayerTextDrawUseBox(playerid, cam_row4, 1);
	PlayerTextDrawBoxColor(playerid, cam_row4, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row4, 400.000000, 0.000000);


	// Data fields
	cam_row1Data = CreatePlayerTextDraw(playerid, 335.000000, 325.000000, "00");
	PlayerTextDrawBackgroundColor(playerid, cam_row1Data, 255);
	PlayerTextDrawFont(playerid, cam_row1Data, 1);
	PlayerTextDrawLetterSize(playerid, cam_row1Data, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row1Data, -1);
	PlayerTextDrawSetOutline(playerid, cam_row1Data, 0);
	PlayerTextDrawSetProportional(playerid, cam_row1Data, 1);
	PlayerTextDrawSetShadow(playerid, cam_row1Data, 1);
	PlayerTextDrawUseBox(playerid, cam_row1Data, 1);
	PlayerTextDrawBoxColor(playerid, cam_row1Data, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row1Data, 400.000000, 14.000000);
	PlayerTextDrawSetSelectable(playerid, cam_row1Data, true);

	cam_row2Data = CreatePlayerTextDraw(playerid, 335.000000, 342.000000, "00000");
	PlayerTextDrawBackgroundColor(playerid, cam_row2Data, 255);
	PlayerTextDrawFont(playerid, cam_row2Data, 1);
	PlayerTextDrawLetterSize(playerid, cam_row2Data, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row2Data, -1);
	PlayerTextDrawSetOutline(playerid, cam_row2Data, 0);
	PlayerTextDrawSetProportional(playerid, cam_row2Data, 1);
	PlayerTextDrawSetShadow(playerid, cam_row2Data, 1);
	PlayerTextDrawUseBox(playerid, cam_row2Data, 1);
	PlayerTextDrawBoxColor(playerid, cam_row2Data, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row2Data, 400.000000, 14.000000);
	PlayerTextDrawSetSelectable(playerid, cam_row2Data, true);

	cam_row3Data = CreatePlayerTextDraw(playerid, 335.000000, 360.000000, "00000");
	PlayerTextDrawBackgroundColor(playerid, cam_row3Data, 255);
	PlayerTextDrawFont(playerid, cam_row3Data, 1);
	PlayerTextDrawLetterSize(playerid, cam_row3Data, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row3Data, -1);
	PlayerTextDrawSetOutline(playerid, cam_row3Data, 0);
	PlayerTextDrawSetProportional(playerid, cam_row3Data, 1);
	PlayerTextDrawSetShadow(playerid, cam_row3Data, 1);
	PlayerTextDrawUseBox(playerid, cam_row3Data, 1);
	PlayerTextDrawBoxColor(playerid, cam_row3Data, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row3Data, 400.000000, 14.000000);
	PlayerTextDrawSetSelectable(playerid, cam_row3Data, true);

	cam_row4Data = CreatePlayerTextDraw(playerid, 335.000000, 378.000000, "MOVE");
	PlayerTextDrawBackgroundColor(playerid, cam_row4Data, 255);
	PlayerTextDrawFont(playerid,cam_row4Data, 1);
	PlayerTextDrawLetterSize(playerid, cam_row4Data, 0.300000, 1.000000);
	PlayerTextDrawColor(playerid, cam_row4Data, 16777215);
	PlayerTextDrawSetOutline(playerid, cam_row4Data, 0);
	PlayerTextDrawSetProportional(playerid, cam_row4Data, 1);
	PlayerTextDrawSetShadow(playerid, cam_row4Data, 1);
	PlayerTextDrawUseBox(playerid, cam_row4Data, 1);
	PlayerTextDrawBoxColor(playerid, cam_row4Data, 3955300);
	PlayerTextDrawTextSize(playerid, cam_row4Data, 400.000000, 14.000000);
	PlayerTextDrawSetSelectable(playerid, cam_row4Data, true);


	// Edit Controls
	cam_buttonEdit = CreatePlayerTextDraw(playerid, 250.000000, 290.000000, "E");
	PlayerTextDrawBackgroundColor(playerid, cam_buttonEdit, 255);
	PlayerTextDrawFont(playerid, cam_buttonEdit, 1);
	PlayerTextDrawLetterSize(playerid, cam_buttonEdit, 1.000000, 2.499999);
	PlayerTextDrawColor(playerid, cam_buttonEdit, -1);
	PlayerTextDrawSetOutline(playerid, cam_buttonEdit, 0);
	PlayerTextDrawSetProportional(playerid, cam_buttonEdit, 1);
	PlayerTextDrawSetShadow(playerid, cam_buttonEdit, 1);
	PlayerTextDrawUseBox(playerid, cam_buttonEdit, 1);
	PlayerTextDrawBoxColor(playerid, cam_buttonEdit, 100);
	PlayerTextDrawTextSize(playerid, cam_buttonEdit, 270.000000, 14.0);
	PlayerTextDrawSetSelectable(playerid, cam_buttonEdit, true);

	cam_buttonSave = CreatePlayerTextDraw(playerid, 280.000000, 290.000000, "S");
	PlayerTextDrawBackgroundColor(playerid, cam_buttonSave, 255);
	PlayerTextDrawFont(playerid, cam_buttonSave, 1);
	PlayerTextDrawLetterSize(playerid, cam_buttonSave, 0.829999, 2.499999);
	PlayerTextDrawColor(playerid, cam_buttonSave, -1);
	PlayerTextDrawSetOutline(playerid, cam_buttonSave, 0);
	PlayerTextDrawSetProportional(playerid, cam_buttonSave, 1);
	PlayerTextDrawSetShadow(playerid, cam_buttonSave, 1);
	PlayerTextDrawUseBox(playerid, cam_buttonSave, 1);
	PlayerTextDrawBoxColor(playerid, cam_buttonSave, 100);
	PlayerTextDrawTextSize(playerid, cam_buttonSave, 300.000000, 14.0);
	PlayerTextDrawSetSelectable(playerid, cam_buttonSave, true);

	cam_buttonDelt = CreatePlayerTextDraw(playerid, 310.000000, 290.000000, "X");
	PlayerTextDrawBackgroundColor(playerid, cam_buttonDelt, 255);
	PlayerTextDrawFont(playerid, cam_buttonDelt, 1);
	PlayerTextDrawLetterSize(playerid, cam_buttonDelt, 0.890000, 2.499999);
	PlayerTextDrawColor(playerid, cam_buttonDelt, -1);
	PlayerTextDrawSetOutline(playerid, cam_buttonDelt, 0);
	PlayerTextDrawSetProportional(playerid, cam_buttonDelt, 1);
	PlayerTextDrawSetShadow(playerid, cam_buttonDelt, 1);
	PlayerTextDrawUseBox(playerid, cam_buttonDelt, 1);
	PlayerTextDrawBoxColor(playerid, cam_buttonDelt, 100);
	PlayerTextDrawTextSize(playerid, cam_buttonDelt, 330.000000, 14.0);
	PlayerTextDrawSetSelectable(playerid, cam_buttonDelt, true);

	cam_buttonPrev = CreatePlayerTextDraw(playerid, 340.000000, 290.000000, ">>");
	PlayerTextDrawBackgroundColor(playerid, cam_buttonPrev, 255);
	PlayerTextDrawFont(playerid, cam_buttonPrev, 1);
	PlayerTextDrawLetterSize(playerid, cam_buttonPrev, 0.389999, 2.499999);
	PlayerTextDrawColor(playerid, cam_buttonPrev, -1);
	PlayerTextDrawSetOutline(playerid, cam_buttonPrev, 0);
	PlayerTextDrawSetProportional(playerid, cam_buttonPrev, 1);
	PlayerTextDrawSetShadow(playerid, cam_buttonPrev, 1);
	PlayerTextDrawUseBox(playerid, cam_buttonPrev, 1);
	PlayerTextDrawBoxColor(playerid, cam_buttonPrev, 100);
	PlayerTextDrawTextSize(playerid, cam_buttonPrev, 360.000000, 14.0);
	PlayerTextDrawSetSelectable(playerid, cam_buttonPrev, true);

	cam_buttonAddN = CreatePlayerTextDraw(playerid, 370.000000, 290.000000, "+");
	PlayerTextDrawBackgroundColor(playerid, cam_buttonAddN, 255);
	PlayerTextDrawFont(playerid, cam_buttonAddN, 1);
	PlayerTextDrawLetterSize(playerid, cam_buttonAddN, 0.860000, 2.499999);
	PlayerTextDrawColor(playerid, cam_buttonAddN, -1);
	PlayerTextDrawSetOutline(playerid, cam_buttonAddN, 0);
	PlayerTextDrawSetProportional(playerid, cam_buttonAddN, 1);
	PlayerTextDrawSetShadow(playerid, cam_buttonAddN, 1);
	PlayerTextDrawUseBox(playerid, cam_buttonAddN, 1);
	PlayerTextDrawBoxColor(playerid, cam_buttonAddN, 100);
	PlayerTextDrawTextSize(playerid, cam_buttonAddN, 390.000000, 14.0);
	PlayerTextDrawSetSelectable(playerid, cam_buttonAddN, true);

	cam_buttonBack = CreatePlayerTextDraw(playerid, 500.000000, 110.000000, "Back");
	PlayerTextDrawBackgroundColor(playerid, cam_buttonBack, 255);
	PlayerTextDrawFont(playerid, cam_buttonBack, 1);
	PlayerTextDrawLetterSize(playerid, cam_buttonBack, 0.759999, 2.499999);
	PlayerTextDrawColor(playerid, cam_buttonBack, -16776961);
	PlayerTextDrawSetOutline(playerid, cam_buttonBack, 1);
	PlayerTextDrawSetProportional(playerid, cam_buttonBack, 1);
	PlayerTextDrawUseBox(playerid, cam_buttonBack, 1);
	PlayerTextDrawBoxColor(playerid, cam_buttonBack, 100);
	PlayerTextDrawTextSize(playerid, cam_buttonBack, 560.000000, 14.000000);
	PlayerTextDrawSetSelectable(playerid, cam_buttonBack, true);
}

// Separate functions that are used
stock GetXYFromAngle(&Float:x, &Float:y, Float:a, Float:distance)
	x+=(distance*floatsin(-a,degrees)),y+=(distance*floatcos(-a,degrees));

stock GetXYZFromAngle(&Float:x, &Float:y, &Float:z, Float:angle, Float:elevation, Float:distance)
	x += ( distance*floatsin(angle,degrees)*floatcos(elevation,degrees) ),y += ( distance*floatcos(angle,degrees)*floatcos(elevation,degrees) ),z += ( distance*floatsin(elevation,degrees) );



//end