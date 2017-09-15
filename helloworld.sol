pragma solidity ^0.4.11;

contract helloworld {

	// public means that "message" is accessible outside of helloWorld contract
	string public message;

	function helloworld() {
		message = "hello world!";
	}

	// constant means that function will not be changing any state in the blockchain
	function sayHi() constant returns (string) {
		return message;
	}
}