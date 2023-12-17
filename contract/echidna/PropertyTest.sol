// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../src/ItemBlocks.sol";

/**
 * @title 
 * @author 
 * @notice 
 * 
 * @dev There are some specific addresses in Echidna:
        0x30000 calls the constructor.
        0x10000, 0x20000, and 0x30000 randomly call other functions.
 */
contract ItemBlocksPropertyTest is ItemBlocks {
    uint256 testTokenId = 0;

    constructor() ItemBlocks(address(0x30000)) {
        testTokenId = createPassport(7, "TestItemName", "TestItemDesc", "TestItemFamily", "TestItemUrl","TestItemImg");
    }

    // owner should never be zero address
    function echidna_owner_not_zero() public view returns (bool) {
        return ownerOf(testTokenId) != address(0);
    }

    // item creator should always be the first entry in allItem Owners
    function echidna_set_creator() public view returns (bool){
        return allItemOwners[7][0] == address(0x30000);
    }

    // it should be possible to create more items
    function echidna_create_more() public view returns (bool) {
        return createdItems[address(0x30000)].length >= 1;
    }

    // if there is a owner in the allItemsOwners array there should be a passport too
    function echidna_need_to_create_history_and_passport() public view returns (bool) {
        if (allItemOwners[7].length > 0) {
            return bytes(itemPassports[7].name).length > 0;
        } else {
            return true;
        }
    }

    // current owner should be the last entry in allItemOwners
    function echidna_owner_is_last_entry_allItemOwners() public view returns (bool) {
        if (allItemOwners[1].length > 0) {
            address[] memory test = allItemOwners[1];
            return test[test.length - 1] == ownerOf(1);
        } else {
            return true;
        }
    }

}