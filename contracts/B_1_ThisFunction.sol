// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Giver {
    address public owner;
    address public invited;
    uint256 public counting;

    constructor() {
        owner = msg.sender;
    }

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function sum_x(uint256 _x) public {
      counting += _x;
    }

    function _signed_sum_x(uint _x) public {
        invited = _msgSender();
        sum_x(_x);
    }

    function signed_sum(uint _x) public virtual {
        _signed_sum_x(_x);
    }

}

contract Taker is Giver {

  function signed_sum(uint _x) public override{
      _signed_sum_x(_x);
  }

  function this_signer_sum(uint _x) public {
      this._signed_sum_x(_x);
  }
  
  function signed() public {            // Maybe in your contract your adding extra logic but the original function is stil usefull
      signed_sum(100);
  }

  function signed_super() public {      // Maybe in your contract your adding extra logic but the original function is stil usefull
      super.signed_sum(100);
  }
}