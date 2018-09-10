<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>login</title>
    <link href="/res/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/res/css/main.css" rel="stylesheet">
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
        }
        #login_box {
            border-radius: 10px;
            position: absolute;
            top: 20%;
            left: 0;
            right: 0;
            opacity: 1;
            width: 400px;
            height: 300px;
            background: white;
            box-shadow: 3px 3px 10px black;
            margin: auto;
        }
        #login_head {
            width: 100%;
            height: 20%;
            background-color: #4cae4c;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        #login_main {
            padding: 20px 15%;
        }

        .input-group {
            padding-bottom: 10px;
        }

        .btn-success {
            width: 100%;
            word-spacing: 50px;
            margin-top: 10px;
        }
        #forgot_pwd {
            padding-left: 100px;
            padding-right: 10px;
        }
    </style>
</head>

<body>
    <div id="login_box">
        <div id="login_head">
        </div>
        <div id="login_main">
            <form id="login_form" method="post" action="/login.form">
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1"><span class="glyphicon glyphicon-user"></span></span>
                        <input type="text" class="form-control" placeholder="用户名" aria-describedby="basic-addon1" name="username">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon2"><span class="glyphicon glyphicon-lock"></span></span>
                        <input type="password" class="form-control" placeholder="密码" aria-describedby="basic-addon2" name="password">
                    </div>
                    <%
                        String msg = (String)request.getAttribute("message");
                        if (msg != null && !msg.isEmpty()) { %>
                            <p style="color: red"><%=msg%></p>
                     <% } %>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" name="auto_login" value="">
                            记住密码
                        </label>
                        <a href="#" id="forgot_pwd">忘记密码</a>
                        <a href="#" id="register">注册</a>
                    </div>
                    <button type="submit" class="btn btn-success">登 录</button>
                </div>
            </form>
        </div>
    </div>

    <script type="text/javascript" src="/res/jquery/jquery-1.8.3.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="/res/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
//        $(document).ready(function () {
//            $("#login_form").submit(function () {
//
//            });
//        })
    </script>
</body>
</html>
