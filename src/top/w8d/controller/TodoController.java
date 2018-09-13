package top.w8d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import top.w8d.service.UserService;

@Controller
public class TodoController {
    @Autowired
    private UserService userService;

    @RequestMapping("/todo")
    public String todoController() {
        return "todo";
    }
}
