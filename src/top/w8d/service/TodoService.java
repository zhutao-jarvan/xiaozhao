package top.w8d.service;

import top.w8d.domain.Todo;

import java.util.List;

public interface TodoService {
    public abstract List<Todo> getTodoByUserId(Integer userId);
    public abstract List<Todo> getTodayTodoByUserId(Integer userId);
    public abstract boolean addTodo(Todo todo);
    public abstract boolean updateTodo(Todo todo);
    public abstract boolean deleteTodo(Todo todo);
}
