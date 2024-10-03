//----------------------------------------------<< Callbacks >>----------------------------------------------//
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

#include <YSI\y_hooks>

//-----------------<[ Callbacki: ]>-----------------
camera_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#pragma unused oldkeys
	if(gPlayerEditingNode[playerid])
	{
		if(newkeys & KEY_FIRE)
		{
			new strInfo[64];
			format(strInfo, 64, "Apply changes to node %d?", gPlayerCamData[playerid][p_Node]);
			ShowPlayerDialogEx(playerid, d_confirmNodeCommit, DIALOG_STYLE_MSGBOX, "Confirm changes?", strInfo, "Apply", "Reset");
		}
		if(newkeys & 16) CancelCurrentNodeEdit(playerid);
	}
}

camera_OnPlayerClickPTD(playerid, PlayerText:playertextid)
{
	if(playertextid == cam_buttonBack) 
	{
		ShowPlayerDialogEx(playerid, d_ConfirmQuit, DIALOG_STYLE_MSGBOX, "Exit Editing", "Are you sure you want to quit? All unsaved data will be lost!", "Ok", "Cancel");
	}

	if(playertextid == cam_buttonEdit) 
	{
		EditCurrentNode(playerid);
	}
	if(playertextid == cam_buttonSave) 
	{
		ShowPlayerDialogEx(playerid, d_ExportDialog, DIALOG_STYLE_LIST, "Export Camera As...", "Sequencer Data File\nInterpolate Functions", "Accept", "Cancel");
	}
	if(playertextid == cam_buttonDelt) 
	{
		DeleteCurrentNode(playerid);
	}
	if(playertextid == cam_buttonPrev) 
	{
		MoveCameraToNextNode(playerid, true, false, false);
	}
	if(playertextid == cam_buttonAddN)
	{
		if(GetCameraMaxNodes(gPlayerCamData[playerid][p_CamID]) < MAX_CAMNODE-1) EditNewNode(playerid);
		else SendClientMessage(playerid, 0xFF0000FF, "Node limit reached, increase constant <MAX_CAMNODE> in script.");
	}

	if(playertextid == cam_arrowLeft)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			tmpNode = gPlayerCamData[playerid][p_Node] - 1;

		if(tmpNode < 0)tmpNode = camMaxNodes[tmpCam];
		JumpToNode(playerid, tmpNode);
	}
	if(playertextid == cam_arrowRight)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			tmpNode = gPlayerCamData[playerid][p_Node] + 1;

		if(tmpNode > camMaxNodes[tmpCam])tmpNode = 0;
		JumpToNode(playerid, tmpNode);
	}
	if(playertextid == cam_row1Data) ShowPlayerDialogEx(playerid, d_NodeID, DIALOG_STYLE_INPUT, "Node ID", "Type a node ID to jump to", "Back", "Accept");
	if(playertextid == cam_row2Data) ShowPlayerDialogEx(playerid, d_MoveTime, DIALOG_STYLE_INPUT, "Move Time", "Time to move to next node (in milliseconds)", "Back", "Accept");
	if(playertextid == cam_row3Data) ShowPlayerDialogEx(playerid, d_WaitTime, DIALOG_STYLE_INPUT, "Wait Time", "Time to wait before moving to next node (in milliseconds)", "Back", "Accept");
	if(playertextid == cam_row4Data) ShowPlayerDialogEx(playerid, d_MoveType, DIALOG_STYLE_MSGBOX, "Cut Type", "Select a Camera Cut Type\nMove: Smoothly moves to the next node.\nJump: Jumps to the next node.", "Move", "Jump");
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == d_MainMenu)
	{
		if(response)
		{
			if(listitem==0) ShowPlayerDialogEx(playerid, d_NewCamName, DIALOG_STYLE_INPUT, "New Camera", "Enter the new camera name below.\nDo not use spaces.", "Accept", "Back");
			else
			{
				SelectedCamera[playerid] = listitem-1;
				ShowPlayerDialogEx(playerid, d_ProjectOptions, DIALOG_STYLE_LIST, "Options", "Edit Camera\nPreview Camera", "Accept", "Back");
			}
		}
	}
	if(dialogid == d_NewCamName)
	{
		if(response)
		{
			if(strfind(inputtext, " ") == -1)
			{
				CreateCameraMover(playerid, inputtext);
				FormatMainMenu(playerid);
			}
			else ShowPlayerDialogEx(playerid, d_NewCamName, DIALOG_STYLE_INPUT, "New Camera", "Enter the new camera name below.\n{FF0000}Do not use spaces.", "Accept", "Back");
		}
		else FormatMainMenu(playerid);
	}
	if(dialogid == d_ProjectOptions)
	{
		if(response)
		{
			if(listitem == 0) EditCameraMover(playerid, LoadCameraMover(indexData[SelectedCamera[playerid]]));
			if(listitem == 1) PlayCameraMover(playerid, LoadCameraMover(indexData[SelectedCamera[playerid]]));
		}
		else FormatMainMenu(playerid);
	}
	if(dialogid == d_ExportDialog)
	{
		if(response)
		{
			SaveCameraMover(playerid, listitem);
			SendClientMessage(playerid, 0xFFFF00FF, "Camera saved!");
		}
	}

	if(dialogid == d_NodeID)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			nextNode = strval(inputtext);
		if(0 <= nextNode < camMaxNodes[tmpCam])JumpToNode(playerid, nextNode);
		else
		{
			SendClientMessage(playerid, 0xFF1100FF, "Invalid value entered");
			ShowPlayerDialogEx(playerid, d_NodeID, DIALOG_STYLE_INPUT, "Node ID", "Type a node ID to jump to", "Back", "Accept");
		}
	}
	if(dialogid == d_MoveTime)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			tmpNode = gPlayerCamData[playerid][p_Node],
			tmpMoveTime = strval(inputtext);

		if(tmpMoveTime > 0)
		{
			camData[tmpCam][tmpNode][cam_moveTime] = tmpMoveTime;
			UpdateGUI(playerid);
		}
		else
		{
			SendClientMessage(playerid, 0xFF1100FF, "Invalid value entered");
			ShowPlayerDialogEx(playerid, d_MoveTime, DIALOG_STYLE_INPUT, "Move Time", "Time to move to next node (in milliseconds)", "Back", "Accept");
		}
	}
	if(dialogid == d_WaitTime)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			tmpNode = gPlayerCamData[playerid][p_Node],
			tmpWaitTime = strval(inputtext);

		if(tmpWaitTime > 0)
		{
			camData[tmpCam][tmpNode][cam_waitTime] = tmpWaitTime;
			UpdateGUI(playerid);
		}
		else
		{
			SendClientMessage(playerid, 0xFF1100FF, "Invalid value entered");
			ShowPlayerDialogEx(playerid, d_WaitTime, DIALOG_STYLE_INPUT, "Wait Time", "Time to wait before moving to next node (in milliseconds)", "Back", "Accept");
		}
	}
	if(dialogid == d_MoveType)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			tmpNode = gPlayerCamData[playerid][p_Node];

		if(!response)
		{
			camData[tmpCam][tmpNode][cam_moveType] = CAMERA_MOVE;
			UpdateGUI(playerid);
		}
		else
		{
			camData[tmpCam][tmpNode][cam_moveType] = CAMERA_CUT;
			UpdateGUI(playerid);
		}
	}

	if(dialogid == d_confirmNodeCommit)
	{
		new
			tmpCam = gPlayerCamData[playerid][p_CamID],
			tmpNode = gPlayerCamData[playerid][p_Node];

		if(response)CommitCurrentNode(playerid);
		else
		{
			SetDynamicObjectPos(noclipdata[playerid][flyobject],
				camData[tmpCam][tmpNode][cam_cPosX],
				camData[tmpCam][tmpNode][cam_cPosY],
				camData[tmpCam][tmpNode][cam_cPosZ]);
		}
	}

	if(dialogid == d_ConfirmQuit)
	{
		if(response)
		{
			ExitEditing(playerid);
			FormatMainMenu(playerid);
		}
	}
}

hook OnPlayerConnect(playerid)
{
	camera_LoadTextDraws(playerid);
	return 1;
}


public OnCameraReachNode(playerid, cameraid, node)
{
	if(node == camMaxNodes[cameraid]) ApplyAnimation(0, "PED", "KO_shot_face", 5.0, 0, 1, 1, 1, 0, 1);
}

//end