<%@ page import="java.io.InputStream" %>
<%@ page import="bean.TodoItem" %>
<%@ page import="utils.PostJsonUtils" %>
<%@ page import="utils.StringUtils" %>
<%@ page import="service.LoginService" %>
<%@ page import="bean.User" %>
<%@ page import="bean.TodoItem" %>
<%@ page import="service.TodoService" %><%--
  Created by IntelliJ IDEA.
  User: zhutao
  Date: 2018/7/11
  Time: 8:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 清除多余的空行 --%>
<%@ page trimDirectiveWhitespaces="true" %>
<%    //获取客户端传递过来参数
    //String username = request.getParameter("username");
    //String password = request.getParameter("password");
    //System.out.println("username: " + username);
    //System.out.println("password: " + password);
    User user = (User)session.getAttribute("user");

    if (user == null) {
        out.print(-1); //用户未登陆
        return;
    }

    InputStream in = request.getInputStream();
    int size = request.getContentLength();
    TodoItem todoItem = PostJsonUtils.getTodoItem(in, size);
    String username = user.getUsername();

    out.print(new TodoService().handleTodoItem(username, todoItem));
%>
