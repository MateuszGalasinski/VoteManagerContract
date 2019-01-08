const VoteManager = artifacts.require("./VoteManager");

module.exports = function(deployer) {
  deployer.deploy(VoteManager);
};
