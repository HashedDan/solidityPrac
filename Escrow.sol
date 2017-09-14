pragma solidity ^0.4.11;

contract Escrow {

	// Buyer deploys a contract in this model becasuse you don't want sellers having to keep paying gas to deploy contracts that may not get used 
	address public buyer;
	address public seller;
	address public arbiter;

	function Escrow(address _seller, address _arbiter) {
		buyer = msg.sender;
		seller = _seller;
		arbiter = _arbiter;
	}

	function paySeller() {
		if (msg.sender == buyer || msg.sender == arbiter) {
			seller.transfer(this.balance);
		}
	}

	function refundBuyer() {
		if (msg.sender == seller || msg.sender == arbiter) {
			buyer.transfer(this.balance);
		}
	}

	// Payable means that it can receive and store ether
	function fund() payable returns (bool) {
		return true;
	}

	// Constant means that it will not cost any gas to query this
	// This is because there is no state change taking place
	function getBalance() constant returns (uint) {
		return this.balance;
	}

	// TODO: self destruct function after execution
}