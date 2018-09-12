package top.w8d.controller;

import top.w8d.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import top.w8d.service.UserService;
import top.w8d.util.Utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class LoginController {
    @Autowired
    private UserService userService;

    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest req, HttpServletResponse res) {
        User user = null;
        String passowrdCookie = null;
        Cookie[] cookie = req.getCookies();
        for (int i=0; i<cookie.length; i++) {
            if (cookie[i].getName().equals("userId")) {
                user = userService.queryUserById(Integer.parseInt(cookie[i].getValue()));
            }

            if (cookie[i].getName().equals("password")) {
                passowrdCookie = cookie[i].getValue();
            }
        }

        if (user != null && passowrdCookie != null) {
            if (passowrdCookie.equals(Utils.genMd5(user.password))) {
                try {
                    res.sendRedirect("/todo");
                } catch (IOException e) {
                    e.printStackTrace();
                }

                return null;
            }
        }

        return new ModelAndView("login");
    }

    @RequestMapping("/login.form")
    public ModelAndView loginForm(HttpServletRequest req, HttpServletResponse res) {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        boolean autoLogin = req.getParameter("auto_login") != null;

        if (username.isEmpty() || password.isEmpty()) {
            req.setAttribute("message", "用户名和密码不能为空");
        } else {
            User tmpUser = this.userService.queryUserByName(username);
            if (tmpUser == null) {
                req.setAttribute("message", "用户不存在");
            } else if (!tmpUser.password.equals(password)) {
                req.setAttribute("message", "密码错误");
            } else { //用户名密码验证成功，跳转主页
                req.getSession().setAttribute(UserService.AUTH_USER_KEY, username);
                req.getSession().setAttribute(UserService.AUTH_USER_NAME_KEY, tmpUser);
                if (autoLogin) {
                    Cookie[] cookie = req.getCookies();
                    res.addCookie(new Cookie("userId", tmpUser.userId.toString()));
                    res.addCookie(new Cookie("password", Utils.genMd5(password)));
                }

                try {
                    res.sendRedirect("/todo.jsp");
                } catch (IOException e) {
                    e.printStackTrace();
                }
                return null;
            }
        }

        return new ModelAndView("login");
    }
}
