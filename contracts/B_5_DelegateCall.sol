// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

// NOTE: Deploy this contract first & My NOTE: This is the contract that would be updated multiple times like B1.0, B1.1, B1.2, ...
// NOTE: There can not be constructors inside Bx.x because state variable will never be used. (OpenZeppelin use case @hardhat/truffle-upgrades)
contract B {
    // NOTE: storage layout must be the same as contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {            // Note: So this A contract is the main contract one & Important: Layout must preserve the order
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _contract, uint _num) public payable {
        // A's storage is set, B is not modified.
        //(bool success, ) = _contract.call(abi.encodeWithSignature("setVars(uint256)", _num));               // Las variables se guardan en B & msg.value = address(A)
        (bool success, ) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));     // Las variables se guardan en A & msg.value = ACCOUNT_x
        require(success, "Tx failed!");
    }
}
