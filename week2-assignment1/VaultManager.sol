// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./VaultBase.sol";

contract VaultManager is VaultBase {
    function deposit() public payable override {
        require(msg.value > 0, "Deposit must be more than 0");

        balances[msg.sender] = balances[msg.sender].add(msg.value);

        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public override {
        require(amount > 0, "Withdraw amount must be more than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] = balances[msg.sender].sub(amount);
        payable(msg.sender).transfer(amount);

        emit Withdrawn(msg.sender, amount);
    }
}