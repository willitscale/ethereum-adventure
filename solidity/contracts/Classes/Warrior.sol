pragma solidity ^0.5.2;

import "./PlayableClass.sol";
import "../Skills/Attack.sol";
import "../Skills/Cleave.sol";

contract Warrior is PlayableClass("Warrior", 1, 200, 10, 2, 2, 16) {
    constructor() public {
        _skills.push(new Attack());
        _skills.push(new Cleave());
    }
}
