#include "component.hpp"

if (!isServer) exitWith {};

params [["_winner",objNull]];

if (missionNamespace getVariable [QGVAR(gameEnded),false]) exitWith {};
missionNamespace setVariable [QGVAR(gameEnded),true,true];

_this spawn {
    params [["_winner",objNull]];

    sleep 1;

    _centerPos = ([EGVAR(missionSetup,playAreaCenter),[0,50]] call EFUNC(common,randomPos)) findEmptyPosition [0,30,"B_Soldier_F"];
    if ((count _centerPos) == 0) then {_centerPos = EGVAR(missionSetup,playAreaCenter)};

    {_x setDamage 0} forEach allPlayers;
    [nil,_centerPos] remoteExec [QEFUNC(common,teleport),0,false];
    [_centerPos] remoteExec [QFUNC(respawnPlayer),0,false];

    [[],{
        waitUntil {alive player};
        removeAllWeapons player;
        player setDamage 0;
        player allowDamage false;
        sleep 1;
        removeAllWeapons player;
    }] remoteExec ["spawn",0,false];

    sleep 2;

    ["helogame_notification1",["HELOGAME",format ["%1 wins!",_winner getVariable ["ACE_Name",name _winner]]]] remoteExec ["bis_fnc_showNotification",0,false];

    sleep 8;

    if (EGVAR(missionSetup,rankedMode)) then {
        _stats = [] call EFUNC(common,updateLeaderboard);
        _compiledStats = [_stats] call EFUNC(common,compileForGRADScoreboard);
        [_compiledStats] remoteExec [QEFUNC(common,showGRADScoreboard),0,false];

        sleep 20;
    };

    ["end1", true, true, true, true] remoteExec ["BIS_fnc_endMission",0,false];
};
