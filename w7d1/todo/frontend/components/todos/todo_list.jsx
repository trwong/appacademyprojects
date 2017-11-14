import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './../todo_list/todo_form.jsx';

const TodoList = ({ todos }) => {
  return (
    <div>
      <h3>Todo List goes here!</h3>
      <ul>
        {
          todos.map((todo, i) => (
            <TodoListItem key={i} todo={todo} />
          ))
        }
      </ul>
      <TodoForm   />
    </div>
  );
};

export default TodoList;


// class TodoList extends React.Component {
//   constructor(props) {
//     super(props);
//   }
//   render() {
//     return (
//       <h3>Todo List goes here!</h3>
//     );
//   }
// }
//
// export default TodoList;
