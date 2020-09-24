#include "component.hpp"

private _layer = (["wait1Layer"] call BIS_fnc_rscLayer);
[{
    params ["_layer","_handle"];

    _layer cutRsc ["voteCountdownTitle", "PLAIN", 0.0001, true];

    if ((missionNamespace getVariable [QGVAR(votingTimeLeft),9999]) <= 0) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        playSound "taskSucceeded";
        _layer cutFadeOut 1;
    };
},1,_layer] call CBA_fnc_addPerFrameHandler;
