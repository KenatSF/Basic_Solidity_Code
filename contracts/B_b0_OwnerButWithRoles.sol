// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

import { AccessControl } from  "@openzeppelin/contracts/access/AccessControl.sol";


contract Rolesillos is AccessControl {

    bytes32 public constant ROL_ADMIN = keccak256("ROL_ADMIN");
    bytes32 public constant ROL_USUARIO = keccak256("ROL_USUARIO");

    constructor() {
        _grantRole(ROL_ADMIN, msg.sender);
    }

    function soloAdmin() public view {
        require(hasRole(ROL_ADMIN, msg.sender), "Esta funcion solo puede ser utilizada por el ADMIN");
    }

    function soloUsuario() public view {
        require(hasRole(ROL_USUARIO, msg.sender), "Esta funcion solo puede ser utilizada por un USUARIO");
    }

    function agregarRol(bytes32 role, address account) public {
        require(hasRole(ROL_ADMIN, msg.sender), "Esta funcion solo puede ser utilizada por el ADMIN");

        _grantRole(role,account);
    }

    function removeRol(bytes32 role, address account) public {
        require(hasRole(ROL_ADMIN, msg.sender), "Esta funcion solo puede ser utilizada por el ADMIN");

        _revokeRole(role, account);
    }

}

//      We have some issues: _grantRole() & _revokeRole() works fine but grantRole() & revokeRole() doesn't work because of the
//      the struct in AccessControl is pointing to an adminRole null 0x00, that's why getRoleAdmin() returns 0x00 and we are calling since address null.
//      Function renounceRole() works fine because only depends on role & msg.sender (owner of the role)
//      NOte: You will have to make you own modifiers to avoid repeat so many times require(hasRole());