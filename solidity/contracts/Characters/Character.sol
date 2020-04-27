pragma solidity ^0.5.2;

import "../Classes/Class.sol";
import "../Libraries/SafeMath.sol";

contract Character {

    using SafeMath for uint;

    address private _game;

    string private _name;
    Class private _class;

    uint private _experience;
    uint private _level;

    uint private _hitPoints;
    uint private _manaPoints;

    uint private _agility;
    uint private _intelligence;
    uint private _strength;

    uint8 private _set;

    modifier isGame {
        require(msg.sender == _game, "Request did not come from the game");
        _;
    }

    constructor(string memory name, Class class) internal {
        _game = msg.sender;
        _name = name;
        _class = class;
        _set = 1;
    }

    function getName() public view returns(string memory) {
        return _name;
    }

    function getClass() public view returns(Class) {
        return _class;
    }

    function getHitPoints() public view returns(uint) {
        return _hitPoints.add(_class.getHitPoints());
    }

    function getManaPoints() public view returns(uint) {
        return _manaPoints.add(_class.getManaPoints());
    }

    function getAgility() public view returns(uint) {
        return _agility.add(_class.getAgility());
    }

    function getIntelligence() public view returns(uint) {
        return _intelligence.add(_class.getIntelligence());
    }

    function getStrength() public view returns(uint) {
        return _strength.add(_class.getStrength());
    }

    function getExperience() public view returns(uint) {
        return _experience;
    }

    function getLevel() public view returns(uint) {
        return _level;
    }

    function isSet() public view returns(uint8) {
        return _set;
    }

    function setLevel(uint level) public isGame {
        _level = level;
    }

    function setExperience(uint experience) public isGame {
        _experience = experience;
    }

    function setHitPoints(uint hitPoints) public isGame {
        _hitPoints = hitPoints;
    }

    function setManaPoints(uint manaPoints) public isGame {
        _manaPoints = manaPoints;
    }

    function setAgility(uint agility) public isGame {
        _agility = agility;
    }

    function setIntelligence(uint intelligence) public isGame {
        _intelligence = intelligence;
    }

    function setStrength(uint strength) public isGame {
        _strength = strength;
    }

    function setClass(Class class) public isGame {
        _class = class;
    }
}
