/*
* Use this script to deploy any contract to local testrpc
*
* Usage: node deployContract.js <Contract File Name> <Sender> [<Constructor Parameters...>]
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
console.log(output);
const bytecode = output.contracts[contractName].bytecode;
const abi = JSON.parse(output.contracts[contractName].interface);
// console.log("COPY ABI CODE BETWEEN DASHED LINES");
// console.log("-----------");
// console.log(JSON.stringify(abi));
// console.log("-----------");
// console.log("END ABI CODE");

// Create contract object
const contract = web3.eth.contract(abi);

// Put all Constuctor Parameters into array
var constructorParams = [];
for (var i = 0; i < process.argv.length - 4; ++i) {
	constructorParams[i] = process.argv[i+4];
};


// Deploy contract
const contractInstance = contract.new(
	constructorParams, {
	data: bytecode,
	from: process.argv[3],
	gas: 4400000,
	gasPrice: 1
}, (err, res) => {
	if (err) {
		console.log(err);
		return;
	}
	else {
		// TODO: promise response to deployed
		console.log("COPY ABI CODE BETWEEN DASHED LINES");
		console.log("-----------");
		console.log(JSON.stringify(abi));
		console.log("-----------");
		console.log("END ABI CODE");
        console.log('Contract Address: ' + res.address);
	}
});