// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract SendETH {
    constructor() payable {
        
    }

    receive() external payable {}

    function transferETH(address payable _to, uint256 amount) external payable {
        _to.transfer(amount);
    }
}
