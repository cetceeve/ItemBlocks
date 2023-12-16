
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/ItemBlocks.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocksTest is Test{
    ItemBlocks public itemBlocks;
    
    function setUp() public{
        address owner = address(42);
        vm.prank(owner);
        itemBlocks = new ItemBlocks(owner);
    }

    function testCreatePassport() public {
        ItemBlocks.Passport memory testPassport = ItemBlocks.Passport({
            name: "TestItemName",
            desc: "TestItemDesc",
            family: "TestItemFamily",
            url: "TestItemUrl",
            img: "TestItemImg"
        });

        vm.prank(address(42));
        uint256 tokenId = itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
        
        assertEq(itemBlocks.ownerOf(tokenId), address(42));
        (string memory name , string memory desc, string memory family, string memory url , string memory img) = itemBlocks.itemPassports(tokenId);
        assertEq(name, testPassport.name);
        assertEq(desc, testPassport.desc);
        assertEq(family, testPassport.family);
        assertEq(url, testPassport.url);
        assertEq(img, testPassport.img);
    }

    // zero address should not be able to create passport/item
    function testFailCreatePassportZeroAddress() public {
        ItemBlocks.Passport memory testPassport = ItemBlocks.Passport({
            name: "TestItemName",
            desc: "TestItemDesc",
            family: "TestItemFamily",
            url: "TestItemUrl",
            img: "TestItemImg"
        });

        vm.prank(address(0));
        itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
    }

    function testUpdatePassport() public {
        ItemBlocks.Passport memory testPassport = ItemBlocks.Passport({
            name: "TestItemName",
            desc: "TestItemDesc",
            family: "TestItemFamily",
            url: "TestItemUrl",
            img: "TestItemImg"
        });

        vm.prank(address(42));
        uint256 tokenId = itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
       
        ItemBlocks.Passport memory updatedPassport = ItemBlocks.Passport({
            name: "UpdatedItemName",
            desc: "UpdatedItemDesc",
            family: "UpdatedItemFamily",
            url: "UpdatedItemUrl",
            img: "UpdatedItemImg"
        });

        vm.prank(address(42));
        uint256 updatedTokenId = itemBlocks.updatePassport(7, updatedPassport.name, updatedPassport.desc, updatedPassport.family, updatedPassport.url, updatedPassport.img);

        assertEq(tokenId, updatedTokenId);
        (string memory name , string memory desc, string memory family, string memory url , string memory img) = itemBlocks.itemPassports(updatedTokenId);
        assertEq(name, updatedPassport.name);
        assertEq(desc, updatedPassport.desc);
        assertEq(family, updatedPassport.family);
        assertEq(url, updatedPassport.url);
        assertEq(img, updatedPassport.img);
    }
    
    function testFailUpdatePassportNotEligibility() public {
        ItemBlocks.Passport memory testPassport = ItemBlocks.Passport({
            name: "TestItemName",
            desc: "TestItemDesc",
            family: "TestItemFamily",
            url: "TestItemUrl",
            img: "TestItemImg"
        });

        vm.prank(address(42));
        uint256 tokenId = itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
       
        ItemBlocks.Passport memory updatedPassport = ItemBlocks.Passport({
            name: "UpdatedItemName",
            desc: "UpdatedItemDesc",
            family: "UpdatedItemFamily",
            url: "UpdatedItemUrl",
            img: "UpdatedItemImg"
        });

        //Not eligible user for passport updates.
        vm.prank(address(40));
        itemBlocks.updatePassport(tokenId, updatedPassport.name, updatedPassport.desc, updatedPassport.family, updatedPassport.url, updatedPassport.img);
    }

    function testUpdatePassportNotEligibility() public {
        ItemBlocks.Passport memory testPassport = ItemBlocks.Passport({
            name: "TestItemName",
            desc: "TestItemDesc",
            family: "TestItemFamily",
            url: "TestItemUrl",
            img: "TestItemImg"
        });

        vm.prank(address(42));
        uint256 tokenId = itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
       
        ItemBlocks.Passport memory updatedPassport = ItemBlocks.Passport({
            name: "UpdatedItemName",
            desc: "UpdatedItemDesc",
            family: "UpdatedItemFamily",
            url: "UpdatedItemUrl",
            img: "UpdatedItemImg"
        });

        //Not eligible user for passport updates.
        vm.prank(address(40));
        vm.expectRevert();
        itemBlocks.updatePassport(tokenId, updatedPassport.name, updatedPassport.desc, updatedPassport.family, updatedPassport.url, updatedPassport.img);
    }

    function testUpdatePassportEligibileCreator() public {
        ItemBlocks.Passport memory testPassport = ItemBlocks.Passport({
            name: "TestItemName",
            desc: "TestItemDesc",
            family: "TestItemFamily",
            url: "TestItemUrl",
            img: "TestItemImg"
        });

        vm.prank(address(42));
        uint256 tokenId = itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
       
        vm.prank(address(42));
        itemBlocks.updateOwnership(address(42), address(43), 7);

        ItemBlocks.Passport memory updatedPassport = ItemBlocks.Passport({
            name: "UpdatedItemName",
            desc: "UpdatedItemDesc",
            family: "UpdatedItemFamily",
            url: "UpdatedItemUrl",
            img: "UpdatedItemImg"
        });

        //Eligible as the creator
        vm.prank(address(42));
        itemBlocks.updatePassport(tokenId, updatedPassport.name, updatedPassport.desc, updatedPassport.family, updatedPassport.url, updatedPassport.img);
    }

}