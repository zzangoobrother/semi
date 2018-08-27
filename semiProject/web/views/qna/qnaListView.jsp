<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="qnaError.jsp"%>
<%@ page import="semi.qna.model.vo.QnaBoard, java.util.ArrayList "%>

<%
	QnaBoard qna = (QnaBoard)request.getAttribute("qna");
	ArrayList<QnaBoard> list = (ArrayList<QnaBoard>)request.getAttribute("list");
	int listCount =((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>

<%@ include file="../../header.jsp" %>
<br><br>
<table id="table" align="center" height="500" width="650" cellspacing="0" border="1" >
<tr>
	<th width="50"  style="text-align:center;">번호</th>
	<th width="400" style="text-align:center;">제목</th>
	<th width="70" style="text-align:center;">작성자</th>
	<th width="100" style="text-align:center;">날짜</th>
	<th width="80" style="text-align:center;">조회수</th>
	<!-- <th width="50" style="text-align:center;  display:none; ">등급</th> -->
	<!-- <th>번호</th><th></th><th>작성자</th>
	<th>날짜</th><th>조회수</th><th>첨부파일</th> -->
</tr>
<% for(QnaBoard q : list){ %>
<tr>
	<td align="center"><%= q.getQ_no() %></td>
	<td align="center">
	<% if(q.getQ_level() == 1){//원글의 댓글일 때 %>
	&nbsp; &nbsp; ▶
	<% }else if(q.getQ_level() ==2){//댓글의 댓글일 때 %>
	&nbsp; &nbsp; &nbsp; &nbsp; ▶▶
	<% } %>
	<%-- 로그인한 사용자만 상세보기할 수 있도록 처리 --%>
	<% if(mId != null){ %>
		<a href="/semi/qdetail?no=<%= q.getQ_no() %>&page=<%= currentPage %>"><%= q.getQ_title() %></a>
	<% }else{ %>
		<%= q.getQ_title() %>
	<% } %>
	<% if(q.getQ_file1() != null || q.getQ_file2() != null) { %>
		<img style= "width:10px; height:10px;" src="/semi/resources/images/noticeList/disk.png">
	<% } %>
	</td>
	<td align="center"><%= q.getM_id() %></td>
	<td align="center"><%= q.getQ_date()%></td>
	<td align="center"><%= q.getQ_count() %></td>
</tr>
<% } %>
</table>

<!-- 페이징처리 -->
<div style="text-align: center;">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/semi/qlist?page=1">[맨처음]</a>
<% } %>
<% if((currentPage - 10) < startPage &&
		(currentPage - 10) > 1){ %>
		<a href = "/semi/qlist?page=<%= startPage - 10 %>">[이전]</a>		
<% }else{ %>
	[이전]&nbsp;
<% } %>
<%--startPage ~ endPage 출력 --%>
<% for(int p = startPage; p <= endPage; p++){
		if(p == currentPage){
%>
	<font color="red" size="4">[<%= p %>]</font>
<% } else{ %>
	<a href="/semi/qlist?page=<%= p %>"><%= p %></a>
<% }} %>

<%----------------------------------------------------------- --%>

<% if((currentPage + 10) > endPage &&
		(currentPage + 10) < maxPage){ %>
	<a href="/semi/qlist?page=<%= endPage + 10 %>">[다음]</a>
<% }else{ %>
	[다음]&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	[맨끝]&nbsp;
<% }else{ %>
	<a href="/semi/qlist?page=<%= maxPage %>"></a>
<% } %>

</div>

<div  style="position: absolute; left: 1200px; top: 800px; ">

	<button  id="writeBtn" onclick="moveWritePage();">
	<a href = "/semi/views/qna/qnaWriteView.jsp">
	공지글 등록</a></button>
</div>
<br><br><br><br><br><br><br><br><br><br>

<%@ include file="../../footer.jsp" %>





















