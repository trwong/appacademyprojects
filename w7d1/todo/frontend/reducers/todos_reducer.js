import { RECEIVE_TODOS, RECEIVE_TODO } from "../actions/todo_actions";
import merge from 'lodash/merge';

const initialState = {
  1: {
    id: 1,
    title: 'wash car',
    body: 'with soap',
    done: false
  },
  2: {
    id: 2,
    title: 'wash dog',
    body: 'with shampoo',
    done: true
  },
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  let newState;
  switch(action.type) {
    case RECEIVE_TODOS:
      newState = {};
    // why use const if we will be mutating this? why not let?
      action.todos.forEach( (el) => {
        newState[el.id] = el;
      });
      return newState;
    case RECEIVE_TODO:
      newState = Object.assign({}, state);
      newState[action.todo.id] = action.todo;
      return newState;
    default:
      return state;
  }
};

export default todosReducer;
