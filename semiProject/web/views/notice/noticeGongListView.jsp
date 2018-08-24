<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="noticeGongError.jsp"%>
<%@ page import="semi.notice.model.vo.Notice, java.util.ArrayList" %>
<%
	ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
	int listCount =((Integer)request.getAttribute("listCount")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>
<%@ include file="../../header.jsp" %>

<script type="text/javascript">
	function showNoticeWriteForm(){
		//글등록 버튼 클릭하면, noticeGongWriteForm.jsp 이동
		loaction.href = "/second/gonggu/noticego/noticeGongWriteForm.jsp";
	}
</script>
        
        

<br><br><br>
<%-- 공지글 등록버튼 아이디로 가져올건지 어떤걸로 가져올지 아직 미정... --%>
<%-- <% if(userId != null){ %>
	<div style="align:center; text-align:center;">
<button onclick="showNoticeWriteForm();">글쓰기</button>
	</div>
<% } %> --%>

<table id="table" align="center" height="500" width="650" cellspacing="0" border="1" >
<tr>
	<th width="50"  style="text-align:center;">번호!!!!</th>
	<th width="400" style="text-align:center;">제목</th>
	<th width="70" style="text-align:center;">작성자</th>
	<th width="100" style="text-align:center;">날짜</th>
	<th width="50" style="text-align:center;">조회수</th>
	<!-- <th>번호</th><th></th><th>작성자</th>
	<th>날짜</th><th>조회수</th><th>첨부파일</th> -->
</tr>
<% for(Notice n : list){ %>
<tr>
	<td align="center"><%= n.getN_no() %></td>
	<td >
		<a href="/second/ngdetail?no=<%= n.getN_no()%>&page=<%= currentPage %>">
		    &nbsp;&nbsp;<%= n.getN_title() %></a>
		<% if(n.getN_file1() != null){ %>
		<img style= "width:10px; height:10px;" src="/second/image/disk.png">
	<% } %>
	</td>
	<td align="center"><%= n.getA_id() %></td>
	<td align="center"><%= n.getN_date() %></td>
	<td align="center"><%= n.getN_count() %></td>
</tr>
<% } %>
</table>
<!-- 페이징처리 -->
<div style="text-align: center;">
<% if(currentPage <= 1){ %>
	[맨처음]&nbsp;
<% }else{ %>
	<a href="/second/nglist?page=1">[맨처음]</a>
<% } %>
<% if((currentPage - 10) < startPage &&
		(currentPage - 10) > 1){ %>
		<a href = "/second/nglist?page=<%= startPage - 10 %>">[이전]</a>		
<% }else{ %>
	[이전]&nbsp;
<% } %>
<%--startPage ~ endPage 출력 --%>
<% for(int p = startPage; p <= endPage; p++){
		if(p == currentPage){
%>
	<font color="red" size="4">[<%= p %>]</font>
<% } else{ %>
	<a href="/second/nglist?page=<%= p %>"><%= p %></a>
<% }} %>

<%----------------------------------------------------------- --%>

<% if((currentPage + 10) > endPage &&
		(currentPage + 10) < maxPage){ %>
	<a href="/second/nglist?page=<%= endPage + 10 %>">[다음]</a>
<% }else{ %>
	[다음]&nbsp;
<% } %>

<% if(currentPage >= maxPage){ %>
	[맨끝]&nbsp;
<% }else{ %>
	<a href="/second/nglist?page=<%= maxPage %>"></a>
<% } %>



</div>


<div  style="position: absolute; left: 1200px; top: 930px; ">

	<button  id="writeBtn" onclick="moveWritePage();">
	<a href = "/second/gonggu/noticego/noticeGongWriteForm.jsp">
	공지글 등록</a></button>
</div>
<br><br><br><br><br><br><br><br><br><br>

<%@ include file="../../footer.jsp" %>