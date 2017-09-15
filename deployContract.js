/*
* Use this script to deploy any contract to local testrpc
*
* Usage: node deployContact.js <Contract File Name>
* 
* 
*/

const fs = require('fs');
const solc = require('solc');
const Web3 = require('web3');

// Connect to local Ethereum node
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

// Identify specified contract
const contractFile = process.argv[2];
const contractName = ':' + contractFile.toString().slice(0,-4);

// Compile the source code
const input = fs.readFileSync(contractFile);
const output = solc.compile(input.toString(), 1);
const bytecode = output.contracts[contractName].bytecode;
const abi = JSON.parse(output.contracts[contractName].interface);
console.log("COPY ABI CODE BELOW");
console.log("-----------");
console.log(abi);

// Create contract object
const contract = web3.eth.contract(abi);

// Deploy contract
const contractInstance = contract.new({
	data: bytecode,
	from: web3.eth.accounts[0],
	gas: 1000000,
	gasPrice: 1
}, (err, res) => {
	if (err) {
		console.log(err);
		return;
	}
});