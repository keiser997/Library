<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reader.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
	//该文件用于获取登录页传来的登录信息，根据登录信息和角色进行登录操作，
	//如果登陆成功则进入相应界面如果失败则返回登陆页面并返回错误码
		//请求数据
		String account = request.getParameter("account");//账号名
		String password = request.getParameter("password");//密码
		String role = request.getParameter("role");//角色
		//定义错误码类型
		String errorcode = null;
		 //账号密码为空时，错误码为1。未选择角色，错误码为2
		if((account == null)||(password == null))
			errorcode = "1";
		else if(role == null)
			errorcode = "2";
		else {
			//判断是否已经有用户在该浏览器登录，如果有，提醒他在原来的账号上登出，或者重启。
			if(session.getAttribute("account") == null) {
				if(role.equals("1")){//代表读者登录
					String info = reader_imp.logIn(account, password);//调用读者登录函数
					if(info == "LOGIN SUCCESSFULLY"||info == "ALREADY ONLINE"){
						response.sendRedirect("Reader/Welcome.jsp");
						session.setAttribute("account", account);//在会话中获取账户名
					}
					else if(info =="BLOCKED ACCOUNT")
						errorcode = "3";//账户已冻结
					else
						errorcode = "4";//账号不存在
				}
				else if(role.equals("2")){//图书管理员登录
					
				}
				else if(role.equals("3")){//超级管理员登录
					
				}
				else
					errorcode = "5";//未知错误
			}
			else
				errorcode = "6";//同一浏览器同时登录
		}
		if(errorcode != null)//登陆失败，返回错误码
			response.sendRedirect("login.jsp?errorcode="+errorcode);
	%>
</body>
</html>