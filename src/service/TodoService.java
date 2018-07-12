package service;

import bean.Todo;
import bean.TodoItem;
import utils.StringUtils;

public class TodoService {
    public int checkTodoItem(String username, Todo todo) {
        if () {

            return -3; //事件已经存在
        }

        return 0;
    }

    public Todo getTodo(String username, TodoItem todoItem) {

    }

    public Todo genTodo(String username, TodoItem todoItem) {

    }

    public int addTodoItem(String username, TodoItem todoItem) {
        if (StringUtils.isEmpty(todoItem.getThing())) {
            return -2; //做事情的描述必须具有可打印字符
        }



        return 0;
    }
}
