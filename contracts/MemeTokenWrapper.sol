pragma solidity ^0.5.0;
import "./libs/SafeMath.sol";
import "./interfaces/IERC20.sol";
contract MemeTokenWrapper {
	using SafeMath for uint256;
	IERC20 public meme;

	constructor(IERC20 _memeAddress) public {
		meme = IERC20(_memeAddress);
	}

	uint256 private _totalSupply;
	mapping(address => uint256) private _balances;

	function totalSupply() public view returns (uint256) {
		return _totalSupply;
	}

	function balanceOf(address account) public view returns (uint256) {
		return _balances[account];
	}

	function stake(uint256 amount) public {
		_totalSupply = _totalSupply.add(amount);
		_balances[msg.sender] = _balances[msg.sender].add(amount);
		meme.transferFrom(msg.sender, address(this), amount);
	}

	function withdraw(uint256 amount) public {
		_totalSupply = _totalSupply.sub(amount);
		_balances[msg.sender] = _balances[msg.sender].sub(amount);
		meme.transfer(msg.sender, amount);
	}
}