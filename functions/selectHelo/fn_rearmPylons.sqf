#include "component.hpp"

params ["_helo"];

[{
    params ["_helo", "_handle"];

    if !(alive _helo) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    _helo setVehicleAmmo 1;
    private _pylonSetup = getPylonMagazines _helo;

    { 
        private _maxAmmo = getNumber (configfile >> "CfgMagazines" >> (_pylonSetup select _forEachIndex) >> "count"); 
        private _ammo =_helo ammoOnPylon _x; 

        if (_ammo < _maxAmmo) then {
            _helo setAmmoOnPylon [_x, _maxAmmo];
        };
    }forEach ((configfile >> "CfgVehicles" >> (typeOf _helo) >> "Components" >> "TransportPylonsComponent" >> "Pylons") call BIS_fnc_getCfgSubClasses);
}, (missionNamespace setVariable [QGVAR(rearmTime),30]), _helo] call CBA_fnc_addPerFrameHandler;
    



