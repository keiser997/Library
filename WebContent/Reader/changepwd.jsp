<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reader.*" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Mandarin-Library</title>
    <link rel="icon" href="../../favicon.ico">

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
            padding-top: 50px;
        }

        /*         li,ul,div{
            border-style: dashed;
        } */
    </style>
</head>
<body>
<%
    	String newpassword = request.getParameter("newpassword");
    	String oldpassword = request.getParameter("oldpassword");
    	String confirmpassword = request.getParameter("confirmpassword");
    	if(newpassword != null){
    		String account = (String)session.getAttribute("account");
    		if(!newpassword.equals(confirmpassword)){
    			out.print("<script>function showMessage1() {alert('The passwords entered are inconsistent');} showMessage1()</script>");
            }
            else if(oldpassword == newpassword){
                out.print("<script>function showMessage2() {alert('The new password cannot be the same as the old one');} showMessage2()</script>");
            }
            else
            {
            	if(reader_imp.changePwd(account, oldpassword,newpassword))
        			out.print("<script>function showMessage3() {alert('Password changed successfully');} showMessage3()</script>");
        		else
        			out.print("<script>function showMessage4() {alert('oldpassword wrong');} showMessage4()</script>");
            }
    	}
    %>
    <script>
                        function change(){
                            var op = document.getElementById("oldpassword")
                            var np = document.getElementById("newpassword")
                            var cp = document.getElementById("confirmpassword")
                            if(np.value != cp.value){
                                alert("The passwords entered are inconsistent")
                            }
                            else if(op.value == np.value){
                                alert("The new password cannot be the same as the old one")
                            }
                            else
                            {
                            	document:form_password.submit()
                                }
                        }
                    </script>
<nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Mandarin-Library</a>
            </div>
            <script>
                function submitzero() {
                    var x = document.getElementById("class");
                    x.value = "0"
                    document:searchform.submit();
                }
                function submitone() {
                	var x = document.getElementById("class");
                    x.value = "1"
                    document:searchform.submit();
                }
                function submittwo() {
                	var x = document.getElementById("class");
                    x.value = "2"
                    document:searchform.submit();
                }
                function submitthree() {
                	var x = document.getElementById("class");
                    x.value = "3"
                    document:searchform.submit();
                }
            </script>
            
            <form method="get" id="searchform" action="booklist.jsp">
            <input type="text" id="class" value = "0" name="class" style="display: none; opacity: 0; width: 1px; height: 1px; float: left;">
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown" style="padding-right: 80px;">
                            <a href="./Welcome.jsp" class="dropdown-toggle" data-toggle="dropdown" role="button"
                                aria-haspopup="true" aria-expanded="false">search <span class="caret"></span></a>
                            <ul class="dropdown-menu">
                                <li><a href="#" onclick="submitzero()">search All</a></li>
                                <li><a href="#" onclick="submitone()">search novel</a></li>
                                <li><a href="#" onclick="submittwo()">search magazine</a></li>
                                <li><a href="#" onclick="submitthree()">search autobiography</a></li>
                            </ul>
                        </li>
                        <li><a href="./../index.jsp?logout=1>">Logout</a></li>
                    </ul>
                    <div class="navbar-form navbar-right">
                        <input type="text" class="form-control" placeholder="Search..." name="search">
                    </div>
                </div>
            </form>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar list">
                <ul class="nav nav-sidebar">
                    <li><a href="./Welcome.jsp">Welcome <span class="sr-only">(current)</span></a></li>
                    <li><a href="./booklist.jsp?class=0&search=">BookList</a></li>
                    <li><a href="myaccount.jsp">My Account</a></li>
                    <li class="active"><a href="changepwd.jsp">Change password</a></li>
                </ul>
            </div>
            <!-- 欢迎代码端 -->
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="main">
                <div class="container" style="padding: 100px 250px;box-shadow: 0 0 5px 0px rgba(50, 50,50,1); border-radius: 15px;">
                    <form class="form-signin" action="changepwd.jsp" id="form_password">
                        <h2 class="form-signin-heading page-header">Change you password</h2>
                        <div class="row">
                            <div class="col-lg-4"><h4>Old password   :</h4></div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                            <label for="inputEmail" class="sr-only">old password</label>
                            <input type="password" id="oldpassword" class="form-control" placeholder="Old password..." name="oldpassword"
                                required autofocus>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4"><h4>New password   :</h4></div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                            <label for="inputEmail" class="sr-only">new password</label>
                            <input type="password" id="newpassword" class="form-control" placeholder="New password..." name="newpassword"
                                required autofocus>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4"><h4>Confirm password   :</h4></div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12">
                            <label for="inputEmail" class="sr-only">confirm password</label>
                            <input type="password" id="confirmpassword" class="form-control" placeholder="Confirm password..." name="confirmpassword"
                                required autofocus>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-12" style="padding: 40px 10px ;">
                                <button class="btn btn-lg btn-primary btn-block">Change Password</button>
                            </div>
                        </div>
                    </form>

                </div> <!-- /container -->
            </div>
        </div>
    </div>
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
    <script>
        window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')
    </script>
    <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="../../assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>