<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String aName = (String)session.getAttribute("a_Name");
String aId = (String)session.getAttribute("a_Id");
%>

<%@ include file="head.jsp" %>

<script type="text/javascript">
			$(function(){
				
				$("#btnLogin").click(function(){
					var aid = $("#aid").val();
					var apassword = $("#apassword").val();
					var exp = /[a-z0-9]$/;
					
					if(aid == ""){
						alert("아이디를 입력해주세요");
						$("#aid").focus();
						return;
					}
					if(!exp.test(aid)){
						alert("영문자와 숫자만 입력가능합니다.");
						$("#aid").focus();
						return;
					}
				    if (apassword == "") {
		                alert("비밀번호를 입력해주세요");
		                $("#apassword").focus();
		                return;
		            }

				});
			});
			function goPage(){
				location.href = "/semi/index.jsp";
			}
			
		</script>

     <style type="text/css">
        input::placeholder {
  			color: #aaaaaa;
			font-size : 10px;
		}
        </style>
        
        <!-- Body content -->

        <div class="header-connect">
            <div class="container">
                <div class="row">
                    <div class="col-md-5 col-sm-8  col-xs-12">
                        <div class="header-half header-call">
                            <p>
                                <span><i class="pe-7s-call"></i> 010-1234-5678</span>
                                <span><i class="pe-7s-mail"></i> hongildong@iei	.org</span>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-2 col-md-offset-5  col-sm-3 col-sm-offset-1  col-xs-12">
                        <div class="header-half header-social">
                            <ul class="list-inline">
                                
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
                    <a class="navbar-brand" href="index.jsp">
                    <img src="/semi/resource/images/common/09.svg" alt="">
                    </a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse yamm" id="navigation">
                    <div class="button navbar-right" id="ajax_load_indicator">
                  
                         <% if(aName == null){ %>
                         <input type="button" id="loginradio" name="loginradio" value="회원페이지로" onclick="goPage();">
                        <form action="/semi/alogin" method="post">
                        <table width="250" height="75" cellspacing="0" cellpadding="0">
					<tr><td width="200">

					  <input type="text"  id="aid" name="aid" size="15" required placeholder="아이디를 입력하세요">
					</td>
					<td width="50" rowspan="2">
					<input type="submit" value="로그인" class= "navbar-btn nav-button wow bounceInRight login" id="btnLogin">
					</td></tr>
				<tr><td>
					
					<input type="password" id="apassword" name="apassword" size="15" required placeholder="비밀번호를 입력하세요">
				   </td></tr>
				   <tr><td colspan="2">
					<a href="#">회원가입</a> &nbsp;
					<a href="#">아이디/암호조회</a>
				</td></tr>
				</table>
				</form>
				<%}else{ %>
				<table width="250" height="75" cellspacing="0" cellpadding="0">
				<tr><td width="150">
					<%= aName %> 님. 
					</td>
					<td width="100">
					<a href="/semi/logout">로그아웃</a>
					</td></tr>
					<tr><td>	메일 개 </td> <td>쪽지  개</td></tr>
				<tr><td colspan="2">
					<a href="/semi/admininfo?aid=<%= aId %>">내 정보보기</a>	
					&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
					<a href="#">문의사항</a>
					
				</td></tr>
				</table>
				<%} %>
                    </div>
                    <ul class="main-nav nav navbar-nav navbar-right">
                        <li class="wow fadeInDown" data-wow-delay="0.1s">
                            <a href="/semi/adminIndex.jsp" class="">Home </a>
                        </li>
                        
                        <li class="dropdown ymm-sw " data-wow-delay="0.2s">
                        	<a href="index.html" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="200">대여품목 <b class="caret"></b></a>
                        <ul class="dropdown-menu navbar-nav">
                                <li>
                                    <a href="#">전체보기</a>
                                </li>
                                <li>
                                    <a href="#">- 절단공구</a>
                                </li>
                                <li>
                                    <a href="#">- 드릴공구</a>
                                </li>
                                <li>
                                    <a href="#">- 충전공구</a>
                                </li>
                                <li>
                                    <a href="#">- 기타공구</a>
                                </li>
                                <li>
                                    <a href="#">- 기타생활공구</a>
                                </li>

                            </ul>
                        </li>
                        <li class="dropdown ymm-sw " data-wow-delay="0.3s">
                        	<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="200">게시판 <b class="caret"></b></a>
                        	<ul class="dropdown-menu navbar-nav">
                                <li>
                                    <a href="#">- 공지사항</a>
                                </li>
                                <li>
                                    <a href="#">- 문    의</a>
                                </li>
                                <li>
                                    <a href="#">- 후    기</a>
                                </li>
                            </ul>
                        </li>
                        <li class="wow fadeInDown" data-wow-delay="0.4s">
                            <a href="#" class="dropdown-toggle">오시는길</a>
                        </li>
                        
                        <li class="dropdown ymm-sw " data-wow-delay="0.2s">
                        	<a href="index.html" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="200">관   리 <b class="caret"></b></a>
                        <ul class="dropdown-menu navbar-nav">
                                <li>
                                    <a href="/semi/views/manager/memberManagementView.jsp">- 회원관리</a>
                                </li>
                                <li>
                                    <a href="/semi/views/manager/toolManagementView.jsp">- 재고관리</a>
                                </li>
                                <li>
                                    <a href="/semi/views/manager/rentalManagementView.jsp">- 대여관리</a>
                                </li> 

                            </ul>
                        </li>
                      
                    </ul>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>