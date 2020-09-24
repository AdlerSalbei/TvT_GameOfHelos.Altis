#include "component.hpp"
#include "..\..\dialog\chooseUniform\defines.hpp"

private _display = findDisplay CHOOSEUNIFORM_IDD_DIALOG;
if (isNull _display) exitWith {};

_display closeDisplay 1;
