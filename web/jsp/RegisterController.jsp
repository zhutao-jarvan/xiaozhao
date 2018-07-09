<%@ page import="java.io.InputStream" %>
<%@ page import="bean.RegisterUser" %>
<%@ page import="static utils.PostJsonUtils.getRegisterData" %>
<%@ page import="utils.StringUtils" %>
<%@ page import="service.RegisterService" %><%--
  Created by IntelliJ IDEA.
  User: jarvan
  Date: 2018/7/9
  Time: 20:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 清除多余的空行 --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
    InputStream in = request.getInputStream();
    int size = request.getContentLength();
    RegisterUser registerUser = getRegisterData(in, size);
    String username = registerUser.getUsername();
    String password = registerUser.getPassword();

    //如果用户名和密码不为空
    if(StringUtils.isEmpty(username) || StringUtils.isEmpty(password)){
        out.print(-1);//错误码-1 :   用户名和密码不能为空！
    }else{
        //初始化LoginService
        RegisterService registerService = new RegisterService();
        //接下来判断用户名是否存在
        out.print(registerService.addUser(registerUser)); // 0:成功， -2：已经存在
    }
%>
