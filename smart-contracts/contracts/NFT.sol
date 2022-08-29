//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract NFT is ERC721Enumerable, Ownable {
    string _baseTokenURI;

    IWhitelist whitelist;

    constructor(string memory _baseURI, address whitelistContract) ERC721("Shree's collection", "SHR") {
        _baseTokenURI = _baseURI;
        whitelist = IWhitelist(whitelistContract);
    }  
}