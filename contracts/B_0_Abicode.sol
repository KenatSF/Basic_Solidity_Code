// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

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
        // Returns characters in packages of 32 bytes = 256 bits: 
        //    address _to: 32 bytes,
        //    uint _amount: 32 bytes,
        //    string memory _message ( Position in bytes of string [array], starting by array length): 32 bytes
        //    uint8 _nonce: 32 bytes
        //    bool booleano: 32 bytes
        //    string memory _message (length of _message): 32 bytes
        //    string memory _message: 32 bytes
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
        //    address _to: 20 bytes, 
        //    uint _amount: 32 bytes, 
        //    string memory _message: n° caracteres = n° bytes, 
        //    uint8 _nonce: 1 byte
        //    bool booleano: 1 byte
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


  // Formato un poco más claro para los casos de WithSelector & WithSignature:
    function checkingData0(address token, address to, uint256 value) public view returns (bytes memory) {
        bytes memory data = abi.encodeWithSelector(IERC20(token).transferFrom.selector, msg.sender, to, value);
        return data;
    }
    function checkingData1(address to, uint256 value) public view returns (bytes memory) {
        bytes memory data = abi.encodeWithSelector(bytes4(keccak256("transferFrom(address,address,uint256)")), msg.sender, to, value);
        return data;
    }
    function checkingData0(address to, uint256 value) public view returns (bytes memory) {
        bytes memory data = abi.encodeWithSignature("transferFrom(address,address,uint256)", msg.sender, to, value);
        return data;
    }
  

}
