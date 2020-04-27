import React from 'react';
import './App.css';
import Game from "./Game";

class App extends React.Component {
  state = { 
    loading: true, 
    drizzleState: null 
  };

  componentDidMount() {
    const { drizzle } = this.props;

    this.unsubscribe = drizzle.store.subscribe(() => {
      const drizzleState = drizzle.store.getState();
      if (drizzleState.drizzleStatus.initialized) {
        this.setState({ loading: false, drizzleState });
      }
    });
  }

  componentWillUnmount() {
    this.unsubscribe();
  }

  render() {
    if (this.state.loading) {
      return "Loading Drizzle...";
    }

    return (
      <div className="App">
        <Game
          drizzle={this.props.drizzle}
          drizzleState={this.state.drizzleState}
        />
      </div>
    );
  }
}

export default App;
