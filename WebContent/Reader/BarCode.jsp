<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reader.*" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Mandarin-Library</title>
    <link rel="icon" href="../../favicon.ico">
	<script src="../JS/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.bootcss.com/jsbarcode/3.8.0/JsBarcode.all.min.js"></script>
    <title>Dashboard Template for Bootstrap</title>
    <!-- Bootstrap core CSS -->
    <link href="../CSS/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../CSS/dashboard.css" rel="stylesheet">
    <!--     <link rel="stylesheet" href="./../../bootstrap/cover.css"> -->

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
        body {
        	height: 100%;
            width: 100%;
        }
		*{
			padding: 0;
			margin:0;
		}
        /*         li,ul,div{
            border-style: dashed;
        } */
        div{
        	height: 50%;
            width: 75%;
            margin: auto auto;
        }
        h1,p{
        	text-align: center;
        }
    </style>
</head>
<body>
	<%
		reader_imp re = new reader_imp();
		String barcode_id = request.getParameter("barcodeid");
		out.print("<script>"
				+"$(function(){"
				    +"$('#ma').JsBarcode("+barcode_id+", {"
				        +"width:2,"// 设置条之间的宽度
				        +"height:50,"// 高度
				       // displayValue:true, // 是否在条形码上下方显示文字
				       // fontOptions:"bold italic", // 使文字加粗体或变斜体
				       // font:"fantasy", // 设置文本的字体
				       // textAlign:"left", // 设置文本的水平对齐方式
				       // textPosition:"top", // 设置文本的垂直位置
				       // textMargin:5, // 设置条形码和文本之间的间距
				       // fontSize:15, // 设置文本的大小
				       // background:"#eee", // 设置条形码的背景
				       // lineColor:"#2196f3", // 设置条和文本的颜色。
				       // margin:15 // 设置条形码周围的空白边距
				   +"});"
				+"});"
			+"</script>);");
	%>
	<div class="jumbotron">
        <h1>Bar Code</h1>
        <p><img alt="BarCode" id="ma"/></p>
        <p>
          <a class="btn btn-lg btn-primary" href="booklist.jsp?class=0&search=" role="button">back</a>
        </p>
    </div>
</body>
</html>