pragma solidity >=0.4.21 <0.6.0;

import "openzeppelin-solidity/contracts/token/ERC20/ERC20Mintable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC20/ERC20Pausable.sol";

contract ELToken is ERC20Detailed, ERC20Burable, ERC20Mintable, ERC20Pausable {

  string public constant name = "ELYSIA";
  string public constant symbol = "EL";
  uint8 public constant decimals = 18;

  // 7,000,000,000
  uint256 public constant initial_supply = 7 * 1000 * 1000 * 1000 * (10 ** uint256(decimals));

  // bytes32 : 32 letters (ascii): each character is a byte.
  //mapping (address => mapping (bytes32 => uint256)) internal buildingtoken;

  constructor() public {
    //_mint(msg.sender, INITIAL_SUPPLY);
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
    emit Transfer(0x0, msg.sender, INITIAL_SUPPLY); // ERC20Basic.sol
  }

  modifier onlyTransferable() {
    require(_paused || owners[msg.sender] != 0);
    _;
  }

  function transferOwner(
    address _from,
    address _to,
    uint256 _value
  )
    onlyOwner
    onlyTransferable
    public
    returns (bool)
  {
    require(_value <= balances[_from]);
    require(_from != address(0));
    require(_to != address(0));

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);

    // When Token tranfer, owner take the permission of Token
    if(allowed[_to][_from] == 0) {
      allowed[_to][_from] = _value;
    } else {
      allowed[_to][_from] += _value;
    }
    emit Transfer(_from, _to, _value);
    return true;
  }
}
