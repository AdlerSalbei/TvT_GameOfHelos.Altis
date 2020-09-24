#include "component.hpp"

if !(missionNamespace getVariable [QEGVAR(missionSetup,gameStarted),false]) exitWith {
    systemChat "Command 'fixMag' unavailable until game has started.";
};

private _isPrimaryWeapon = true;
private _weapon = primaryWeapon player;
if (_weapon == "") then {
    _weapon = handgunWeapon player;
    _isPrimaryWeapon = false;
};

private _oldMags = magazines player;

// remove old mags
{player removeMagazine _x} forEach _oldMags;
player removePrimaryWeaponItem ((primaryWeaponMagazine player) param [0,""]);
player removeHandgunItem ((handgunMagazine player) param [0,""]);

// remove duplicates for logging
_oldMags = _oldMags arrayIntersect _oldMags;

// message
[[profileName,_oldMags],{
    params ["_name","_oldMags"];
    systemChat format ["%1 now using replacement for broken magazines %2.",_name,_oldMags];
    playSound "addItemFailed"
}] remoteExec ["call",0,false];

// log
[[profileName,_oldMags],{
    params ["_name","_oldMags"];
    INFO_2("%1 now using replacement for broken magazines %2.",_name,_oldMags);
}] remoteExec ["call",2,false];

private _newMag = ([configfile >> "CfgWeapons" >> _weapon,"magazines",[]] call BIS_fnc_returnConfigEntry) param [0,""];
if (_newMag == "") exitWith {
    systemChat "No default magazine found. Please use '#helogame fixWeapon' instead.";
    playSound "addItemFailed";
};

player addMagazine _newMag;
player addMagazines [_newMag, 6];
if (_isPrimaryWeapon) then {
    player addPrimaryWeaponItem _newMag;
} else {
    player addHandgunItem _newMag;
};
