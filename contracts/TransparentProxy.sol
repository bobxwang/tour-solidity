// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract TransparentProxy {
    address implementation; // 逻辑合约地址
    address admin;          // 管理员
    string public words;    // 字符串，可以通过逻辑合约的函数改变

    constructor(address implementation_) {
        implementation = implementation_;
        admin = msg.sender;
    }

    fallback() external payable { 
        require(msg.sender != admin);
        (bool success, bytes memory data) = implementation.delegatecall(msg.data);
        if (success) {
            require(data.length != 0);
        }
    }

    receive() external payable { 

    }

    // 升级函数，改变逻辑合约地址，只能由admin调用
    function upgrade(address newImplementation) external {
        if (msg.sender != admin) revert();
        implementation = newImplementation;
    }
}