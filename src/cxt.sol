// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract CXT is ERC20, Ownable {
    constructor(address _owner) ERC20("CXT Token", "CXT") Ownable(msg.sender) {}

    function mintToken(address mintTo, uint256 mintAmount) public isOwner {
        _mint(mintTo, mintAmount); // Use ERC20's _mint function
    }
}
