pragma solidity ^0.5.2;

import "../Class.sol";
import "../Skills/Attack.sol";
import "../Skills/Backstab.sol";

contract Rogue is Class("Rogue", 3, 150, 15, 10, 5, 5) {
    constructor() public {
        _skills.push(new Attack());
        _skills.push(new Backstab());
    }
}