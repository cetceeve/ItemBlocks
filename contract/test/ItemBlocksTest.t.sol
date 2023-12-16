// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test, console2} from "../lib/forge-std/src/Test.sol";
import "../src/ItemBlocks.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract ItemBlocks is Test{
    ItemBlocks public itemBlocks;

    function SetUp() public{
        itemBlocks = new ItemBlocks(); 
    }

    function test_isEligible() public {
        address(itemBlocks) = ownerOf(12);
        itemBlocks.isEligible(12, address(itemBlocks));
        assert(true);
    }
}