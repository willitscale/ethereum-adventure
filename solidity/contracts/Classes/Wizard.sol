pragma solidity ^0.5.2;

import "./PlayableClass.sol";
import "../Skills/Attack.sol";
import "../Skills/Fireball.sol";

contract Wizard is PlayableClass("Wizard", 2, 100, 20, 2, 16, 2) {
    constructor() public {
        _skills.push(new Attack());
        _skills.push(new Fireball());
    }
}
