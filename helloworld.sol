pragma solidity ^0.4.11;

contract helloWorld {

	// public means that "message" is accessible outside of helloWorld contract
	string public message;

	function helloWorld() {
		message = "hello world!";
	}

	// constant means that function will not be changing any state in the blockchain
	function sayHi() constant returns (string) {
		return message;
	}
}