## Question

Identify and fix the vulnerabilities in this simple smart contract to make it secure. 
Add your custom attack function to attack the smart contract and call the withdraw function.

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
contract VulnerablePiggyBank {
    address public owner;
    constructor() { owner = msg.sender }
    function deposit() public payable {}
    function withdraw() public { payable(msg.sender).transfer(address(this).balance); }
    function attack() public { }
}

## Answer

This VulnerablePiggyBank smart contract is very insecure. It allows anyone to withdraw all the funds in the contract because it doesn’t restrict who can call the withdraw() function.

### Vulnerabilities

- No access control on withdraw()
Anyone can drain the contract using:

```sh
withdraw();
```

- No purpose to attack() function
It's a stub. But it can be used in a malicious contract for a reentrancy or ownership attack.

- Missing constructor parentheses
constructor() { owner = msg.sender } → should be constructor() { owner = msg.sender; }

#### vulnerable version
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IVulnerablePiggyBank {
    function withdraw() external;
}

contract PiggyBankAttacker {
    address public vulnerableAddress;

    constructor(address _target) {
        vulnerableAddress = _target;
    }

    // Attack by draining the piggy bank
    function attack() external {
        IVulnerablePiggyBank(vulnerableAddress).withdraw();
    }

    // Helper to receive ETH
    receive() external payable {}
}

```

### Secured Version
Here's a secure version of the contract that:

- Restricts withdraw() to the owner.

```
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
```

