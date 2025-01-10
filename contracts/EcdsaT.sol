// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract EcdsaT {
    function getMessageHash(address account_, uint256 tokenId_) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(account_, tokenId_));
    }

    // EIP191
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }
}
