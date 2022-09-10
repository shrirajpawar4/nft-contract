const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

const { WHITELIST_CONTRACT_ADDRESS, METADATA_URL } = require("../constants");

async function main() {
  const whitelistContract = WHITELIST_CONTRACT_ADDRESS;

  const metadataUrl = METADATA_URL;

  const nftContract = await ethers.getContractFactory("NFT");

  const deployedNftContract = await nftContract.deploy(metadataUrl, whitelistContract);

  console.log("NFT collection contract address: ", deployedNftContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });