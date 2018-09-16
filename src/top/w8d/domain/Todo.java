package top.w8d.domain;

import java.util.Date;

public class Todo {
     public static final int TODO_STAT_TODO = 1;
     public static final int TODO_STAT_DONE = 2;
     public static final int TODO_STAT_DEL = 3;
     public static final int TODO_STAT_LATER = 4;

     private Integer todoId;
     private Integer userId;
     private Date createTime;
     private Date doTime;
     private Date deadTime;
     private Integer status;
     private String key;
     private String todo;
     private String desc;

    public Todo() {
    }

    public Todo(Integer todoId, Date doTime, Date deadTime, Integer status, String key, String todo, String desc) {
        this.todoId = todoId;
        this.doTime = doTime;
        this.deadTime = deadTime;
        this.status = status;
        this.key = key;
        this.todo = todo;
        this.desc = desc;
    }

    public Todo(Integer userId, Date doTime, String key, String todo, String desc) {
        this.userId = userId;
        this.doTime = doTime;
        this.key = key;
        this.todo = todo;
        this.desc = desc;
    }

    public Integer getTodoId() {
        return todoId;
    }

    public void setTodoId(Integer todoId) {
        this.todoId = todoId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getDeadTime() {
        return deadTime;
    }

    public Date getdoTime() {
        return doTime;
    }

    public void setdoTime(Date doTime) {
        this.doTime = doTime;
    }

    public void setDeadTime(Date deadTime) {
        this.deadTime = deadTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getTodo() {
        return todo;
    }

    public void setTodo(String todo) {
        this.todo = todo;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
