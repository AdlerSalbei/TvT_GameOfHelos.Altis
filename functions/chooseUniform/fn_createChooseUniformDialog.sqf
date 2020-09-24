#include "component.hpp"
#include "..\..\dialog\chooseUniform\defines.hpp"

params [["_timeout",9999]];

disableSerialization;

createDialog "helogame_rscChooseUniform";
private _display = findDisplay CHOOSEUNIFORM_IDD_DIALOG;

GVAR(escEH) = _display displayAddEventHandler ["KeyDown",{_this#1 == 1}];

private _ctrlButtonReroll = _display displayCtrl CHOOSEUNIFORM_IDC_REROLL;
_ctrlButtonReroll ctrlSetText "REROLL (0/2)";

private _ctrlButtonConfirm = _display displayCtrl CHOOSEUNIFORM_IDC_CONFIRM;
_ctrlButtonConfirm ctrlEnable false;

[_display] call FUNC(reroll);

private _ctrlCountdown = _display displayCtrl CHOOSEUNIFORM_IDC_COUNTDOWN;
[{
    params ["_args","_handle"];
    _args params ["_timeout","_display","_ctrlCountdown"];

    if (isNull _display) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    private _timeout = _timeout - 1;
    _ctrlCountdown ctrlSetText str _timeout;
    if (_timeout <= 0) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        _display closeDisplay 2;
        ["helogame_notification1",["HELOGAME","Timed out. Uniform chosen randomly."]] call bis_fnc_showNotification;
    };
    _args set [0,_timeout];

    if (_timeout <= 5) then {
        playSound "addTime";
        _ctrlCountdown ctrlSetTextColor [0.8,0,0,1];
    };
},1,[_timeout,_display,_ctrlCountdown]] call CBA_fnc_addPerFrameHandler;
