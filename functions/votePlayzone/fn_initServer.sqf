#include "component.hpp"

// declare storage arrays
if (isNil QGVAR(areaMarkers)) then {GVAR(areaMarkers) = []};
if (isNil QGVAR(voteMarkers)) then {GVAR(voteMarkers) = []};
if (isNil QGVAR(markerVotes)) then {GVAR(markerVotes) = []};
if (isNil QGVAR(voters)) then {GVAR(voters) = []};

GVAR(votingTimeLeft) = [missionConfigFile >> "cfgMission","votingTime",60] call BIS_fnc_returnConfigEntry;

[{
    params ["","_handle"];

    missionNamespace setVariable [QGVAR(votingTimeLeft),GVAR(votingTimeLeft) - 1,true];

    if (GVAR(votingTimeLeft) <= 0) exitWith {
        missionNamespace setVariable [QGVAR(votingComplete),true,true];        
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

},1,[]] call CBA_fnc_addPerFrameHandler;
