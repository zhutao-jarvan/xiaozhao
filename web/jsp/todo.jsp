<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>待办事项</title>
    <link href="/res/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/res/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="/res/css/main.css" rel="stylesheet">
    <style type="text/css">
        .myDesc {
            font-weight: normal;
            display: none;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">小昭</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li class="active"><a href="#">待办事项<span class="sr-only">(current)</span></a></li>
                    <li><a href="#">今日工作</a></li>
                    <li><a href="#">全部工作</a></li>
                    <li><a href="#">完成事项</a></li>
                    <li><a href="#">删除事项</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">退出</a></li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">祝涛 <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="#">编辑信息</a></li>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

    <div class="main">
        <div class="row" style="padding-top: 20px">
            <div class="col-md-4">
                <span class="item_number">每页条数</span><select class="btn btn-default dropdown-toggle">
                    <option value="10">10</option>
                    <option value="15">15</option>
                    <option value="20">20</option>
                    <option value="25">25</option>
                    <option value="30">30</option>
                </select>
            </div>
            <div class="col-md-6">
                <form class="navbar-form navbar-right">
                    <select class="btn btn-default dropdown-toggle">
                        <option value="all">全部</option>
                        <option value="title">标题</option>
                        <option value="content">正文</option>
                    </select>
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="搜索关键字">
                    </div>
                    <button type="submit" class="btn btn-default">搜索</button>
                </form>
            </div>
            <div class="col-md-2">
                <!-- button 中必须的字段 data-toggle="modal" data-target="#mymodal-data" -->
                <button class="btn btn-default" data-toggle="modal" data-target="#mymodal-data" type="button"><span class="glyphicon glyphicon-plus"></span></button>
            </div>
        </div>
        <!-- 模态弹出窗内容 -->
        <div class="modal" id="mymodal-data" tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">待办事项</h4>
                    </div>
                    <form  id="form1" method="post" action="##" onsubmit="return false">
                        <input id="post_todo_id" name="post_todo_id" type="text" value="" style="display: none;"/>
                        <div class="modal-body">
                            <div class="input-group">
                                <span class="input-group-addon" id="basic-addon1">项目</span>
                                <input type="text" name="myObject" class="form-control myObject" aria-describedby="basic-addon1">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon" id="basic-addon2">概述</span>
                                <input type="text" name="mySummary" class="form-control mySummary" aria-describedby="basic-addon2">
                            </div>
                            <textarea placeholder="详细描述项目细节" name="myDesc" class="form-control todo-desc myDetail" rows="8" style="min-width: 90%"></textarea>
                            <div class="todo-date">
                                <!--input placeholder="处理日期及时间，可不填" type="text" id="datetimepicker"-->
                                <input placeholder="处理日期及时间，可不填" id="datetimepicker" name="date" type="date" min="2018-09-05">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="submit" onclick="post_form()" class="btn btn-primary">保存</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <table class="table table-bordered">
            <thead>
            <tr>
                <th style="width: 10%">序号</th>
                <th style="width: 15%">状态</th>
                <th style="width: 60%">待办事项</th>
                <th style="width: 15%">操作</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <nav aria-label="...">
            <ul class="pager">
                <li><a href="#">上一页</a></li>
                <li><a href="#">下一页</a></li>
            </ul>
        </nav>
    </div>

    <script type="text/javascript" src="/res/jquery/jquery-1.8.3.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="/res/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/res/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
    <script type="text/javascript" src="/res/bootstrap/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script type="text/javascript">
        var g_tb_obj = null;

        function showTodo(json) {
            $("tbody").empty("");
            var tb_obj = eval(json);
            g_tb_obj = tb_obj;
            $.each(tb_obj, function (i) {
                var domStr = "";
                if (tb_obj[i].status == 1) {
                    domStr = "<tr class=\"danger\">\n"
                    var id = i + 1;
                    domStr += "<td>" + id + "</td>\n";
                    domStr += "<td>处理中</td>\n";
                    domStr += "<td class='tdTodo'><div class=\"myKey\">" + tb_obj[i].key + "</div>\n<div class=\"myTodo\">\n<p>" + tb_obj[i].todo + "</p>\n<p class=\"myDesc\">" + tb_obj[i].desc + "</p>\n</div>\n</td>\n";
                    domStr += "<td>\n" +
                        "                    <a href=\"#\" onclick=\"todo_method('later', $(this));return false;\"><span class=\"glyphicon glyphicon-star-empty\"></span></a>\n" +
                        "                    <a href=\"#\"  onclick=\"todo_method('delete', $(this));return false;\"><span class=\"glyphicon glyphicon-trash\"></span></a>\n" +
                        "                    <a href=\"#\" class=\"edit_todo\" data-toggle=\"modal\" data-target=\"#mymodal-data\" data-id='edit_todo'><span class=\"glyphicon glyphicon-pencil\"></span></a>\n" +
                        "                    <a href=\"#\"  onclick=\"todo_method('done', $(this));return false;\"><span class=\"glyphicon glyphicon-ok\"></span></a>\n" +
                        "                </td>";
                } else {
                    domStr = "<tr>\n"
                    var id = i + 1;
                    domStr += "<td>" + id + "</td>\n";
                    domStr += "<td>排队中</td>\n";
                    domStr += "<td class='tdTodo'><div class=\"myKey\">" + tb_obj[i].key + "</div>\n<div class=\"myTodo\">\n<p>" + tb_obj[i].todo + "</p>\n<p class=\"myDesc\">" + tb_obj[i].desc + "</p>\n</div>\n</td>\n";
                    domStr += "<td>\n" +
                        "                    <a href=\"#\" onclick=\"todo_method('immediately', $(this));return false;\"><span class=\"glyphicon glyphicon-star\"></span></a>\n" +
                        "                    <a href=\"#\" onclick=\"todo_method('delete', $(this));return false;\"><span class=\"glyphicon glyphicon-trash\"></span></a>\n" +
                        "                    <a href=\"#\" data-toggle=\"modal\" data-target=\"#mymodal-data\" data-id='edit_todo'><span class=\"glyphicon glyphicon-pencil\"></span></a>\n" +
                        "                </td>\n" +
                        "            </tr>";
                }

                //console.log(domStr);
                $("tbody").append(domStr);
                $(".pager li:first").addClass("disabled");
                $(".pager li:last").addClass("disabled");
            });
        }

        function errFunction() {
            alert("AJAX加载失败!");
        }

        function syncTodo() {
            $.ajax(
                {
                    url: 'todo.json',
                    type: 'GET',
                    dateType: 'json',
                    timeout: 1000,
                    cache: true,
                    error: errFunction,
                    success: showTodo
                }
            );
        }
        
        function reShowTodo(json) {
            showTodo(json);
            $("#mymodal-data").modal('hide');
        }

        function gen_todo_json(action, todoId, key, todo, desc, doTime) {
            var json = {
                "action": action,
                "todoId": todoId,
                "key": key,
                "todo": todo,
                "desc": desc,
                "toTime": doTime
            };

            return json;
        }

        function todo_method_done(json) {
            showTodo(json);
        }

        function todo_method(action, aThis) {
            var tb_obj = g_tb_obj;
            var rootItem = $(aThis).parent().parent();
            var id = $(rootItem).children("td:first").text();
            console.log(tb_obj[id-1].key);
            console.log(tb_obj[id-1].todo);
            console.log(tb_obj[id-1].desc);

            $.ajax({
                async: false,
                url: 'handler_todo.json',
                type: 'POST',
                dateType: 'json',
                contentType: "application/json; charset=utf-8",
                timeout: 2000,
                cache: false,
                data:JSON.stringify(gen_todo_json(action, tb_obj[id-1].todoId, tb_obj[id-1].key, tb_obj[id-1].todo, tb_obj[id-1].desc, tb_obj[id-1].doTime)),
                error: errFunction,
                success: todo_method_done
            });
        }

        function post_form() {
            $.ajax({
                async: false,
                url: 'post_todo.json',
                type: 'POST',
                dateType: 'json',
                timeout: 2000,
                cache: false,
                data:$("#form1").serialize(),
                error: errFunction,
                success: reShowTodo
            });
        }

        $(document).ready(function () {
            syncTodo();
        });


        $("#mymodal-data").on('show.bs.modal', function (event) {
            var tb_obj = g_tb_obj;
            var btnThis = $(event.relatedTarget); //触发事件的按钮
            var modal = $(this);  //当前模态框

            if (btnThis.data("id") == "edit_todo") {
                var rootItem = $(btnThis).parent().parent();
                var id = $(rootItem).children("td:first").text();
                $("#post_todo_id").val(id);
                modal.find(".myObject").val(tb_obj[id-1].key);
                modal.find(".mySummary").val(tb_obj[id-1].todo);
                modal.find(".myDetail").val(tb_obj[id-1].desc);
                modal.find("#datetimepicker").val(tb_obj[id-1].doTime);
            } else {
                $("#post_todo_id").val("");
                modal.find(".myObject").val("");
                modal.find(".mySummary").val("");
                modal.find(".myDetail").val("");
                modal.find("#datetimepicker").val("");
            }
        });

        $("tbody").on('mouseenter', ".tdTodo", function () {
            $(this).find(".myDesc").fadeIn(500);
        });
        $("tbody").on('mouseleave', ".tdTodo", function () {
            $(this).find(".myDesc").fadeOut(500);
        });
    </script>
</body>
</html>
