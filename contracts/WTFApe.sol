// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract WTFApe is ERC721 {

    uint256 public MAX_APES = 10000; 
    constructor(string memory name_, string memory symbol_) ERC721(name_, symbol_) {

    }

    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmeSjSinHpPnmXmspMjwiXyN6zS4E9zccariGR3jxcaWtq/";
    }

    function mint(address to, uint256 tokenId) external {
        require(tokenId >= 0 && tokenId < MAX_APES, "tokenId out of bounds");
        _mint(to, tokenId);
    }
}