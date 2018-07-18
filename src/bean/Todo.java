package bean;

import annotation.Column;
import annotation.Table;

import java.util.Date;
import java.sql.Timestamp;

@Table(tableName = "todo")
public class Todo {
    @Column(type = "VARCHAR(64)", field = "username", defaultNull = false)
    private String username;

    @Column(type = "datetime", field = "doDate", defaultNull = false)
    private String doDate;

    @Column(type = "long", field = "createDate", defaultNull = false)
    private Long createDate;

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
