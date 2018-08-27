<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="boardError.jsp"%>
<%@ page import="semi.board.model.vo.Board, java.util.ArrayList " %>

<%
	Board board = (Board)request.getAttribute("board");
	ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
	int listCount =((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>    



<%@ include file="../../header.jsp"%>
<br><br><br>
<table id="table" align="center" height="500" width="650" cellspacing="0" border="1" >
<tr>
	<th width="50"  style="text-align:center;">번호</th>
	<th width="400" style="text-align:center;">제목</th>
	<th width="70" style="text-align:center;">작성자</th>
	<th width="100" style="text-align:center;">날짜</th>
	<th width="80" style="text-align:center;">조회수</th>
</tr>
<% for(Board b : list){ %>
<tr>
	<td align="center"><%= b.getRb_no() %></td>
	<td>
	<a href="/semi/bdetail?no=<%= b.getRb_no()%>&page=<%= currentPage%>"
	style="text-size:30px;"> &nbsp;&nbsp;<%= b.getRb_title() %></a>
	<% if(b.getRb_file1() != null || b.getRb_file2() != null){ %>
		<img style= "width:10px; height:10px;" src="/semi/resources/images/noticeList/disk.png">
	<% } %>
	</td>
	<td align="center"><%= b.getM_id() %></td>
	<td align="center"><%= b.getRb_date() %></td>
	<td align="center"><%= b.getRb_count() %></td>
</tr>
<% } %>
</table>

<!-- 페이징처리 -->
<div style="text-align: center;">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/semi/blist?page=1">[맨처음]</a>
<% } %>
<% if((currentPage - 10) < startPage &&
		(currentPage - 10) > 1){ %>
		<a href = "/semi/blist?page=<%= startPage - 10 %>">[이전]</a>		
<% }else{ %>
	[이전]&nbsp;
<% } %>
<%--startPage ~ endPage 출력 --%>
<% for(int p = startPage; p <= endPage; p++){
		if(p == currentPage){
%>
	<font color="red" size="4">[<%= p %>]</font>
<% } else{ %>
	<a href="/semi/blist?page=<%= p %>"><%= p %></a>
<% }} %>

<%----------------------------------------------------------- --%>

<% if((currentPage + 10) > endPage &&
		(currentPage + 10) < maxPage){ %>
	<a href="/semi/blist?page=<%= endPage + 10 %>">[다음]</a>
<% }else{ %>
	[다음]&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	[맨끝]&nbsp;
<% }else{ %>
	<a href="/semi/blist?page=<%= maxPage %>"></a>
<% } %>

</div>

<div  style="position: absolute; left: 1200px; top: 800px; ">

	<button  id="writeBtn" onclick="moveWritePage();">
	<a href = "/semi/views/board/boardWriteView.jsp">
	게시글작성</a></button>
</div>
<br><br><br><br><br><br>




<%@ include file="../../footer.jsp" %>