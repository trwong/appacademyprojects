import React from 'react';
import TodoListContainer from './todos/todo_list_container';
import TodoList from './todos/todo_list';

const App  = () => {
  return (
    <div>
      <h1>ToDo</h1>
      <TodoListContainer />
    </div>
  );
};

export default App;
