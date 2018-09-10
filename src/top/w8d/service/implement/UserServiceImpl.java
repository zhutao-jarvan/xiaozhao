package top.w8d.service.implement;

import beans.User;
import org.springframework.stereotype.Service;
import top.w8d.service.UserService;


public class UserServiceImpl implements UserService {
    @Override
    public User queryUserById(Integer id) {
        return null;
    }

    @Override
    public User queryUserByName(String username) {
        return null;
    }

    @Override
    public boolean addUser(User user) {
        return false;
    }

    @Override
    public boolean deleteUser(Integer id) {
        return false;
    }
}
