<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="bean.Todo" %>
<%@ page import="java.util.List" %>
<%@ page import="service.TodoService" %>
<%@ page import="bean.User" %>
<%
    User user = (User)session.getAttribute("user");
    List<Todo> list = new TodoService().getAllValidTodo(user.getUsername());
    request.setAttribute("todoList", list);
%>
<!DOCTYPE html>
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

        .how h4 {
            line-height: 0.75;
            padding-bottom: 0;
            margin-bottom: 0.75em;
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
        <a href="today.jsp" class="btn_jump_today">今日工作</a>
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
                <c:forEach items="${requestScope.todoList}" var="todo" varStatus="status">
                    <tr>
                        <td>
                            <dl>
                                <strong>${todo.getKeywords()}</strong>
                                <dt>${todo.getThing()}</dt>
                                <dd>${todo.getHow()}</dd>
                            </dl>
                        </td>
                        <td>
                            <ul>
                                <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'urgent')">急</a></li>
                                <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'do_today')">今</a></li>
                                <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'do_tomorrow')">明</a></li>
                                <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'do_later')">未</a></li>
                                <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'not_essential')">沉</a></li>
                                <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'delete')">删</a></li>
                            </ul>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>

            <tfoot>

            </tfoot>
        </table>
    </div>

    <div class="mask"></div>
    <div id="add_item">
        <form class="add_item_form" onsubmit="return submit_add_one_item('add');return false;" method="post" name="add_form">
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
                <button type="submit">保存</button>
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

        function submit_add_one_item(action) {
            var xmlhttp = new XMLHttpRequest();
            var keywords = document.getElementById("keywords").value;
            var thing = document.getElementById("thing").value;
            var how = document.getElementById("how").value;
            var do_today = document.getElementById("do_today").checked;
            var do_tomorrow = document.getElementById("do_tomorrow").checked;
            var do_later = document.getElementById("do_later").value;

            var data = "{\"keywords\":\"" + keywords + "\",\"thing\":\"" + thing + "\",\"how\":\"" + how + "\",\"action\":\"" + action + "\",\"do_today\":\"" + do_today + "\",\"do_tomorrow\":\"" + do_tomorrow + "\",\"do_later\":\"" + do_later + "\"}";
            console.log("xmlhttp.requestText: " + data);
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var resp = xmlhttp.responseText;
                    console.log("xmlhttp.resonseText: " + resp);
                    document.getElementById("hint").style.color = "red";
                    switch (resp) {
                        case "0": //登录成功，3秒跳转首页
                            document.getElementById("hint").innerHTML = "添加成功";
                            document.getElementById("hint").style.color = "green";
                            window.setTimeout("window.location='/todo.jsp'", 2000);
                            break;
                        case "-1": //用户名未登陆！
                            document.getElementById("hint").innerHTML = "用户名未登陆！";
                            break;
                        case "-2": //做事情的描述必须具有可打印字符！
                            document.getElementById("hint").innerHTML = "【做啥事】 的描述必须具有可打印字符";
                            break;
                        case "-3": //事件已经存在！
                            document.getElementById("hint").innerHTML = "事情已在计划中";
                            break;
                        default:
                            document.getElementById("hint").innerHTML = "服务器错误";
                            break;
                    }
                }
            }
            xmlhttp.open("POST", "todoController.jsp", true);
            xmlhttp.send(data);
            return false;
        }

        function handler_todo_item(myself, action) {
            var xmlhttp = new XMLHttpRequest();
            var keywords = null;
            var thing = null;
            var how = "";
            var m1 = myself.parentNode;	//当前节点第一个父元素
            var m2 = m1.parentNode;		//当前节点第二个父元素
            var m3 = m2.parentNode;		//当前节点第三个父元素
            var m4 = m3.parentNode;		//当前节点第四个父元素
            var n3s = m4.childNodes;	//顶层父元素下的所有子元素

            for(var i=0 in n3s){ //遍历子元素数组
                if(n3s[i].nodeName == "#text" && !/\S/.test(n3s[i].nodeValue)) {
                    //删除数组中的text
                    m4.removeChild(n3s[i]);
                }
            }
            var n3 = m4.firstChild;		//获取到td

            var n2s = n3.childNodes;
            for(var i=0 in n2s){ //遍历子元素数组
                if(n2s[i].nodeName == "#text" && !/\S/.test(n2s[i].nodeValue)) {
                    //删除数组中的text
                    n3.removeChild(n2s[i]);
                }
            }
            var n2 = n3.firstChild;	//获取到dl

            var n1s = n2.childNodes;
            for(var i=0 in n1s){ //遍历子元素数组
                if(n1s[i].nodeName == "STRONG") {
                    keywords = n1s[i];
                    console.log("keywords: " + keywords.innerHTML);
                } else if (n1s[i].nodeName == "DT") {
                    thing = n1s[i];
                    console.log("thing: " + thing.innerHTML);
                } else if (n1s[i].nodeName == "DD") {
                    how = n1s[i];
                    console.log("how: " + how.innerHTML);
                }
            }

            //上传后台
            var data = "{\"keywords\":\"" + keywords.innerHTML + "\",\"thing\":\"" + thing.innerHTML + "\",\"action\":\"" + action + "\"}";
            console.log("xmlhttp.requestText: " + data);
            //document.getElementById("hint").innerHTML = "";
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var resp = xmlhttp.responseText;
                    console.log("xmlhttp.resonseText: " + resp);
                    document.getElementById("hint").style.color = "red";
                    switch (resp) {
                        case "0": //登录成功，3秒跳转首页
                            document.getElementById("hint").innerHTML = "添加成功";
                            document.getElementById("hint").style.color = "green";
                            window.setTimeout("window.location='/todo.jsp'", 2000);
                            break;
                        case "-1": //用户名未登陆！
                            document.getElementById("hint").innerHTML = "用户名未登陆！";
                            break;
                        case "-2": //做事情的描述必须具有可打印字符！
                            document.getElementById("hint").innerHTML = "【做啥事】 的描述必须具有可打印字符";
                            break;
                        case "-3": //事件已经存在！
                            document.getElementById("hint").innerHTML = "事情已在计划中";
                            break;
                        default:
                            document.getElementById("hint").innerHTML = "服务器错误";
                            break;
                    }
                }
            }
            xmlhttp.open("POST", "todoController.jsp", true);
            xmlhttp.send(data);
            return false;
        }
    </script>
</body>
</html>