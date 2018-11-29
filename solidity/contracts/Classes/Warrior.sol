pragma solidity ^0.4.0;

import "../Class.sol";

contract Warrior is Class {
    function getName() public view returns(string memory) {
        return "Warrior";
    }
}