package top.w8d.service.implement;

import org.springframework.stereotype.Service;
import top.w8d.dao.TodoDao;
import top.w8d.domain.Todo;
import top.w8d.service.TodoService;

import javax.annotation.Resource;
import java.util.List;

@Service
public class TodoServiceImpl implements TodoService {
    @Resource
    private TodoDao todoDao;

    @Override
    public List<Todo> getAllTodoByUserId(Integer userId) {
        return todoDao.getAllTodoByUserId(userId);
    }

    @Override
    public List<Todo> getTodayTodoByUserId(Integer userId) {
        return todoDao.getTodayTodoByUserId(userId);
    }

    @Override
    public List<Todo> getTodoByUserId(Integer userId) {
        return todoDao.getTodoByUserId(userId);
    }

    @Override
    public Todo getTodoByTodoId(Integer todoId) {
        return todoDao.getTodoByTodoId(todoId);
    }

    @Override
    public boolean addTodo(Todo todo) {
        return todoDao.addTodo(todo);
    }

    @Override
    public boolean deleteTodo(Todo todo) {
        return false;
    }

    @Override
    public boolean updateTodo(Todo todo) {
        return todoDao.updateTodo(todo);
    }
}
