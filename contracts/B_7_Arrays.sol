// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;



contract ArregloFijo {

    uint[10] public arreglito;      // Puedes usar el indice para guardar las variables

    function insert(uint _number) public returns (uint) {
        arreglito[1] = _number;
        return arreglito[1];
    }

}

contract ArregloDinamico {
    uint[] public arreglito;

    function insert(uint _number) public {          // Push is available only on storage arrays, that is state variables 
        arreglito.push(_number);                    // and not in memory arrays, that is local variables:
    }

    function remove_1(uint _index) public {
        delete arreglito[_index];                   // Set the index valued to default uint value ie arreglito[_index] == 0 without changing length
    }

    function remove_2(uint _index) public {
        arreglito[_index] = arreglito[arreglito.length - 1];     // This method indeed changes array length
        arreglito.pop();                                         // pop() deletes last value
    }

    function length() public view returns (uint) {
        return arreglito.length;
    }
}




           