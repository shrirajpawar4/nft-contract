const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

const { WHITELIST_CONTRACT_ADDRESS, METADATA_URL } = require("../constants")

async function main() {
  const whitelistContract = 0xa6362b21cC72950E7374D0A6997c412a824a0F04;

  const metadataUrl = ;

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