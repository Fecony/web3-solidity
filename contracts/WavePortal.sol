// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    Wave[] waves;

    mapping(address => uint) addressWave;

    event NewWave(address indexed from, uint256 timestamp, string message);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    constructor() payable {
        console.log("Yo, Send me a Wave!");
    }

    function wave(string memory _message) public {
        console.log("%s waved w/ message %s", msg.sender, _message);

        totalWaves++;
        addressWave[msg.sender]++;
        waves.push(Wave({
            waver: msg.sender,
            message: _message,
            timestamp: block.timestamp
        }));

        uint256 prizeAmount = 0.0001 ether;

        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );

        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");

        emit NewWave(msg.sender, block.timestamp, _message);
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
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
