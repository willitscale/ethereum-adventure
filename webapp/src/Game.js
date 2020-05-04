import React from "react";

import GameContractJson from './contracts/Game.json';
import PlayableCharacter from './contracts/PlayableCharacter.json';
import PlayableClass from './contracts/PlayableClass.json';

class Game extends React.Component {
  state = { dataKey: null };

  constructor(props) {
    super(props);
    this.createCharacter = this.createCharacter.bind(this);
    this.getCharacter = this.getCharacter.bind(this);
  }

  componentDidMount() {
    const { drizzle } = this.props;
    const { Game } = drizzle.contracts;
    const state = drizzle.store.getState();

    if (state.drizzleStatus.initialized) {
      const gameDataKey = Game.methods['_gameVersion'].cacheCall();
      this.setState({ gameDataKey });
    }
  }

  async getCharacter() {
    const { drizzle } = this.props;
    const { Game } = drizzle.contracts;
    const state = drizzle.store.getState();
    
    if (state.drizzleStatus.initialized) {

      let characterAddress = await Game.methods.getPlayableCharacter().call();

      PlayableCharacter.networks = GameContractJson.networks;
      PlayableCharacter.networks['5777'].address = characterAddress;

      drizzle.addContract(PlayableCharacter);

      let classAddress = await drizzle.contracts.PlayableCharacter.methods.getClass().call();

      console.log('Character Name: ' + await drizzle.contracts.PlayableCharacter.methods.getName().call());
      console.log('Character Level: ' + await drizzle.contracts.PlayableCharacter.methods.getLevel().call());
      console.log('Character Health: ' + await drizzle.contracts.PlayableCharacter.methods.getHitPoints().call());
      console.log('Character Mana: ' + await drizzle.contracts.PlayableCharacter.methods.getManaPoints().call());

    
      PlayableClass.networks = GameContractJson.networks;
      PlayableClass.networks['5777'].address = classAddress;

      drizzle.addContract(PlayableClass);

      console.log('Class Name: ' + await drizzle.contracts.PlayableClass.methods.getName().call());
    }
  }

  async createCharacter() {
    const { drizzle } = this.props;
    const { Game } = drizzle.contracts;
    const state = drizzle.store.getState();
    
    if (state.drizzleStatus.initialized) {
    console.log(Game);
    Game.methods.createPlayableCharacter("test", "Warrior").send({}, (error, result) => {
        console.log(error, result);
      });
    }
  }

  render() {
    const { Game } = this.props.drizzleState.contracts;
    const gameVersion = Game['_gameVersion'][this.state.gameDataKey];
    return (
      <div>
      <p>Game Version: {gameVersion && gameVersion.value}</p>
      <button onClick={this.createCharacter}>Create Character</button>
      <button onClick={this.getCharacter}>Get Character</button>
      </div>
    );
  
  }
}

export default Game;