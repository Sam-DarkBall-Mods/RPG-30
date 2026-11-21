/*
    RPG30_fnc_fired
    Launches the IG-30 decoy from the side tube and lets the PG-30 out of the main tube after it.
    Author: DarkBall
*/
params ["_unit", "", "", "", "", "", "_projectile"];
if (isNull _projectile) exitWith {};

private _pos = getPosASL _projectile;
private _dir = vectorDir _projectile;
private _up = vectorUp _projectile;
private _velocity = velocity _projectile;
private _side = vectorNormalized (_dir vectorCrossProduct _up);

// every machine shows its own decoy; a local round has no parent to ignore, so it starts clear of the shooter
private _decoy = createVehicleLocal ["RPG_30K_IG30", ASLToAGL _pos, [], 0, "CAN_COLLIDE"];
_decoy setPosASL (_pos vectorAdd (_dir vectorMultiply 0.8) vectorAdd (_side vectorMultiply 0.09));
_decoy setVectorDirAndUp [_dir, _up];
_decoy setVelocity _velocity;

if (!local _projectile) exitWith {};

private _hold = _pos vectorDiff (_dir vectorMultiply 0.6);
if (terrainIntersectASL [_pos, _hold] || {(lineIntersectsSurfaces [_pos, _hold, _unit, _projectile]) isNotEqualTo []}) then {
    _hold = _pos;
};
_projectile setPosASL _hold;
_projectile setVelocity [0, 0, 0];

[{
    params ["_args", "_handle"];
    _args params ["_projectile", "_hold", "_dir", "_up", "_velocity", "_release"];
    if (isNull _projectile) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};
    _projectile setPosASL _hold;
    _projectile setVectorDirAndUp [_dir, _up];
    if (time < _release) exitWith {_projectile setVelocity [0, 0, 0]};
    // the boost burnt out while held: let it go at the boosted speed
    _projectile setVelocity (_velocity vectorMultiply 1.28);
    [_handle] call CBA_fnc_removePerFrameHandler;
}, 0, [_projectile, _hold, _dir, _up, _velocity, time + 0.25]] call CBA_fnc_addPerFrameHandler;
