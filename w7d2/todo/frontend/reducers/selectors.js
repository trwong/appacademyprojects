
const allTodos = (state) => {
  console.log(state);
  let keys = Object.keys(state.todos);
  return keys.map((key) => {
    return state.todos[parseInt(key)];
  });
};

export default allTodos;
