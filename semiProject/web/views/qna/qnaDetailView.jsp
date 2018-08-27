<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="semi.qna.model.vo.QnaBoard"%>
<%
	QnaBoard qna = (QnaBoard)request.getAttribute("qna");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>
<%@ include file="../../header.jsp" %>

<script type="text/javascript">
	function showList(){
		location.href = "/semi/qlist";
		return false;		
	}
</script>
<script type="text/javascript">
	function showimage(){
		
	}

</script>

<br><br>
	<form action="/semi/qupdate" method="post"
		enctype="multipart/form-data">
		<%-- <input type="hidden" name="no" value="<%= qna.getQ_no() %>">
		<input type="hidden" name="rfile" value="<%= qna.getQ_file1() %>"> --%>
		<table id="table" align="center" height="500" width="650" cellspacing="0" border="1" >
			
			<col width="80">
			<col width="">
			
			<tr style="height: 40px;">
				<th>제목</th>
				<td>
					<input style="border: 1px solid #666;" type="text" name="ngtitle" 
					value="<%=qna.getQ_title() %>" readonly>
				</td>
			</tr>
			<tr style="height: 50px;">
				<th>작성자</th>
				<td>
					<input style="border: 1px solid #666;" type="text" name="ngwriter" 
					value="<%= qna.getM_id() %>" readonly>
				</td>
			</tr>

<%-- <tr style="height: 50px;">
			<th>등급</th>
			<td>
			 	<select name="grade" >
			 	<% if(notice.getN_grade().equals("easy")){ %>
 	 			<option value="easy" selected="selected">보통</option>
 	 			
 	 			<% }else if(notice.getN_grade().equals("hard")){ %>
 				<option value="hard" selected="selected">중요</option>
 				
 				<% }else{ %>
  	 			<option value="hell" selected="selected">매우중요</option>
  	 			
  	 		
  	 			<% } %>
	</select>
				
			</td>
			</tr> --%>
			
			<tr>
				<th>내용</th>
				<td style=" height:300px;  border: 1px solid #666;"  readonly; >
					<div style="border: 1px solid #666;" >
					<%= qna.getQ_content() %>
						<% if(qna.getQ_file1() != null) { %>
						<img  src="/semi/semi/ngupfiles/<%= qna.getQ_file1() %>">
					
						<% } %>
						<br>
						<br>
						<% if(qna.getQ_file2() != null) { %>
						<img  
							src="/semi/semi/ngupfiles/<%= qna.getQ_file2() %>"  >
								
						<% } %>
						<br>
						<br>
						
					</div>
				</td>
			</tr>
			
			
		</table>
	</form>
	<br>
	
	<div style="margin: 0 auto; padding-top: 15px; width: 800px; height: 200px; text-align: right;">
			<%if(mId.equals(qna.getM_id()) == true){ %>
			<a href="/semi/qupview?no=<%= qna.getQ_no() %>&page=<%= currentPage %>">
				수정하기</a>
		 &nbsp;		
			<a href="/semi/qdelete?no=<%= qna.getQ_no() %>">
			삭제하기</a>
			<% }else{ %>
				<a href="/semi/views/qna/qnaReplyForm.jsp?no=<%= qna.getQ_no() %>&page=<%= currentPage %>">
				댓글달기</a>
			<% } %>
		 &nbsp;
			<a href="/semi/qlist?page=<%= currentPage %>">
			목록</a>
					
		</div>
<br><br><br><br><br><br><br>

<%@ include file="../../footer.jsp" %>















