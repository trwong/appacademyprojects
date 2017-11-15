import React from 'react';
import ReactDOM from 'react-dom';
import Content from './content';
import configureStore from'./store/store';
import { receiveTodos, receiveTodo, fetchTodos } from './actions/todo_actions.js';
import Root from './components/root';
import { allTodos } from './reducers/selectors';
import { testFunction } from './util/todo_api_util';

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  window.store = store;
  // window.receiveTodos = receiveTodos;
  // window.receiveTodo = receiveTodo;
  // window.allTodos = allTodos;
  console.log("asdf");
  window.testFunction = testFunction;
  window.fetchTodos = fetchTodos;
  
  const rootElement = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, rootElement);
});
