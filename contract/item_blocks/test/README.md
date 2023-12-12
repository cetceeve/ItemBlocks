# Testing vyper contracts

While we are testing the vyper contract we need to write our tests in solidity unfortunatly.
In order to do this we need two files.

## Interface file: 

We use this to tell solidity which kinds of functions and data is available in our contract.
Interface files are prefixed with I: `ICounter.sol`

## Test file:

A solidity contract that is actually used to test the vyper contract.
Test contracts live in the `test` directory and have a file ending of `.t.sol`.
Example file name: `Counter.t.sol`.

The test contract need to inherit from `DSTest` in order to run with `foundry`.
The test files need to import the `VyperDeployer` which is used to buld and deploy the contract.
We need to import the interface files defined before in order to be able to call funtions and access data from in vyper contract.