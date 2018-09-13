package top.w8d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.w8d.domain.Todo;
import top.w8d.service.TodoService;
import top.w8d.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class TodoController {
    @Autowired
    private UserService userService;
    @Autowired
    private TodoService todoService;

    @RequestMapping("/todo")
    public String todoViewController() {
        return "todo";
    }

    @RequestMapping("/todo.json")
    @ResponseBody
    public String todoDataController(HttpServletRequest req, HttpServletResponse resp) {
        Integer userId = (Integer) req.getSession().getAttribute(UserService.AUTH_USER_ID_KEY);
        List<Todo> todos = todoService.getTodoByUserId(userId);

        return null;
    }
}
