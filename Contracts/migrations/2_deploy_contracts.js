const CoinsContract = artifacts.require("VoteManager");

module.exports = function(deployer) {
  deployer.deploy(VoteManager);
};
