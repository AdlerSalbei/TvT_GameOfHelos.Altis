#include "component.hpp"

params ["_control", "_button", "_xScreen", "_yScreen"];

if (_button != 0) exitWith {};
if (missionNamespace getVariable [QGVAR(votingComplete), false]) exitWith {};

deleteMarkerLocal QGVAR(currentMarker);
deleteMarkerLocal QGVAR(distanceMarker);
deleteMarkerLocal QGVAR(recommendedMinMarker);
deleteMarkerLocal QGVAR(recommendedMaxMarker);
deleteMarkerLocal QGVAR(recommendedLabelMarker);

_control ctrlRemoveEventHandler ["MouseMoving", missionNamespace getVariable [QGVAR(mouseMovingEH), -1]];
GVAR(markerEndPos) = _control ctrlMapScreenToWorld [_xScreen, _yScreen];
private _size = GVAR(markerStartPos) distance2D GVAR(markerEndPos);

[GVAR(markerStartPos), player, _size] remoteExecCall [QFUNC(receiveVote), 2, false];

GVAR(mouseEventRuning) = false;

true
