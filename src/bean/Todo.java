package bean;

import annotation.Column;
import annotation.Table;

import java.util.Date;
import java.sql.Timestamp;

@Table(tableName = "todo")
public class Todo {
    public static int TODO_STAT_DELETE = 1;
    public static int TODO_STAT_TODO = 2;
    public static int TODO_STAT_DONE = 3;
    public static int TODO_STAT_TODAY = 4; //not save in database

    @Column(type = "int(8)", field = "id", primaryKey = true, defaultNull = false)
    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    @Column(type = "VARCHAR(64)", field = "userId", defaultNull = false)
    private String userId; //关联user表

    @Column(type = "datetime", field = "doDate", defaultNull = false)
    private String doDate;

    @Column(type = "long", field = "createDate", defaultNull = false)
    private Long createDate;

    @Column(type = "long", field = "deleteTime")
    private Long deleteTime;

    @Column(type = "long", field = "doneTime")
    private Long doneTime;

    public Long getDoneTime() {
        return doneTime;
    }

    public void setDoneTime(Long doneTime) {
        this.doneTime = doneTime;
    }

    @Column(type = "int(1)", field = "status")
    private Integer status;

    @Column(type = "int(1)", field = "priority")
    private Integer priority; // 0 - 4; 0 > 4

    @Column(type = "VARCHAR(64)", field = "keywords")
    private String keywords;

    @Column(type = "VARCHAR(256)", field = "thing", defaultNull = false)
    private String thing;

    @Column(type = "VARCHAR(4096)", field = "how")
    private String how;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDoDate() {
        return doDate;
    }

    public void setDoDate(String doDate) {
        this.doDate = doDate;
    }

    public Long getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Long createDate) {
        this.createDate = createDate;
    }

    public Long getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(Long deleteTime) {
        this.deleteTime = deleteTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }
    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getThing() {
        return thing;
    }

    public void setThing(String thing) {
        this.thing = thing;
    }

    public String getHow() {
        return how;
    }

    public void setHow(String how) {
        this.how = how;
    }
}
