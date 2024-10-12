#include <a_npc>

#define RECORDING "lodka2"

main()
{
    printf("lodka_przemytnicza");
}

public OnRecordingPlaybackEnd() 
{
    StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER, RECORDING);
}

public OnNPCEnterVehicle(vehicleid, seatid) 
{
    StartRecordingPlayback(PLAYER_RECORDING_TYPE_DRIVER, RECORDING);
}

public OnNPCExitVehicle()
{
    StopRecordingPlayback();
}
