pragma solidity ^0.5.2;

import "./NonPlayableClass.sol";
import "../Skills/Attack.sol";

contract Troll is NonPlayableClass("Troll", 11, 50, 0, 2, 0, 2) {
    constructor() public {
        _skills.push(new Attack());
    }
}
