pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Detailed.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract ELToken is ERC20Detailed, ERC20Burnable, ERC20Mintable, ERC20Pausable, Ownable {

  // bytes32 : 32 letters (ascii): each character is a byte.
  //mapping (address => mapping (bytes32 => uint256)) internal buildingtoken;

  constructor(string memory name, string memory symbol, uint8 decimals, uint256 totalSupply) ERC20Detailed(name, symbol, decimals) public {
    _mint(owner(), totalSupply * 10 ** uint(decimals));
    emit Transfer(address(0), msg.sender, totalSupply * 10 ** uint(decimals)); // ERC20Basic.sol
  }
}
