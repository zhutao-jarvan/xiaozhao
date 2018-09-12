package top.w8d.domain;

import java.util.Date;

public class User {
    public Integer userId;
    public String username;
    public String nickname;
    public String password;
    public String qq;
    public String telephone;
    public Date createTime;
    public boolean valid;

    public User() {}

    public User(Integer userId, String username, String nickname, String password, String qq, String telephone, Date createTime, boolean valid) {
        this.userId = userId;
        this.username = username;
        this.nickname = nickname;
        this.password = password;
        this.qq = qq;
        this.telephone = telephone;
        this.createTime = createTime;
        this.valid = valid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public boolean isValid() {
        return valid;
    }

    public void setValid(boolean valid) {
        this.valid = valid;
    }
}
