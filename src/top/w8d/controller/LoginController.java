package top.w8d.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
public class LoginController {
    @RequestMapping("/login")
    public ModelAndView login(HttpServletRequest req, HttpServletResponse res) {
        return null;
    }
}
