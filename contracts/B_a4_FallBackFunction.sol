// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Fallback {
    event Log(uint gas);

    // Fallback function must be declared as external.
    fallback() external payable { 
        emit Log(gasleft());
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {           // Gas cost: 32511
        // send returns true/false in function of a successfull or not transaction
        // transfer reverts transaction in case of some problem
        // send / transfer (just transfers 2,300 of gas to fallback() function in the contract)
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {                 // Gas cost: 25997
        // call (forwards all of the gas)
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

// receive() A smart contract requires reveive function to be able to receive ETH (empty calldata) & (Must be external) & (Can not return anything)
// fallback() function is activated in case of a non-existent function is called (not even the receive() function ) & (optionally payable) & (Must be external) & (Can not return anything)