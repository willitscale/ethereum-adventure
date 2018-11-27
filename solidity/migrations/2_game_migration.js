var Game = artifacts.require("./Game.sol");

module.exports = function(deployer) {
  deployer.deploy(Game);
};
