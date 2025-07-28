// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SecurePiggyBank {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // Accept ETH deposits
    function deposit() public payable {}

    // Only owner can withdraw funds
    function withdraw() public {
        require(msg.sender == owner, "Not the owner");
        payable(msg.sender).transfer(address(this).balance);
    }
}

