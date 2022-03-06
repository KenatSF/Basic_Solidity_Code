// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Callee {
    uint public x;
    uint public value;

    function setX(uint _x) public returns (uint) {
        x = _x;
        return x;
    }

    function setXandReceiveETH(uint _x) public payable returns (uint, uint) {
        x = _x;
        value = msg.value;

        return (x, value);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

}

contract Caller {           // With same uint number
    Callee novo;

    
    function setX_0(Callee _contract, uint _x) public returns (uint) {                      // Gas cost: 48567
        uint x = _contract.setX(_x);
        return x;
    }

    function setX_1(address _contract, uint _x) public {                                    // Gas cost: 48405
        Callee callee = Callee(_contract);
        callee.setX(_x);
    }

    function setX_2(address _contract, uint _x) public {
        (bool success, ) = _contract.call(abi.encodeWithSignature("setX(uint256)", _x));    // Gas cost: 48570
        require(success, "call tx failed!");
    }

    function intialize(address _contract) public {                                          // Gas cost: 44098
        novo = Callee(_contract);
    }

    function setX_3(uint _x) public {                                                        // Gas cost: 49891 
        novo.setX(_x);
    }

    function setX_and_sendETH(address _contract, uint _x) public payable returns (uint) {                                    
        Callee callee = Callee(_contract);
        (uint x, ) = callee.setXandReceiveETH{value: msg.value}(_x);
        return x;
    }
    
}
