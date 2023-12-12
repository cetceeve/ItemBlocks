// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocks is ERC721, Ownable {
    struct Passport {
        string name;
        string desc;
    }

    mapping (uint256 => Passport) public itemPassports;

    constructor(address initialOwner)
        ERC721("ItemBlocks", "ITM")
        Ownable(initialOwner)
    {}

    function _baseURI() internal pure override returns (string memory) {
        return "kth.se";
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function createPassport(uint tokenId, string calldata name, string calldata desc) public {
        itemPassports[tokenId] = Passport ({
            name: name,
            desc: desc
        });
    }

    function passport(uint256 tokenId) public view returns (Passport memory) {
        Passport memory p = itemPassports[tokenId];
        return p;
    }
}
