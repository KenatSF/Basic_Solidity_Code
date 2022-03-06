// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Giver2 {
    address public owner;
    address public invited;
    uint256 public counting;

    constructor() payable {
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

    function get_balance() public view returns (uint) {
        return address(this).balance;
    }

}

contract Taker2 is Giver2 {
  Giver2 public novo;

  function create_contract() public payable returns(address) {
      //novo = (new Giver2).value(1 ether)();    //works upto 0.6.x 
      novo = (new Giver2){value: msg.value}();   //works From: 0.7.0 to: 0.8.x 
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

  function novo_get_balance() public view returns (uint)  {
      return novo.get_balance();
  }
  
}
