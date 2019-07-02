let Game = artifacts.require("Game");

let Rogue = artifacts.require("Classes/Rogue");
let Troll = artifacts.require("Classes/Troll");
let Wizard = artifacts.require("Classes/Wizard");
let Warrior = artifacts.require("Classes/Warrior");

module.exports = function (deployer) {
  let _game;
  deployer.deploy(Game)
    .then((instance) => { _game = instance; return deployer.deploy(Rogue); })
    .then(() => { return _game.addClass("Rogue", Rogue.address); })
    .then(() => { return deployer.deploy(Wizard); })
    .then(() => { return _game.addClass("Wizard", Wizard.address); })
    .then(() => { return deployer.deploy(Warrior); })
    .then(() => { return _game.addClass("Warrior", Warrior.address); })
    .then(() => { return deployer.deploy(Troll); })
    .then(() => { return _game.addClass("Troll", Troll.address); });
};
