package service;

import bean.Todo;
import bean.TodoItem;
import utils.DataBaseUtils;
import utils.StringUtils;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class TodoService {
    private static Lock lock =  new ReentrantLock();

    public List<Todo> getTodo(String username) {
        String sql = "select * from todo where username = ?";
        try {
            return DataBaseUtils.queryForBeanList(sql, Todo.class, username);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int checkTodoItem(String username, TodoItem todoItem) {
        String sql = "select * from todo where username = ? and keywords = ? and thing = ?";
        Todo todo = null;
        try {
            todo =  (Todo)DataBaseUtils.queryForBean(sql, Todo.class, username, todoItem.getKeywords(), todoItem.getThing());
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        if (todo != null) {
            return -3; //事件已经存在
        }

        return 0;
    }

    public Todo genTodo(String username, TodoItem todoItem) {
        Todo todo = new Todo();
        todo.setUsername(username); //关联用户
        Timestamp t = new Timestamp(System.currentTimeMillis());
        todo.setCreateDate(t.getTime()); //设置创建时间
        todo.setKeywords(todoItem.getKeywords() == null ? "" : todoItem.getKeywords());
        todo.setThing(todoItem.getThing());
        todo.setHow(todoItem.getHow() == null ? "" : todoItem.getHow());

        //设置处理时间
        Date date = new Date();//取时间
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        if (StringUtils.stringToBoolean(todoItem.getDo_today())) {
            date = calendar.getTime(); //获取当前时间
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = formatter.format(date);
            todo.setDoDate(dateString);
        } else if (StringUtils.stringToBoolean(todoItem.getDo_tomorrow())) {
            calendar.add(calendar. DATE, 1);//把日期往后增加一天.整数往后推,负数往前移动
            date = calendar.getTime(); //这个时间就是日期往后推一天的结果
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = formatter.format(date);
            todo.setDoDate(dateString);
        } else if (StringUtils.isEmpty((todoItem.getDo_later()))) {
            todo.setDoDate("1970-01-01 00:00:00");
        } else {
            todo.setDoDate(todoItem.getDo_later());
        }

        return todo;
    }

    public int addTodoItem(String username, TodoItem todoItem) {
        if (StringUtils.isEmpty(todoItem.getThing())) {
            return -2; //做事情的描述必须具有可打印字符
        }

        lock.lock();
        int status = checkTodoItem(username, todoItem);
        if (status != 0) {
            lock.unlock();
            return status;
        }

        Todo todo = genTodo(username, todoItem);
        DataBaseUtils.update("INSERT INTO todo(username, createDate, doDate, keywords, thing, how) VALUES (?, ?, ?, ?, ?, ?)", todo.getUsername(), todo.getCreateDate(), todo.getDoDate(), todo.getKeywords(), todo.getThing(), todo.getHow());
        lock.unlock();

        return 0;
    }

    public int handleTodoItem(String username, TodoItem todoItem) {
        String action = todoItem.getAction();

        if (action.equals("add")) {
            return addTodoItem(username, todoItem);
        } else if (action.equals("urgent")) {

        } else if (action.equals("do_today")) {
            //设置处理时间
            Date date = new Date();//取时间
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            date = calendar.getTime(); //获取当前时间
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = formatter.format(date);
            DataBaseUtils.update("UPDATE todo SET doDate = ? WHERE username = ? and keywords = ? and thing = ?",
                    dateString, username, todoItem.getKeywords(), todoItem.getThing());
            return 0;
        } else if (action.equals("do_tomorrow")) {
            //设置处理时间
            Date date = new Date();//取时间
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            calendar.add(calendar. DATE, 1);//把日期往后增加一天.整数往后推,负数往前移动
            date = calendar.getTime(); //获取当前时间
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = formatter.format(date);
            DataBaseUtils.update("UPDATE todo SET doDate = ? WHERE username = ? and keywords = ? and thing = ?",
                    dateString, username, todoItem.getKeywords(), todoItem.getThing());
            return 0;
        } else if (action.equals("do_later")) {

        } else if (action.equals("not_essential")) {

        } else if (action.equals("delete")) {

        }

        return -10;
    }

    public static void main(String[] args) {
            /*
            TodoItem todoItem = new TodoItem();
            todoItem.setKeywords("zhutao");
            todoItem.setThing("写代码");
            todoItem.setDo_today("true");
            todoItem.setDo_tomorrow("false");
            new TodoService().addTodoItem("zhutao", todoItem);
            */
        List<Todo> list =  new TodoService().getTodo("zhutao");

        for (Todo todo: list) {
            System.out.println(todo.getThing());
        }
    }
}
