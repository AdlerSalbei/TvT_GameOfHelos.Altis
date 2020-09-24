#include "component.hpp"

if (!isServer) exitWith {};

params ["_clickPos", "_player", "_size"];
private ["_closestMarker"];

// declare storage arrays
if (isNil QGVAR(areaMarkers)) then {GVAR(areaMarkers) = []};
if (isNil QGVAR(voteMarkers)) then {GVAR(voteMarkers) = []};
if (isNil QGVAR(markerVotes)) then {GVAR(markerVotes) = []};
if (isNil QGVAR(voters)) then {GVAR(voters) = []};

//player specific marker name
private _markerName = format [QGVAR(areamarker_%1), getPlayerUID _player];
private _votesMarkerName = _markerName + "_votes";

//delete old markers ===========================================================
if (str getMarkerSize _markerName != "[0,0]") then {

    deleteMarker _markerName;
    deleteMarker _votesMarkerName;
    _markerID = GVAR(areaMarkers) find _markerName;

    if (_markerID < 0) exitWith {
        ERROR_1("Marker %1 not found in areaMarkers array.",_markerName);
    };

    //delete old voter variables
    _oldVoters = GVAR(voters) select _markerID;
    {
        _x setVariable [QGVAR(playerVote),""];
    } forEach _oldVoters;

    //delete old markers
    _allfound = false;
    _i = 0;
    while {!_allFound} do {
        _oldVoterMarkerName = format ["%1_%2", _votesMarkerName, _i];
        if (str getMarkerPos _oldVoterMarkerName != "[0,0,0]") then {
            deleteMarker _oldVoterMarkerName;
        } else {
            _allFound = true;
        };
        _i = _i + 1;
    };

    GVAR(areaMarkers) deleteAt _markerID;
    GVAR(voteMarkers) deleteAt _markerID;
    GVAR(markerVotes) deleteAt _markerID;
    GVAR(voters) deleteAt _markerID;
};


//detract old vote =============================================================
private _oldVote = _player getVariable [QGVAR(playerVote), ""];
if (_oldVote != "") then {
    _markerID = GVAR(areaMarkers) find _oldVote;
    _oldVoteNumber = GVAR(markerVotes) select _markerID;
    GVAR(markerVotes) set [_markerID, _oldVoteNumber-1];
    _oldVoters = GVAR(voters) select _markerID;
    _newVoters = _oldVoters - [_player];
    GVAR(voters) set [_markerID, _newVoters];

    [_oldVote] call FUNC(updateVotesMarker);
};


//check if vote or proposal ====================================================
private _isVote = false;
private _closestDistance = 9999999;
{
    _markerPos = getMarkerPos _x;
    _markerSize = (getMarkerSize _x) select 0;
    _distance = _clickPos distance2D _markerPos;
    if (_distance < _markerSize) then {
        _isVote = true;
    if (_distance < _closestDistance) then {
        _closestMarker = _x;
        _closestDistance = _distance;
    };
  };
} forEach GVAR(areaMarkers);


//update vote if isvote ========================================================
if (_isVote) then {
    //add new vote
    _player setVariable [QGVAR(playerVote), _closestMarker];
    _markerID = GVAR(areaMarkers) find _closestMarker;
    _oldVoteNumber = GVAR(markerVotes) select _markerID;
    GVAR(markerVotes) set [_markerID, _oldVoteNumber+1];
    _oldVoters = GVAR(voters) select _markerID;
    _newVoters = _oldVoters + [_player];
    GVAR(voters) set [_markerID, _newVoters];
    [_closestMarker] call FUNC(updateVotesMarker);

    INFO_2("Player %1 voted for %2.", name _player, _closestMarker);
};


//create marker if proposal ====================================================
if (!_isVote) then {
    _playAreaMinSize = [missionConfigFile >> "cfgMission","playAreaMinSize",100] call BIS_fnc_returnConfigEntry;
    _playAreaMaxSize = [missionConfigFile >> "cfgMission","playAreaMaxSize",2000] call BIS_fnc_returnConfigEntry;

    _size = _size max _playAreaMinSize;
    _size = _size min _playAreaMaxSize;

    _areaMarker = createMarker [_markerName, _clickPos];
    _areaMarker setMarkerShape "ELLIPSE";
    _areaMarker setMarkerSize [_size,_size];
    _areaMarker setMarkerBrush "BORDER";
    _areaMarker setMarkerColor "COLORWEST";

    _votesMarker = createMarker [_votesMarkerName, _clickPos];
    _votesMarker setMarkerType "hd_flag";
    _votesMarker setMarkerColor "COLORWEST";

    GVAR(areaMarkers) pushBack _areaMarker;
    GVAR(voteMarkers) pushBack _votesMarker;
    GVAR(markerVotes) pushBack 1;
    GVAR(voters) pushBack [_player];

    _player setVariable [QGVAR(playerVote), _markerName];
    [_areaMarker] call FUNC(updateVotesMarker);
    INFO_3("Player %1 proposed play area around %2 with radius %3.", name _player, _clickPos, _size);
};


//update most voted marker
private _mostUpvotedID = [GVAR(markerVotes)] call EFUNC(common,findMax);
for [{_i=0}, {_i<(count GVAR(areaMarkers))}, {_i=_i+1}] do {
    _marker = GVAR(voteMarkers) select _i;
    if (_i == _mostUpvotedID) then {
        _marker setMarkerColor "COLORGREEN";
    } else {
        _marker setMarkerColor "COLORWEST";
    };
};
