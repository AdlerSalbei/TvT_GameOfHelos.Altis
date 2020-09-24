#include "component.hpp"

if (isNil QGVAR(uniformSelected) || {GVAR(uniformSelected) == ""}) then {
    if (isNil QGVAR(allAvailableUniforms)) then {
        GVAR(allAvailableUniforms) = [] call FUNC(getAllAvailableUniforms);
    };
    GVAR(uniformSelected) = selectRandom GVAR(allAvailableUniforms);
};

player setVariable [QEGVAR(missionSetup,playerUniform),GVAR(uniformSelected),true];
player setVariable [QGVAR(uniformChosen),true,true];

GVAR(uniformSelected) = nil;
GVAR(allAvailableUniforms) = nil;
