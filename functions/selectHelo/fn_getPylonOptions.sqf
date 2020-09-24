#include "component.hpp"

if (isServer) exitWith {};

helogame_pylonMagazinesName = [];  
helogame_pylonMagazines = [];  
  
{  
 private _weapon = _x;  
 	if (isArray (configfile >> "CfgMagazines" >> _weapon >> "hardpoints")) then {  
		private _array = getArray (configfile >> "CfgMagazines" >> _x >> "hardpoints");   

		{
			private _hardpoint = _x;

			if (_hardpoint in helogame_pylonMagazinesName) then {
				private _index = helogame_pylonMagazinesName find _hardpoint;  

				if (_index >= 0) then {
					
					private _subArray = helogame_pylonMagazines select _index;  
					
					_subArray pushback _weapon; 
					helogame_pylonMagazines set [_index, _subArray];  
				};
			} else {  
				helogame_pylonMagazinesName pushback _hardpoint;  
				helogame_pylonMagazines pushback [_weapon]; 

			}; 
		}forEach _array;  
	};  
}forEach ((configfile >> "CfgMagazines") call BIS_fnc_getCfgSubClasses);