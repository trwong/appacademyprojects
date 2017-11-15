import React from 'react';
import {receiveTodo} from './../../actions/todo_actions';
import {uniqueId} from './../../../util/util';


class TodoForm extends React.Component {
  constructor(prop) {
    super(prop);
    this.state = {
      title: '',
      body: ''
    };
    this.submitForm = this.submitForm.bind(this);
  }

  linkState(word) {
    return (event => this.setState({[word]: event.currentTarget.value}));
  }

  submitForm(event) {
    event.preventDefault();
    let newState = Object.assign({}, this.state, {id: uniqueId()});
    // debugger;
    this.props.receiveTodo(newState);
  }

  render() {
    return (
      <form onSubmit={ e => this.submitForm(e)}>
        <label>
          Title:
          <input onChange={this.linkState('title')} value={this.state.title} />
        </label>
        <label>
          Body:
          <input onChange={this.linkState('body')} value={this.state.body} />
        </label>
        <input type="submit"></input>
      </form>
    );
  }
}

export default TodoForm;
