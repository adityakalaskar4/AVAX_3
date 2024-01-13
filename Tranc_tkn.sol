// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Trans_Tkn is ERC20, Ownable {

    uint public max_mint_limit;

   constructor() ERC20("Aditya", "Adi") Ownable(msg.sender) {
    _mint(msg.sender, 1000 * 10 ** decimals());
    max_mint_limit = 10000 * 10 ** decimals();
}

    function mint_Tkn(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Error");
        require(amount <= max_mint_limit, "Higher the maximum supply");
        _mint(to, amount);
        max_mint_limit -= amount;
    }

    function burn_Tkn(uint256 amount) external {
        _burn(msg.sender, amount);
        max_mint_limit += amount;
    }

    function transfer_Tkn(address to, uint256 amount) public  returns (bool) {
        require(to != address(0), "Address is Insufficient");
        _transfer(msg.sender, to, amount);
        return true;
    }
}
