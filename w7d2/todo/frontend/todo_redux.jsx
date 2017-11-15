import React from 'react';
import ReactDOM from 'react-dom';
import Content from './content';
import configureStore from'./store/store';
import { receiveTodos, receiveTodo } from './actions/todo_actions.js';
import Root from './components/root';
import { allTodos } from './reducers/selectors';

document.addEventListener("DOMContentLoaded", () => {
  const store = configureStore();
  window.store = store;
  window.receiveTodos = receiveTodos;
  window.receiveTodo = receiveTodo;
  window.allTodos = allTodos;
  
  const rootElement = document.getElementById('root');
  ReactDOM.render(<Root store={store}/>, rootElement);
});
