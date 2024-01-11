// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721, Ownable {

    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant PRICE = 0.01 ether;
    uint256 public _nextTokenId = 1;

    constructor(address initialOwner)
        ERC721("MyNFT", "MNFT")
        Ownable(initialOwner)
    {}

    function safeMint() external payable {
        require(_nextTokenId <= MAX_SUPPLY, "All tokens have been minted.");
        require(msg.value == PRICE, "Ether value sent is not correct!");

        _safeMint(msg.sender, _nextTokenId);
        _nextTokenId++;
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
