#include "component.hpp"

if !(missionNamespace getVariable [QEGVAR(missionSetup,gameStarted),false]) exitWith {
    systemChat "Command 'fixWeapon' unavailable until game has started.";
};

private _oldWeapon = primaryWeapon player;
if (_oldWeapon == "") then {
    _oldWeapon = handgunWeapon player;
};

// message
[[profileName,_oldWeapon],{
    params ["_name","_oldWeapon"];
    systemChat format ["%1 now using replacement for broken weapon %2.",_name,_oldWeapon];
    playSound "addItemFailed"
}] remoteExec ["call",0,false];

// log
[[profileName,_oldWeapon],{
    params ["_name","_oldWeapon"];
    INFO_2("%1 now using replacement for broken weapon %2.",_name,_oldWeapon);
}] remoteExec ["call",2,false];

//remove old weapon and magazines
{player removeWeapon _x} forEach weapons player;
{player removeMagazine _x} forEach magazines player;

//add weapon and attachments
player addMagazine "30Rnd_9x21_Mag";
player addWeapon "SMG_02_F";
player addMagazines ["30Rnd_9x21_Mag",6];
