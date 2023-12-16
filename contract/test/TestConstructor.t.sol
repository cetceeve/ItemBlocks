// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/ItemBlocks.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocksTest is Test{
    ItemBlocks public itemBlocks;
    
    function setUp() public{

    }

    function testConstructor() public {
        address owner = address(42);
        vm.prank(owner);
        itemBlocks = new ItemBlocks(owner);
        assertEq(itemBlocks.owner(), address(42));
    }

    function testFailConstructorZeroAddress() public {
        address owner = address(0);
        vm.prank(owner);
        itemBlocks = new ItemBlocks(owner);
    }


}