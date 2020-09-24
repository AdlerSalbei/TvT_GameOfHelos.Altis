#include "component.hpp"

params ["_control", "_deltaXScreen", "_deltaYScreen"];

if (missionNamespace getVariable [QGVAR(votingComplete),false]) exitWith {};

private _currentPos = _control ctrlMapScreenToWorld [_deltaXScreen, _deltaYScreen];
private _distance = GVAR(markerStartPos) distance2D _currentPos;

GVAR(distanceMarker) setMarkerPosLocal [(_currentPos select 0)+100, (_currentPos select 1)-100];
GVAR(distanceMarker) setMarkerTextLocal (format ["Diameter: %1m", round (_distance*2)]);
GVAR(currentMarker) setMarkerSizeLocal [_distance,_distance];

false
