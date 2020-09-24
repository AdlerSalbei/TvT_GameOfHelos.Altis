#include "component.hpp"

params ["_areaMarker"];

private _ySpacing = -100;

private _markerID = GVAR(areaMarkers) find _areaMarker;
private _votes = GVAR(markerVotes) select _markerID;
private _voteMarker = GVAR(voteMarkers) select _markerID;
private _voters = GVAR(voters) select _markerID;
private _pos = getMarkerPos _areaMarker;

//delete old markers
private _allfound = false;
private _i = 0;
while {!_allFound} do {
    _oldVoterMarkerName = format ["%1_%2", _voteMarker, _i];
    if (str getMarkerPos _oldVoterMarkerName != "[0,0,0]") then {
        deleteMarker _oldVoterMarkerName;
    } else {
        _allFound = true;
    };
    _i = _i + 1;
};

//create new markers
_voteMarker setMarkerText format ["Diam.: %1m, Votes: %2", round ((getMarkerSize _areaMarker) param [0,0]) * 2,count _voters];
for [{_i=0}, {_i < count _voters}, {_i=_i+1}] do {
    _voterMarkerName = format ["%1_%2", _voteMarker, _i];
    _voterMarkerPos = _pos vectorAdd [0,_ySpacing * (_i+1),0];
    _voterMarker = createMarker [_voterMarkerName, _voterMarkerPos];
    _voterMarker setMarkerType "hd_dot";
    _voterMarker setMarkerColor "COLORWEST";
    _voterMarker setMarkerText (name (_voters select _i));
};
