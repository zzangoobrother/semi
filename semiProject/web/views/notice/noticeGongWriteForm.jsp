<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		String userId = (String)session.getAttribute("userId");
%>

<!DOCTYPE html>
<html class="no-js"> <!--<![endif]-->
    <head>
       <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>공지사항 글쓰기</title>
        <!-- 이미지 업로드시 미리보기 -->
<script type="text/javascript" src="/second/resources/js/jquery-3.3.1.min.js"></script>
<script type="text/javascript"> 

function readURL(input) {
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$('#blah').attr('src', e.target.result); 
			} 
			reader.readAsDataURL(input.files[0]); 
	}
}



function readURL2(input) {
	if (input.files && input.files[0]) { 
		var reader = new FileReader(); 
		reader.onload = function (e) { 
			$('#blah2').attr('src', e.target.result); 
			} 
			reader.readAsDataURL(input.files[0]); 
	}
}

</script>
        
        <meta name="description" content="company is a real-estate template">
        <meta name="author" content="Kimarotec">
        <meta name="keyword" content="html5, css, bootstrap, property, real-estate theme , bootstrap template">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,700,800' rel='stylesheet' type='text/css'>

        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
        <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
        <link rel="icon" href="favicon.ico" type="image/x-icon">

        <link rel="stylesheet" href="/second/assets/css/normalize.css">
        <link rel="stylesheet" href="/second/assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="/second/assets/css/fontello.css">
        <link href="/second/assets/fonts/icon-7-stroke/css/pe-icon-7-stroke.css" rel="stylesheet">
        <link href="/second/assets/fonts/icon-7-stroke/css/helper.css" rel="stylesheet">
        <link href="/second/assets/css/animate.css" rel="stylesheet" media="screen">
        <link rel="stylesheet" href="/second/assets/css/bootstrap-select.min.css"> 
        <link rel="stylesheet" href="/second/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="/second/assets/css/icheck.min_all.css">
        <link rel="stylesheet" href="/second/assets/css/price-range.css">
        <link rel="stylesheet" href="/second/assets/css/owl.carousel.css">  
        <link rel="stylesheet" href="/second/assets/css/owl.theme.css">
        <link rel="stylesheet" href="/second/assets/css/owl.transitions.css">
        <link rel="stylesheet" href="/second/assets/css/style.css">
        <link rel="stylesheet" href="/second/assets/css/responsive.css">
    </head>
    <body>

        <div id="preloader">
            <div id="status">&nbsp;</div>
        </div>
        <!-- Body content -->

        <div class="header-connect">
            <div class="container">
                <div class="row">
                    <div class="col-md-5 col-sm-8  col-xs-12">
                        <div class="header-half header-call">
                           
                        </div>
                    </div>
                    <div class="col-md-2 col-md-offset-5  col-sm-3 col-sm-offset-1  col-xs-12">
                        <div class="header-half header-social">
                            <ul class="list-inline">
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-vine"></i></a></li>
                                <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                                <li><a href="#"><i class="fa fa-dribbble"></i></a></li>
                                <li><a href="#"><i class="fa fa-instagram"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>             
        <!--End top header -->

        <nav class="navbar navbar-default ">
            <div class="container">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navigation">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.html"><img src="/second/assets/img/logo.png" alt=""></a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse yamm" id="navigation">
                    <div class="button navbar-right">
                        <button class="navbar-btn nav-button wow bounceInRight login" onclick=" window.open('register.html')" data-wow-delay="0.4s">Login</button>
                        <button class="navbar-btn nav-button wow fadeInRight" onclick=" window.open('submit-property.html')" data-wow-delay="0.5s">Submit</button>
                    </div>
                    <ul class="main-nav nav navbar-nav navbar-right">
                        <li class="dropdown ymm-sw " data-wow-delay="0.1s">
                            <a href="index.html" class="dropdown-toggle active" data-toggle="dropdown" data-hover="dropdown" data-delay="200">Home <b class="caret"></b></a>
                            <ul class="dropdown-menu navbar-nav">
                                <li>
                                    <a href="index-2.html">Home Style 2</a>
                                </li>
                                <li>
                                    <a href="index-3.html">Home Style 3</a>
                                </li>
                                <li>
                                    <a href="index-4.html">Home Style 4</a>
                                </li>
                                <li>
                                    <a href="index-5.html">Home Style 5</a>
                                </li>

                            </ul>
                        </li>

                        <li class="wow fadeInDown" data-wow-delay="0.1s"><a class="" href="properties.html">Properties</a></li>
                        <li class="wow fadeInDown" data-wow-delay="0.1s"><a class="" href="property.html">Property</a></li>
                        <li class="dropdown yamm-fw" data-wow-delay="0.1s">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="200">Template <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <div class="yamm-content">
                                        <div class="row">
                                            <div class="col-sm-3">
                                                <h5>Home pages</h5>
                                                <ul>
                                                    <li>
                                                        <a href="index.html">Home Style 1</a>
                                                    </li>
                                                    <li>
                                                        <a href="index-2.html">Home Style 2</a>
                                                    </li>
                                                    <li>
                                                        <a href="index-3.html">Home Style 3</a>
                                                    </li>
                                                    <li>
                                                        <a href="index-4.html">Home Style 4</a>
                                                    </li>
                                                    <li>
                                                        <a href="index-5.html">Home Style 5</a>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-3">
                                                <h5>Pages and blog</h5>
                                                <ul>
                                                    <li><a href="blog.html">Blog listing</a>  </li>
                                                    <li><a href="single.html">Blog Post (full)</a>  </li>
                                                    <li><a href="single-right.html">Blog Post (Right)</a>  </li>
                                                    <li><a href="single-left.html">Blog Post (left)</a>  </li>
                                                    <li><a href="contact.html">Contact style (1)</a> </li>
                                                    <li><a href="contact-3.html">Contact style (2)</a> </li>
                                                    <li><a href="contact_3.html">Contact style (3)</a> </li>
                                                    <li><a href="faq.html">FAQ page</a> </li> 
                                                    <li><a href="404.html">404 page</a>  </li>
                                                </ul>
                                            </div>
                                            <div class="col-sm-3">
                                                <h5>Property</h5>
                                                <ul>
                                                    <li><a href="property-1.html">Property pages style (1)</a> </li>
                                                    <li><a href="property-2.html">Property pages style (2)</a> </li>
                                                    <li><a href="property-3.html">Property pages style (3)</a> </li>
                                                </ul>

                                                <h5>Properties list</h5>
                                                <ul>
                                                    <li><a href="properties.html">Properties list style (1)</a> </li> 
                                                    <li><a href="properties-2.html">Properties list style (2)</a> </li> 
                                                    <li><a href="properties-3.html">Properties list style (3)</a> </li> 
                                                </ul>                                               
                                            </div>
                                            <div class="col-sm-3">
                                                <h5>Property process</h5>
                                                <ul> 
                                                    <li><a href="submit-property.html">Submit - step 1</a> </li>
                                                    <li><a href="submit-property.html">Submit - step 2</a> </li>
                                                    <li><a href="submit-property.html">Submit - step 3</a> </li> 
                                                </ul>
                                                <h5>User account</h5>
                                                <ul>
                                                    <li><a href="register.html">Register / login</a>   </li>
                                                    <li><a href="user-properties.html">Your properties</a>  </li>
                                                    <li><a href="submit-property.html">Submit property</a>  </li>
                                                    <li><a href="change-password.html">Change password</a> </li>
                                                    <li><a href="user-profile.html">Your profile</a>  </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- /.yamm-content -->
                                </li>
                            </ul>
                        </li>

                        <li class="wow fadeInDown" data-wow-delay="0.4s"><a href="contact.html">Contact</a></li>
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <!-- End of nav bar -->

        <div class="page-head"> 
            <div class="container">
                <div class="row">
                    <div class="page-head-content">
                        <h1 class="page-title">게시글 작성</h1>               
                    </div>
                </div>
            </div>
        </div>
        <!-- End page header -->
    

        <script src="/second/assets/js/modernizr-2.6.2.min.js"></script>

        <script src="/second/assets/js/jquery-1.10.2.min.js"></script> 
        <script src="/second/bootstrap/js/bootstrap.min.js"></script>
        <script src="/second/assets/js/bootstrap-select.min.js"></script>
        <script src="/second/assets/js/bootstrap-hover-dropdown.js"></script>

        <script src="/second/assets/js/easypiechart.min.js"></script>
        <script src="/second/assets/js/jquery.easypiechart.min.js"></script>

        <script src="/second/assets/js/owl.carousel.min.js"></script>
        <script src="/second/assets/js/wow.js"></script>

        <script src="/second/assets/js/icheck.min.js"></script>
        <script src="/second/assets/js/price-range.js"></script>
        
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&amp;sensor=false"></script>
        <script src="/second/assets/js/gmaps.js"></script>        
        <script src="/second/assets/js/gmaps.init.js"></script>

        <script src="/second/assets/js/main.js"></script>
        
        
        <h2 align="center">공지사항 글쓰기 페이지</h2>
        <br><br>
<form action="/second/nginsert" method="post" enctype="multipart/form-data">
<div>
<table align="center"  cellspacing="0" cellpadding="0"  height="500" width="650">
<col width="80">
<col width="">

<tr style="height: 50px">
	<th style="text-align: center; font-size: 16px;">제목</th>
	<td><input type="text" name="ngtitle" style="border: 1px solid #666;"></td>
</tr>
<tr style="height: 50px">
	<th style="font-size: 16px;">작성자</th>
	<td><input type="text" name="ngwriter" value="<%= userId %>" style="border: 1px solid #666;" readonly></td>
</tr>
<tr style="height: 80px">
	<th>첨부파일</th>
	<td>
		<input type="file" name="gupfile" onchange="readURL(this);" style="margin-bottom: 5px; padding: 3px; border: 1px solid #666;">
		<input type="file" name="gupfile2" onchange="readURL2(this);" style="padding: 3px; border: 1px solid #666;">
	</td>
</tr>
<tr style="height: 10px;">
<td colspan="2"></td>
</tr>

<tr >

	<th>내용</th>
	<td style=" height:300px; overflow-y:scroll; border: 1px solid #666;">
	
	<div contentEditable="true"  style="height:300px; " >
	
	<img  style="border:0px;" id="blah"/>
	<img style="border:0px;" id="blah2"/>
	<input type="text" name="ngcontent" >
	
	</div>
	</td>

	
</tr>

</table>

<div style="margin: 0 auto; padding-top: 15px; width: 600px; height: 30px; text-align: right;">
<input type="submit" value="등록" style="background-color: #fff; width:100px; height: 30px;">&nbsp;
<input type="reset" value="취소" style="background-color: #fff; width:100px; height: 30px;">&nbsp;
<a href="/second/nglist"  style="width:100px; height: 30px;">목록 </a>
    </div>
</div>
</form>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
    </body>
</html>














