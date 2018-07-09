package service;

import bean.RegisterUser;
import bean.User;
import utils.DataBaseUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

public class RegisterService {
    public int checkRegisterUser(RegisterUser registerUser) {
        LoginService loginService = new LoginService();

        User user = loginService.getUser(registerUser.getUsername());
        if (user != null)
            return -2; //用户名已经存在
        return 0;
    }

    public User genUser(RegisterUser registerUser) {
        User user = new User();
        user.setUsername(registerUser.getUsername());
        user.setPassword(registerUser.getPassword());
        user.setId(UUID.randomUUID() + "");
        user.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

        return user;
    }

    public int addUser(RegisterUser registerUser) {
        User user = null;
        int status = checkRegisterUser(registerUser);
        if (status != 0)
            return status;

        user = genUser(registerUser);
        DataBaseUtils.update("INSERT INTO user(id,username,password,sex,create_time,is_delete,address,telephone) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)", user.getId(), user.getUsername(), user.getPassword(), 0, user.getCreateTime(), 0, "保密", "保密");

        return 0;
    }
}
