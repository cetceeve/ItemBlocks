// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/ItemBlocks.sol";
import "openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocksTest is Test {
    ItemBlocks public itemBlocks;

    ItemBlocks.Passport testPassport = ItemBlocks.Passport({
        name: "TestItemName",
        desc: "TestItemDesc",
        family: "TestItemFamily",
        url: "TestItemUrl",
        img: "TestItemImg"
    });

    function setUp() public{
        address owner = address(42);
        vm.prank(owner);
        itemBlocks = new ItemBlocks(owner);

        vm.prank(address(42));
        itemBlocks.createPassport(7, testPassport.name, testPassport.desc, testPassport.family, testPassport.url, testPassport.img);
    }

    // should return item ids created by 
    function testGetCreatedItemTokens() public {
        assertEq(itemBlocks.getCreatedItemTokens(address(42))[0], 7);
    }

    // should return nothing if nothing was created
    function testGetCreatedItemTokensNothingCreated() public {
        assertEq(itemBlocks.getCreatedItemTokens(address(7)).length, 0);
    }

    // should fail for null address
    function testFailGetCreatedItemTokensZeroAddress() public view{
        itemBlocks.getCreatedItemTokens(address(0));
    }
  
    // should fail for null address
    function testGetCreatedItemTokensZeroAddress() public {
        vm.expectRevert();
        itemBlocks.getCreatedItemTokens(address(0));
    }
    // should return list of users who owned this token
    function testGetUserHistory() public {
        assertEq(itemBlocks.getUserHistory(7)[0], address(42));
    }

    // should fail if token doesn't exits
    function testFailUserHistoryNotToken() public view {
        itemBlocks.getUserHistory(1234);
    }

    // should fail if token doesn't exits
    function testUserHistoryZeroAddress() public {
        vm.expectRevert();
        itemBlocks.getUserHistory(1234);
    }
    // should return passport
    function testGetPassport() public {
        ItemBlocks.Passport memory p = itemBlocks.getPassport(7);
        assertEq(p.name, testPassport.name);
        assertEq(p.desc, testPassport.desc);
        assertEq(p.family, testPassport.family);
        assertEq(p.url, testPassport.url);
        assertEq(p.img, testPassport.img);
    }

    // should fail if token doesn't exits
    function testFailGetPassportNotToken() public view {
        itemBlocks.getPassport(1234);
    }

    // should fail if token doesn't exits
    function testGetPassportNotToken() public {
        vm.expectRevert();
        itemBlocks.getPassport(1234);
    }
}
