//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract NFT is ERC721Enumerable, Ownable {
    string _baseTokenURI;

    IWhitelist whitelist;

    bool public presaleStarted;

    uint256 public presaleEnded;

    uint256 public maxTokenId = 20;

    uint256 public tokenId;

    uint256 public _price = 0.05 ether; 

    bool public _paused;

    modifier onlyWhenNotPaused {
        require(!_paused, "Contract currently paused");
        _;
    }

    constructor(string memory baseURI, address whitelistContract) ERC721("Shree's collection", "SHR") {
        _baseTokenURI = baseURI;
        whitelist = IWhitelist(whitelistContract);
    }  

    function startPresale() public onlyOwner {
        presaleStarted = true;
        presaleEnded = block.timestamp + 5 minutes;
    }

    function presaleMint() public payable onlyWhenNotPaused {
        require(presaleStarted && block.timestamp < presaleEnded, "Presale has ended");
        require(whitelist.whiteListAddresses(msg.sender), "Address not in whitelist");
        require(tokenId < maxTokenId, "Limit Exceeded");
        require(msg.value >= _price, "Ether is too low");

        tokenId += 1;

        _safeMint(msg.sender, tokenId); 

    }

    function mint() public payable onlyWhenNotPaused{
        require(presaleStarted && block.timestamp >= presaleEnded, "Presale still on");
        require(tokenId < maxTokenId, "Limit Exceeded");
        require(msg.value >= _price, "Ether is too low");

        tokenId += 1;
        _safeMint(msg.sender, tokenId);
    }

    function _baseURI() internal view override returns(string memory) {
        return _baseTokenURI;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        //boolean to check if ether is sent or not. amount from contract is given to owner(address who calls contract)
        (bool sent, ) = _owner.call{value: amount}(" ");
        require(sent, "Failed to send ether");
    }

    function setPaused(bool val) public onlyOwner {
        _paused = val;
    }

    receive() external payable {}  

    fallback() external payable {}

}

// 0x4a267209489DE6585A284d07183001B3880dC732