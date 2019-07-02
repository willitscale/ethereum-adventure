pragma solidity ^0.5.2;

import "./Character.sol";
import "./Class.sol";
import "./CombatEngine.sol";
import "./Skill.sol";

contract Game {
    
    address private _owner;

    CombatEngine private _combatEngine;

    mapping(address => Character) private _characters;
    mapping(string => Class) private _classes;

    modifier isOwner {
        require(_owner == msg.sender, "Sender is not the contract owner");
        _;
    }

    modifier hasCharacter {
        require(_characters[msg.sender].isSet() == 1, "Character does not exist for address");
        _;
    }

    constructor() public {
        _owner = msg.sender;
        _combatEngine = new CombatEngine();
    }

    function createCharacter(string memory name, string memory class) public {
        _characters[msg.sender] = new Character(name, _classes[class]);
    }

    function getCharacter() public view returns (Character) {
        return _characters[msg.sender];
    }

    function addClass(string memory key, Class class) public isOwner {
        _classes[key] = class;
    }

    function removeClass(string memory key) public isOwner {
        delete _classes[key];
    }

    function attack(Character character, Skill skill) public view returns(uint) {
        return _combatEngine.attack(_characters[msg.sender], character, skill);
    }
}
