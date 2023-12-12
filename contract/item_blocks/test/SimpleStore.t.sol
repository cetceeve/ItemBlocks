// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "./ISimpleStore.sol";

// Declare the interface for the ffi cheatcode function
interface ffiInterface{
    function ffi(string[] calldata) external returns (bytes memory);
}

contract SimpleStoreTest is Test {

    ISimpleStore simpleStore;

    function setUp() public {
        // Instantiate the ffi interface
        ffiInterface ffiCheat = ffiInterface(HEVM_ADDRESS);
        
        // The string array input varaible used by ffi
        string[] memory deployCommand = new string[](4);
        // The Vyper keyword to compile a contract
        deployCommand[0] = "vyper";
        deployCommand[1] = "-f";
        deployCommand[2] = "bytecode";
        // The path to the Vyper contract file starting from the project root directory
        deployCommand[3] = "src/SimpleStore.vy";
        
        // A local variable to hold the output bytecode
        bytes memory compiledByteCode = ffiCheat.ffi(deployCommand);
        
        // A local variable to hold the address of the deployed Vyper contract
        address newContractAddress;
        
        // Inline assembly code to deploy a contract using bytecode
        assembly { 
                    newContractAddress := create(0, add(compiledByteCode, 0x20), mload(compiledByteCode)) 
                }
        
        ///@notice check that the deployment was successful
        require(
            newContractAddress != address(0),
            "VyperDeployer could not deploy contract"
        );
 
        ///@notice deploy a new instance of ISimplestore by passing in the address of the deployed Vyper contract
        // simpleStore = ISimpleStore(vyperDeployer.deployContract("SimpleStore"));
        simpleStore = ISimpleStore(newContractAddress);

    }

    function testGet() public {
        uint256 val = simpleStore.get();

        require(val == 1234);
    }

    function testStore(uint256 _val) public {
        simpleStore.store(_val);
        uint256 val = simpleStore.get();

        require(_val == val);
    }
}
