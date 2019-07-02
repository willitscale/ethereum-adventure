pragma solidity ^0.5.2;

import "../Class.sol";
import "../Skills/Attack.sol";

contract Troll is Class("Troll", 11, 50, 0, 2, 0, 2) {
    constructor() public {
        _skills.push(new Attack());
    }
}
