// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Context } from '@openzeppelin/contracts/utils/Context.sol';
import { ERC20 } from '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import { IERC20 } from '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import { SafeMath } from '@openzeppelin/contracts/utils/math/SafeMath.sol';
import { ERC165 } from '@openzeppelin/contracts/utils/introspection/ERC165.sol';


abstract contract ERC20Burnable is Context, ERC20 {
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

    function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}


contract ERC20PresetFixedSupply is ERC20Burnable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        address owner
    ) ERC20(name, symbol) {
        _mint(owner, initialSupply);
    }
}


contract IntrospectionToken is ERC20PresetFixedSupply, ERC165 {
    using SafeMath for uint256;
    constructor(address _owner) ERC20PresetFixedSupply("Polkren", "PKRN", 5000000 * 10 ** 18, _owner) {
    }

    // Check docs:  @dev Implementation of the {IERC165} interface.
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165) returns (bool) {
        return interfaceId == type(IERC20).interfaceId || super.supportsInterface(interfaceId);
    }
}