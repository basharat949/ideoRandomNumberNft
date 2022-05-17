const hre = require('hardhat');
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
