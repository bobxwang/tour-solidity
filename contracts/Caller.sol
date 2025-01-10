// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Caller {
    address public proxy;

    constructor(address proxy_) {
        proxy = proxy_;
    }

    // 通过代理合约调用increment()函数
    function increment() external returns(uint) {
        ( , bytes memory data) = proxy.call(abi.encodeWithSignature("increment()"));
        return abi.decode(data,(uint));
    }
}