export const fetchTodos = () => (
   $.ajax({
    url: '/api/todos',
    dataType: 'json',
    method: 'GET',
  })
);
