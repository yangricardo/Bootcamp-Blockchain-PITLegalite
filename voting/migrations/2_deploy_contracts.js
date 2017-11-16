var Voting = artifacts.require("./Voting.sol");
module.exports = function(deployer) {
  deployer.deploy(Voting, ['Batman', 'DarthVader', 'FelipeArgento'], {gas: 6700000});
};
