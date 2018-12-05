let Game = artifacts.require("./Game.sol");
let Character = artifacts.require("./Character.sol");
let Class = artifacts.require("./Class.sol");

const PROVIDED_NAME = "TEST";
const PROVIDED_CLASS = "Warrior";

contract("Game", (accounts) => {

    let creatorAccount = accounts[0];
    let characterAccount = accounts[1];

    let _game;

    it("should create a character with the name and class provided", () => {
        let _character;
        let _class;

        return Game.deployed()
            .then(instance => {
                _game = instance;
                return _game.createCharacter(PROVIDED_NAME, PROVIDED_CLASS, { from: creatorAccount });
            })
            .then(() => {
                return _game.getCharacter();
            })
            .then(instance => {
                _character = Character.at(instance);
                return _character.getName();
            })
            .then(name => {
                assert.equal(name, PROVIDED_NAME, "Failed to create a character with the provided name");
                return _character.getClass();
            })
            .then(instance => {
                _class = Class.at(instance);
                return _class.getName();
            })
            .then(name => {
                assert.equal(name, PROVIDED_CLASS, "Failed to create a character with the provided class");
            });
    });

    it("should not allow me to set attributes of a character", () => {
        let _character;
        let _class;

        return Game.deployed()
            .then(instance => {
                _game = instance;
                return _game.createCharacter(PROVIDED_NAME, PROVIDED_CLASS, { from: characterAccount });
            })
            .then(() => {
                return _game.getCharacter({ from: characterAccount });
            })
            .then(instance => {
                _character = Character.at(instance);
                return _character.setStrength(200, { from: characterAccount });
            })
            .catch(error => {
                assert.equal(
                    error.message,
                    "VM Exception while processing transaction: revert Request did not come from the game",
                    "Exception not thrown when setting attributes of character with invalid address"
                );
            });
    });
});