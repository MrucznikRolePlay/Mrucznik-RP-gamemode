forward closeGate(i, j, playerid);
public closeGate(i, j, playerid)
{
    bramki_sasd_state[i] = false;
    SetPVarInt(playerid, "wybramkowany", 0);
    bramy[j][b_flaga] = true;
    MoveDynamicObject(bramy[j][b_obiekt], bramy[j][b_x2],  bramy[j][b_y2], bramy[j][b_z2], bramy[j][b_speed], bramy[j][b_rx2],  bramy[j][b_ry2], bramy[j][b_rz2]);
    return 1;
}
