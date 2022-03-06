// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Giver1 {
    address public owner;
    address public invited;
    uint256 public counting;

    constructor() {
        owner = msg.sender;
    }

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function sum_x(uint256 _x) internal {
      counting += _x;
    }

    function signed_sum_x(uint _x) public {
        invited = _msgSender();
        sum_x(_x);
    }

}

contract Taker1 is Giver1 {
  Giver1 public novo;

  function create_contract() public returns(address) {
      novo = new Giver1();
      return address(novo);
  }

  function _signed_sum(uint _x) public {
      signed_sum_x(_x);
  }

  function _this_signed_sum(uint _x) public {
      this.signed_sum_x(_x);
  }

  function novo_get_owner() public view returns (address) {
      return novo.owner();
  }

  function novo_get_invited() public view returns (address) {
      return novo.invited();
  }

  function novo_get_counting() public view returns (uint256) {
      return novo.counting();
  }

  function novo_singed_sum(uint _x) public {
      novo.signed_sum_x(_x);
  }
  
}
