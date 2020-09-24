params ["_group", "_pos"];

private _stage = format["stage%1", (leader _group) getVariable ["helogame_stage", 1]];
private _availableHelos = (missionConfigFile >> "CfgHeloStages" >> _stage) call BIS_fnc_getCfgSubClasses;

private _newHeloType = selectRandom _availableHelos;

private _newHelo = createVehicle [_newHeloType, [0,0,500], [], 0, "NONE"]; 
_newHelo setPos _pos;

[_newHelo] call helogame_selectHelo_fnc_setPylons;

{
	if (_x == leader _group) then {
		_newHelo moveInDriver _x;
	} else {
		_newHelo moveInGunner _x;
	};
}forEach (units _group);
