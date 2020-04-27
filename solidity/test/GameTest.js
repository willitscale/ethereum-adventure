const Game = artifacts.require("./Game.sol");
const Character = artifacts.require("./Characters/Character.sol");
const Class = artifacts.require("./Classes/Class.sol");
const Warrior = artifacts.require("./Classes/Warrior.sol");

const PROVIDED_NAME = "TEST";
const PROVIDED_CLASS = "Warrior";

contract("Game", (accounts) => {

    const creatorAccount = accounts[0];
    const characterAccount = accounts[1];

    let setGame;

    it("should create a character with the name and class provided", () => {
        let setCharacter;
        let setClass;

        return Game.deployed()
            .then(instance => {
                setGame = instance;
                return Warrior.deployed();
            })
            .then(warrior => {
                return setGame.addClass("Warrior", warrior.address);
            })
            .then(() => {
                return setGame.createCharacter(PROVIDED_NAME, PROVIDED_CLASS, { from: creatorAccount });
            })
            .then(() => {
                return setGame.getCharacter();
            })
            .then(instance => {
                return Character.at(instance);
            })
            .then(returnedCharacter => {
                setCharacter = returnedCharacter;
                return setCharacter.getName();
            })
            .then(name => {
                assert.equal(name, PROVIDED_NAME, "Failed to create a character with the provided name");
                return setCharacter.getClass();
            })
            .then(instance => {
                return Class.at(instance);
            })
            .then(returnedClass => {
                setClass = returnedClass;
                return setClass.getName();
            })
            .then(name => {
                assert.equal(name, PROVIDED_CLASS, "Failed to create a character with the provided class");
            });
    });

    it("should not allow me to set attributes of a character", () => {
        let setCharacter;

        return Game.deployed()
            .then(instance => {
                setGame = instance;
                return setGame.createCharacter(PROVIDED_NAME, PROVIDED_CLASS, { from: characterAccount });
            })
            .then(() => {
                return setGame.getCharacter({ from: characterAccount });
            })
            .then(instance => {
                return Character.at(instance);
            })
            .then(returnedCharacter => {
                setCharacter = returnedCharacter;
                return setCharacter.setStrength(200, { from: characterAccount });
            })
            .catch(error => {
                assert.equal(
                    error.message,
                    "Returned error: VM Exception while processing transaction: revert Request did not come from the game -- Reason given: Request did not come from the game.",
                    "Exception not thrown when setting attributes of character with invalid address"
                );
            });
    });
});