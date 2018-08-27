<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="noticeGongError.jsp"%>
<%@ page import="semi.notice.model.vo.Notice" %>
<%
		Notice notice = (Notice)request.getAttribute("notice");
		int currentPage = ((Integer)request.getAttribute("page")).intValue();
		

%>

<%@ include file="../../adminHeader.jsp" %>
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
<form action="/semi/ngoriginup" method="post" enctype="multipart/form-data">
<input type="hidden" name="no" value="<%= notice.getN_no()%>">
<input type="hidden" name="page" value="<%= currentPage%>">
<table align="center" height="500" width="650" cellspacing="0" border="1" >

<tr>
	<td height="15" width="100">제목</td>
	<td><input type="text" name="ngtitle" value="<%= notice.getN_title() %>"></td>
</tr>
<tr>
	<td height="15" width="100">작성자</td>
	<td><input type="text" name="ngwriter" value="<%= notice.getA_id() %>" readonly></td>
</tr>

	<tr style="height: 50px;">
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
			</tr>



<tr>
	<th>첨부파일변경</th>
	<td>
<input type="file"  name="gupfile" onchange="readURL(this);">
<input type="file"  name="gupfile2" onchange="readURL2(this);">
	</td>
</tr>
<%-- <tr>
	<th>추가된이미지</th>
	<td>
	<% if(notice.getN_file1() != null){ %>
	<img style="width:100px; height:100px;" src="/second/second/ngupfiles/<%= notice.getOriginalFilepath() %>">
	<%=notice.getN_file1() %>
	<% } %>
	
	<% if(notice.getN_file2() != null ){ %>
	<img style="width:100px; height:100px;" src="/semi/semi/ngupfiles/<%= notice.getN_file2() %>">
	<% } %>
	</td>
	
</tr> --%>

<tr>
	<th>내용</th>
	<td>
	<div contentEditable="true"   style="border: 1px solid #666;" >
	<input type="text" name="ngcontent"  
	value="<%= notice.getN_content() %>" style="border:none; pre-line" >
	<% if(notice.getN_file1() != null ) { %>
	<img  id="blah" style=" border:0px; " src="/semi/semi/ngupfiles/
	<%= notice.getN_file1()%>" >
	
	<% }else{ %>
	<img  id="blah" style=" border:0px;" >
	<% } %>
	<br><br>
	<% if(notice.getN_file2() != null) { %>
	<img  id="blah2" style=" border:0px;" src="/semi/semi/ngupfiles/
	<%= notice.getN_file2()%>">
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
<%-- <tr  align="right">
   <th colspan="2">
      <div style="float: right; width: 350px; height: 30px; ">
        <input type="submit" value="등록">&nbsp;
       <input type="reset" value="취소"> &nbsp;
       <a href="/second/nglist?page=<%= currentPage %>">목록</a>
    </div>
    
   </th>
</tr> --%>
</table>

<div style="margin: 0 auto; padding-top: 15px; width: 600px; height: 30px; text-align: right;">
<input type="submit" value="등록" style="width:100px; height: 30px;  background-color: #fff;">&nbsp;
<a href="/semi/nglist?page=<%= currentPage %>">목록</a>

</div>


</form>
<br><br><br><br><br><br><br><br>
<%@ include file="../../footer.jsp" %>
   

























