import React from "react";

class Game extends React.Component {
  state = { dataKey: null };

  componentDidMount() {
    const { drizzle } = this.props;
    const gameContract = drizzle.contracts.Game;
    const state = drizzle.store.getState();

    if (state.drizzleStatus.initialized) {
      const gameDataKey = gameContract.methods['_gameVersion'].cacheCall();
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