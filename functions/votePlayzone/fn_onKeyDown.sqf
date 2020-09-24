#include "component.hpp"

params ["",["_DIK",-1]];

if (missionNamespace getVariable [QGVAR(votingComplete),false]) exitWith {};

if (_DIK == 28 || _DIK == 156) then {
    (findDisplay 46) displayRemoveEventHandler ["KeyDown", GVAR(keydownEH)];
    GVAR(playzoneSkipVote) = true;
    [player,true] remoteExec [QFUNC(skipVote),2,false];
    true
};
