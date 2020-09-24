#include "component.hpp"

private _allCfgWeapons = "(getNumber (_x >> 'scope')) == 2" configClasses (configFile >> "cfgWeapons");
private _allAvailableUniforms = [];

{
    if (
        _x isKindOf ["Uniform_Base",configFile >> "cfgWeapons"] &&
        // filter LOP, because they have no preview pictures -,-
        {(_x find "LOP") != 0} &&
        {[_x] call FUNC(hasUniformDLC)}
    ) then {
        _allAvailableUniforms pushBack _x
    };
} forEach (_allCfgWeapons apply {configName _x});

_allAvailableUniforms
