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
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar list">
                <ul class="nav nav-sidebar">
                    <li class="active"><a href="booklist.jsp?class=0&search=">BookList</a></li>
                </ul>
               <!--  <ul class="nav nav-sidebar .nav-stacked">
                    <li><a href="">Nav item</a></li>
                    <li><a href="">Nav item again</a></li>
                    <li><a href="">One more nav</a></li>
                    <li><a href="">Another nav item</a></li>
                    <li><a href="">More navigation</a></li>
                </ul>
                <ul class="nav nav-sidebar .nav-stacked">
                    <li><a href="">Nav item again</a></li>
                    <li><a href="">One more nav</a></li> 
                    <li><a href="">Another nav item</a></li>
                </ul> -->
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
            <!-- search代码端 -->
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

                <h2 class="sub-header">Here is the list of books</h2>
                <form action="booklist.jsp" id="reserve">
                	<input type="hidden" name="search" value="">
                	<input type="hidden" name="class" value="0">
                    <input type="hidden" name="bookid" id="bookid">
                    <input type="hidden" name="barcodeid" id="barcodeid">
                <div class="table-responsive">
                    <table class="table  table-bordered table-responsive">
                        <thead>
                            <tr>
                                <th>ID  </th>
                                <th>Name</th>
                                <th>Author</th>
                                <th>Been Borrowed</th>
                                <th>Book Type</th>                             
                            </tr>
                        </thead>
                        <%
                        String book_information = request.getParameter("search");
           				String barcode_id = request.getParameter("barcodeid");
                        if(book_information == null)
                        	book_information = "";
                        else
                        	System.out.println("检索"+book_information);
                		Book[] books = reader_imp.searchBook(book_information,0);
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