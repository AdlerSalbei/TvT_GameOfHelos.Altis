#include "component.hpp"
#include "..\..\dialog\chooseUniform\defines.hpp"

params ["_uniformID"];

private _display = findDisplay CHOOSEUNIFORM_IDD_DIALOG;
if (isNull _display) exitWith {};

GVAR(uniformSelected) = "";
private _alpha = 0;
{
    _ctrlUniform = _display displayCtrl _x;

    if (_forEachIndex == _uniformID) then {
        GVAR(uniformSelected) = _ctrlUniform getVariable [QGVAR(uniformClass),""];
        _alpha = 1;
        playSound "soundClick";
    } else {
        _alpha = 0.5;
    };
    _ctrlUniform ctrlSetTextColor [1,1,1,_alpha];
} forEach [CHOOSEUNIFORM_IDC_ITEM0,CHOOSEUNIFORM_IDC_ITEM1,CHOOSEUNIFORM_IDC_ITEM2];

private _ctrlButtonConfirm = _display displayCtrl CHOOSEUNIFORM_IDC_CONFIRM;
_ctrlButtonConfirm ctrlEnable (_uniformID >= 0);
