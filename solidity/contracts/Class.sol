pragma solidity ^0.4.0;

contract Class {
    string private _name;
    
    uint private _hitPoints;
    uint private _manaPoints;

    uint private _agility;
    uint private _intelligence;
    uint private _strength;

    constructor(
        string memory name,
        uint hitPoints,
        uint manaPoints,
        uint agility,
        uint intelligence,
        uint strength
    ) public {
        _name = name;
        _hitPoints = hitPoints;
        _manaPoints = manaPoints;
        _agility = agility;
        _intelligence = intelligence;
        _strength = strength;
    }

    function getName() public view returns(string memory) {
        return _name;
    }

    function getHitPoints() public view returns(uint) {
        return _hitPoints;
    }

    function getManaPoints() public view returns(uint) {
        return _manaPoints;
    }

    function getAgility() public view returns(uint) {
        return _agility;
    }

    function getIntelligence() public view returns(uint) {
        return _intelligence;
    }

    function getStrength() public view returns(uint) {
        return _strength;
    }
}