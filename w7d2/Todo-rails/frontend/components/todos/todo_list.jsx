import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './../todo_list/todo_form.jsx';
// import {receiveTodo} from './../../actions/todo_actions';
import {uniqueId} from './../../util/util';


// const TodoList = ({ todos, receiveTodo }) => {
//   return (
//     <div>
//       <h3>Todo List goes here!</h3>
//       <ul>
//         {
//           todos.map((todo, i) => (
//             <TodoListItem key={i} todo={todo} />
//           ))
//         }
//       </ul>
//       <TodoForm receiveTodo={receiveTodo} />
//     </div>
//   );
// };
//
// export default TodoList;


class TodoList extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.props.fetchTodos();
  }

  render() {
    return (
      <div>
        <h3>Todo List goes here!</h3>
        <ul>
          {
            this.props.todos.map((todo, i) => (
              <TodoListItem key={i} todo={todo} />
            ))
          }
        </ul>
        <TodoForm receiveTodo={this.props.receiveTodo} />
      </div>
    );
  }
}

export default TodoList;
