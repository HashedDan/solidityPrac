const fs = require('fs');
const solc = require('solc');
const Web3 = require('web3');

// Connect to local Ethereum node
const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

// Identify specified contract
const contractFile = process.argv[2];
const contractName = contractFile.toString().slice(0,-4);

console.log(contractName);

// Compile the source code
const input = fs.readFileSync(contract);
const output = solc.compile(input.toString(), 1);
console.log(output);
const bytecode = output.contracts[contractName].bytecode;
const abi = JSON.parse(output.contracts[contractName].interface);