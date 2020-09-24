#include "component.hpp"

params ["_player","_add"];

if (isNil QGVAR(skipVotePlayers)) then {GVAR(skipVotePlayers) = []};

if (_add) then {
    GVAR(skipVotePlayers) pushBackUnique _player;
} else {
    GVAR(skipVotePlayers) = GVAR(skipVotePlayers) - [_player];
};

if (count GVAR(skipVotePlayers) == count playableUnits) then {
    GVAR(votingTimeLeft) = 1;
    GVAR(skipVotePlayers) = nil;
};
