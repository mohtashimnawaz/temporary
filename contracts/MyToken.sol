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
