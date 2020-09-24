#include "component.hpp"

params ["_control", "_button", "_xScreen", "_yScreen"];

if (_button != 0) exitWith {};
if (missionNamespace getVariable [QGVAR(votingComplete),false]) exitWith {};


if (missionNamespace getVariable [QGVAR(mouseEventRuning),false]) exitWith {};
GVAR(mouseEventRuning) = true;

GVAR(markerStartPos) = _control ctrlMapScreenToWorld [_xScreen,_yScreen];

deleteMarkerLocal QGVAR(currentMarker);
GVAR(currentMarker) = createMarkerLocal [QGVAR(currentMarker),GVAR(markerStartPos)];
GVAR(currentMarker) setMarkerColorLocal "COLORWEST";
GVAR(currentMarker) setMarkerShapeLocal "ELLIPSE";
GVAR(currentMarker) setMarkerBrushLocal "Border";
GVAR(currentMarker) setMarkerSizeLocal [1,1];

deleteMarkerLocal QGVAR(distanceMarker);
GVAR(distanceMarker) = createMarkerLocal [QGVAR(distanceMarker),GVAR(markerStartPos)];
GVAR(distanceMarker) setMarkerColorLocal "COLORWEST";
GVAR(distanceMarker) setMarkerTypeLocal "hd_dot";

deleteMarkerLocal QGVAR(recommendedMinMarker);
GVAR(recommendedMinMarker) = createMarkerLocal [QGVAR(recommendedMinMarker),GVAR(markerStartPos)];
GVAR(recommendedMinMarker) setMarkerColorLocal "COLORGUER";
GVAR(recommendedMinMarker) setMarkerShapeLocal "ELLIPSE";
GVAR(recommendedMinMarker) setMarkerBrushLocal "Border";
GVAR(recommendedMinMarker) setMarkerSizeLocal [GVAR(recommendedMin),GVAR(recommendedMin)];

deleteMarkerLocal QGVAR(recommendedMaxMarker);
GVAR(recommendedMaxMarker) = createMarkerLocal [QGVAR(recommendedMaxMarker),GVAR(markerStartPos)];
GVAR(recommendedMaxMarker) setMarkerColorLocal "COLORGUER";
GVAR(recommendedMaxMarker) setMarkerShapeLocal "ELLIPSE";
GVAR(recommendedMaxMarker) setMarkerBrushLocal "Border";
GVAR(recommendedMaxMarker) setMarkerSizeLocal [GVAR(recommendedMax),GVAR(recommendedMax)];

deleteMarkerLocal GVAR(recommendedLabelMarker);
GVAR(recommendedLabelMarker) = createMarkerLocal [QGVAR(recommendedLabelMarker), [(GVAR(markerStartPos) select 0) + GVAR(recommendedLabelDist), (GVAR(markerStartPos) select 1) - GVAR(recommendedLabelDist)]];
GVAR(recommendedLabelMarker) setMarkerColorLocal "COLORGREEN";
GVAR(recommendedLabelMarker) setMarkerTypeLocal "hd_dot";
GVAR(recommendedLabelMarker) setMarkerTextLocal (format ["Recommended Diameter: %1m - %2m", GVAR(recommendedMin) * 2, GVAR(recommendedMax) * 2]);

GVAR(mouseMovingEH) = _control ctrlAddEventHandler ["MouseMoving",QUOTE(_this call FUNC(onMouseMoving))];
