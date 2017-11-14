import React from 'react';

class TodoForm extends React.Component {
  constructor() {
    super();
    this.state = {
      word: ''
    };
  }

  linkState(word) {
    return (event => this.setState({[word]: event.currentTarget.value}));
  }

  render() {
    return (
        <input onChange={this.linkState('word')} value={this.state.word} />
    );
  }
}

export default TodoForm;
