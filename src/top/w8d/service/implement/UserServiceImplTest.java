package top.w8d.service.implement;

import beans.User;
import org.springframework.stereotype.Service;
import top.w8d.service.UserService;

@Service
public class UserServiceImplTest implements UserService{
    private User genTestUser() {
        User user = new User();
        user.setId(123456);
        user.setUsername("zhutao");
        user.setPassword("123");
        return user;
    }

    @Override
    public User queryUserById(Integer id) {
        return genTestUser();
    }

    @Override
    public User queryUserByName(String username) {
        return genTestUser();
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
