pragma solidity ^0.5.2;

contract Skill {
    string private _name;
    uint private _class;
    uint private _levelRequired;
    uint private _damage;
    uint private _manaCost;
    uint private _skillType;

    constructor(string memory name, uint class, uint levelRequired, uint damage, uint manaCost, uint skillType) public {
        _name = name;
        _class = class;
        _levelRequired = levelRequired;
        _damage = damage;
        _manaCost = manaCost;
        _skillType = skillType;
    }

    function getName() public view returns(string memory) {
        return _name;
    }

    function getClass() public view returns (uint) {
        return _class;
    }

    function getLevelRequired() public view returns(uint) {
        return _levelRequired;
    }

    function getDamage() public view returns (uint) {
        return _damage;
    }

    function getManaCost() public view returns (uint) {
        return _manaCost;
    }

    function getSkillType() public view returns (uint) {
        return _skillType;
    }
}
