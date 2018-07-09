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
        <a href="#" onclick="todo.html" class="btn_jump_todo">待办事项</a>
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
            <tr>
                <td>
                    <dl>
                        <strong>新型号</strong>
                        <dt>制作固件WAP5-200W和AP4301-CW<span>D2</span><a href="#">详</a></dt>
                        <dd>新的硬件是福瑞联提供的，硬件形态是双屏入墙AP，芯片是9531（2x2）+9887(1x1)；WAP5-200W是智开渠道固件，AP4301-CW是齐邦微桥固件</dd>
                    </dl>
                </td>
                <td>
                    <ul>
                        <li><a href="#">先</a></li>
                        <li><a href="#">后</a></li>
                        <li><a href="#">完</a></li>
                        <li><a href="#">注</a></li>
                    </ul>
                </td>
            </tr>
            <tr>
                <td>
                    <dl>
                        <strong>认证</strong>
                        <dt>微信小程序认证<span>D4</span><a href="#">详</a></dt>
                        <dd>微信小程序通过websocket跟AP进行信息交换，AP开启一个wss，小程序连接AP的wss后，将用户手机发给AP，AP将手机上传平台查询，平台决定是否放行，AP根据平台返回的是否放行结果来决定AP是否开网。AP中的实现由wifidog完成。</dd>
                    </dl>
                </td>
                <td>
                    <ul>
                        <li><a href="#">先</a></li>
                        <li><a href="#">后</a></li>
                        <li><a href="#">完</a></li>
                        <li><a href="#" onclick="add_one_comment()">注</a></li>
                    </ul>
                </td>
            </tr>
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
    </script>
</body>
</html>