// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract stackETH {
    mapping(address => uint) stackbalance;
    uint public ETH_balance;

    constructor() {}

    function stack() public payable {
        require(msg.value >= 0, "Send min 1 ETH");
        stackbalance[msg.sender] += msg.value;
        ETH_balance += msg.value;
    }

    function unStack(uint _amt) public {
        uint256 userBal = stackbalance[msg.sender];
        require(userBal >= _amt, "bal not found");
        stackbalance[msg.sender] -= _amt;
        ETH_balance -= _amt;
        payable(msg.sender).transfer(_amt);
    }

    function balCheck() public view returns (uint) {
        return ETH_balance;
    }
}

contract parentProxyContract {
    address implementation;
    mapping(address => uint) stackbalance;
    uint public ETH_balance;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    function stack() public {
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Process failed");
    }

    function unstack() public {
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Process failed");
    }

    function setImplementation(address _new) public {
        implementation = _new;
    }
}

contract proxyStackingContract {
    address public implementation;

    constructor(address _imp) {
        implementation = _imp;
    }

    fallback() external {
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Invaild funcation");
    }
}
