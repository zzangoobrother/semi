<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="qnaError.jsp"%>
<%@ page import="semi.qna.model.vo.QnaBoard" %>
<%
		QnaBoard qna = (QnaBoard)request.getAttribute("qna");
		int currentPage = ((Integer)request.getAttribute("page")).intValue();
%>

<%@ include file="../../header.jsp" %>

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

<!-- 아이디 일치 하지 않을시 수정 불가하게 작성 -->
<% if(qna.getQ_level() == 0){ %> <%-- 원글일 때 --%>
<form action="/semi/qoriginup" method="post" enctype="multipart/form-data">
<input type="hidden" name="no" value="<%= qna.getQ_no() %>">
<input type="hidden" name="page" value="<%= currentPage %>">
<table align="center" width="500" border="1" 
cellpadding="10" cellspacing="0">

<tr>
	<td height="15" width="100">제목</td>
	<td><input type="text" name="qtitle" value="<%= qna.getQ_title() %> "></td>
</tr>
<tr>
	<td height="15" width="100">작성자</td>
	<td><input type="text" name="qwriter" value="<%= qna.getM_id() %>" readonly></td>
</tr>

<%-- <tr style="height: 50px;">
			<th>등급</th>
			<td>
			 	<select name="grade" >
			 	<% if(notice.getN_grade().equals("easy")){ %>
 	 			<option value="easy" selected="selected">보통</option>
 	 			<option value="hard" >중요</option>
 	 			<option value="hell" >매우중요</option>
 	 			<% }else if(notice.getN_grade().equals("hard")){ %>
 				<option value="hard" selected="selected">중요</option>
 				<option value="easy" >보통</option>
 				<option value="hell" >매우중요</option>
 				<% }else{ %>
  	 			<option value="hell" selected="selected">매우중요</option>
  	 			<option value="easy" >보통</option>
  	 			<option value="hard" >중요</option>
  	 		
  	 			<% } %>
	</select>
				
			</td>
			</tr> --%>
			
			<tr>
	<th>첨부파일변경</th>
	<td>
<input type="file"  name="qupfile" onchange="readURL(this);">
<input type="file"  name="qupfile2" onchange="readURL2(this);">
	</td>
</tr>

<tr>
	<th>내용</th>
	<td>
	<div contentEditable="true"   style="border: 1px solid #666;" >
	<input type="text" name="qcontent"  
	value="<%= qna.getQ_content() %>" style="border:none; pre-line" >
	<% if(qna.getQ_file1() != null ) { %>
	<img  id="blah" style=" border:0px; " src="/semi/semi/qupfiles/
	<%=qna.getQ_file1()%>" >
	
	<% }else{ %>
	<img  id="blah" style=" border:0px;" >
	<% } %>
	<br><br>
	<% if(qna.getQ_file2() != null) { %>
	<img  id="blah2" style=" border:0px;" src="/semi/semi/qupfiles/
	<%= qna.getQ_file2()%>">
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
<a href="/semi/qlist?page=<%= currentPage %>">목록</a>
</div>
</form>

<% }else{ %><%-- 댓글일 때 --%>
<form action="/second/qreplyup" method="post" method="post">
<input type="hidden" name="no" value="<%= qna.getQ_no() %>">
<input type="hidden" name="page" value="<%= currentPage %>">
<table align="center" width="500" border="1" 
cellpadding="10" cellspacing="0">

<tr>
	<td height="15" width="100">제목</td>
	<td><input type="text" name="qtitle" value="<%= qna.getQ_title()%> "></td>
</tr>
<tr>
	<td height="15" width="100">작성자</td>
	<td><input type="text" name="qwriter" value="<%= qna.getM_id() %>" readonly></td>
</tr>

<tr>
	<td>내용</td>
	<td>
	<textarea name="qcontent" cols="50" rows="7"><%= qna.getQ_content() %>
	</textarea>
	</td>
</tr>
</table>
</form>
<% } %>



<br><br><br><br><br><br><br><br>
<%@ include file="../../footer.jsp" %>




















