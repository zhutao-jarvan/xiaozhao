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
            <div class="form-group">
                <div class="input-group">
                    <input type="text" name="username" class="form-control" placeholder="用户名" aria-describedby="basic-addon1">
                </div>
                <div class="input-group">
                    <input type="password1" name="password1" class="form-control" placeholder="密码" aria-describedby="basic-addon2">
                </div>
                <div class="input-group">
                    <input type="password2" name="password2" class="form-control" placeholder="重复密码" aria-describedby="basic-addon2">
                </div>
                <div class="input-group">
                    <input type="text" name="qq" class="form-control" placeholder="QQ号" aria-describedby="basic-addon2">
                </div>
                <div class="input-group">
                    <input type="text" name="telephone" class="form-control" placeholder="手机号" aria-describedby="basic-addon2">
                </div>
                <div class="input-group verify">
                    <input type="text" name="verify_code" class="form-control" placeholder="验证码" aria-describedby="basic-addon2">
                </div>
                <div class="verify_img">
                    <a href="#"><img src="/res/img/register.png" width="130px" height="40px"></a>
                </div>
                <div class="input-group verify">
                    <input type="text" name="verify_note" class="form-control" placeholder="短信码" aria-describedby="basic-addon2">
                </div>
                <div class="verify_btn">
                    <button type="button" class="btn btn-warning">获取短信验证码</button>
                </div>
                <button type="button" class="btn btn-success">注 册</button>
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
</script>
</body>
</html>
