<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../header.jsp" %> 


 <title>문의게시판 글쓰기</title>
        <!-- 이미지 업로드시 미리보기 -->
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

<h2 align="center">문의사항 글쓰기 페이지</h2>
        <br><br>
<!-- <form action="/semi/nginsert" method="post" enctype="multipart/form-data"> -->
<div>
<table align="center"  cellspacing="0" cellpadding="0"  height="500" width="650">

<tr style="height: 50px">
	<th style="text-align: center; font-size: 16px;">제목</th>
	<td><input type="text" id="qtitle" style="border: 1px solid #666;"></td>
</tr>
<tr style="height: 50px">
	<th style="font-size: 16px;">작성자</th>
	<td><input type="text" id="qwriter" value="<%= mId %>" style="border: 1px solid #666;" readonly></td>
</tr>

<form id="frm2" type="post" enctype="multipart/form-data">
<tr style="height: 80px">
	<th>첨부파일</th>
	<td>
		<input type="file" id="qupfile" name="qupfile" onchange="readURL(this);" style="margin-bottom: 5px; padding: 3px; border: 1px solid #666;">
		<input type="file" id="qupfile2" name="qupfile2" onchange="readURL2(this);" style="padding: 3px; border: 1px solid #666;">
	</td>
</tr>
</form>
<tr style="height: 10px;">
<td colspan="2"></td>
</tr>

<!-- <tr>
<th>물품</th>
<td>
  	<select id="pro">
 	 <option value="easy" selected="selected">보통</option>
 	 <option value="hard">중요</option>
  	 <option value="hell" selected="selected">매우중요</option>
	</select>
</td>
</tr>
 -->


<tr >
	<th>내용</th>
	<td style=" height:300px; overflow-y:scroll; border: 1px solid #666;">
	
	<div contentEditable="true"  style="height:300px; " id="qcontent" >
	<!-- <input type="text" name="ngcontent" > -->
	<img  style="border:0px;" id="blah"/>
	<img style="border:0px;" id="blah2"/>

	</div>
	</td>

</tr>

</table>

<script type="text/javascript">
		function aclick(qna){
			var qna = new Object();
			//var form = $('form')[0];
			//var formData = new FormData(form); 
			
			var qcontent = $("#qcontent").text();
			qna.qcontent = $("#qcontent").text();
			qna.qtitle = $("#qtitle").val();	
			qna.qwriter = $("#qwriter").val();
			qna.qupfile = $("#qupfile").val();
			qna.qupfile2 = $("#qupfile2").val();  
			
			
			var jsonStr = JSON.stringify(qna);
			//alert("ajax 전");
			$.ajax({
				url : "/semi/qinsert",
				enctype: "multipart/form-data",
				type : "post",
				dataType : "json",
				data : {"jsonStr" : jsonStr },
				success : function(data){
					alert("성공");
				}, //success
				error : function(jqXHR, textstatus, errorThrown){
					console.log("error : " + jqXHR + ", " + textstatus + ", " + errorThrown);
				} //error
		
			}); 
			//alert("빠져나옴");
			$("#frm2").ajaxForm(jsonStr).submit();
		}

	
	</script>

<div style="margin: 0 auto; padding-top: 15px; width: 600px; height: 30px; text-align: right;">
<a href="/semi/qlist" type="submit" onclick="aclick();" style="background-color: #fff; width:100px; height: 30px;">등록</a> &nbsp;
<input type="reset" value="취소" style="background-color: #fff; width:100px; height: 30px;">&nbsp;
<a href="/semi/qlist"  style="width:100px; height: 30px;">목록 </a>
    </div>
</div>


<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<%@ include file="../../footer.jsp" %>















