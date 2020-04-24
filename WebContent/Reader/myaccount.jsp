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
    <title>my account</title>
    <!-- Bootstrap core CSS -->
    <link href="../CSS/sb-admin-2.min.css" rel="stylesheet">
    <!-- <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> -->
    <link href="../CSS/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="../../assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../CSS/dashboard.css" rel="stylesheet">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
    <!-- link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> -->
    <!-- Custom styles for this template-->
    <script src="../../assets/js/ie-emulation-modes-warning.js"></script>
    <style>
        body {
            padding-top: 50px;
        }

        /*         li,ul,div{
            border-style: dashed;
        } */
    </style>
</head>
<% 
	String reader_id = (String)session.getAttribute("account");
	double fine = reader_imp.query_fine(reader_id);
	BorrowedBook[] Bobook = reader_imp.Searchforborrow(reader_id);
	BorrowedBook[] Rebook = reader_imp.queryReturnedBook(reader_id);
	int BobookLen=0;
	int RebookLen=0;
	while(Bobook[BobookLen] != null)
		BobookLen++;
	while(Rebook[RebookLen] != null)
		RebookLen++;
	System.out.println(BobookLen);
	System.out.println(RebookLen);
%>
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
                    <li><a href="booklist.jsp?class=0&search=">BookList</a></li>
                    <li class="active"><a href="myaccount.jsp">My Account</a></li>
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
            <!-- sreach代码端 -->
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <div class="container"
                    style="padding: 0px 0px;  box-shadow: 0 0 0px 0px rgba(0, 0,0,1); border-radius: 15px;">
                    <div class="row">
                        <div class="jumbotron" style="padding-top: 30px;">
                            <h2>Chack you account</h2>
                            <p class="lead">Here is your fine and the books you are currently borrowing. If there is any
                                fine, please pay it at the library administrator as soon as possible. Otherwise, we will
                                freeze your account</p>
                            <!--  <p><a class="btn btn-lg btn-success" href="#" role="button">Get started today</a></p> -->
                        </div>
                    </div>
                    <div class="row">
                        <!-- Earnings (Monthly) Card Example -->
                        <div class="col-xl-4 col-md-6 mb-4"
                            style="position: relative; width: 100%; padding-right: .75rem; padding-left: .75rem;">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center" style="margin-right: 0;
                                margin-left: 0; padding: 10px;">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"
                                                style="font-size: 13px;">YOU FINE
                                                (CURRENTLY)</div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"
                                                style="font-size: 20px;">
                                                $<%=fine %></div>
                                        </div>
                                        <div class="col-auto">
                                            <svg class="bi bi-person-fill" width="2em" height="2em" viewBox="0 0 16 16"
                                                style="opacity: 0.5;" fill="currentColor"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd"
                                                    d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-md-6 mb-4"
                            style="position: relative; width: 100%; padding-right: .75rem; padding-left: .75rem;">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center" style="margin-right: 0;
                                margin-left: 0; padding: 10px;">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"
                                                style="font-size: 13px;">THE NUMBER OF YOU BORROWED BOOK
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"
                                                style="font-size: 20px;">
                                                NUM: <%=BobookLen %></div>
                                        </div>
                                        <div class="col-auto">
                                            <svg class="bi bi-book" width="2em" height="2em" viewBox="0 0 16 16"
                                                style="opacity: 0.5;" fill="currentColor"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd"
                                                    d="M3.214 1.072C4.813.752 6.916.71 8.354 2.146A.5.5 0 0 1 8.5 2.5v11a.5.5 0 0 1-.854.354c-.843-.844-2.115-1.059-3.47-.92-1.344.14-2.66.617-3.452 1.013A.5.5 0 0 1 0 13.5v-11a.5.5 0 0 1 .276-.447L.5 2.5l-.224-.447.002-.001.004-.002.013-.006a5.017 5.017 0 0 1 .22-.103 12.958 12.958 0 0 1 2.7-.869zM1 2.82v9.908c.846-.343 1.944-.672 3.074-.788 1.143-.118 2.387-.023 3.426.56V2.718c-1.063-.929-2.631-.956-4.09-.664A11.958 11.958 0 0 0 1 2.82z"
                                                    clip-rule="evenodd" />
                                                <path fill-rule="evenodd"
                                                    d="M12.786 1.072C11.188.752 9.084.71 7.646 2.146A.5.5 0 0 0 7.5 2.5v11a.5.5 0 0 0 .854.354c.843-.844 2.115-1.059 3.47-.92 1.344.14 2.66.617 3.452 1.013A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.276-.447L15.5 2.5l.224-.447-.002-.001-.004-.002-.013-.006-.047-.023a12.582 12.582 0 0 0-.799-.34 12.96 12.96 0 0 0-2.073-.609zM15 2.82v9.908c-.846-.343-1.944-.672-3.074-.788-1.143-.118-2.387-.023-3.426.56V2.718c1.063-.929 2.631-.956 4.09-.664A11.956 11.956 0 0 1 15 2.82z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-4 col-md-6 mb-4"
                            style="position: relative; width: 100%; padding-right: .75rem; padding-left: .75rem;">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center" style="margin-right: 0;
                                margin-left: 0; padding: 10px;">
                                        <div class="col mr-2">
                                            <div class="text-xs font-weight-bold text-primary text-uppercase mb-1"
                                                style="font-size: 13px;">THE NUMBER OF YOU RETURNED BOOK
                                            </div>
                                            <div class="h5 mb-0 font-weight-bold text-gray-800"
                                                style="font-size: 20px;">
                                                NUM: <%=RebookLen %></div>
                                        </div>
                                        <div class="col-auto">
                                            <svg class="bi bi-book" width="2em" height="2em" viewBox="0 0 16 16"
                                                style="opacity: 0.5;" fill="currentColor"
                                                xmlns="http://www.w3.org/2000/svg">
                                                <path fill-rule="evenodd"
                                                    d="M3.214 1.072C4.813.752 6.916.71 8.354 2.146A.5.5 0 0 1 8.5 2.5v11a.5.5 0 0 1-.854.354c-.843-.844-2.115-1.059-3.47-.92-1.344.14-2.66.617-3.452 1.013A.5.5 0 0 1 0 13.5v-11a.5.5 0 0 1 .276-.447L.5 2.5l-.224-.447.002-.001.004-.002.013-.006a5.017 5.017 0 0 1 .22-.103 12.958 12.958 0 0 1 2.7-.869zM1 2.82v9.908c.846-.343 1.944-.672 3.074-.788 1.143-.118 2.387-.023 3.426.56V2.718c-1.063-.929-2.631-.956-4.09-.664A11.958 11.958 0 0 0 1 2.82z"
                                                    clip-rule="evenodd" />
                                                <path fill-rule="evenodd"
                                                    d="M12.786 1.072C11.188.752 9.084.71 7.646 2.146A.5.5 0 0 0 7.5 2.5v11a.5.5 0 0 0 .854.354c.843-.844 2.115-1.059 3.47-.92 1.344.14 2.66.617 3.452 1.013A.5.5 0 0 0 16 13.5v-11a.5.5 0 0 0-.276-.447L15.5 2.5l.224-.447-.002-.001-.004-.002-.013-.006-.047-.023a12.582 12.582 0 0 0-.799-.34 12.96 12.96 0 0 0-2.073-.609zM15 2.82v9.908c-.846-.343-1.944-.672-3.074-.788-1.143-.118-2.387-.023-3.426.56V2.718c1.063-.929 2.631-.956 4.09-.664A11.956 11.956 0 0 1 15 2.82z"
                                                    clip-rule="evenodd" />
                                            </svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="col-lg-6" style="padding: 5px 5px; height: 400px;">
                            <div class="card shadow h-100 py-2 border-left-primary">
                                <div class="card-body">
                                    <h4 class="sub-header ">Here is the list of books</h4>
                                    <form action="#">
                                        <input type="hidden" name="bookid">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Book Name</th>
                                                        <th>Deadline</th>
                                                        <th>Fine</th>
                                                    </tr>
                                                </thead>
                                                <%
                                                	out.print("<tbody>");
	                                                int count = 1;
	                        						if(Bobook !=null){
	                        							out.print("<tbody>");
	                        							for(BorrowedBook B :Bobook){
	                        								if(B == null)
	                        									break;
	                        								
	                        								count++;
	                        								if(count%2 == 0)
	                        									out.print("<tr style='background-color: #f5f5f5;'>");
	                        								else
	                        									out.print("<tr>");
	                        										out.print("<td>"+B.book_id+"</td>");
	                        										out.print("<td>"+B.book_name+"</td>");
	                        										out.print("<td>"+B.deadline+"</td>");
	                        										out.print("<td>"+B.fine_amount+"</td>");
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
                        <div class="col-lg-6" style="padding: 5px 5px; height: 400px;">
                            <div class="card shadow h-100 py-2 border-left-primary" style="padding-top:0px;">
                                <div class="card-body">
                                    <h4 class="sub-header">Here is the list of books</h4>
                                    <div class="table-responsive">
                                        <table class="table table-striped  table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Book Name</th>
                                                    <th>Fine</th>
                                                    <th>Condition</th>
                                                </tr>
                                            </thead>
                                            <%
                                                	out.print("<tbody>");
	                                                count = 1;
	                        						if(Rebook !=null){
	                        							out.print("<tbody>");
	                        							for(BorrowedBook B :Rebook){
	                        								if(B == null)
	                        									break;
	                        								
	                        								count++;
	                        								if(count%2 == 0)
	                        									out.print("<tr style='background-color: #f5f5f5;'>");
	                        								else
	                        									out.print("<tr>");
	                        										out.print("<td>"+B.book_id+"</td>");
	                        										out.print("<td>"+B.book_name+"</td>");
	                        										out.print("<td>"+B.fine_amount+"</td>");
	                        										out.print("<td>"+((B.date != null)?B.date:"unpaid")+"</td>");
	                        									out.print("</tr>");

	                        							}
	                        						out.print("</tbody>");	
	                        						}
                                                %>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
   </div>
        <!-- Bootstrap core JavaScript
    ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
        <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
        <script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
        <script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>

</html>