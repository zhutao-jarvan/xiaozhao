﻿<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv=”Content-Type” content=”text/html; charset=utf-8″>
    <title>待办事项</title>
    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
        }
        .backlog {
            position: relative;
            width: 800px;
            margin: 0 auto;
        }

        table {
                position: absolute;
                border: 2px solid black;
                border-collapse: collapse;

        }
        table caption {
            font-size: 2.5em;
            line-height: 3em;
        }

        .backlog .btn_add_new {
            position: absolute;
            display: inline-block;
            top: 3em;
            right: 3em;
            z-index: 1;
        }

        .backlog .btn_jump_today {
            position: absolute;
            display: inline-block;
            top: 3em;
            right: 6em;
            z-index: 1;
        }

        table th,td {
            border: 1px solid black;
        }
        table th {
            font-size: 1.5em;
            line-height: 2em;
        }
        table td {
            font-size: 1.2em;
            line-height: 1.5em;
        }
        .col_things {
            width: 560px;
        }
        .col_function {
            width: 240px;
            text-align: center;
        }

        table tbody ul li {
            list-style: none;
            display: inline;

        }
        table tbody ul li a {
            text-decoration: none;
        }
        table tbody dl strong {
            display: inline-block;
            width: 20%;
            text-align: right;
            font-size: 1.15em;
        }
        table tbody dl dd {
            display: none;
        }
        table tbody dl dt {
            display: inline;
        }

        .mask {
            position: fixed!important;
            margin:0;
            background-color: #878787;
            background-clip: border-box;
            opacity: 0.5;
            z-index: 999;
            display: none;
            width: 100%;
            height: 100%;
        }

        #add_item {
            position: absolute;
            top: 100px;
            left: 40%;
            opacity: 1;
            background: white;
            background-clip: padding-box;
            z-index: 1000;
            display: none;
            width: 400px;
            height: 400px;
            border-radius: 5px;
            box-shadow: 3px 3px 5px #888888;
        }

        .add_item_block {
            padding: 1em 1em 0 2em;
        }
        .add_item_block input {
            line-height: 1.5em;
        }

        .keyword {
            padding-top: 3em;
        }

        .how textarea {
            vertical-align: center;
        }

        .control {
            position: absolute;
            bottom: 1.5em;
            right: 4em;
        }
        .control button {
            margin-left: 0.3em;
        }

        .time label {
            padding-right: 1em;
        }

    </style>
</head>
<body>
    <div class="backlog main_tab">
        <a href="#" onclick="today.html" class="btn_jump_today">今日工作</a>
        <a href="#" onclick="add_one_item()" class="btn_add_new">新增</a>
        <table>
            <caption>待办事项</caption>
            <col class="col_things" />
            <col class="col_function" />
            <thead>
                <tr>
                    <th>事项</th>
                    <th>操作</th>
                </tr>
            </thead>

            <tbody>
                <tr>
                    <td>
                        <dl>
                            <strong>新型号</strong>
                            <dt>制作固件WAP5-200W和AP4301-CW</dt>
                            <dd>新的硬件是福瑞联提供的，硬件形态是双屏入墙AP，芯片是9531（2x2）+9887(1x1)；WAP5-200W是智开渠道固件，AP4301-CW是齐邦微桥固件</dd>
                        </dl>
                    </td>
                    <td>
                        <ul>
                            <li><a href="#">急</a></li>
                            <li><a href="#">今</a></li>
                            <li><a href="#">明</a></li>
                            <li><a href="#">未</a></li>
                            <li><a href="#">沉</a></li>
                            <li><a href="#">删</a></li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <td>
                        <dl>
                            <strong>认证</strong>
                            <dt>微信小程序认证</dt>
                            <dd>微信小程序通过websocket跟AP进行信息交换，AP开启一个wss，小程序连接AP的wss后，将用户手机发给AP，AP将手机上传平台查询，平台决定是否放行，AP根据平台返回的是否放行结果来决定AP是否开网。AP中的实现由wifidog完成。</dd>
                        </dl>
                    </td>
                    <td>
                        <ul>
                            <li><a href="#">急</a></li>
                            <li><a href="#">今</a></li>
                            <li><a href="#">明</a></li>
                            <li><a href="#">未</a></li>
                            <li><a href="#">沉</a></li>
                            <li><a href="#">删</a></li>
                        </ul>
                    </td>
                </tr>
            </tbody>

            <tfoot>

            </tfoot>
        </table>
    </div>

    <div class="mask"></div>
    <div id="add_item">
        <form class="add_item_form" onsubmit="return submit_add_one_item()" method="post">
            <!-- 关键字 -->
            <div class="add_item_block keyword">
                <label for="keywords">关键字</label>
                <input type="text" name="keywords" id="keywords" list="keyLists" maxlength="5"/>
                <datalist id="keyLists" style="display: none">
                    <option value="新型号"></option>
                    <option value="认证"></option>
                </datalist>
            </div>

            <!-- 什么事情 -->
            <div class="add_item_block thing">
                <label for="thing">做啥事</label>
                <input type="text" name="thing" id="thing" maxlength="20"/>
            </div>

            <div class="add_item_block how">
                <!-- 怎么做这件事情，描述一下 -->
                <h4>咋个做</h4>
                <textarea id="how" rows="5" cols="40"></textarea>
            </div>

            <!-- 何时做 -->
            <div class="add_item_block time">
                <label>今天<input type="radio" id="do_today" name="when" value="今天" /></label>
                <label>明天<input type="radio" id="do_tomorrow" name="when" value="明天" /></label>
                <label>改天<input type="date" id="do_later" value="改天" class="date"/></label>
            </div>

            <!-- 何时做 -->
            <div class="add_item_block">
                <span id="hint"></span>
            </div>

            <div class="add_item_block control">
                <button type="submit" onclick="submit_add_one_item()">保存</button>
                <button type="button" onclick="cancelForm()">取消</button>
            </div>
        </form>
    </div>
    <script type="text/javascript">
        function add_one_item() {
            document.getElementById("add_item").style.display="block";
            var array = document.getElementsByClassName("mask");

            for (var i=0; i<array.length; i++) {
                array[i].style.display = "block";
            }
        }
        
        function cancelForm() {
            document.getElementById("add_item").style.display="none";
            var array = document.getElementsByClassName("mask");

            for (var i=0; i<array.length; i++) {
                array[i].style.display = "none";
            }
        }

        function submit_add_one_item() {
            var xmlhttp = new XMLHttpRequest();
            var keyword = document.getElementById("keywords").value;
            var thing = document.getElementById("thing").value;
            var how = document.getElementById("how").value;
            var do_today = document.getElementById("do_today").checked;
            var do_tomorrow = document.getElementById("do_tomorrow").checked;
            var do_later = document.getElementById("do_later").value;

            var data = "{\"keyword\":\"" + keyword + "\",\"thing\":\"" + thing + "\",\"how\":\"" + how + "\",\"do_today\":\"" + do_today + "\",\"do_tomorrow\":\"" + do_tomorrow + "\",\"do_later\":\"" + do_later + "\"}";
            console.log("xmlhttp.requestText: " + data);
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
            xmlhttp.open("POST", "todoController.jsp", true);
            xmlhttp.send(data);
        }
    </script>
</body>
</html>