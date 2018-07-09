package service;

import bean.User;
import utils.DataBaseUtils;

import java.sql.SQLException;

public class LoginService {
    public User getUser(String username){
        String sql = "select * from user where username = ?";
        User user = null;
        try {
            user = DataBaseUtils.queryForBean(sql, User.class, username);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        if(user == null){
            return null;
        }

        return user;
    }
}
