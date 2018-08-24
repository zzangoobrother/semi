<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@	page import="semi.cart.model.vo.Cart, java.util.ArrayList" %>
<%
	ArrayList<Cart> list = (ArrayList<Cart>)request.getAttribute("list");
	
	//String p_Name = (String)request.getAttribute("p_Name");
	//int p_Price = Integer.parseInt(request.getAttribute("p_Price"));
	
	Cart c1 = new Cart();
	for(Cart c : list){
		c = list.get(0);
		System.out.print(c);
		c1 = c;
	}
%>

<%@ include file="../../header.jsp" %>
        
        <style>
	.left-box {
	float: left;
 	width: 60%;
 	 float:left;
	}
	.right-box {
 	float: right;
	width: 40%;
	}
	
	.bottomright {
    position: absolute;
    bottom: 8px;
    right: 16px;
    font-size: 18px;
}
</style>        
 
<script type="text/javascript"> 
$(function(){ 
	//전체선택 체크박스 클릭 
	$("#allCheck").click(function(){ 

	//만약 전체 선택 체크박스가 체크된상태일경우 
	if($("#allCheck").prop("checked")) { 
		//해당화면에 전체 checkbox들을 체크해준다
		$("input[type=checkbox]").prop("checked",true); 
		// 전체선택 체크박스가 해제된 경우 
		} else { 
			//해당화면에 모든 checkbox들의 체크를해제시킨다. 
			$("input[type=checkbox]").prop("checked",false);
		}
		});
	}); 
	</script>
	<h2>장바구니</h2>
<div class='left-box' style="overflow-y: scroll; height:60%;">
<table border="0" cellspacing="0" width="100%" >
<!-- <input type="button" value="전체선택/삭제"> &nbsp; &nbsp; &nbsp; -->
<input type="button" value="선택물품삭제" style="width: 110px; height: 35px;" class="btn btn-warning"> 

<tr>
<td align="center" style="width: 15px; height: 15px;">
<input type="checkbox" rowspan="2" colspan="0" id="allCheck"><hr>
</td></tr>


<tr>
<td rowspan="3" colspan="2" align="center">
<input type="checkbox">
</td>
<td rowspan="3" colspan="0" width="200">
<img src="/semi/resources/images/main/01_1.jpg" width="200" height="150" value="<%= c1.getP_Main_Image() %>">
</td>
<td>대여 물품명</td>
<td> 
<input type="text" style="width: 200px; height: 30px; text-align: right;" class="form-control"
			value="<%= c1.getP_Name() %>">
</td></tr>
<tr>
<td>대여 물품가격</td>
<td>
<input type="text" style="width: 200px; height: 30px; text-align: right;" class="form-control"
		value="<%= c1.getP_Price() %>">
</td></tr>
<tr>
<td>대여 가능일</td>
<td>
<input type="text" style="width: 200px; height: 30px; text-align: right;" class="form-control"
		value="<%= c1.getP_State() %>">
</td></tr>
<!-- 두번째 정보 -->
<tr>
<td rowspan="3" colspan="2" align="center">
<input type="checkbox" name="box">
</td>
<td rowspan="3" colspan="0" width="200">
<img src="/semi/resources/images/main/01._1.png" width="200" height="150" value="<%= c1.getP_Main_Image() %>">
</td>
<td>대여 물품명</td>
<td> 
<input type="text" style="width: 200px; height: 30px; text-align: right;" class="form-control" 
			value="<%= c1.getP_Name() %>">
</td></tr>
<tr>
<td>대여 물품가격</td>
<td>
<input type="text" style="width: 200px; height: 30px; text-align: right;" class="form-control"
			 value="<%= c1.getP_Price() %>">
</td></tr>
<tr>
<td>대여 가능일</td>
<td>
<input type="text" style="width: 200px; height: 30px; text-align: right;" class="form-control"
			 value="<%= c1.getP_State() %>">
</td></tr>

</table><br>
</div>

<div class="right-box">
<table width="100%" height="60%" border="0" cellspacing="0">
<tr height="100" ><td></td></tr>
<tr><td></td></tr>
<tr><td style="font-size:20px">선택 물품 갯수 : </td><td>
<input type="text" style="width: 220px; height: 30px; text-align: right;" id="aa" class="form-control">
</td></tr>

<tr height="100"><td></td></tr>
<tr><td style="font-size:20px">선택 물품 총 가격 : </td><td>
<input type="text" style="width: 220px; height: 30px; text-align: right;" class="form-control">
</td></tr>
<tr height="300"><td></td></tr>
<tr><td colspan="4"></td></tr>

<!-- <tr>
<td></td>
<td colspan="0" align="center">
	<input type="button" value="결제하기" style="width: 100px; height: 30px;" onclick=""> &nbsp; &nbsp;
	<input type="reset" value="취 소" onclick="location.href='/gonggu/index.jsp'" style="width: 100px; height: 30px; ">
</td></tr> -->
<<tr>
<td colspan="3" align="center">
<!-- <button style="position:absolute; right:0px; bottom:0px;">결제하기</button> -->
<button width="90" height="50" style="width: 150px; height: 40px;" class="btn btn-warning">결제하기</button> &nbsp; &nbsp;
<button style="width: 150px; height: 40px;" onclick="location.href='/gonggu/index.jsp'" class="btn btn-warning">취소</button>
</td>
</tr>
</table>
<br><br>
</div>
	<br><br>
<%@ include file="../../footer.jsp" %>