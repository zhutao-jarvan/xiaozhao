package service;

import bean.Todo;
import bean.TodoItem;
import utils.DataBaseUtils;
import utils.StringUtils;

import javax.swing.*;
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

    public List<Todo> getTodoList(String userId, String sql) {
        try {
            return DataBaseUtils.queryForBeanList(sql, Todo.class, userId);
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

    public Todo getTodo(String userId, TodoItem todoItem) {
        String sql = "select * from todo where userId = ? and keywords = ? and thing = ?";
        Todo todo = null;
        try {
            todo =  (Todo)DataBaseUtils.queryForBean(sql, Todo.class, userId, todoItem.getKeywords(), todoItem.getThing());
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }

        return todo;
    }

    public List<Todo> getAllTodo(String userId) {
        String sql = "select * from todo where userId = ?";
        return getTodoList(userId, sql);
    }

    public List<Todo> getAllTodayValidTodo(String userId) {
        Date date = new Date();//取时间
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        date = calendar.getTime(); //获取当前时间
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);

        StringBuilder sb = new StringBuilder("select * from todo where userId = ?  and status = 2 and doDate like \"");
        sb.append(dateString);
        sb.append("%\"");
        return getTodoList(userId, sb.toString());
    }

    public List<Todo> getAllValidTodo(String userId) {
        Date date = new Date();//取时间
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        date = calendar.getTime(); //获取当前时间
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);

        String sql = "select * from todo where userId = ?  and status = 2";
        return getTodoList(userId, sql);
    }

    public int checkTodoItem(String userId, TodoItem todoItem) {
        Todo todo = getTodo(userId, todoItem);

        if (todo != null) {
            return -3; //事件已经存在
        }

        return 0;
    }

    public Todo genTodo(String userId, TodoItem todoItem) {
        Todo todo = new Todo();
        todo.setUserId(userId); //关联用户
        Timestamp t = new Timestamp(System.currentTimeMillis());
        todo.setCreateDate(t.getTime()); //设置创建时间
        todo.setKeywords(todoItem.getKeywords() == null ? "" : todoItem.getKeywords());
        todo.setThing(todoItem.getThing());
        todo.setHow(todoItem.getHow() == null ? "" : todoItem.getHow());
        todo.setStatus(Todo.TODO_STAT_TODO);
        todo.setPriority(2);
        todo.setDeleteTime(0L);

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

    /* 未完成 */
    public int changeTodoItem(String userId, TodoItem todoItem) {
        if (StringUtils.isEmpty(todoItem.getThing())) {
            return -2; //做事情的描述必须具有可打印字符
        }

        lock.lock();
        Todo todo = getTodo(userId, todoItem);
        if (todo == null) {
            lock.unlock();
            return -3;
        }

        DataBaseUtils.update("INSERT INTO todo(userId, createDate, doDate, keywords, thing, how, status, priority, deleteTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", todo.getUserId(),
                todo.getCreateDate(), todo.getDoDate(), todo.getKeywords(), todo.getThing(), todo.getHow(), todo.getStatus(), todo.getPriority(), todo.getDeleteTime());
        lock.unlock();

        return 0;
    }

    public int addTodoItem(String userId, TodoItem todoItem) {
        if (StringUtils.isEmpty(todoItem.getThing())) {
            return -2; //做事情的描述必须具有可打印字符
        }

        lock.lock();
        int status = checkTodoItem(userId, todoItem);
        if (status != 0) {
            lock.unlock();
            return status;
        }

        Todo todo = genTodo(userId, todoItem);
        DataBaseUtils.update("INSERT INTO todo(userId, createDate, doDate, keywords, thing, how, status, priority, deleteTime) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", todo.getUserId(),
                            todo.getCreateDate(), todo.getDoDate(), todo.getKeywords(), todo.getThing(), todo.getHow(), todo.getStatus(), todo.getPriority(), todo.getDeleteTime());
        lock.unlock();

        return 0;
    }

    public int handleTodoItem(String userId, TodoItem todoItem) {
        String action = todoItem.getAction();

        if (action.equals("add")) {
            return addTodoItem(userId, todoItem);
        } else if (action.equals("edit")) {
            return changeTodoItem(userId, todoItem);
        } else if (action.equals("urgent")) {
            Todo todo = getTodo(userId, todoItem);
            int priority = todo.getPriority();
            if (priority > 0) {
                priority--;
            } else {
                System.out.println("priority is first!");
            }
            DataBaseUtils.update("UPDATE todo SET priority = ? WHERE userId = ? and keywords = ? and thing = ?",
                    priority, userId, todoItem.getKeywords(), todoItem.getThing());
        } else if (action.equals("do_today")) {
            //设置处理时间
            Date date = new Date();//取时间
            Calendar calendar = new GregorianCalendar();
            calendar.setTime(date);
            date = calendar.getTime(); //获取当前时间
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String dateString = formatter.format(date);
            DataBaseUtils.update("UPDATE todo SET doDate = ? WHERE userId = ? and keywords = ? and thing = ?",
                    dateString, userId, todoItem.getKeywords(), todoItem.getThing());
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
            DataBaseUtils.update("UPDATE todo SET doDate = ? WHERE userId = ? and keywords = ? and thing = ?",
                    dateString, userId, todoItem.getKeywords(), todoItem.getThing());
            return 0;
        } else if (action.equals("do_later")) {
            String dateString = todoItem.getDo_later();
            DataBaseUtils.update("UPDATE todo SET doDate = ? WHERE userId = ? and keywords = ? and thing = ?",
                    dateString, userId, todoItem.getKeywords(), todoItem.getThing());
            return 0;
        } else if (action.equals("not_essential")) {
            DataBaseUtils.update("UPDATE todo SET priority = ? WHERE userId = ? and keywords = ? and thing = ?",
                    4, userId, todoItem.getKeywords(), todoItem.getThing());
            return 0;
        } else if (action.equals("delete")) {
            Timestamp t = new Timestamp(System.currentTimeMillis());
            long now = t.getTime();
            DataBaseUtils.update("UPDATE todo SET status = ?, deleteTime = ? WHERE userId = ? and keywords = ? and thing = ?",
                    Todo.TODO_STAT_DELETE, now, userId, todoItem.getKeywords(), todoItem.getThing());
            return 0;
        } else if (action.equals("done")) {
            Timestamp t = new Timestamp(System.currentTimeMillis());
            long now = t.getTime();
            DataBaseUtils.update("UPDATE todo SET status = ?, doneTime = ? WHERE userId = ? and keywords = ? and thing = ?",
                    Todo.TODO_STAT_DONE, now, userId, todoItem.getKeywords(), todoItem.getThing());
            return 0;
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
            /*
        Date date = new Date();//取时间
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        date = calendar.getTime(); //获取当前时间
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);
        System.out.println("now: " + dateString.length() + ": " + dateString);
        */
        List<Todo> list =  new TodoService().getAllTodayValidTodo("zhutao");

        for (Todo todo: list) {
            System.out.println( todo.getThing());
        }
    }
}
