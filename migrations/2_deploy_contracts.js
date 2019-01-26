var Bribes = artifacts.require("./Bribes.sol");

module.exports = function(deployer) {
  deployer.deploy(Bribes);
};
