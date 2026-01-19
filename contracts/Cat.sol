// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Cat is ERC20Burnable,Ownable {
    constructor(string memory name_, string memory symbol_, address initialOwner, uint256 initialAmount) 
        ERC20(name_, symbol_) 
        Ownable(initialOwner) {
        _mint(msg.sender, initialAmount * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}