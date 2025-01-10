// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract OtherContract {
    uint256 private _x = 0; 
    event Log(uint amount, uint gas);
    
    function getBalance() view public returns(uint) {
        return address(this).balance;
    }

    function setX(uint256 x) external payable{
        _x = x;
        if(msg.value > 0){
            emit Log(msg.value, getBalance());
        }
    }

    function getX() external view returns(uint x){
        x = _x;
    }

    fallback() external payable {}

    receive() external payable { }
}
