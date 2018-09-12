package top.w8d.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
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


        int ret = RegisterCheck.regCheck(username, password1, password2, qq, telephone, verifyCode, verifyNote);
        if (ret != RegisterCheck.REG_OK) {
            req.setAttribute("error", RegisterCheck.regErrorInfo(ret));
            return new ModelAndView("register");
        } else {
            req.setAttribute("message", RegisterCheck.regErrorInfo(ret));
            return new ModelAndView("register");
        }
    }
}
