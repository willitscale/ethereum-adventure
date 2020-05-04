const Game = artifacts.require("Game");
const Rogue = artifacts.require("Classes/Rogue");
const Troll = artifacts.require("Classes/Troll");
const Wizard = artifacts.require("Classes/Wizard");
const Warrior = artifacts.require("Classes/Warrior");
const NonPlayableCharacter = artifacts.require("Characters/NonPlayableCharacter");

module.exports = function (deployer) {
  let _game;
  deployer.deploy(Game)
    .then((instance) => { _game = instance; return deployer.deploy(Rogue); })
    .then(() => { return _game.addPlayableClass("Rogue", Rogue.address); })
    .then(() => { return deployer.deploy(Wizard); })
    .then(() => { return _game.addPlayableClass("Wizard", Wizard.address); })
    .then(() => { return deployer.deploy(Warrior); })
    .then(() => { return _game.addPlayableClass("Warrior", Warrior.address); })
    .then(() => { return deployer.deploy(Troll); })
    .then(() => { return _game.addNonPlayableClass("Troll", Troll.address); });
};
