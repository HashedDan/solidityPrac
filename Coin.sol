pragma solidity ^0.4.11;

contract Coin {

	// Public means "queryable"
	address owner;
	uint public totalSupply;

	mapping(address => uint) public balances;

	// "Indexed" allows you to search for those arguments directly as opposed to looking through the entire log
	event Transfer(address indexed _to, address indexed _from, uint _value);

	// Keep track in the changing supply of coins
	event NewCoinLog(address _to, uint _amount, uint _newSupply);

	modifier onlyOwner() {
		if (msg.sender != owner) {
			throw;
		}
		else {
			// Underscore just tells compiler to run whatever code comes after
			_;
		}
	}

	// Constructor function
	function Coin(uint _supply) {
		owner = msg.sender;
		totalSupply = _supply;
		balances[owner] += _supply;
	}

	// Constant functions do not require any gas because they don't change state of blockchain
	function getBalance(address _aadr) constant returns (uint) {
		return balances[_aadr];
	}

	function transfer(address _to, uint _amount) returns (bool) {
		if (balances[msg.sender] < _amount) throw;
		balances[msg.sender] -= _amount;
		balances[_to] += _amount;

		// Execute transfer event to add to log
		Transfer(_to, msg.sender, _amount);
		return true;
	}

	// Create more coins and give to owner
	function mint(uint _amount) onlyOwner returns (bool) {
		totalSupply += _amount;
		balances[owner] += _amount;

		// Add minting to the log
		NewCoinLog(owner, _amount, totalSupply);
		return true;
	}


	// Allow contract only to be disabled by owner
	function disable() onlyOwner {
		// Address parameter specifies where any balance in the contract will go on destruction
		selfdestruct(owner);
	}
}