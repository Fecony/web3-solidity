// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;

    mapping(address => uint) addressWave;

    constructor() {
        console.log("Yo, Farza. Don't be sad!");
    }

    function wave() public {
        totalWaves++;
        addressWave[msg.sender]++;
        console.log("%s has waved!", msg.sender);
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getTotalWavesFor(address _address) public view returns (uint256) {
        console.log("%s has waved %d times!", _address, addressWave[_address]);
        return addressWave[_address];
    }
}
