pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GameItems is ERC1155, Ownable {
    // 三种游戏物品
    uint256 public constant SWORD = 0;          // 剑
    uint256 public constant SHIELD = 1;         // 盾牌
    uint256 public constant HEALTH_POTION = 2;  // 健康药水

    constructor() ERC1155("https://images.example/{id}.json") Ownable(msg.sender) {
        _mint(msg.sender, SWORD, 10, "");
        _mint(msg.sender, SHIELD, 5, "");
        _mint(msg.sender, HEALTH_POTION, 20, "");
    }

    // 添加访问控制，只有合约所有者才能铸造
    function mint(address account, uint256 id, uint256 amount) public onlyOwner {
        _mint(account, id, amount, "");
    }
}
