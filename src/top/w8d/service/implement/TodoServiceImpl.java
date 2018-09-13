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
    public List<Todo> getTodayTodoByUserId(Integer userId) {
        return todoDao.getTodoByUserId(userId);
    }

    @Override
    public List<Todo> getTodoByUserId(Integer userId) {
        return null;
    }

    @Override
    public boolean addTodo(Todo todo) {
        return false;
    }

    @Override
    public boolean deleteTodo(Todo todo) {
        return false;
    }

    @Override
    public boolean updateTodo(Todo todo) {
        return false;
    }
}
