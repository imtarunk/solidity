// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract BridgeETH is Ownable, IERC20 {
    mapping(address account => uint256) public pendingBalance;
    address tokenAddress;

    constructor(address _tokenAddress) Ownable(msg.sender) {
        tokenAddress = _tokenAddress;
    }

    // when user sent ETH call other contract and mint weth and send to senderAdd
    function lock(IERC20 _tokenAddress, uint256 _amount) public {
        require(address(_tokenAddress) == tokenAddress);
        require(_tokenAddress.allowance(msg.sender, address(this)) >= _amount);
        require(_tokenAddress.transferFrom(msg.sender, address(this), _amount));
        pendingBalance[msg.sender] += _amount;
        emit Deposit(msg.sender, _amount);
    }

    // when user burn/deposit WETH to other contract call this contract withdrow funtion and send back thier asset

    function unlock(IERC20 _tokenAddress, uint256 _amount) public {
        require(pendingBalance[msg.sender] >= _amount);
        pendingBalance[msg.sender] -= _amount;
        _tokenAddress.transfer(msg.sender, _amount);
    }

    function burnedOnOtherSide() public {
        // when user burn WETH on other side call this function and mint ETH and send to sender
    }
}
