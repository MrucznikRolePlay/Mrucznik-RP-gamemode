//
#define MAX_SOUNDMANAGER    100

forward SoundManager_Add(soundid);
forward SoundManager_Remove(id);
forward SoundManager_Play(id);
forward SoundManager_Stop(id);
forward SoundManager_PlayForPlayer(id, forplayerid);
forward SoundManager_StopForPlayer(id, forplayerid);
forward SoundManager_ApplyForPlayer(id, forplayerid);
forward SoundManager_FlushForPlayer(id, forplayerid);
forward SoundManager_SetPos(id, Float:x, Float:y, Float:z);
forward SoundManager_SetDistance(id, Float:dist);
forward SoundManager_SetPriority(id, strange);

enum eSManager {
    SM@SOUNDID,
    Float:SM@X,
    Float:SM@Y,
    Float:SM@Z,
    Float:SM@DISTANCE,
    SM@PRIORITY,
    bool:SM@ACTIVE
};
new SoundManager[MAX_SOUNDMANAGER][eSManager];

new SM_PlayerHandle[MAX_PLAYERS];

stock SM_GetIDX()
{
    for(new i=0;i<MAX_SOUNDMANAGER;i++)
        if(SoundManager[i][SM@SOUNDID] == 0)
            return i;
    return -1;
}

public SoundManager_Add(soundid)
{
    new idx = SM_GetIDX();
    if(idx == -1)
        return -1;
    SoundManager[idx][SM@SOUNDID] = soundid;
    return idx;
}
public SoundManager_Remove(id)
{
    SoundManager_Stop(id);

    SoundManager[id][SM@SOUNDID] = 0;
    SoundManager[id][SM@ACTIVE] = false;
}
public SoundManager_Play(id)
{
    SoundManager[id][SM@ACTIVE] = true;
}
public SoundManager_Stop(id)
{
    SoundManager[id][SM@ACTIVE] = false;
}
public SoundManager_PlayForPlayer(id, forplayerid)
{
    if(SM_PlayerHandle[forplayerid] != 0)
        if(SoundManager[SM_PlayerHandle[forplayerid]][SM@PRIORITY] > SoundManager[id][SM@PRIORITY])
            return 0;

    return 1;
}
public SoundManager_StopForPlayer(id, forplayerid)
{
    SM_PlayerHandle[forplayerid] = 0;
}
public SoundManager_SetPos(id, Float:x, Float:y, Float:z)
{
    SoundManager[id][SM@X] = x;
    SoundManager[id][SM@Y] = y;
    SoundManager[id][SM@Z] = z;
}
public SoundManager_SetDistance(id, Float:dist)
{
    SoundManager[id][SM@DISTANCE] = dist;
}
public SoundManager_SetPriority(id, strange)
{
    SoundManager[id][SM@PRIORITY] = strange;
}
//
