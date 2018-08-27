<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import ="semi.board.model.vo.Board" %>
<%
	Board board =(Board)request.getAttribute("board");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
%>	
<%@ include file="../../header.jsp" %>

<script type="text/javascript">
	function showList(){
		location.href = "/semi/blist";
		return false;		
	}
</script>
<script type="text/javascript">
	function showimage(){
		
	}

</script>

<br><br>
<form action="/semi/bupdate" method="post"
		enctype="multipart/form-data">
		<input type="hidden" name="no" value="<%= board.getRb_no() %>">
		<input type="hidden" name="rfile" value="<%= board.getRb_file1() %>">
<table align="center" width="800" cellspcing="0">
			
			<col width="80">
			<col width="">
			
			<tr style="height: 40px;">
				<th>제목</th>
				<td>
					<input style="border: 1px solid #666;" type="text" name="btitle" 
					value="<%= board.getRb_title() %>" readonly>
				</td>
			</tr>
			<tr style="height: 50px;">
				<th>작성자</th>
				<td>
					<input style="border: 1px solid #666;" type="text" name="bwriter"  
					value="<%= board.getM_id() %>" readonly>
				</td>
			</tr>
			
			<tr>
			<th>물품번호</th>
			<td>
				<input style="border: 1px solid #666;" type="text" name="pro"  
					value="<%= board.getP_no() %>" readonly>
			</td>
			
			</tr>
 
			<tr>
				<th>내용</th>
				<td style=" height:300px;  border: 1px solid #666;"  readonly; >
					<div style="border: 1px solid #666;" >
					<%= board.getRb_content() %>
						<% if(board.getRb_file1() != null) { %>
						<img  src="/semi/semi/bupfiles/<%= board.getRb_file1() %>">
					
						<% } %>
						<br>
						<br>
						<% if(board.getRb_file2() != null) { %>
						<img  
							src="/semi/semi/bupfiles/<%= board.getRb_file2() %>"  >
								
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
	
						<a href="/semi/bupview?no=<%= board.getRb_no() %>&page=<%= currentPage %>">
							수정하기</a>
					 &nbsp;
				
						<a href="/semi/bdelete?no=<%= board.getRb_no() %>">삭제하기</a>
					 &nbsp;

					
						<a href="/semi/blist?page=<%= currentPage %>">목록</a>
					
		</div>
<br><br><br><br><br><br><br>

<%@ include file="../../footer.jsp" %>

















