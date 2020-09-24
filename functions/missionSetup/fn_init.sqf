#include "component.hpp"

[{!isNull player || isDedicated},{

    ["ace_unconscious", EFUNC(events,onUnconscious)] call CBA_fnc_addEventHandler;

    // PLAYER ==================================================================
    if (hasInterface) then {
        [] call FUNC(moveToMapStartPos);

        if (didJIP && missionNamespace getVariable [QGVAR(setupDone), false]) exitWith {
            player setVariable [QGVAR(isSpectator), true, true];
            player setDamage 1;
            ["Terminate"] call BIS_fnc_EGSpectator;
            ["Initialize", [player, [WEST,EAST,INDEPENDENT], true]] call BIS_fnc_EGSpectator;
        };

        player addEventHandler ["Killed", EFUNC(events,onPlayerKilled)];
        player addEventHandler ["Respawn", EFUNC(events,onPlayerRespawn)];

        [{[] call FUNC(scoreBoard)},1,[]] call CBA_fnc_addPerFrameHandler;

        [{!isNull (findDisplay 46)},{
            [] call EFUNC(votePlayzone,initPlayer);
        },[]] call CBA_fnc_waitUntilAndExecute;
    };

    // SERVER ==================================================================
    if (isServer) then {
        missionNamespace setVariable [QGVAR(respawnTime), "RespawnTime" call BIS_fnc_getParamValue, true];
        missionNamespace setVariable [QGVAR(rearmTime), "RearmTime" call BIS_fnc_getParamValue, true];

        private _timeOfDay = [] call FUNC(setTime);
        [_timeOfDay] call FUNC(setWeather);

        [{missionNamespace getVariable ["CBA_missionTime",0] > 0},{
            [] call EFUNC(votePlayzone,initServer);
        },[]] call CBA_fnc_waitUntilAndExecute;

        private _fnc_setup = {

            [] call FUNC(initPlayersServer);
            [] call FUNC(playAreaSetup);

            missionNamespace setVariable [QGVAR(setupDone),true,true];

            [{
                /* ["helogame_notification1",["HELOGAME","Select uniforms!"]] remoteExec ["bis_fnc_showNotification",0,false]; */
                    ["helogame_notification1",["HELOGAME","Game starting in 10s."]] remoteExec ["bis_fnc_showNotification",0,false];
                    [{
                        ["helogame_notification1",["HELOGAME","Use '#helogame help' for a list of chatcommands."]] remoteExec ["bis_fnc_showNotification",0,false];
                    },[],3] call CBA_fnc_waitAndExecute;

                    // wait 10s
                    [{
                        [] call FUNC(movePlayerToStartPos);
                        [] remoteExec [QFUNC(initPlayerInPlayzone),0,false];
                        [] remoteExec [QFUNC(initCampingProtection),0,false];
                        [] remoteExec [QFUNC(scoreBoard),0,false];

                        missionNamespace setVariable [QGVAR(gameStarted),true,true];

                    },[],10] call CBA_fnc_waitAndExecute;
            },[],5] call CBA_fnc_waitAndExecute;
        };

        // wait until voting complete
        [{
            missionNamespace getVariable [QEGVAR(votePlayzone,votingComplete),false]
        },_fnc_setup,[],([missionConfigFile >> "cfgMission","votingTime",60] call BIS_fnc_returnConfigEntry) + 20,_fnc_setup] call CBA_fnc_waitUntilAndExecute;
    };
},[]] call CBA_fnc_waitUntilAndExecute;
