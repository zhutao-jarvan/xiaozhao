package top.w8d.service.implement;

import org.springframework.stereotype.Service;
import top.w8d.dao.UserDao;
import top.w8d.domain.User;
import top.w8d.service.UserService;

import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserDao userDao;

    @Override
    public User queryUserById(Integer userId) {
        return userDao.queryUserById(userId);
    }

    @Override
    public User queryUserByName(String username) {
        return userDao.queryUserByName(username);
    }

    @Override
    public boolean addUser(User user) {
        return userDao.addUser(user);
    }

    @Override
    public boolean deleteUser(Integer userId) {
        return userDao.deleteUser(userId);
    }
}
