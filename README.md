# Creating and Minting Tokens

This project uses Hardhat and Solidity. It comes with a sample contract which has functions to see balance and burn and mint tokens, a test for that contract, and a script that deploys that contract.

# Installing

Run the following commands to install the required dependencies to run this project.
* Firstly, download the zip folder for this project
* Open the project on your IDE and open a new terminal
* To install hardhat locally run the following code on the terminal

```shell
npm install -g hardhat
```
this will install hardhat globally

* To get a list of accounts and the local https server run the following code on the terminal

```shell
npx hardhat node
```
this will list the accounts and give the local server

* Using remix IDE open the contract file MyToken.sol present in the contracts folder which has the following code

```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.18;


    contract MyToken {
        string public name;
        string public symbol;
        uint256 public totalSupply;
        mapping(address => uint256) public balanceOf;

        event Transfer(address indexed from, address indexed to, uint256 value);
        event Burn(address indexed from, uint256 value);
        event Mint(address indexed to, uint256 value);

        address public owner;

        modifier onlyOwner() {
            require(msg.sender == owner, "Only the contract owner can call this function.");
            _;
        }

        constructor(string memory _name, string memory _symbol) {
            name = _name;
            symbol = _symbol;
            totalSupply = 0;
            owner = msg.sender;
        }

        function mint(address _to, uint256 _value) public onlyOwner {
            totalSupply += _value;
            balanceOf[_to] += _value;
            emit Mint(_to, _value);
            emit Transfer(address(0), _to, _value);
        }

        function burn(uint256 _value) public {
            require(balanceOf[msg.sender] >= _value, "Insufficient balance.");
            balanceOf[msg.sender] -= _value;
            totalSupply -= _value;
            emit Burn(msg.sender, _value);
            emit Transfer(msg.sender, address(0), _value);
        }

        function transfer(address _to, uint256 _value) public {
            require(balanceOf[msg.sender] >= _value, "Insufficient balance.");
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
        }
    }
```

* Compile the code on remix and deploy it on the hardhat network that you will obtain using `npx hardhat node`
* When the smart contract is deployed you can interact with the various functions and burn and mint tokens

# Functions present in the smart contract

### mint(address _to, uint256 _value)

* This function is used to credit tokens
* It adds the value to the total supply for the address provided

### burn(uint256 _value)

* This function is used to debit tokens
* It debits the value from the total supply from the running address
* It checks if the value to be credited is lesser or equal to the total supply

### transfer(address _to, uint256 _value)    

* This function is used to transfer tokens to the given address from the current address
* It debits the value from the current address and credits it to the given address
