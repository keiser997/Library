<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./bootstrap-3.3.7-dist/css/bootstrap.css">
    <link rel="stylesheet" href="./bootstrap-3.3.7-dist/css/bootstrap-theme.css">
    
    <script src="../jquery-3.4.1.min.js"></script>
    <script src="../bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <style>
    	* {
   			 padding: 0;
   			 margin: 0;
			}

		html {
    		height: 100%;
		}
        .login-left{
            width: 56%;
            height: 912px;
            background-color: rgb(79,87,97);
            margin-left: -15px;
            margin-top: -10px;            
            float: left;
        }
        .login-right{
            width: 34%;
            height: 912px;
            background-color: white;;
            float: right;
            margin-top: -10px;
        }
        .welcome{
            color: white;
            margin-left: 30%;
            margin-top: 56%;
            font-size: 60px;

        }
        .intro{
            color: white;
            margin-left: 30%;
        }
        .form-horizontal{
            margin-top: 70%;
            margin-left: -20%;
        }
        .btn-block{
            margin-left: 50%;
            background-color: rgb(79,87,97);
        }
        .sign-in{
            color: white;
        }
        .info{
            color:  rgb(79,87,97);
            font-size: 40px;
            margin-left: 30%;
        }
        .checkbox{
            float: left;
            margin-left: -15%;
            margin-right: 25%;
        }
        .forgetpassword{
            font-size: 18px;
            color: rgb(79,87,97);
        }
        .option{
            margin-left: 20%;
        }
        .optionx{
            margin-right: 16%;
        }
        body{
            /* overflow: hidden; */
            height: 100%;
        }
    </style>

</head>
<body>
    <div class="container-fluid">
        <div class="login">
            <!-- 登录界面左边 -->
            <div class="login-left">
                <div class="word">
                    <div class="welcome">
                        <p><strong>Welcome to</strong></p>
                    </div>
                    <div class="intro">
                        <h2>use Mandarin Online Library System!</h2>
                    </div>
                </div>

            </div>
            <!-- 登录界面右边 -->
            <form action="check.jsp">
	            <div class="login-right">
	                <div class="form-horizontal">
	                    <div class="info">
	                        <p>
	                            <img src="./assets/images/LOGO.jpg" alt="">
	                        </p>
	                    </div>
	                    <div class="head-of-login">
	                    </div>
	                    <div class="form-group">
	                        <label for="inputEmail3" class="col-sm-2 control-label sr-only" >Account</label>
	                        <div class="col-sm-8">
	                            <input type="Account" class="form-control input-lg" id="account" name="account" placeholder="Account">
	                        </div>
	                    </div>
	                    <div class="form-group">
	                        <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
	                        <div class="col-sm-8">
	                            <input type="password" class="form-control input-lg" id="password" name="password"
	                                placeholder="Password">
	                        </div>
	                        <br><br><br>
	                        <!-- 选项 -->
	                        <div class="option">
	                            <label class="optionx">
	                                <input type="radio" name="role" id="id1" class="a-radio" value="1">
	                                <span class="b-radio"></span>Reader
	                            </label>
	                            <label class="optionx">
	                                <input type="radio" name="role" id="2" class="a-radio" value="2">
	                                <span class="b-radio"></span>Librarian
	                            </label>
	                            <label class="optionx">
	                                <input type="radio" name="role" id="3" class="a-radio" value="3">
	                                <span class="b-radio"></span>Admin
	                            </label>
	                            <div>
	                            </div>
	                            <div class="form-group">
	                                <div class="col-sm-offset-2 col-sm-12">
	                                    <div class="checkbox">
	                                        <label>
	                                            <input type="checkbox"><strong>Remember me</strong>
	                                        </label>
	                                    </div>
	                                    <div>
	                                        <a href="javascript:">
	                                            <p class="forgetpassword"><strong>forget password?</strong></p>
	                                        </a>
	                                    </div>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <div class="col-sm-offset-2 col-sm-3">
	                                    <button type="submit" class="btn btn-lg btn-block">
	                                        <div class="sign-in">sign in</div>
	                                    </button>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	            </div>
            </form>
        </div>
    </div>
    <%
    	String err = request.getParameter("errorcode");//获取登陆失败后check.jsp返回的错误码,进行报错
    	if(err != null){
	    	if(err.equals("1"))
	    		out.print("<script>function err1() {alert('The account number and password cannot be empty！！');} err1()</script>");
	    	else if(err.equals("2"))
	    		out.print("<script>function err2() {alert('The login role was not selected！！');} err2()</script>");
	    	else if(err.equals("3"))
	    		out.print("<script>function err3() {alert('Account has been frozen！！');} err3()</script>");
	    	else if(err.equals("4"))
	    		out.print("<script>function err4() {alert('Account does not exist！！');} err4()</script>");
	    	else if(err.equals("5"))
	    		out.print("<script>function err5() {alert('unknown error！！');} err5()</script>");
	    	else if(err.equals("6"))
	    		out.print("<script>function err6() {"
	    			+"alert('You have logged in the browser, please log out the original account, if the original page has closed, please restart the browser！！');} err6()</script>");
    	}
    %>
</body>
</html>