// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract EcdsaT {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;

    function getMessageHash(address account_, uint256 tokenId_) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(account_, tokenId_));
    }

    // EIP191
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

    // 手动计算函数选择器
    function getTransferSelector() public pure returns (bytes4) {
        return bytes4(keccak256("transfer(address,uint256)"));
        // 返回: 0xa9059cbb
    }

    function getSetSelector() public pure returns (bytes4) {
        return bytes4(keccak256("set(uint256)"));
        // 返回: 0x60fe47b1
    }

    function verify(
        address signer,
        string memory message,
        bytes memory signature
    ) public pure returns (bool) {
        // 1. 对消息进行哈希
        bytes32 messageHash = keccak256(abi.encodePacked(message));

        // 2. 添加以太坊签名前缀
        bytes32 ethSignedMessageHash = messageHash.toEthSignedMessageHash();

        // 3. 恢复签名者地址并验证
        address recoveredSigner = ethSignedMessageHash.recover(signature);

        return recoveredSigner == signer;
    }
}
