<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv=”Content-Type” content=”text/html; charset=utf-8″>
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <title>login</title>
    <style type="text/css">
        .dialog h3 {
            text-align: center;
            background-color: yellowgreen;
            padding: 0.6em 0;
            margin-bottom: 2em;
        }
        .dialog .text label {
            width: 3em;
            float: left;
            text-align: right;
            font-weight: bold;
            padding: 0 1em 0 0.5em;
        }
        .dialog .text input {
            width: 180px;
            height: 1.5em;
        }

        .dialog .control {
            padding-top: 16px;
            padding-left: 200px;
        }
    </style>
</head>
<body>
        <div class="mask" style="display: block;"></div>
        <div class="dialog" style="display: block">
            <h3>登&nbsp;&nbsp;&nbsp;&nbsp;陆</h3>
            <form onsubmit="return userRegister()" method="post" action="servlet">
                <div class="form_block text">
                    <label for="username">用户名</label>
                    <input type="text" name="thing" id="username"/>
                </div>

                <div class="form_block text">
                    <label for="password">密 码</label>
                    <input type="password" name="thing" id="password"/>
                </div>
                <div class="form_block text">
                    <span id="hint"></span>
                </div>

                <div class="form_block control">
                    <button type="button" onclick="userLogin()">登录</button>
                    <button type="button" onclick="userRegister()">注册</button>
                </div>
            </form>
        </div>

        <script>
            function userLogin() {
                var xmlhttp = new XMLHttpRequest();
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;
                var data = "{\"username\":\"" + username + "\",\"password\":\"" + password + "\"}";
                document.getElementById("hint").innerHTML = "";
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var resp = xmlhttp.responseText;
                        console.log("xmlhttp.resonseText: " + resp);
                        document.getElementById("hint").style.color = "red";
                        switch (resp) {
                            case "0": //登录成功，3秒跳转首页
                                document.getElementById("hint").innerHTML = "登录成功";
                                document.getElementById("hint").style.color = "green";
                                window.setTimeout("window.location='todo.jsp'",3000);
                                break;
                            case "-1": //用户名和密码不能为空！
                                document.getElementById("hint").innerHTML = "用户名和密码不能为空";
                                break;
                            case "-2": //用户名不存在！
                                document.getElementById("hint").innerHTML = "用户名不存在";
                                break;
                            case "-3": //用户名或密码错误！
                                document.getElementById("hint").innerHTML = "用户名或密码错误";
                                break;
                            default:
                                document.getElementById("hint").innerHTML = "服务器错误";
                                break;
                        }
                    }
                }
                xmlhttp.open("POST", "loginController.jsp", true);
                xmlhttp.send(data);
            }

            function userRegister() {
                var xmlhttp = new XMLHttpRequest();
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;
                var data = "{\"username\":\"" + username + "\",\"password\":\"" + password + "\"}";
                document.getElementById("hint").innerHTML = "";
                xmlhttp.onreadystatechange = function () {
                    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                        var resp = xmlhttp.responseText;
                        console.log("xmlhttp.resonseText: " + resp);
                        document.getElementById("hint").style.color = "red";
                        switch (resp) {
                            case "0": //登录成功，3秒跳转首页
                                document.getElementById("hint").innerHTML = "注册成功";
                                document.getElementById("hint").style.color = "green";
                                window.setTimeout("window.location='/'",3000);
                                break;
                            case "-1": //用户名和密码不能为空！
                                document.getElementById("hint").innerHTML = "用户名和密码不能为空";
                                break;
                            case "-2": //用户名不存在！
                                document.getElementById("hint").innerHTML = "用户名已存在";
                                break;
                            case "-3": //用户名或密码错误！
                                document.getElementById("hint").innerHTML = "用户名或密码错误";
                                break;
                            default:
                                document.getElementById("hint").innerHTML = "服务器错误";
                                break;
                        }
                    }
                }
                xmlhttp.open("POST", "jsp/RegisterController.jsp", true);
                xmlhttp.send(data);
            }
        </script>
</body>
</html>