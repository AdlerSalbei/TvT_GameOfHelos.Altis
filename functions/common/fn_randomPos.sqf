#include "component.hpp"

params [["_searchCenter",[0,0,0]],["_radii",[0,1000]]];

private _returnPos = _searchCenter findEmptyPosition [_radii, 0, "I_Heli_Transport_02_F"];

_returnPos
