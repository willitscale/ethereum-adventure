pragma solidity ^0.5.2;

import "./Class.sol";

contract PlayableClass is Class {
    constructor(
        string memory name,
        uint class,
        uint hitPoints,
        uint manaPoints,
        uint agility,
        uint intelligence,
        uint strength
    ) internal Class(name, class, hitPoints, manaPoints, agility, intelligence, strength) {}
}