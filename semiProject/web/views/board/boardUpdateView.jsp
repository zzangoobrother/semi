<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="boardError.jsp"%>
<%@ page import="semi.board.model.vo.Board" %>   
<%
		Board board = (Board)request.getAttribute("board");
		int currentPage = ((Integer)request.getAttribute("page")).intValue();
%>

<%@ include file="../../header.jsp" %>

 <title>수정페이지</title>
<script type="text/javascript" src="/semi/resources/js/jquery/jquery-3.3.1.min.js"></script>
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

<br><br>
<!-- 아이디 일치 하지 않을시 수정 불가하게 작성 -->
<form action="/semi/boriginup" method="post" enctype="multipart/form-data">
<input type="hidden" name="no" value="<%= board.getRb_no() %>">
<input type="hidden" name="page" value="<%= currentPage%>">
<table align="center" height="500" width="650" cellspacing="0" border="1" >

<tr>
	<td height="15" width="100">제목</td>
	<td><input type="text" name="btitle" value="<%= board.getRb_title() %>"></td>
</tr>
<tr>
	<td height="15" width="100">작성자</td>
	<td><input type="text" name="bwriter" value="<%= board.getM_id() %>" readonly></td>
</tr>

<tr>
	<th>첨부파일변경</th>
	<td>
<input type="file"  name="bupfile" onchange="readURL(this);">
<input type="file"  name="bupfile2" onchange="readURL2(this);">
	</td>
</tr>

<tr>
	<th>물품번호</th>
	<td>
	<input type="text" name="pro" value="<%= board.getP_no() %>">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
	<div contentEditable="true"   style="border: 1px solid #666;" >
	<input type="text" name="bcontent"  
	value="<%= board.getRb_content() %>" style="border:none; pre-line" >
	<% if(board.getRb_file1() != null ) { %>
	<img  id="blah" style=" border:0px; " src="/semi/semi/ngupfiles/
	<%= board.getRb_file1()%>" >
	<% }else{ %>
	<img  id="blah" style=" border:0px;" >
	<% } %>
	<br><br>
	<% if(board.getRb_file2() != null) { %>
	<img  id="blah2" style=" border:0px;" src="/semi/semi/ngupfiles/
	<%= board.getRb_file2()%>">
	<% }else{ %>
	<img  id="blah2" style=" border:0px;" >
	<% } %>
	<br><br>
	<%-- <% if(notice.getN_content() != null) { %>
	<input type="text" name="ngcontent"  
	value="<%= notice.getN_content() %>" style="border:none;">
	<% } %> --%>
	
	</div>
	</td>
</tr>

</table>

<div style="margin: 0 auto; padding-top: 15px; width: 600px; height: 30px; text-align: right;">
<input type="submit" value="등록" style="width:100px; height: 30px;  background-color: #fff;">&nbsp;
<a href="/semi/blist?page=<%= currentPage %>">목록</a>

</div>

</form>
<br><br><br><br><br><br><br><br>
   




