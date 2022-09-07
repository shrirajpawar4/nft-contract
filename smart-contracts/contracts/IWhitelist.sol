//SPDX-License-identifier: UNLICENSED

pragma solidity ^0.8.4;

interface IWhitelist {
    function whiteListAddresses(address) external view returns (bool);
}

