#include "component.hpp"

private _map = (findDisplay 12 displayCtrl 51);

deleteMarkerLocal QGVAR(currentMarker);

_map ctrlRemoveEventHandler ["MouseButtonDown", GVAR(mouseButtonDownEH)];
_map ctrlRemoveEventHandler ["MouseButtonUp", GVAR(mouseButtonUpEH)];
_map ctrlRemoveEventHandler ["MouseMoving", missionNamespace getVariable [QGVAR(mouseMovingEH),-1]];

(findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(keydownEH)];

GVAR(recommendedMin) = nil;
GVAR(recommendedMax) = nil;
GVAR(recommendedLabelDist) = nil;
GVAR(mouseButtonDownEH) = nil;
GVAR(mouseButtonUpEH) = nil;
GVAR(mouseMovingEH) = nil;
GVAR(keydownEH) = nil;
GVAR(mouseEventRuning) = nil;
GVAR(markerStartPos) = nil;
GVAR(currentMarker) = nil;
GVAR(distanceMarker) = nil;
GVAR(recommendedMinMarker) = nil;
GVAR(recommendedMaxMarker) = nil;
GVAR(recommendedLabelMarker) = nil;
GVAR(markerEndPos) = nil;
GVAR(markerStartPos) = nil;

openMap [false,false];
