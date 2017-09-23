pragma solidity ^0.4.11;

contract  Registrar {

	struct Pool {

	}

	struct Insurer {
		address insurerAddr;
		Pool[] pools;
		address[] doctors;
	}

	mapping(address => Insurer) public insurers;

	
	function Registrar() {

	}

	function addInsurer() {
		insurers[msg.sender] = Insurer(msg.sender);
	}

	function approveDoctor(address docAddr) {
		
	}
}