const Web3 = require('web3')
const Tx = require('ethereumjs-tx');

const Web3js = new Web3(new Web3.providers.HttpProvider('http://localhost:8545'));

let tokenAddress = '0x0b4B148C6AB76335899A1294c22f48964cB04869';
let toAddress = '0xDc27C2b26EDbfb7Eb223589D4997dDA997DA8D1e';
let fromAddress = '0x2DcCa9B61E50D79A90a813fcD6a42c3A3Ac52e6f';
let privateKey = Buffer.from('3f0b5c58378de554534a5a8c630aac075886e74a6b3229000ae78f4500e153e3', 'hex');

let fs = require('fs');
let abiFile = fs.readFileSync('build/contracts/ELToken.json', 'utf-8');
let contractABI = JSON.parse(abiFile).abi;

let contract = new Web3js.eth.Contract(contractABI, tokenAddress, {from: fromAddress});

let amount = Web3js.utils.toHex(10e18);

Web3js.eth.getTransactionCount(fromAddress)
.then((count) => {
  let rawTransaction = {
    'from': fromAddress,
    'gasPrice': Web3js.utils.toHex(20 * 1e9),
    'gasLimit': Web3js.utils.toHex(210000),
    'to': tokenAddress,
    'value': 0x0,
    'data': contract.methods.transfer(toAddress, amount).encodeABI(),
    'nonce': Web3js.utils.toHex(count)
  }
  let transaction = new Tx(rawTransaction)
  transaction.sign(privateKey)
  Web3js.eth.sendSignedTransaction('0x' + transaction.serialize().toString('hex'))
  .on('transactionHash', console.log)
})
