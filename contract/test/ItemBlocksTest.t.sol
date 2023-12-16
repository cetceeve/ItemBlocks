// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import "../src/ItemBlocks.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocksExposed is ItemBlocks{
    constructor(address initialOwner) 
        ItemBlocks(initialOwner)
    {}

    function exposed_setCreator(address creatorAddress, uint256 tokenId) public {
        return setCreator(creatorAddress, tokenId);
    } 
}

contract ItemBlocksTest is Test{
    ItemBlocksExposed public itemBlocks;

    function setUp() public{
        address owner = address(42);
        vm.prank(owner);
        itemBlocks = new ItemBlocksExposed(owner);
        vm.prank(owner);
        itemBlocks.safeMint(owner, 12);
        
        vm.prank(owner);
        itemBlocks.safeMint(address(420), 20);
    }

    function testSafeMint() public {
        vm.prank(address(42));
        itemBlocks.safeMint(address(42), 0);
        assertEq(itemBlocks.ownerOf(0), address(42));
    }
    
    function testFailSafeMintZeroAddress() public {
        vm.prank(address(0));
        itemBlocks.safeMint(address(0), 0);
    }

    // TESTS FOR isEligible
    // should pass because 42 minted token 12
    function testIsEligible() public {
        assertTrue(itemBlocks.isEligible(12, address(42)));
    }

    // should fail because token doesn't exist
    function testFailIsEligible() public {
        assertTrue(itemBlocks.isEligible(13, address(42)));
    }
    
    // should fail because token is owned by user 42
    function testFailDoesNotOwnToken() public {
        assertTrue(itemBlocks.isEligible(12, address(420)));
    }

    // TESTS FOR updateOwnership
    function testOwnershipShouldChange() public {

    }

    // TESTS FOR setCreator
    // should place owner into the allItemOwners array
    function testSetCreator() public {
        itemBlocks.exposed_setCreator(address(42), 12);
        assertEq(itemBlocks.allItemOwners(12, 0), address(42));
    }
    
    // should fail because zero address should not be allowed
    function testFailUpdateSetCreatorZeroAddress() public {
        itemBlocks.exposed_setCreator(address(0), 12);
    }

    // should fail because token 13 should not be in the mapping
    function testFailUpdateSetCreatorNoToken() public {
        itemBlocks.exposed_setCreator(address(42), 12);
        assertEq(itemBlocks.allItemOwners(13, 0), address(42));
    }

    // should fail because token is already owned
    function testFailSetCreatorAlreadyOwner() public {
        itemBlocks.exposed_setCreator(address(42), 12);
        itemBlocks.exposed_setCreator(address(44), 12);
    }

    //TESTS for updateOwnership
    // should not allow transfer from zero address
    function testFailUpdateOwnershipFromZeroAddress() public {
        itemBlocks.updateOwnership(address(0), address(42), 32);
    }

    // should not allow transfer to zero address
    function testFailUpdateOwnershipToZeroAddress() public {
        itemBlocks.updateOwnership(address(42), address(0), 12);
    }

    // should not allow transfer if not owner
    function testFailUpdateOwnershipNotOwner() public {
        itemBlocks.updateOwnership(address(420), address(30), 12);
    }

    // should not allow transfer if token doesn't exist
    function testFailUpdateOwnershipNoToken() public {
        itemBlocks.updateOwnership(address(42), address(420), 50);
    }

    // should add new owner to allItemOwners
    function testUpdateOwnership() public {
        itemBlocks.exposed_setCreator(address(42), 12);
        vm.prank(address(42));
        itemBlocks.updateOwnership(address(42), address(420), 12);
        assertEq(itemBlocks.ownerOf(12), address(420));
        assertEq(itemBlocks.allItemOwners(12, 0), address(42));
        assertEq(itemBlocks.allItemOwners(12, 1), address(420));
    }
}