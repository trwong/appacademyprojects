import { connect } from 'react-redux';
import { receiveTodo } from '../../actions/todo_actions';
import todoList from './todo_list';
import allTodos from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  todos: allTodos(state)
});

const mapDispatchToProps = dispatch => ({
  receiveTodo: (todo) => {
    dispatch(receiveTodo(todo));
  }
});

export default connect(mapStateToProps, mapDispatchToProps)(todoList);
