#define RECORDING "Linia55US_2"
#define RECORDING_TYPE 1

#include <a_npc>
main(){}
public OnRecordingPlaybackEnd() StartRecordingPlayback(RECORDING_TYPE, RECORDING);

#if RECORDING_TYPE == 1
public OnNPCEnterVehicle(vehicleid, seatid) StartRecordingPlayback(RECORDING_TYPE, RECORDING);
public OnNPCExitVehicle() StopRecordingPlayback();
#else
public OnNPCSpawn() StartRecordingPlayback(RECORDING_TYPE, RECORDING);
#endif
