<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="qnaError.jsp"%>
<%@ page import="semi.qna.model.vo.QnaBoard"%>    
<%
		int qnaNo = Integer.parseInt(request.getParameter("no"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
%>    
    
<%@ include file="../../header.jsp" %> 

<h1 align="center"><%= qnaNo %>글의 댓글 달기</h1>
<br>
<form action="/semi/qreply" method="post" >
<input type="hidden" name="no" value="<%= qnaNo %>">
<input type="hidden" name="page" value="<%= currentPage %>">
<table id="table" align="center" height="500" width="650" cellspacing="0" border="1" >
<tr>
	<td height="15" width="100">제목</td>
	<td><input type="text" name="qtitle" size="50"></td>
</tr>

<tr>
	<td height="15" width="100">작성자</td>
	<td><input type="text" name="qwriter" 
	value="<%= mId %>" readonly></td>
</tr>

<tr>
	<td>내용</td>
	<td>
	<textarea name="qcontent" cols="50" rows="7">
	</textarea></td>
</tr>

<tr align="center" valign="middle">
	<td colspan="2">
	<input type="submit" value="댓글등록"> &nbsp;
	<input type="button" value="취소" onclick ="history.go(-1); return false;"> &nbsp;
	&nbsp; &nbsp;
	<a href="/semi/qlist?page=<%= currentPage %>">[목록]</a>
	</td>
</tr>
</table>
</form>
<br><br>
<hr>
<%@ include file="../../footer.jsp" %>
























