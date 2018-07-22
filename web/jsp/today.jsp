<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="bean.Todo" %>
<%@ page import="java.util.List" %>
<%@ page import="service.TodoService" %>
<%@ page import="bean.User" %>
<%
    User user = (User)session.getAttribute("user");
    List<Todo> list = new TodoService().getAllTodayValidTodo(user.getUsername());
    request.setAttribute("todoList", list);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv=”Content-Type” content=”text/html; charset=utf-8″>
    <title>今日工作</title>
    <link rel="stylesheet" type="text/css" href="../css/common.css">
    <style type="text/css">
        .btn_jump_todo {
            position: absolute;
            display: inline-block;
            top: 3em;
            right: 3em;
            z-index: 1;
        }

        .main_tab {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            margin: 0 auto;
            width: 800px;
        }
        .main_tab table {
            position: relative;
            border: 2px solid black;
            border-collapse: collapse;
        }

        .dialog form p span, .main_tab tbody dl dt span {
            padding-left: 0.5em;
            color: yellowgreen;
        }
        .main_tab tbody dl dt a {
            margin-left: 0.5em;
            padding: 0.25em 0.5em 0.15em 0.5em;
            color: #38cd1e;
            background-color: #870174;
            border-radius: 5px;
            box-shadow: 1px 1px 5px black;
            font-size: 0.8em;
            font-family: "Microsoft YaHei UI";
            text-decoration: none;
        }

        .main_tab tbody dl dd {
            display: block;
            text-indent: 2em;
            padding: 0.5em 2em;
            font-size: 0.75em;
        }

        .dialog form p {
            padding-top: 1em;
            padding-bottom: 0.5em;
            padding-left: 3em;
            font-size: 1.2em;
        }
        .dialog form strong {
            padding-right: 0.5em;
        }

        .dialog .control {
            padding-top: 16px;
            padding-left: 200px;
        }
    </style>
</head>
<body>
    <div class="main_tab">
        <a href="todo.jsp" class="btn_jump_todo">待办事项</a>
        <table>
            <caption>今日工作</caption>
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
                            <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'up')">先</a></li>
                            <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'down')">后</a></li>
                            <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'done')">完</a></li>
                            <li><a href="javascript:void(0)" onclick="handler_todo_item(this, 'note')">注</a></li>
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
    <div id="add_comment" class="dialog">
        <form class="dialog_form add_comment_form" action="#" method="post">
            <p><strong>认证</strong>微信小程序认证<span>D4</span></p>

            <!-- 计划或者总结 -->
            <div class="form_block thing">
                <label for="plan">计划<input type="radio" name="thing" id="plan"/></label>
                <label for="summary">总结<input type="radio" name="thing" id="summary" checked/></label>
            </div>

            <div class="form_block how">
                <textarea id="what" cols="32" rows="5"></textarea>
            </div>

            <div class="form_block control">
                <button type="submit">保存</button>
                <button type="button">取消</button>
            </div>
        </form>
    </div>

    <script type="text/javascript">
        function add_one_comment() {
            var arrays = document.getElementsByClassName("dialog");
            for (var i=0; i<arrays.length; i++) {
                arrays[i].style.display = "block";
            }
            arrays = document.getElementsByClassName("mask");
            for (var i=0; i<arrays.length; i++) {
                arrays[i].style.display = "block";
            }
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
                    //document.getElementById("hint").style.color = "red";
                    switch (resp) {
                        case "0": //登录成功，3秒跳转首页
                            //document.getElementById("hint").innerHTML = "添加成功";
                            //document.getElementById("hint").style.color = "green";
                            window.setTimeout("window.location='/today.jsp'", 2000);
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