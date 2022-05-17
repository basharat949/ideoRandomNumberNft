const hre = require('hardhat');
const ethers = hre.ethers;
const upgrades = hre.upgrades;
const chai = require("chai");
const fs = require("fs");
const path = require("path");
const { solidity } = require("ethereum-waffle");
const { expect } = chai;
const { BigNumber, logger } = require("ethers");
const network = hre.hardhatArguments.network;

chai.use(solidity);
async function main () {
    let nft = await hre.ethers.getContractFactory('IdeoNft');
    nft = await nft.deploy();
    await nft.deployed();
    console.log('Nft deployed to ', nft.address)
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
