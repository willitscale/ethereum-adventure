pragma solidity ^0.5.2;

import "./Characters/Character.sol";
import "./Characters/PlayableCharacter.sol";
import "./Characters/NonPlayableCharacter.sol";

import "./Classes/Class.sol";
import "./Classes/PlayableClass.sol";
import "./Classes/NonPlayableClass.sol";
import "./Classes/Troll.sol";

import "./Skills/Skill.sol";

import "./CombatEngine.sol";
import "./AdventureEngine.sol";

contract Game {
    
    address private _owner;

    string public _gameVersion = "1.0.0";

    CombatEngine private _combatEngine;
    AdventureEngine private _adventureEngine;

    address[] public _playableCharacterIndex;
    mapping(address => PlayableCharacter) public _playableCharacter;

    address[] public _nonPlayableCharacterIndex;
    mapping(address => NonPlayableCharacter) public _nonPlayableCharacter;
    
    string[] public _playableClassesIndex;
    mapping(string => PlayableClass) public _playableClasses;

    string[] public _nonPlayableClassesIndex;
    mapping(string => NonPlayableClass) public _nonPlayableClasses;

    modifier isOwner {
        require(_owner == msg.sender, "Sender is not the contract owner");
        _;
    }

    modifier isCombatEngine {
        require(address(_combatEngine) == msg.sender, "Sender is not the combat engine");
        _;
    }

    modifier isAdventureEngine {
        require(address(_adventureEngine) == msg.sender, "Sender is not the adventure engine");
        _;
    }

    modifier hasCharacter {
        require(_playableCharacter[msg.sender].isSet() == 1, "Character does not exist for address");
        _;
    }

    constructor() public {
        _owner = msg.sender;
        setCombatEngine(new CombatEngine());
        setAdventureEngine(new AdventureEngine());
    }

    function setCombatEngine(CombatEngine combatEngine) public isOwner {
        _combatEngine = combatEngine;
    }

    function setAdventureEngine(AdventureEngine adventureEngine) public isOwner {
        _adventureEngine = adventureEngine;
    }

    // Playable Classes

    function addPlayableClass(string memory key, PlayableClass class) public isOwner {
        _playableClasses[key] = class;
        _playableClassesIndex.push(key);
    }

    function replacePlayableClass(string memory key, PlayableClass class) public isOwner {
        _playableClasses[key] = class;
    }

    function removePlayableClass(string memory key) public isOwner {
        uint8 replaced = 0;
        bytes32 keyIndex = keccak256(abi.encodePacked());

        uint indexLength = _playableClassesIndex.length;

        for(uint i = 0; i < indexLength; i++) {
            bytes32 itemIndex = keccak256(abi.encodePacked(_playableClassesIndex[i]));
            if (1 == replaced) {
                _playableClassesIndex[i-1] = _playableClassesIndex[i];
            } else {
                if (itemIndex == keyIndex) {
                    replaced = 1;
                }
            }
        }
        
        delete _playableClassesIndex[indexLength - 1];
        delete _playableClasses[key];

        _playableClassesIndex.length--;
    }

    // Non Playable Classes

    function addNonPlayableClass(string memory key, NonPlayableClass class) public isOwner {
        _nonPlayableClasses[key] = class;
        _nonPlayableClassesIndex.push(key);
    }

    function replaceNonPlayableClass(string memory key, NonPlayableClass class) public isOwner {
        _nonPlayableClasses[key] = class;
    }

    function removeNonPlayableClass(string memory key) public isOwner {
        uint8 replaced = 0;
        bytes32 keyIndex = keccak256(abi.encodePacked());

        uint indexLength = _nonPlayableClassesIndex.length;

        for(uint i = 0; i < indexLength; i++) {
            bytes32 itemIndex = keccak256(abi.encodePacked(_nonPlayableClassesIndex[i]));
            if (1 == replaced) {
                _nonPlayableClassesIndex[i-1] = _nonPlayableClassesIndex[i];
            } else {
                if (itemIndex == keyIndex) {
                    replaced = 1;
                }
            }
        }
        
        delete _nonPlayableClassesIndex[indexLength - 1];
        delete _nonPlayableClasses[key];

        _nonPlayableClassesIndex.length--;
    }

    // Playable Characters

    function createPlayableCharacter(string memory name, string memory class) public {
        _playableCharacter[msg.sender] = new PlayableCharacter(name, _playableClasses[class]);
        _playableCharacterIndex.push(msg.sender);
    }

    function getPlayableCharacter() public view returns (PlayableCharacter) {
        return _playableCharacter[msg.sender];
    }

    // Non Playable Characters

    function createNonPlayableCharacter(string memory name, string memory class) isAdventureEngine public {
        _nonPlayableCharacter[msg.sender] = new NonPlayableCharacter(name, _playableClasses[class]);
        _nonPlayableCharacterIndex.push(msg.sender);
    }

    function getNonPlayableCharacter() public view returns(NonPlayableCharacter) {
        return _nonPlayableCharacter[msg.sender];
    }

    // Actions

    function attack(Character character, Skill skill) public view hasCharacter returns(uint) {
        return _combatEngine.attack(_playableCharacter[msg.sender], character, skill);
    }

    function attackNpc(Skill skill) public view hasCharacter returns(uint) {
        return attack(_nonPlayableCharacter[msg.sender], skill);
    }
}

