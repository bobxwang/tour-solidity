// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract ReceiveETH {

    event Log(uint amount, uint gas);
    

    receive() external payable{
        emit Log(msg.value, gasleft());
    }
    

    function getBalance() view public returns(uint) {
        return address(this).balance;
    }
}
