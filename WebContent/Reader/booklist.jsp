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

    <title>Dashboard Template for Bootstrap</title>
    <!-- Bootstrap core CSS -->
    <link href="./../CSS/bootstrap.min.css" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="./../CSS/dashboard.css" rel="stylesheet">
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
                    <li class="active"><a href="booklist.jsp?class=0&search=">BookList</a></li>
                    <li><a href="myaccount.jsp">My Account</a></li>
                    <li><a href="changepwd.jsp">Change password</a></li>
                </ul>
            </div>
            <script type="text/javascript">
                function reserve(btn) {
                    //获取当前单元格的值
                    var r = confirm("Would you like to make an appointment for 《" + btn.parentNode.parentNode.cells[1].innerHTML + "》")
                    if (r == true) {
                        var value = btn.tagName;
                        var x = document.getElementById("bookid");
                        x.value = btn.parentNode.parentNode.cells[0].innerHTML;
                        var y = document.getElementById("barcodeid");
                        y.value = null;
                        document: reserve.submit();
                    }
                    else {
                    	var value = btn.tagName;
                        var x = document.getElementById("bookid");
                        x.value = "null";
                        var y = document.getElementById("barcodeid");
                        y.value = null;
                        document: reserve.submit();
                    }
                    
                }
            </script>
            <script type="text/javascript">
                function look_over(btn) {
                    //获取当前单元格的值
                    var value = btn.tagName;
                    var z = document.getElementById("reserve");
                    z.action="BarCode.jsp"
                    var x = document.getElementById("barcodeid");
                    x.value = btn.parentNode.parentNode.cells[0].innerHTML;
                    var y = document.getElementById("bookid");
                    y.value = null;
                    document: reserve.submit();
                }
            </script>
            <!-- search代码端 -->
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h2 class="sub-header">Here is the list of books</h2>
                <form action="booklist.jsp" id="reserve">
                	<input type="hidden" name="search" value="">
                	<input type="hidden" name="class" value="0">
                    <input type="hidden" name="bookid" id="bookid">
                    <input type="hidden" name="barcodeid" id="barcodeid">
                <div class="table-responsive">
                    <table class="table table-bordered  table-responsive">
                        <thead>
                            <tr>
                                <th>ID  </th>
                                <th>Book Name</th>
                                <th>Author</th>
                                <th>Been Borrowed</th>
                                <th>Book Type</th>
                                <th>Bar Code</th>                                
                                <th>Appointment</th>
                            </tr>
                        </thead>
                        <%
                        String book_information = request.getParameter("search");
                        String book_class = request.getParameter("class");
                        String barcode_id = request.getParameter("barcodeid");
                        String book_id = request.getParameter("bookid");                     
                        if(book_id != null){
                        	if(!book_id.equals("null")) {
	                        	String account = (String)session.getAttribute("account");
	                        	if(reader_imp.appointment(book_id,account))
	                        		out.print("<script>function showMessage1() {alert('reserve successful');} showMessage1()</script>");
	                        	else
	                        		out.print("<script>function showMessage2() {alert('The book is on reserve!!');} showMessage2()</script>");
	                        }
                        }
                        if(book_information == null)
                        	book_information = "";
                        else
                        	System.out.println("检索"+book_information);
                        System.out.print("class="+book_class);
                		Book[] books = reader_imp.searchBook(book_information, Integer.valueOf(book_class));
						int count = 1;
						if(books !=null){
							out.print("<tbody>");
							for(Book B :books){
								if(B == null)
									break;
								count++;
								if(count%2 == 0)
									out.print("<tr style='background-color: #f5f5f5;'>");
								else
									out.print("<tr>");
										out.print("<td>"+B.id+"</td>");
										out.print("<td>"+B.name+"</td>");
										out.print("<td>"+B.author+"</td>");
										out.print("<td>"+((B.borw == 1)?"yes":"no")+"</td>");
										out.print("<td>"+reader_imp.booktype(B.bookType)+"</td>");
										out.print("<td><button class='btn btn-default' onclick='look_over(this)'>look over</button></td>");
										out.print("<td><button class='btn btn-default' onclick='reserve(this)'>reserve</button></td>");
									out.print("</tr>");
							}
							out.print("</tbody>");
						}
						%>
                    </table>
                </div>
        		</form>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="../JS/jquery.min.js"></script>
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