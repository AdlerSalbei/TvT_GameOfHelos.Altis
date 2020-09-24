#include "component.hpp"

params ["_helo"];

private _type = typeOf _helo;
private _blackList = getArray (missionConfigFile >> "cfgMission" >> "pylonBlacklist");

{
	private _compatWeapons = _helo getCompatiblePylonMagazines _x;
	private _usableWeapons = _compatWeapons - _blackList;

	_helo setPylonLoadout [_x, selectRandom _usableWeapons]; 

}forEach ((configfile >> "CfgVehicles" >> _type >> "Components" >> "TransportPylonsComponent" >> "Pylons") call BIS_fnc_getCfgSubClasses);

[_helo] call helogame_selectHelo_fnc_rearmPylons;