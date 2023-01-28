// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;


contract Stack {
    bytes[] stack;

    function push(bytes calldata data) public {
        stack.push(data);
    }

    function pop() public returns (bytes memory data) {
        data = stack[stack.length - 1];
        stack.pop();
    }
}

contract Queue {
    mapping(uint256 => bytes) queue;
    uint256 first = 1;
    uint256 last = 0;

    function enqueue(bytes calldata data) public {
        last += 1;
        queue[last] = data;
    }

    function dequeue() public returns (bytes memory data) {
        require(last >= first);  // non-empty queue

        data = queue[first];

        delete queue[first];
        first += 1;
    }
}

