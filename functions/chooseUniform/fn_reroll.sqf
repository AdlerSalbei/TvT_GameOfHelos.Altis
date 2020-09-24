#include "component.hpp"
#include "..\..\dialog\chooseUniform\defines.hpp"

params ["_display"];

if (isNil "_display") then {
    _display = findDisplay CHOOSEUNIFORM_IDD_DIALOG;
};

if (isNull _display) exitWith {};

if (isNil QGVAR(allAvailableUniforms)) then {
    GVAR(allAvailableUniforms) = [] call FUNC(getAllAvailableUniforms);
};

for "_i" from 0 to 2 do {
    private _ctrlUniform = _display displayCtrl (CHOOSEUNIFORM_IDC_ITEM0 + _i);
    private _randomUniform = selectRandom GVAR(allAvailableUniforms);
    _ctrlUniform ctrlSetText ([_randomUniform] call EFUNC(common,getPicturePath));
    _ctrlUniform setVariable [QGVAR(uniformClass),_randomUniform];
};
