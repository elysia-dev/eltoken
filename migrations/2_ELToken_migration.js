let ELToken = artifacts.require("./ELToken.sol");

const _name = "ELYSIA";
const _symbol = "EL";
const _decimals = 18;
const _total_supply = 7000000000; // 7,000,000,000

module.exports = function(deployer) {
  deployer.deploy(ELToken, _name, _symbol, _decimals, _total_supply);
};
