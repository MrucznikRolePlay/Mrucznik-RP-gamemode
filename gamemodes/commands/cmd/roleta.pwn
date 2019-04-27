//-----------------------------------------------<< Komenda >>-----------------------------------------------//
//-------------------------------------------------[ roleta ]------------------------------------------------//
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

// Opis:
/*
	
*/


// Notatki skryptera:
/*
	
*/

YCMD:roleta(playerid,params[], help)
{
	if(open == 0)
	{
		if(IsPlayerInRangeOfPoint(playerid, 5, 1154.9895,-1440.2941,15.8004))
		{
			MoveDynamicObject(roleta1, 1155.3385, -1434.8569, 19.53240, 1);
			MoveDynamicObject(roleta2, 1155.3075, -1445.4606, 19.53240, 1);
			MoveDynamicObject(roleta27_b, 1155.33020, -1440.26257, 19.76762, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1155.0774,-1458.3248,15.7969))
		{
			MoveDynamicObject(roleta3, 1155.2838, -1452.4583, 19.53240, 1);
			MoveDynamicObject(roleta28_b, 1155.26587, -1457.96631, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1158.9919,-1473.2074,15.7969))
		{
			MoveDynamicObject(roleta4, 1157.2544, -1468.3411, 19.34046, 1);
			MoveDynamicObject(roleta5, 1160.5482, -1478.3494, 19.34046, 1);
			MoveDynamicObject(roleta29_b, 1158.97632, -1473.48071, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1157.6462,-1506.8799,15.8043))
		{
			MoveDynamicObject(roleta6, 1159.79529, -1502.02625, 19.34046, 1);
			MoveDynamicObject(roleta30_b, 1157.87805, -1507.22778, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1144.3123,-1521.6416,15.7969))
		{
			MoveDynamicObject(roleta7, 1139.32727, -1523.66382, 19.34046, 1);
			MoveDynamicObject(roleta31_b, 1144.33337, -1521.67236, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1112.2089,-1521.6674,15.7969))
		{
			MoveDynamicObject(roleta8, 1117.11047, -1523.44629, 19.34046, 1);
			MoveDynamicObject(roleta32_b, 1111.57068, -1521.30261, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1099.0670,-1507.3119,15.7988))
		{
			MoveDynamicObject(roleta9, 1097.22986, -1502.35522, 19.34046, 1);
			MoveDynamicObject(roleta33_b, 1099.09314, -1507.37439, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1098.1234,-1473.5315,15.7957))
		{
			MoveDynamicObject(roleta10, 1096.56262, -1478.35095, 19.34046, 1);
			MoveDynamicObject(roleta11, 1099.71655, -1468.33777, 19.34046, 1);
			MoveDynamicObject(roleta34_b, 1098.15015, -1473.25708, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1101.5022,-1457.7675,15.7969))
		{
			MoveDynamicObject(roleta12, 1101.80994, -1452.50964, 19.34046, 1);
			MoveDynamicObject(roleta35_b, 1101.69348, -1457.87415, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1101.5773,-1440.2340,15.7969))
		{
			MoveDynamicObject(roleta13, 1101.85461, -1445.46973, 19.34046, 1);
			MoveDynamicObject(roleta14, 1101.87024, -1434.87134, 19.34046, 1);
			MoveDynamicObject(roleta36_b, 1101.77600, -1440.09167, 19.78000, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1163.2041,-1434.8906,22.7901))
		{
			MoveDynamicObject(roleta15, 1163.03076, -1441.90295, 26.60007, 1);
			MoveDynamicObject(roleta16, 1163.09363, -1428.44617, 26.60007, 1);
			MoveDynamicObject(roleta24_b, 1163.08789, -1435.43616, 26.61972, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1094.5642,-1451.2289,22.7596))
		{
			MoveDynamicObject(roleta17, 1094.42163, -1444.70667, 26.60007, 1);
			MoveDynamicObject(roleta18, 1094.48633, -1458.07800, 26.60007, 1);
			MoveDynamicObject(roleta26_b, 1094.44238, -1451.46936, 26.60007, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1097.1677,-1522.5531,22.7442))
		{
			MoveDynamicObject(roleta19, 1092.84375, -1517.22107, 26.53010, 1);
			MoveDynamicObject(roleta20, 1100.95435, -1526.41223, 26.53010, 1);
			MoveDynamicObject(roleta25_b, 1096.88684, -1521.87561, 26.53010, 1);
			open = 1;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1158.7311,-1522.1617,22.7422))
		{
			MoveDynamicObject(roleta21, 1154.93408, -1526.49878, 26.53010, 1);
			MoveDynamicObject(roleta22, 1162.9818, -1517.2509, 26.5301, 1);
			MoveDynamicObject(roleta23_b, 1158.95239, -1521.83850, 26.53010, 1);
			open = 1;
		}
	}
	else
	{
		if(IsPlayerInRangeOfPoint(playerid, 5, 1154.9895,-1440.2941,15.8004))
		{
			MoveDynamicObject(roleta1, 1155.3385, -1434.8569, 16.53240, 1);
			MoveDynamicObject(roleta2, 1155.3075, -1445.4606, 16.53240, 1);
			MoveDynamicObject(roleta27_b, 1155.33020, -1440.26257, 16.76762, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1155.0774,-1458.3248,15.7969))
		{
			MoveDynamicObject(roleta3, 1155.2838, -1452.4583, 16.53240, 1);
			MoveDynamicObject(roleta28_b, 1155.26587, -1457.96631, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1158.9919,-1473.2074,15.7969))
		{
			MoveDynamicObject(roleta4, 1157.2544, -1468.3411, 16.34046, 1);
			MoveDynamicObject(roleta5, 1160.5482, -1478.3494, 16.34046, 1);
			MoveDynamicObject(roleta29_b, 1158.97632, -1473.48071, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1157.6462,-1506.8799,15.8043))
		{
			MoveDynamicObject(roleta6, 1159.79529, -1502.02625, 16.34046, 1);
			MoveDynamicObject(roleta30_b, 1157.87805, -1507.22778, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1144.3123,-1521.6416,15.7969))
		{
			MoveDynamicObject(roleta7, 1139.32727, -1523.66382, 16.34046, 1);
			MoveDynamicObject(roleta31_b, 1144.33337, -1521.67236, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1112.2089,-1521.6674,15.7969))
		{
			MoveDynamicObject(roleta8, 1117.11047, -1523.44629, 16.34046, 1);
			MoveDynamicObject(roleta32_b, 1111.57068, -1521.30261, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1099.0670,-1507.3119,15.7988))
		{
			MoveDynamicObject(roleta9, 1097.22986, -1502.35522, 16.34046, 1);
			MoveDynamicObject(roleta33_b, 1099.09314, -1507.37439, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1098.1234,-1473.5315,15.7957))
		{
			MoveDynamicObject(roleta10, 1096.56262, -1478.35095, 16.34046, 1);
			MoveDynamicObject(roleta11, 1099.71655, -1468.33777, 16.34046, 1);
			MoveDynamicObject(roleta34_b, 1098.15015, -1473.25708, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1101.5022,-1457.7675,15.7969))
		{
			MoveDynamicObject(roleta12, 1101.80994, -1452.50964, 16.34046, 1);
			MoveDynamicObject(roleta35_b, 1101.69348, -1457.87415, 16.53240, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1101.5773,-1440.2340,15.7969))
		{
			MoveDynamicObject(roleta13, 1101.85461, -1445.46973, 16.34046, 1);
			MoveDynamicObject(roleta14, 1101.87024, -1434.87134, 16.34046, 1);
			MoveDynamicObject(roleta36_b, 1101.77600, -1440.09167, 16.78000, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1163.2041,-1434.8906,22.7901))
		{
			MoveDynamicObject(roleta15, 1163.03076, -1441.90295, 23.60007, 1);
			MoveDynamicObject(roleta16, 1163.09363, -1428.44617, 23.60007, 1);
			MoveDynamicObject(roleta24_b, 1163.08789, -1435.43616, 23.61972, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1094.5642,-1451.2289,22.7596))
		{
			MoveDynamicObject(roleta17, 1094.42163, -1444.70667, 23.60007, 1);
			MoveDynamicObject(roleta18, 1094.48633, -1458.07800, 23.60007, 1);
			MoveDynamicObject(roleta26_b, 1094.44238, -1451.46936, 23.60007, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1097.1677,-1522.5531,22.7442))
		{
			MoveDynamicObject(roleta19, 1092.84375, -1517.22107, 23.53010, 1);
			MoveDynamicObject(roleta20, 1100.95435, -1526.41223, 23.53010, 1);
			MoveDynamicObject(roleta25_b, 1096.88684, -1521.87561, 23.53010, 1);
			open = 0;
		}
		else if(IsPlayerInRangeOfPoint(playerid, 5, 1158.7311,-1522.1617,22.7422))
		{
			MoveDynamicObject(roleta21, 1154.93408, -1526.49878, 23.53010, 1);
			MoveDynamicObject(roleta22, 1162.9818, -1517.2509, 23.5301, 1);
			MoveDynamicObject(roleta23_b, 1158.95239, -1521.83850, 23.53010, 1);
			open = 0;
		}
	}
	return 1;
}
