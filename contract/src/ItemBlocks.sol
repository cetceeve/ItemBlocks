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
    mapping (uint256 => address[]) public allItemOwners;

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
        updateOwnership(0, msg.sender, tokenId);
        (tokenId,  ) = updatePassport(tokenId, name, desc, family, url, img);
        return tokenId;
    }

    function updatePassport(uint tokenId, string calldata name, string calldata desc, string calldata family, string calldata url, string calldata img) public returns(uint256, Passport memory) {
        
        require( isEligible(tokenId, msg.sender) == true, "Mast be the owner of the item od the creator of it" );

        itemPassports[tokenId] = Passport ({
            name: name,
            desc: desc,
            family: family,
            url: url,
            img: img,
        });
        return (tokenId, itemPassports[tokenId]);
        
    }

    function getPassport(uint256 tokenId) public view returns (Passport memory) {
        return itemPassports[tokenId];
    }

    // isEligible is a funtion that it takes the tokenId and userAddress and checks
    // if the user is eligible user for this item (tokenId)
    function isEligible(uint256 tokenId, address userAddress) returns(bool){
        if (userAddress == ownerOf(tokenID) || userAddress == allItemOwners[tokenId][0]) return true;
        return false;
    }


    // updateOwnership is a function that we use it chane owners of our NFT (item)
    // Also we use it to add all the owners of an NFT in a list of owners.
    function updateOwnership(address currentOwnerAddress, address nextOwnerAddress, uint256 tokenId) public{
        if (allItemOwners[tokenId].length == 0){
            allItemOwners[tokenId].push(nextOwnerAddress);
        }else{ 
            safeTransferFrom(currentOwnerAddress, nextOwnerAddress, tokenId);
            allItemOwners[tokenId].push(nextOwnerAddress);
        }
    }
}
