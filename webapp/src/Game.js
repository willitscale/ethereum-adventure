import React from "react";

import GameContractJson from './contracts/Game.json';
import PlayableCharacter from './contracts/PlayableCharacter.json';
import PlayableClass from './contracts/PlayableClass.json';

class Game extends React.Component {
  state = { dataKey: null };

  async componentDidMount() {
    const { drizzle } = this.props;
    const gameContract = drizzle.contracts.Game;
    const state = drizzle.store.getState();

    if (state.drizzleStatus.initialized) {
      const gameDataKey = gameContract.methods['_gameVersion'].cacheCall();

      // gameContract.methods.createPlayableCharacter("Bob", "Warrior").send({}, (error, result) => {
      //   console.log(error, result);
      // });

      let characterAddress = await gameContract.methods.getPlayableCharacter().call();

      //console.log(PlayableCharacter);
      //console.log(GameContractJson.networks);

      PlayableCharacter.networks = GameContractJson.networks;
      PlayableCharacter.networks['5777'].address = characterAddress;

      drizzle.addContract(PlayableCharacter);

      //console.log(drizzle);

      let classAddress = await drizzle.contracts.PlayableCharacter.methods.getClass().call();

      console.log('Character Name: ' + await drizzle.contracts.PlayableCharacter.methods.getName().call());
      console.log('Character Level: ' + await drizzle.contracts.PlayableCharacter.methods.getLevel().call());
      console.log('Character Health: ' + await drizzle.contracts.PlayableCharacter.methods.getHitPoints().call());
      console.log('Character Mana: ' + await drizzle.contracts.PlayableCharacter.methods.getManaPoints().call());

    
      PlayableClass.networks = GameContractJson.networks;
      PlayableClass.networks['5777'].address = classAddress;

      drizzle.addContract(PlayableClass);

      console.log('Class Name: ' + await drizzle.contracts.PlayableClass.methods.getName().call());

      this.setState({ gameDataKey });
    }
  }

  render() {
    const { Game } = this.props.drizzleState.contracts;
    const gameVersion = Game['_gameVersion'][this.state.gameDataKey];
    return <p>Game Version: {gameVersion && gameVersion.value}</p>;
  }
}

export default Game;