<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="semi.member.model.vo.Member, java.util.*" %>  
<%
	Member member = (Member)request.getAttribute("member");
	String mid = (String)session.getAttribute("m_id");
%>
<%@ include file="../../header.jsp" %>

<style type="text/css">
	#allbutton { width : 68px; height : 30px; font : 7px Sans-Serif; position : absolute; right : 45px; bottom : 160px;}
	#recentTable th{align : center;}
</style>

<script type="text/javascript">
	$(function(){
		//암호 입력 상자에서 포커스가 사라질 때 암호확인 처리함
		$("#pwd2").blur(function(){
			console.log("포커스가 사라짐...");
			var pwd1 = $("#pwd1").val();
			var pwd2 = $("#pwd2").val();
			
			if(pwd1 != pwd2){
				alert("암호와 암호확인이 일치하지 않습니다.");
				$("#pwd1").select();
			}			
		});
	});
	
</script>

<%@ include file="../../aside2.jsp" %>
<div class="page-head"> 
            <div class="container">
                <div class="row">
                    <div class="page-head-content">
                        <h1 class="page-title">09 : <span class="orange strong">My Page</span></h1>               
                    </div>
                </div>
            </div>
        </div>
        <!-- End page header --> 

<h1 align="center"><b><%= member.getmName() %></b> 님의 정보</h1><br>

<form action="/semi/mupdate" method="post">
<table width="600" align="center" cellspacing="5" 
bgcolor="#3399ff">
<tr><td><label>아이디</label></td>
<td>
	<input type="text" name="mid" 
	value="<%= member.getmId() %>" readonly>
</td></tr>
<tr><td><label>이 름</label></td>
<td>
	<input type="text" name="mname" 
	value="<%= member.getmName() %>" readonly>
</td></tr>
<tr><td><label>암 호</label></td>
<td>
	<input type="password" name="mpassword" id="pwd1"
	value="<%= member.getmPassword() %>">
</td></tr>
<tr><td><label>암호확인</label></td>
<td>
	<input type="password" id="pwd2">
</td></tr>
<tr><td><label>닉네임</label></td>
<td>
	<input type="text" name="mnickname"
	value="<%= member.getmNickname() %>">
</td></tr>
<tr><td><label>포인트</label></td>
<td>
	<input type="text" name="mpoint"
	value="<%= member.getmPoint() %>" readonly>
</td></tr>
<tr><td><label>성 별</label></td>
<td>
	<% if(member.getmGender().equals("M")){ %>
	<input type="radio" name="mgender" value="M" checked> 남 &nbsp;
	<input type="radio" name="mgender" value="F"> 여
	<% }else{ %>
	<input type="radio" name="mgender" value="M"> 남 &nbsp;
	<input type="radio" name="mgender" value="F" checked> 여
	<% } %>
</td></tr>
<tr><td><label>주 소</label></td>
<td>
	<input type="text" name="maddress" 
	value="<%= member.getmAddress() %>">
</td></tr>
<tr><td><label>전화번호</label></td>
<td>
	<input type="tel" name="mphone" 
	value="<%= member.getmPhone() %>">
</td></tr>
<tr><td><label>이메일</label></td>
<td>
	<input type="email" name="memail" 
	value="<%= member.getmEmail() %>">
</td></tr>	
<tr>
<tr><td><label>생년월일</label></td>
<td>
	<input type="text" name="msno" 
	value="<%= member.getmSno() %>" readonly>
</td></tr>	
<tr>
	<td colspan="2" align="center">
		<input type="submit" value="수정하기" class="btn btn-default">
		&nbsp; &nbsp;
		<a href="/semi/mdelete?mid=<%= member.getmId() %>">탈퇴하기</a>
	</td>
</tr>

</table>
<br>
</form>
<div class="clear">
	<br>
	<hr>
	<br>

	<button class="btn btn-default btn-lg"
		style="background: white; margin-left: 670px;">
		<a href="/semi/myinfo?mid=<%= member.getmId() %>"
			style="color: black;">Home</a>
	</button>
	<button class="btn btn-default btn-lg" style="background: white;">
		<a href="/semi/mypoint?mid=<%= member.getmId() %>"
			style="color: black;">포인트 내역</a>
	</button>
	<button class="btn btn-default btn-lg" style="background: white;">
		<a href="/semi/myrent?mid=<%= member.getmId() %>"
			style="color: black;">최근 대여목록</a>
	</button>
	<button class="btn btn-default btn-lg" style="background: white;">
		<a style="color: black;">나의 게시글</a>
	</button>
	<br>
	<br>

	<div class="col-sm-5 col-sm-offset-1">
		<!-- 최근 대여목록 -->
		<div class="form-group">
			<table align="center" border="1" cellspacing="0" width="700"
				style="position: relative;" id="recentTable">
				<a>최근 대여 목록</a>
				<br>
				<button id="allbutton">
					<a href="/semi/mypoint?mid=<%= member.getmId() %>"
						style="color: #777;">전체보기</a>
				</button>
				<hr>

				<tr>
					<th>대여번호</th>
					<th>상품번호</th>
					<th>대여 일자</th>
					<th>상품명 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						&nbsp;</th>
					<th>금액 &nbsp; &nbsp; &nbsp;</th>

				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>

				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>

				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>

				</tr>
			</table>
		</div>

	</div>


	<div class="col-sm-5">
		<!-- 나의 게시글 -->
		<div class="form-group">
			<label>Public email :</label> <input name="p-email" type="email"
				class="form-control" placeholder="p-email@rmail.com">
		</div>
		<div class="form-group">
			<label>Phone :</label> <input name="Phone" type="text"
				class="form-control" placeholder="+1 9090909090">
		</div>
		<div class="form-group">
			<label>FAX :</label> <input name="FAX" type="text"
				class="form-control" placeholder="+1 9090909090">
		</div>
	</div>


</div>

<hr>

<%@ include file="../../footer.jsp" %>