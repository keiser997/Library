<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reader.*" %>
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <style>
        #LOGO{
            max-width: 150px;
        }
        .search{
            width: 60%;            
            margin: 100px auto;
            margin-top: -5%;
            display: flex;
            /*border: 1px solid red;*/
        }
        .search input{
            float: left;
            flex: 4;
            height: 40px;
            outline: none;
            border: 1px solid rgb(79,87,97);
            /* box-sizing: border-box;//盒子模型，怪异IE盒子模型，width=content+border*2+padding*2 */
            border-radius: 10px 0px 0px 10px;
            padding-left: 10px;
        }
        .search button{
            float: right;
            flex: 1;
            height: 40px;
            background-color:rgb(79,87,97);
            color: white;
            border-radius: 0px 10px 10px 0px;
            outline: none;
        }
        .search button i{
            font-style: normal;
        }
        .search button:hover{
            font-size: 16px;
        }
        .section{
            max-width: 100%;
        }
    </style>

    <title>Training Studio - Free CSS Template</title>
<!--

TemplateMo 548 Training Studio

https://templatemo.com/tm-548-training-studio

-->
    <!-- Additional CSS Files -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.min.css">

    <link rel="stylesheet" type="text/css" href="assets/css/font-awesome.css">

    <link rel="stylesheet" href="assets/css/templatemo-training-studio.css">

    </head>
    
    <body>
    <%
    	//判断是否是因为登出而回到首页的
    	String logout = request.getParameter("logout");
    	if(logout != null){//如果是因为登出回到当前页面的
    		String account = (String)session.getAttribute("account");//获取当前登录账号
    		//输出弹窗告知用户当前账号已经登出
    		reader_imp.logOut(account);
    		out.print("<script>function message() {alert('user "+account+" has logout');} message()</script>");
    		session.removeAttribute("account");//把账号信息从当前会话中删除
    	}
    %>   
    <!-- ***** Header Area Start ***** -->
    <header class="header-area header-sticky">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <nav class="main-nav">
                        <!-- ***** Logo Start ***** -->
                        <a href="index.jsp" class="logo"><img src="./assets/images/LOGO.jpg" alt="" id="LOGO"></a>
                        <!-- ***** Logo End ***** -->
                        <!-- ***** Menu Start ***** -->
                        <ul class="nav">
                            <li class="scroll-to-section"><a href="#top" class="active">Home</a></li>
                            <li class="scroll-to-section"><a href="#search">SEARCH</a></li>
                            <li class="scroll-to-section"><a href="#post">POST</a></li>
                            <!-- <li class="scroll-to-section"><a href="#schedule">Schedules</a></li>
                            <li class="scroll-to-section"><a href="#contact-us">Contact</a></li>  -->
                            <li class="main-button"><a href="login.jsp">Sign Up</a></li>
                        </ul>        
                        <a class='menu-trigger'>
                            <span>Menu</span>
                        </a>
                        <!-- ***** Menu End ***** -->
                    </nav>
                </div>
            </div>
        </div>
    </header>
    <!-- ***** Header Area End ***** -->

    <!-- ***** Main Banner Area Start ***** -->
    <div class="main-banner" id="top">
        <video autoplay muted loop id="bg-video">
        </video>

        <div class="video-overlay header-text">
            <div class="caption">
                <h6>keep hungry, keep foolish</h6>
                <h2>join in <em>Mandarin</em></h2>
                <div class="main-button scroll-to-section">
                    <a href="#features">Become a member</a>
                </div>
            </div>
        </div>
    </div>
    <!-- ***** Main Banner Area End ***** -->

    <!-- ***** Features Item Start ***** -->
    <section class="section" id="search">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="section-heading">
                        <h2>Search for <em>BooK</em></h2>
                        <img src="assets/images/line-dec.png" alt="waves">
                        <p>If you want to search more books or rent book what you want , just join us ! We can offer any book you want!</p>
                    </div>
                </div>
                <div class="col-lg-12">
                    <form action="Reader/littlebooklist.jsp">
                        <div class="search">
                            <input type="text" placeholder=" type the keyword..." name="search" id="" value="" />
                            <button onclick="document:searchfrom.submit()"><i>SEARCH</i></button>
                        </div>
                    </form>
                </div>
                <!-- 加一些行数 -->
                <br><br><br><br>
                <br><br><br><br>
                <br><br><br><br>
                <br><br><br><br>
                <br><br><br><br>
            </div>
        </div>
    </section>
    <!-- ***** Features Item End ***** -->

    <!-- ***** Call to Action Start ***** -->
    <!-- <section class="section" id="call-to-action">
        <div class="container">
            <div class="row">
                <div class="col-lg-10 offset-lg-1">
                    <div class="cta-content">
                        <h2>Don’t <em>think</em>, begin <em>today</em>!</h2>
                        <p>Ut consectetur, metus sit amet aliquet placerat, enim est ultricies ligula, sit amet dapibus odio augue eget libero. Morbi tempus mauris a nisi luctus imperdiet.</p>
                        <div class="main-button scroll-to-section">
                            <a href="#our-classes">Become a member</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section> -->
    <!-- ***** Call to Action End ***** -->

    <!-- ***** Our Classes Start ***** -->
    <section class="section" id="post">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 offset-lg-3">
                    <div class="section-heading">
                        <h2>Latest <em>Post</em></h2>
                        <img src="assets/images/line-dec.png" alt="">
                        <p>You can see the newest post! Every policy we post may improve Book Borrowing Experience!</p>
                    </div>
                </div>
            </div>
            <div class="row" id="tabs">
              <div class="col-lg-4">
                <ul>
                  <li><a href='#tabs-1'><img src="./assets/images/section.jpg" alt="" class="section">First Post</a></li>
                  <li><a href='#tabs-2'><img src="./assets/images/section.jpg" alt="">Second Post</a></a></li>
                  <li><a href='#tabs-3'><img src="./assets/images/section.jpg" alt="">Third Post</a></a></li>
                  <li><a href='#tabs-4'><img src="./assets/images/section.jpg" alt="">Fourth Post</a></a></li>
                </ul>
              </div>
              <div class="col-lg-8">
                <section class='tabs-content'>
                  <article id='tabs-1'>
                    <h4>First Post</h4>
                    <p>post1</p>
                    
                  </article>
                  <article id='tabs-2'>
                    <h4>Second Post</h4>
                    <p>post2</p>
                    
                  </article>
                  <article id='tabs-3'>
                    <h4>Third Post</h4>
                    <p>post3</p>
                    
                  </article>
                  <article id='tabs-4'>
                    <h4>Fourth Post</h4>
                    <p>post4</p>

                  </article>
                </section>
              </div>
            </div>
        </div>
    </section>
    <!-- ***** Our Classes End ***** -->
    
  
    
    <!-- ***** Footer Start ***** -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; 2020 Training Studio
                    
                    - Designed by <a rel="nofollow" href="https://templatemo.com" class="tm-text-link" target="_parent">TemplateMo</a></p>
                    
                    <!-- You shall support us a little via PayPal to info@templatemo.com -->
                    
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="assets/js/jquery-2.1.0.min.js"></script>

    <!-- Bootstrap -->
    <script src="assets/js/popper.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>

    <!-- Plugins -->
    <script src="assets/js/scrollreveal.min.js"></script>
    <script src="assets/js/waypoints.min.js"></script>
    <script src="assets/js/jquery.counterup.min.js"></script>
    <script src="assets/js/imgfix.min.js"></script> 
    <script src="assets/js/mixitup.js"></script> 
    <script src="assets/js/accordions.js"></script>
    
    <!-- Global Init -->
    <script src="assets/js/custom.js"></script>

  </body>
</html>