#include "component.hpp"

params [["_display",displayNull]];

if (isNull _display) exitWith {};

private _skip = missionNamespace getVariable [QGVAR(playzoneSkipVote),false];
private _skipText = ["PRESS ENTER TO SKIP","READY"] select _skip;
private _skipTextColor = [[1,1,1,1],[0,1,0,1]] select _skip;

private _voteTimeLeft = missionNamespace getVariable [QGVAR(votingTimeLeft),99999];

(_display displayCtrl 1402) ctrlSetText format ["TIME REMAINING: %1", ([_voteTimeLeft,"MM:SS"] call BIS_fnc_secondsToString)];
(_display displayCtrl 1403) ctrlSetText _skipText;
(_display displayCtrl 1403) ctrlSetTextColor _skipTextColor;
