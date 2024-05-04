public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	if(response)
	{
		if(modelid == 19142) //By niceCzlowiek
		{
			if(fScaleX > 1.6 || fScaleY > 1.96 || fScaleZ > 1.96 || fScaleX < 0.7 || fScaleY < 0.7 || fScaleZ < 0.7) {
				RemovePlayerAttachedObject(playerid, 7);
				SetPlayerAttachedObject(playerid, 7, 19142, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
				return sendErrorMessage(playerid, "Zmiany nie zosta³y zapisane, dodatek by³ zbyt du¿y lub zbyt ma³y!");
			}
			if(fOffsetX > 0.35 || fOffsetY > 0.35 || fOffsetZ > 0.35 || fOffsetX < -0.35 || fOffsetY < -0.35 || fOffsetZ < -0.35) {
				RemovePlayerAttachedObject(playerid, 7);
				SetPlayerAttachedObject(playerid, 7, 19142, 1, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
				return sendErrorMessage(playerid, "Zmiany nie zosta³y zapisane, dodatek by³ zbyt oddalony od gracza!");
			}
			SetPVarFloat(playerid, "k_offsetX", fOffsetX);
			SetPVarFloat(playerid, "k_offsetY", fOffsetY);
			SetPVarFloat(playerid, "k_offsetZ", fOffsetZ);
			SetPVarFloat(playerid, "k_rotX", fRotX);
			SetPVarFloat(playerid, "k_rotY", fRotY);
			SetPVarFloat(playerid, "k_rotZ", fRotZ);
			SetPVarFloat(playerid, "k_scaleX", fScaleX);
			SetPVarFloat(playerid, "k_scaleY", fScaleY);
			SetPVarFloat(playerid, "k_scaleZ", fScaleZ);
			return 1;
			
		}
		if(fOffsetX > 0.95 || fOffsetY > 0.95 || fOffsetZ > 0.95 || fOffsetX < -0.95 || fOffsetY < -0.95 || fOffsetZ < -0.95) 
		{
			RemovePlayerAttachedObject(playerid, index);
			SetPlayerAttachedObject(playerid, index, modelid, boneid, GetPVarFloat(playerid, "k_offsetX"), GetPVarFloat(playerid, "k_offsetY"), GetPVarFloat(playerid, "k_offsetZ"), GetPVarFloat(playerid, "k_rotX"), GetPVarFloat(playerid, "k_rotY"), GetPVarFloat(playerid, "k_rotZ"), GetPVarFloat(playerid, "k_scaleX"), GetPVarFloat(playerid, "k_scaleY"), GetPVarFloat(playerid, "k_scaleZ"));
			return sendErrorMessage(playerid, "Zmiany nie zosta³y zapisane, dodatek by³ zbyt oddalony od gracza!");
		}
		sendTipMessage(playerid, "Zapisano pozycje edycji"); 
		//chwilowe rozwi¹zanie (póki nie poszerzê tablicy) - tak aby gracz nie musia³ edytowaæ za ka¿dym razem 
		SetPVarFloat(playerid, "d_offsetX", fOffsetX);
		SetPVarFloat(playerid, "d_offsetY", fOffsetY);
		SetPVarFloat(playerid, "d_offsetZ", fOffsetZ);
		SetPVarFloat(playerid, "d_rotX", fRotX);
		SetPVarFloat(playerid, "d_rotY", fRotY);
		SetPVarFloat(playerid, "d_rotZ", fRotZ);
		SetPVarFloat(playerid, "d_scaleX", fScaleX);
		SetPVarFloat(playerid, "d_scaleY", fScaleY);
		SetPVarFloat(playerid, "d_scaleZ", fScaleZ);
	}
	else
	{
		sendErrorMessage(playerid, "Odrzucono zapis obiektu"); 
	}
	
    return 1;
}
