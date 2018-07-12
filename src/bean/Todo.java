package bean;

import annotation.Column;
import annotation.Table;

import java.sql.Date;
import java.sql.Timestamp;

@Table(tableName = "todo")
public class Todo {
    @Column(type = "VARCHAR(64)", field = "username", defaultNull = false)
    private String username;

    @Column(type = "timestamp", field = "doDate", primaryKey = true, defaultNull = false)
    private long doDate;

    @Column(type = "timestamp", field = "createDate", defaultNull = false)
    private long createDate;

    @Column(type = "VARCHAR(64)", field = "keywords")
    private String keywords;

    @Column(type = "VARCHAR(256)", field = "thing", defaultNull = false)
    private String thing;

    @Column(type = "VARCHAR(4096)", field = "how")
    private String how;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public long getDoDate() {
        return doDate;
    }

    public void setDoDate(long doDate) {
        this.doDate = doDate;
    }

    public long getCreateDate() {
        return createDate;
    }

    public void setCreateDate(long createDate) {
        this.createDate = createDate;
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
