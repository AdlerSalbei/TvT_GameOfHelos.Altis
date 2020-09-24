#include "component.hpp"

params ["_helo"];

if (isNull _helo) exitWith {};

private _pilot = driver _helo; 
private _gunner = gunner _helo;

private _stage = format["stage%1", _pilot getVariable ["helogame_stage", 1]];
private _availableHelos = (missionConfigFile >> "CfgHeloStages" >> _stage) call BIS_fnc_getCfgSubClasses;

private _newHeloType = selectRandom _availableHelos;

private _pos = getPos _helo; 
private _dir = vectorDir _helo; 
private _up = vectorUp _helo; 
private _velocity = velocityModelSpace _helo; 

(group _pilot) leaveVehicle _helo;
moveOut _pilot;
moveOut _gunner;

_pilot setPos [0,0,0];
_gunner setPos [0,0,0]; 

deleteVehicle _helo; 
 
private _newHelo = createVehicle [_newHeloType, [0,0,500], [], 0, "FLY"]; 
_newHelo setPos _pos; 
_newHelo setVectorDirAndUp [_dir, _up];
_newHelo setVelocityModelSpace _velocity;

_pilot moveInDriver _newHelo;
_gunner moveInGunner _newHelo;

[_newHelo] call helogame_selectHelo_fnc_setPylons;