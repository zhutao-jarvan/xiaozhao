<%@ page import="top.w8d.util.RegisterCheck" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <link href="/res/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/res/css/main.css" rel="stylesheet">
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
        }
        #reg_box {
            border-radius: 10px;
            position: absolute;
            top: 10%;
            left: 0;
            right: 0;
            opacity: 1;
            width: 400px;
            background: white;
            box-shadow: 3px 3px 10px black;
            margin: auto;
        }
        #reg_head {
            width: 100%;
            height: 20%;
            background-color: #4cae4c;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        #reg_main {
            padding: 20px 15%;
        }

        .input-group {
            width: 100%;
            padding-bottom: 10px;
        }

        .verify {
            display: inline-block;
            padding-right: 5%;
            width: 45%;
        }

        .verify_img {
            display: inline-block;
            width: 50%;
        }

        .verify_btn {
            display: inline-block;
            width: 50%;
            position: relative;
        }

        .btn-success {
            width: 100%;
            word-spacing: 50px;
            margin-top: 10px;
        }

        #login {
            padding-left: 50%;
        }
    </style>
</head>

<body>
<div id="reg_box">
    <div id="reg_head">
    </div>
    <div id="reg_main">
        <h4 align="center">注册新用户</h4>
        <hr>
        <form method="post" action="register.form">
            <p id="reg_info"></p>
            <div class="form-group">
                <div class="input-group" id="username">
                    <input type="text" name="username" class="form-control" placeholder="用户名" aria-describedby="basic-addon1">
                </div>
                <div class="input-group" id="password1">
                    <input type="password" name="password1" class="form-control" placeholder="密码" aria-describedby="basic-addon2">
                </div>
                <div class="input-group" id="password2">
                    <input type="password" name="password2" class="form-control" placeholder="重复密码" aria-describedby="basic-addon2">
                </div>
                <div class="input-group" id="qq">
                    <input type="text" name="qq" class="form-control" placeholder="QQ号" aria-describedby="basic-addon2">
                </div>
                <div class="input-group" id="telephone">
                    <input type="text" name="telephone" class="form-control" placeholder="手机号" aria-describedby="basic-addon2">
                </div>
                <div class="input-group verify" id="verify_code">
                    <input type="text" name="verify_code" class="form-control" placeholder="验证码" aria-describedby="basic-addon2">
                </div>
                <div class="verify_img">
                    <a href="#"><img src="/res/img/register.png" width="130px" height="40px"></a>
                </div>
                <div class="input-group verify"  id="verify_node">
                    <input type="text" name="verify_note" class="form-control" placeholder="短信码" aria-describedby="basic-addon2">
                </div>
                <div class="verify_btn">
                    <button type="button" class="btn btn-warning">获取短信验证码</button>
                </div>
                <button type="submit" class="btn btn-success">注 册</button>
            </div>
            <div class="checkbox">
                <label>
                    <input type="checkbox" value="">
                    同意<a href="#">使用协议</a>
                </label>
                <a href="login" id="login">登陆</a>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="/res/jquery/jquery-1.8.3.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="/res/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $("#reg_info").hide();
        <%
    String error = (String) request.getAttribute("error");
    if (error != null && !error.isEmpty()) {
        String username = (String) request.getAttribute("username");
        String password1 = (String) request.getAttribute("password1");
        String password2 = (String) request.getAttribute("password2");
        String telephone = (String) request.getAttribute("telephone");
        String qq = (String) request.getAttribute("qq");
        Integer errno = (Integer) request.getAttribute("errno");
    %>

        var username = "<%=username%>";
        var password1 = "<%=password1%>";
        var password2 = "<%=password2%>";
        var telephone = "<%=telephone%>";
        var qq = "<%=qq%>";
        var errno = <%=errno%>;
        var error = "<%=error%>";

        $("#username input").val(username);
        $("#password1 input").val(password1);
        $("#password2 input").val(password2);
        $("#telephone input").val(telephone);
        $("#qq input").val(qq);
        switch (errno) {
            case <%=RegisterCheck.REG_OK%>:
                $("#reg_info").css("color", "green");
                $("#reg_info").text("注册成功");
                $("#reg_info").show();
                setTimeout(function () {
                    location.href = "/login";
                }, 3000);
                return;
            case <%=RegisterCheck.REG_USERNAME_ERR1%>:
            case <%=RegisterCheck.REG_USERNAME_ERR2%>:
                $("#username").addClass("has-error");
                break;
            case <%=RegisterCheck.REG_PASSOWRD_ERR1%>:
            case <%=RegisterCheck.REG_PASSOWRD_ERR2%>:
            case <%=RegisterCheck.REG_PASSOWRD_ERR3%>:
                $("#password1").addClass("has-error");
                $("#password2").addClass("has-error");
                break;
            case <%=RegisterCheck.REG_QQ_ERR1%>:
                $("#qq").addClass("has-error");
                break;
            case <%=RegisterCheck.REG_TELEPHONE_ERR1%>:
            case <%=RegisterCheck.REG_TELEPHONE_ERR2%>:
                $("#telephone").addClass("has-error");
                break;
            case <%=RegisterCheck.REG_VERIFY_ERR1%>:
                $("#verify_code").addClass("has-error");
                break;
            case <%=RegisterCheck.REG_VERIFY_ERR2%>:
                $("#verify_node").addClass("has-error");
                break;
            default:
                break;
        }

        $("#reg_info").css("color", "red");
        $("#reg_info").text(error);
        $("#reg_info").show();
        <%}%>
    });
</script>
</body>
</html>
