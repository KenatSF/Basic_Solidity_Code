// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract MyAbi {
  uint256 public counting;

  event FallbackFunction(address _from, bytes32 _message);

  fallback() external {
      emit FallbackFunction(msg.sender, bytes32("There was a mistake!"));
  }

  function sum_x_y(uint256 _x, uint256 _y) public {
      counting = _x + _y;
  }

  function get_abi_encode(address _to,
      uint _amount,
      string memory _message,
      uint8 _nonce
      ) public pure returns (bytes memory) {
      return abi.encode(_to, _amount, _message, _nonce);
      // Retunrs characters in packages of 32 bytes: 
      //    address 32 bytes,
      //    uint 245 bits = 32 bytes,
      //    Position in bytes of string (array) _message variable (starting by array length) 32 bytes
      //    uint8 _nonce but in uint 245 bits = 32 bytes
      //    length of _message variable in 32 bytes
      //    content of _message variable in 32 bytes
      // Note: Basically an array has the format: position, length, array content codified with encode()
  }

  function get_abi_encode_package(
      address _to,
      uint _amount,
      string memory _message,
      uint8 _nonce, 
      bool booleano
  ) public pure returns (bytes memory) {
      return abi.encodePacked(_to, _amount, _message, _nonce, booleano);
      // Returns characters in function of type variable length: 
      //    address 20 bytes, 
      //    uint 256 bits = 32 bytes, 
      //    string memory n° caracteres = n° bytes, 
      //    uint8 8 bits = 1 byte
  }


  function get_sum_abi_0(uint _x, uint _y) public pure returns (bytes memory) {
      return abi.encodeWithSelector(bytes4(keccak256("sum_x_y(uint256, uint256)")), _x, _y);    //Like bytecode is different from below, fallback() is activated!
  }

  function get_sum_abi_1(uint _x, uint _y) public pure returns (bytes memory) { // Returns an array
      return abi.encodeWithSignature("sum_x_y(uint256,uint256)", _x, _y);       // No spaces!
  }


  function sum_xy_abi(bytes calldata _data) public {
      (bool success, ) = address(this).call(_data);
      require(success, "sum_x_y() failed");
  }
  

}
