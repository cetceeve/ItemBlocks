# ItemBlocks
Create a digital passport for your physical items.

## Testing!

![100 Percent Coverage](./images/100coverage.png)

## Description

A dApp that allows users to create a digital passport for physical items and make the information associated with these items easily accessible.
To bring an item into the application users can create a QR-Code, that is stuck onto the item. The QR code is an encoding of the key that uniquely identifies this item in the cloud. Other users can scan the QR-Code to easily access the data of this item on the blockchain. This has the potential to break down data silos, e.g. across company databases.
The users of our application can choose which data to associate with the item.
Each item will have an owner, that can change the information about the item, but all changes will be visible in the item passport.
We also have the role of manufacturer, which can change information in case there was a mistake on the first entry or if some critical flaw was discovered. Initially, the contract owners will decide who is a trusted manufacturer, but in the future, this could be managed by a DAO.

## Technnology

We will use Foundry to compile, (fuzz) test, and deploy our smart contracts.
We can utilize Foundry GitHub-actions integration for a CI-CD pipeline.
We will use Vyper as the smart contract language.
An ERC721 (NFT) contact will be used to represent the items.
We are currently planning to run on an Ethereum Layer 2 chain to reduce gas fees.
We plan to create a website as our user interface, where users can easily check the item passport and see all the associated information. Since QR codes play an important role in our application the website design will be optimized for mobile devices.
