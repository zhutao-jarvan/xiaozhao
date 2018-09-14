package top.w8d.dao;

import top.w8d.domain.Todo;

import java.util.List;

public interface TodoDao {
    public abstract List<Todo> getTodoByUserId(Integer userId);
    public abstract Todo getTodoByTodoId(Integer todoId);
    public abstract boolean addTodo(Todo todo);
    public abstract boolean updateTodo(Todo todo);
    public abstract boolean deleteTodo(Todo todo);
}
