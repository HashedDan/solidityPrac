pragma solidity ^0.4.11;

contract Coin {

	// Public means "queryable"
	address owner;
	uint public totalSupply;
	mapping(address => uint) public balances;

	function Coin(uint _supply) {
		owner = msg.sender;
		totalSupply = _supply;
		balances[owner] += _supply;
	}

	// Constant functions do not require any gas because they don't change state of blockchain
	function getBalance(address _aadr) constant returns (uint) {
		return balances[_aadr];
	}
}