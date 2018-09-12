package top.w8d.test;

import org.junit.BeforeClass;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import top.w8d.domain.User;
import top.w8d.service.UserService;

public class UserDaoTest {
    static UserService userService;

    @BeforeClass
    static public void before() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("config/.xml");
        userService = ctx.getBean(UserService.class);
    }

    @Test
    public void testAdd() {
        User user = new User();
        user.setUsername("zhutao");
        user.setPassword("123456");

        userService.addUser(user);
    }
}
