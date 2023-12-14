// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocks is ERC721, Ownable {
    struct Passport {
        string name;
        string desc;
        string family;
        string url;
        string img;
        address creator;
    }

    mapping (uint256 => Passport) public itemPassports;

    constructor(address initialOwner)
        ERC721("ItemBlocks", "ITM")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function createPassport(uint tokenId, string calldata name, string calldata desc, string calldata family, string calldata url, string calldata img) public returns(uint256) {
        (tokenId,  ) = updatePassport(tokenId, name, desc, family, url, img);
        return tokenId;
    }

    function updatePassport(uint tokenId, string calldata name, string calldata desc, string calldata family, string calldata url, string calldata img) public returns(uint256, Passport memory) {
        itemPassports[tokenId] = Passport ({
            name: name,
            desc: desc,
            family: family,
            url: url,
            img: img,
            creator: msg.sender
        });
        return (tokenId, itemPassports[tokenId]);
    }

    function getPassport(uint256 tokenId) public view returns (Passport memory) {
        return itemPassports[tokenId];
    }
}
