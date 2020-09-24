#include "component.hpp"

if (missionNamespace getVariable [QGVAR(votingComplete),false]) exitWith {};

openMap [true, true];
[] call FUNC(voteDialog);

GVAR(playzoneSkipVote) = false;

private _recommendedMid = sqrt((count playableUnits) * (45000 / 3.1415));
GVAR(recommendedMin) = ((round ((_recommendedMid * 0.75)/10)) *10);
GVAR(recommendedMax) = ((round ((_recommendedMid * 1.25)/10)) *10);
GVAR(recommendedLabelDist) = ((sin 45) * GVAR(recommendedMax)) * 1.1;


// ADD EHs =====================================================================
disableSerialization;
private _map = (findDisplay 12 displayCtrl 51);
GVAR(mouseButtonDownEH) = _map ctrlAddEventHandler ["MouseButtonDown", QUOTE(_this call FUNC(onMouseButtonDown))];
GVAR(mouseButtonUpEH) = _map ctrlAddEventHandler ["MouseButtonUp", QUOTE(_this call FUNC(onMouseButtonUp))];
GVAR(keydownEH) = (findDisplay 46) displayAddEventHandler ["KeyDown", QUOTE(_this call FUNC(onKeyDown))];


// EXIT VOTING =================================================================
private _waitUntil = {missionNamespace getVariable [QGVAR(votingComplete),false]};
[_waitUntil,FUNC(exitVotingPlayer),[]] call CBA_fnc_waitUntilAndExecute;
