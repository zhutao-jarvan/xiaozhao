package top.w8d.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import top.w8d.domain.Todo;
import top.w8d.service.TodoService;
import top.w8d.service.UserService;
import top.w8d.util.Utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.text.ParseException;
import java.util.List;

class TodoAction extends Todo {
    String action;

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
}

@Controller
public class TodoController {
    private static final Gson gson = new GsonBuilder().disableHtmlEscaping().setDateFormat("yyyy-MM-dd").create();
    @Autowired
    private UserService userService;
    @Autowired
    private TodoService todoService;

    @RequestMapping("/todo")
    public String todoViewController() {
        return "todo";
    }

    @RequestMapping(value = "/todo.json", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String todoDataController(HttpServletRequest req, HttpServletResponse resp) {
        Integer userId = (Integer) req.getSession().getAttribute(UserService.AUTH_USER_ID_KEY);
        List<Todo> todos = todoService.getTodoByUserId(userId);

        String json = gson.toJson(todos);

        return json;
    }

    @RequestMapping(value = "/post_todo.json", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String todoFormController(HttpServletRequest req, HttpServletResponse resp,
                                     @RequestParam("post_todo_id") String todoIdStr,
                                     @RequestParam("myObject") String key,
                                     @RequestParam("mySummary") String todoThing,
                                     @RequestParam("myDesc") String desc,
                                     @RequestParam("date") String doDateStr) {
        Integer userId = (Integer) req.getSession().getAttribute(UserService.AUTH_USER_ID_KEY);
        Date doDate = null;
        try {
            doDate = Utils.stringToDateYMD(doDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }

        if (todoIdStr.isEmpty()) {
            Todo todoTmp = new Todo(userId, doDate, key, todoThing, desc);
            todoService.addTodo(todoTmp);
        } else {
            Integer todoId = Integer.parseInt(todoIdStr);
            Todo todo = todoService.getTodoByTodoId(todoId);
            Todo todoTmp = new Todo(todoId, doDate, todo.getDeadTime(), todo.getStatus(), key, todoThing, desc);
            todoService.updateTodo(todoTmp);
        }

        List<Todo> todos = todoService.getTodoByUserId(userId);
        String json = gson.toJson(todos);

        return json;
    }


    @RequestMapping(value = "handler_todo.json", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String todoHandlerController(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Integer userId = (Integer) req.getSession().getAttribute(UserService.AUTH_USER_ID_KEY);
        InputStream iStream = req.getInputStream();
        String json = IOUtils.toString(iStream, "utf-8");
        TodoAction todoAction = gson.fromJson(json, TodoAction.class);

        Todo todo = todoService.getTodoByTodoId(todoAction.getTodoId());
        if (todoAction.action.equals("later")) {
            todo.setdoTime(Utils.getTomorrowYMD(todo.getdoTime()));
            todo.setStatus(todo.TODO_STAT_LATER);
        } else if (todoAction.action.equals("delete")) {
            todo.setDeadTime(new Date());
            todo.setStatus(todo.TODO_STAT_DEL);
        } else if (todoAction.action.equals("immediately")) {
            todo.setdoTime(new Date());
            todo.setStatus(todo.TODO_STAT_TODO);
        } else if (todoAction.action.equals("done")) {
            todo.setDeadTime(new Date());
            todo.setStatus(todo.TODO_STAT_DONE);
        }
        todoService.updateTodo(todo);

        List<Todo> todos = todoService.getTodoByUserId(userId);
        json = gson.toJson(todos);
        return json;
    }
}
