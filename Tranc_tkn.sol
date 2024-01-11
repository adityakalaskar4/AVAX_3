// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Trans_Tkn {

    string public tk_name;
    string public tk_symbol;
    uint256 public totalsupply;
    mapping(address=> uint256) public balance;
    address public owner;
    uint public max_mint_limit;

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    constructor() {
        tk_name = "Aditya";
        tk_symbol = "Adi";
        totalsupply = 1000;
        max_mint_limit = 10000;
        owner = msg.sender;
    }

    function mint_Tkn(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Error");
        require(amount < max_mint_limit, "Higher the maximum supply");
        totalsupply += amount;
        balance[to] += amount;
        max_mint_limit -= amount;
    }

    function burn_Tkn(uint256 amount) public {
        require(balance[msg.sender] >= amount, "Balance is Insufficient");
        totalsupply -= amount;
        balance[msg.sender] -= amount;
        max_mint_limit += amount;
    }

    function transfer_Tkn(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Error");
        require(balance[msg.sender] >= amount, "Balance is Insufficient");
        balance[msg.sender] -= amount;
        balance[to] += amount;
        return true;
    }
}
