// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract AdvancedCollectible is ERC721URIStorage, VRFConsumerBase {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    bytes32 private _keyhash;
    uint256 private _fee;

    enum Breed {PUG, SHIBA_INU, ST_BERNARD}
    mapping(Counters.Counter => Breed) private _tokenIdToBreed;

    mapping(bytes32 => address) private _requestIdToSender;

    constructor(
        address vrfCoordinator_, 
        address linkToken_, 
        bytes32 keyhash_, 
        uint256 fee_
        ) 
        public 
        ERC721URIStorage("Doggie", "DOG")
        VRFConsumerBase(
            vrfCoordinator_,
            linkToken_
        )
        {
            _keyhash = keyhash_;
            _fee = fee_;
    }

    function createCollectible(string memory tokenURI_) public returns (uint256) {
        bytes32 requestId = requestRandomness(_keyhash, _fee);
    }

    function fulfillRandomness(bytes32 requestId_, uint256 randomNumber_) internal override {
        Breed breed = Breed=(randomNumber_ % 3);
        uint256 newTokenId = _tokenIds.current();
        _tokenIdToBreed[newTokenId] = breed;
        address owner = _requestIdToSender[requestId_];
        //safeMint();
    }
}