package top.w8d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import top.w8d.domain.User;
import top.w8d.service.UserService;
import top.w8d.util.RegisterCheck;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class RegisterController {
    @Autowired
    private UserService userService;

    @RequestMapping("/register")
    public String registerController() {
        return "register";
    }

    @RequestMapping(value = "/register.form", method = RequestMethod.POST)
    public ModelAndView registerFormController(HttpServletRequest req, HttpServletResponse res,
            @RequestParam("username") String username,
            @RequestParam("password1") String password1,
            @RequestParam("password2") String password2,
            @RequestParam("qq") String qq,
            @RequestParam("telephone") String telephone,
            @RequestParam("verify_code") String verifyCode,
            @RequestParam("verify_note") String verifyNote) {
        req.setAttribute("username", username);
        req.setAttribute("password1", password1);
        req.setAttribute("password2", password2);
        req.setAttribute("qq", qq);
        req.setAttribute("telephone", telephone);
        int ret = RegisterCheck.regCheck(username, password1, password2, qq, telephone, verifyCode, verifyNote);
        if (ret == RegisterCheck.REG_OK) {
            User userTmp = userService.queryUserByName(username);
            if (userTmp != null) {
                req.setAttribute("errno", RegisterCheck.REG_USERNAME_ERR2);
                req.setAttribute("error", RegisterCheck.regErrorInfo(RegisterCheck.REG_USERNAME_ERR2));
                return new ModelAndView("register");
            }
            userTmp = userService.queryUserByTelephone(telephone);
            if (userTmp != null) {
                req.setAttribute("errno", RegisterCheck.REG_TELEPHONE_ERR2);
                req.setAttribute("error", RegisterCheck.regErrorInfo(RegisterCheck.REG_TELEPHONE_ERR2));
                return new ModelAndView("register");
            }
        } else {
            req.setAttribute("errno", ret);
            req.setAttribute("error", RegisterCheck.regErrorInfo(ret));
            return new ModelAndView("register");
        }

        User user = new User(username, password1, qq, telephone);
        userService.addUser(user);
        req.setAttribute("errno", ret);
        req.setAttribute("error", RegisterCheck.regErrorInfo(ret));
        return new ModelAndView("register");
    }
}
