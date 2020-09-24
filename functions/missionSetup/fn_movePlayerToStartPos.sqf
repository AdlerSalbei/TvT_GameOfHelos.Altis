#include "component.hpp"

private _spawnGroupsMinDist = [missionConfigFile >> "cfgMission", "spawnGroupMinDist",50] call BIS_fnc_returnConfigEntry;
private _startPositions = [];

{
    private _player = _x;
	private _group = group _player;
	if (_player == (leader _group)) then {
		private  _repetitions = 0;
		private  _tooCloseFound = true;
		private  _startPos = GVAR(playAreaCenter);

		while {_tooCloseFound} do {

			//find position that is not over water
			_isWater = true;
			for [{_i=0}, {_i<100}, {_i = _i + 1}] do {
				_startPos = [GVAR(playAreaCenter), GVAR(playAreaSize)] call EFUNC(common,randomPos);
				_isWater = surfaceIsWater _startPos;
				if (!_isWater) exitWith {};
			};

			if (_isWater) then {INFO_2("Server found only water positions in 100 cycles around %1 with a searchradius of %2.",GVAR(playAreaCenter),GVAR(playAreaSize) - 25)};

			//make sure position is at least SPAWNGROUPMINDIST away from other positions
			_tooCloseFound = false;
			{
				if ((_x distance2D _startPos) < _spawnGroupsMinDist) exitWith {_tooCloseFound = true; INFO_1("Start position for %1 to close to other position. Repeating.", name _player)};
			} forEach _startPositions;

			//unless this has been repeated too often -> use position anyway
			if (_repetitions >= 20) then {
				_tooCloseFound = false;
			};

			_repetitions = _repetitions + 1;
		};

		_startPositions pushBack _startPos;
		[_group, _startPos] call helogame_selectHelo_fnc_setupHelo;
	};
} forEach (allPlayers select {_x getVariable [QGVAR(isPlaying),false]});
