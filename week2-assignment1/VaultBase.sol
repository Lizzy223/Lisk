// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SafeMathLib.sol";

abstract contract VaultBase {
    using SafeMathLib for uint256;

    mapping(address => uint256) internal balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }

    // Abstract functions to implement in child contract
    function deposit() public payable virtual;
    function withdraw(uint256 amount) public virtual;
}