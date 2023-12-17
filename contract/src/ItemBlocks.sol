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
    }

    mapping (uint256 => Passport) public itemPassports;
    mapping (uint256 => address[]) public allItemOwners;
    mapping (address => uint256[]) public createdItems;

    enum Role {Owner, Creator}

    event PassportUpdate(uint256 indexed tokenId, address indexed editor, Role role, string name, string desc, string family, string url, string img);
    // from ERC721: Transfer(from, to, tokenId)
    // we can track who created a passport
    // we can track ownership changes

    constructor(address initialOwner)
        ERC721("ItemBlocksTest9", "IB9")
        Ownable(initialOwner)
    {}

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }

    function createPassport(uint tokenId, string memory name, string memory desc, string memory family, string memory url, string memory img) public returns(uint256) {
        _safeMint(msg.sender, tokenId);
        setCreator(msg.sender, tokenId);
        return updatePassport(tokenId, name, desc, family, url, img);
    }

    function updatePassport(uint tokenId, string memory name, string memory desc, string memory family, string memory url, string memory img) public returns(uint256) {        
        require( isEligible(tokenId, msg.sender), "Must be the owner of the item or the creator of it" );

        itemPassports[tokenId] = Passport ({
            name: name,
            desc: desc,
            family: family,
            url: url,
            img: img
        });

        emit PassportUpdate(
            tokenId,
            msg.sender,
            msg.sender == ownerOf(tokenId) ? Role.Owner: Role.Creator,
            name,
            desc,
            family,
            url,
            img);

        return (tokenId);
        
    }

    /**
    * @notice isEligible is a function that checks if the user is eligible for item informaton
    * changes. 
    *
    * @param tokenId uint256 id of the item that the user wants to make the changes.
    * @param userAddress ethereum address of the user that wants to make the changes
    * on items information.
    *
    * @return true if the userAddress and the owner address of the item are same.
    * Meaning the user is the owner of the item.
    * @return true if the userAddress is the first owner of the item.
    * Meaning the user is the creator of the item.
    * @return false if the the user with the userAddress is neither the owner or
    * the creator of the item.
     */
    function isEligible(uint256 tokenId, address userAddress) public view returns(bool){
        return (userAddress == ownerOf(tokenId) || userAddress == allItemOwners[tokenId][0]);
    }

    /**
    * @notice setCreator is a function that adds creator to a new item.
    * 
    * @param creatorAddress ethereum address of the creator of the new item.
    * @param tokenId uint256 id of the token that is created.
    * 
    * @dev fails if there is allread a creator for the specific tokenId.
    * @dev fails if the user has a zero address.
     */
    function setCreator(address creatorAddress, uint256 tokenId) internal {
        require(allItemOwners[tokenId].length == 0, "There is already a creator for this item.");
        require(creatorAddress != address(0), "You are not allowed to have a zero address.");
        allItemOwners[tokenId].push(creatorAddress);
        createdItems[creatorAddress].push(tokenId);
    } 
    
    /**
     * @notice updateOwnership is a function that we use it change owners of our NFT (item).
     * Also we use it to add the new owner of an NFT in a list of all owners for a specific NFT.
     * 
     * @param currentOwnerAddress ethereum address of current tokenId owner
     * @param nextOwnerAddress ethereum address we want to transfer ownership to
     * @param tokenId uint256 id of token we want to update ownership for
     */
    function updateOwnership(address currentOwnerAddress, address nextOwnerAddress, uint256 tokenId) public{
        // safe transfer ensures transfer is only possible if sender owns the item
        safeTransferFrom(currentOwnerAddress, nextOwnerAddress, tokenId);
        allItemOwners[tokenId].push(nextOwnerAddress);
    }
    
    /**
     * @notice getUserHistory is a function the returns a list of addresses that have owner this item.
     * The first address is the item creator and the last is the current owner of the item.
     * 
     * @param tokenId uint256 id of a nft token
     * @return address[] list of all owners of token with tokenId
     * 
     * @dev fails if tokenId does not exists.
     */
    function getUserHistory(uint256 tokenId) public view  returns(address[] memory){
        require( _ownerOf(tokenId) != address(0), string(abi.encodePacked("The token is not valid. There is no such token as" , tokenId)) );
        return allItemOwners[tokenId];
    }
    /**
    * @notice getCreatedItemTokens returns a list of user items.  
    * 
    * @param userAddress ethereum user Address for whome all the items will be retun.
    *                    Like user's intentory.
    *
    * @return createdItems[] list of all user items.
    *
    * @dev fails if the userAdderss is a zero address.
     */
    function getCreatedItemTokens(address userAddress) public view returns(uint256[] memory) {
        require(userAddress != address(0), "You are not allowed to see the created tokens with an zero address.");
        return createdItems[userAddress];
    }    
    

    /**
    * @notice getPassort is a function that returns a Passport for an item (tokenId).
    *
    * @param tokenId uint256 id item's Id that we want to retun the Passport.
    *
    * @return itemPassport[tokenId] the Passport of the item (token).
    *
    * @dev fails if the tokenId does not exists.
     */
    function getPassport(uint256 tokenId) public view returns (Passport memory) {
        require( _ownerOf(tokenId) != address(0), string(abi.encodePacked("The token is not valid. There is no such token as" , tokenId)));
        return itemPassports[tokenId];
    }


}