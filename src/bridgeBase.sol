// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract BridgeBase is Ownable {
    constructor() Ownable(msg.sender) {
        _transferOwnership(msg.sender);
    }

    function mint() public {
        // code here
    }

    function burn() public {
        // code here
    }

    function depositHappendOtherSide() public onlyOwner {
        // call other contract and mint weth and send to senderAdd
    }
}
